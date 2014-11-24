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
import sys.FileSystem;
import sys.io.File;
import views.PianoButton;

class JsonMappingReader {
    private var pianoButtons:Array<PianoButton>;
    private var sensorDataController:SensorDataController;
    private var gestureController:GestureController;

    public function new(pianoButtons:Array<PianoButton>, gestureController:GestureController, sensorDataController:SensorDataController)
    {
        this.pianoButtons = pianoButtons;
        this.gestureController = gestureController;
        this.sensorDataController = sensorDataController;
    }

    public function getMapping(mappingObj:Dynamic):Mapping
    {
        var mapping:Mapping = null;

        mapping = new Mapping();
        mapping.name = mappingObj.name;
        var mappingData:MappingData = null;
        var mappingDataArray:Array<Dynamic> = mappingObj.mappingData;

        for(mappingDataObj in mappingDataArray)
        {
            switch(mappingDataObj.eventTriggerType)
            {
                case(MappingData.TYPE_SENSOR):
                    var sensorName:String = mappingDataObj.sensor;
                    var sensorData:SensorData = null;
                    var staticParameters:Array<ViperCommand> = getArrayOfStaticParameters(mappingDataObj.staticParameters); 
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
                        var targetFields:Array<String> = mappingDataObj.dynamicParameters.targetFields;
                        var minOutputs:Array<Float> = mappingDataObj.dynamicParameters.minOutputs;
                        var maxOutputs:Array<Float> = mappingDataObj.dynamicParameters.maxOutputs;
                        mappingData = new SensorMappingData(
                            sensorData,
                            mappingDataObj.intervalInMs,
                            mappingDataObj.valueIndex,
                            targetFields,
                            minOutputs,
                            maxOutputs
                        );

                         if(staticParameters != null){
                            trace("static parameters don't equal null. I've got viper comands");
                            for(staticParameter in staticParameters){
                                mappingData.addViperCommand(staticParameter);
                            }
                        } else {
                            trace("static prameters equals null DUUDE!");
                        }
                    } else
                    {
                        trace("Could not map to sensor: " + sensorName);
                    }

                //Add piano specific data to the piano mapping 
                case(MappingData.TYPE_PIANO):
                var staticParameters:Array<ViperCommand> = getArrayOfStaticParameters(mappingDataObj.staticParameters);
                    mappingData = new PianoMappingData
                    (
                        pianoButtons[mappingDataObj.buttonId],
                        mappingDataObj.pressType
                    );
                if(staticParameters != null){
                    trace("static parameters don't equal null. I've got viper comands");
                    for(staticParameter in staticParameters){
                        mappingData.addViperCommand(staticParameter);
                    }
                } else {
                    trace("static prameters equals null DUUDE!");
                }    

                //Add gesture specific data to the gesture mapping 
                case(MappingData.TYPE_GESTURE):
                var staticParameters:Array<ViperCommand> = getArrayOfStaticParameters(mappingDataObj.staticParameters);
                    mappingData = new GestureMappingData
                    (
                        gestureController,
                        mappingDataObj.gestureId
                    );   
                if(staticParameters != null){
                    trace("static parameters don't equal null. I've got viper comands");
                    for(staticParameter in staticParameters){
                        mappingData.addViperCommand(staticParameter);
                    }
                } else {
                    trace("static prameters equals null DUUDE!");
                } 
            }

            //add all the data to the mapping object 
            mapping.addMappingData(mappingData);
        }
        return mapping;
    }

    private function getArrayOfStaticParameters(jsonStaticParameters:Array<Dynamic>):Array<ViperCommand>
    {
        var viperCommands:Array<ViperCommand> = new Array<ViperCommand>();
        var viperCommand:ViperCommand;

        trace("getting Array of Static parameters"); 
        if(jsonStaticParameters == null)
        {
            trace("jsonstatic parmemters equals null dawg!");
            return viperCommands;
        }

        for(jsonStaticParameter in jsonStaticParameters)
        {
            var staticParameters:Array<Dynamic> = jsonStaticParameter.targetFields;
            var staticParameterValues:Array<Dynamic> = jsonStaticParameter.targetOutputs;
            var method:String = jsonStaticParameter.method;

            trace("json static param method :" + method); 

            if(method == null)
            {
                method = "update"; 
            }

            viperCommand = new ViperCommand();
            viperCommand.method = method; 

            if(staticParameters != null){
                for(i in 0...staticParameters.length)
                {
                    viperCommand.addParam(staticParameters[i], staticParameterValues[i]);
                    trace("Static Parameter Target Field: " + staticParameters[i]);
                    trace(method); 
                    trace("Static Paremeber Target Outputs: " + staticParameterValues[i]);
                }
            }

            viperCommands.push(viperCommand);
        }
        return viperCommands;
    }
}