package controllers;

import controllers.SensorDataController;
import gestures.controllers.GestureController;
import haxe.ui.toolkit.controls.Button;
import models.commands.ViperCommand;
import models.mappings.JsonMappingReader;
import models.mappings.Mapping;
import models.mappings.MappingData;
import msignal.Signal.Signal0;
import osc.OscMessage;
import views.PianoButton;

class MappingController {

    public var onUpdated:Signal0 = new Signal0();

    public var mappings:Array<Mapping>;

    private var client:Client;
    private var jsonMappingReader:JsonMappingReader;

    public function new(client:Client, pianoButtons:Array<PianoButton>, gestureController:GestureController, sensorDataController:SensorDataController)
    {
        this.client = client;

        mappings = new Array<Mapping>();
        jsonMappingReader = new JsonMappingReader(pianoButtons, gestureController, sensorDataController);
    }

    public function getMappingWithName(name:String):Mapping
    {
        for(mapping in mappings)
        {
            if(mapping.name == name)
            {
                return mapping;
            }
        }
        return null;
    }

    public function addMappingFromFile(filename:String)
    {
        addMapping(jsonMappingReader.getMapping(filename));
    }

    public function addMapping(mapping:Mapping)
    {
        if(mapping != null)
        {
            mapping.onRequestSend.add(send);
            mappings.push(mapping);

            onUpdated.dispatch();
        }
    }

    public function deleteMapping(mapping:Mapping)
    {
        if(mapping != null)
        {
            mapping.onRequestSend.remove(send);
            mappings.remove(mapping);
            onUpdated.dispatch();
        }
    }

    private function send(mapping:Mapping, mappingData:MappingData)
    {
        if(mapping.targetIds.length == 0)
        {
            trace("send failed no targets");
            return;
        }

        trace("sending mapping data");
        var oscMessage:OscMessage = null;
        for(targetId in mapping.targetIds)
        {
            for(command in mappingData.getViperCommands())
            {
                command.id = targetId;
                oscMessage = command.fillOscMessage(oscMessage);
            }
            client.send(oscMessage);
            oscMessage = null;
        }
    }
}