package models.mappings;

import gestures.controllers.GestureController;
import controllers.SensorDataController;
import haxe.Json;
import haxe.ui.toolkit.controls.Button;
import models.commands.ViperCommand;
import models.mappings.Mapping;
import models.mappings.MappingData;
import models.mappings.PianoMappingData;
import models.sensors.data.SensorData;
import openfl.Assets;
import views.PianoButton;

class JsonMappingReader {
    //private static var MAPPING_DIR:String = SystemPath.applicationStorageDirectory + "/mappings/";

    private static var MAPPING_DIR:String = "assets/data/mappings/";

    private var pianoButtons:Array<PianoButton>;
    private var sensorDataController:SensorDataController;
    private var gestureController:GestureController;

    public function new(pianoButtons:Array<PianoButton>, gestureController:GestureController, sensorDataController:SensorDataController)
    {
        this.pianoButtons = pianoButtons;
        this.gestureController = gestureController;
        this.sensorDataController = sensorDataController;
    }

    public function getMapping(filename:String):Mapping
    {
        var mapping:Mapping = null;
        var fullPath:String = MAPPING_DIR + filename;
        if(Assets.exists(fullPath))
        {
            var jsonContent:String = Assets.getText(fullPath);
            var mappingObj:Dynamic = Json.parse(jsonContent);

            mapping = new Mapping();
            var mappingData:MappingData = null;
            var mappingDataArray:Array<Dynamic> = mappingObj.mappingData;

            for(mappingDataObj in mappingDataArray)
            {
                switch(mappingDataObj.type)
                {
                    case(MappingData.TYPE_SENSOR):
                        var sensorName:String = mappingDataObj.sensor;
                        var sensorData:SensorData = null;
                        if(mappingDataObj.rawData != null && mappingDataObj.rawData == "true")
                        {
                            sensorData = sensorDataController.getRawWithName(sensorName);
                        }
                        else
                        {
                            sensorData = sensorDataController.getFilteredWithName(sensorName);
                        }

                        if(sensorData != null)
                        {
                            var targetFields:Array<String> = mappingDataObj.targetFields;
                            var minOutputs:Array<Float> = mappingDataObj.minOutputs;
                            var maxOutputs:Array<Float> = mappingDataObj.maxOutputs;
                            mappingData = new SensorMappingData(
                                sensorData,
                                mappingDataObj.intervalInMs,
                                mappingDataObj.valueIndex,
                                targetFields,
                                minOutputs,
                                maxOutputs
                            );
                        }
                        else
                        {
                            trace("Could not map to sensor: " + sensorName);
                        }
                    case(MappingData.TYPE_PIANO):
                        var viperCommands:Array<ViperCommand> = getArrayOfViperCommandsFromJson(mappingDataObj.commands);
                        mappingData = new PianoMappingData
                        (
                            pianoButtons[mappingDataObj.buttonId],
                            mappingDataObj.pressType
                        );
                        for(viperCommand in viperCommands)
                        {
                            mappingData.addViperCommand(viperCommand);
                        }
                    case(MappingData.TYPE_GESTURE):
                        var viperCommands:Array<ViperCommand> = getArrayOfViperCommandsFromJson(mappingDataObj.commands);
                        mappingData = new GestureMappingData
                        (
                            gestureController,
                            mappingDataObj.gestureId
                        );
                        for(viperCommand in viperCommands)
                        {
                            mappingData.addViperCommand(viperCommand);
                        }
                }
                mapping.addMappingData(mappingData);
            }

        }
        else
        {
            trace("Mapping file " + filename + " not found");
        }
        return mapping;
    }

    private function getArrayOfViperCommandsFromJson(jsonCommands:Array<Dynamic>):Array<ViperCommand>
    {
        var viperCommands:Array<ViperCommand> = new Array<ViperCommand>();
        var viperCommand:ViperCommand;

        if(jsonCommands == null)
        {
            return viperCommands;
        }

        for(jsonCommand in jsonCommands)
        {
            var targetFields:Array<Dynamic> = jsonCommand.targetFields;
            var targetOutputs:Array<Dynamic> = jsonCommand.targetOutputs;
            var method:String = jsonCommand.method;

            if(method == null)
            {
                method = "update";
            }

            viperCommand = new ViperCommand();
            viperCommand.method = method;

            for(i in 0...targetFields.length)
            {
                viperCommand.addParam(targetFields[i], targetOutputs[i]);
            }

            viperCommands.push(viperCommand);
        }
        return viperCommands;
    }
}