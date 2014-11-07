package models.mappings;

import controllers.SensorDataController;
import haxe.Json;
import models.mappings.Mapping;
import models.mappings.MappingData;
import sys.FileSystem;
import sys.io.File;
import sys.io.FileInput;
import sys.io.FileOutput;

class JsonMappingReader {
    //private static var MAPPING_DIR:String = SystemPath.applicationStorageDirectory + "/mappings/";

    private static var MAPPING_DIR:String = "assets/data/mappings/";

    private var sensorDataController:SensorDataController;

    public function new(sensorDataController:SensorDataController)
    {
        this.sensorDataController = sensorDataController;
        getMapping("mapping1.json");
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