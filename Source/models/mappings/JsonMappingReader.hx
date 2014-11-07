package models.mappings;

import gestures.controllers.GestureController;
import controllers.SensorDataController;
import haxe.Json;
import haxe.ui.toolkit.controls.Button;
import models.mappings.Mapping;
import models.mappings.MappingData;
import models.mappings.PianoMappingData;
import sys.FileSystem;
import sys.io.File;
import sys.io.FileInput;
import sys.io.FileOutput;
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
        if(FileSystem.exists(fullPath))
        {
            var jsonContent:String = File.getContent(fullPath);
            var mappingObj:Dynamic = Json.parse(jsonContent);

            mapping = new Mapping();
            var mappingData:MappingData = null;
            var mappingDataArray:Array<Dynamic> = mappingObj.mappingData;

            for(mappingDataObj in mappingDataArray)
            {
                switch(mappingDataObj.type)
                {
                    case(MappingData.TYPE_SENSOR):
                        mappingData = new SensorMappingData(
                            sensorDataController.getFiltered()[0],
                            mappingDataObj.intervalInMs,
                            mappingDataObj.valueIndex,
                            mappingDataObj.method,
                            mappingDataObj.targetField,
                            mappingDataObj.minOutput,
                            mappingDataObj.maxOutput
                        );
                    case(MappingData.TYPE_PIANO):
                        mappingData = new PianoMappingData
                        (
                            pianoButtons[mappingDataObj.buttonId],
                            mappingDataObj.pressType,
                            mappingDataObj.method,
                            mappingDataObj.targetField,
                            mappingDataObj.targetOutput
                        );
                    case(MappingData.TYPE_GESTURE):
                        mappingData = new GestureMappingData
                        (
                            gestureController,
                            mappingDataObj.gestureId,
                            mappingDataObj.method,
                            mappingDataObj.targetField,
                            mappingDataObj.targetOutput
                        );
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
}