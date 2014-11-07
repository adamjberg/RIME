package controllers;

import controllers.SensorDataController;
import haxe.ui.toolkit.controls.Button;
import models.commands.ViperCommand;
import models.mappings.JsonMappingReader;
import models.mappings.Mapping;
import models.mappings.MappingData;
import osc.OscMessage;
import views.PianoButton;

class MappingController {

    public var mappings:Array<Mapping>;

    private var client:Client;
    private var sensorDataController:SensorDataController;
    private var jsonMappingReader:JsonMappingReader;

    public function new(client:Client, pianoButtons:Array<PianoButton>, sensorDataController:SensorDataController)
    {
        this.client = client;
        this.sensorDataController = sensorDataController;

        mappings = new Array<Mapping>();
        jsonMappingReader = new JsonMappingReader(pianoButtons, sensorDataController);
    }

    public function addMappingFromFile(filename:String)
    {
        addMapping(jsonMappingReader.getMapping(filename));
    }

    public function addMapping(mapping:Mapping)
    {
        mapping.onRequestSend.add(send);
        mappings.push(mapping);
    }

    private function send(mapping:Mapping, mappingData:MappingData)
    {
        if(mapping.targetIds.length == 0)
        {
            return;
        }

        var oscMessage:OscMessage = null;
        for(targetId in mapping.targetIds)
        {
            var command:ViperCommand = new ViperCommand(targetId);
            mappingData.fillViperCommand(command);
            oscMessage = command.fillOscMessage(oscMessage);
        }
        client.send(oscMessage);
    }
}