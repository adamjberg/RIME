package controllers;

import controllers.SensorDataController;
import models.commands.ViperCommand;
import models.mappings.JsonMappingReader;
import models.mappings.Mapping;
import models.mappings.MappingData;
import osc.OscMessage;

class MappingController {

    public var mappings:Array<Mapping>;

    private var client:Client;
    private var sensorDataController:SensorDataController;
    private var jsonMappingReader:JsonMappingReader;

    public function new(client:Client, sensorDataController:SensorDataController)
    {
        this.client = client;
        this.sensorDataController = sensorDataController;

        mappings = new Array<Mapping>();
        jsonMappingReader = new JsonMappingReader(sensorDataController);
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