package models.effects;

import models.sensors.data.SensorData;

/**
 * An effect that varies based on the current reading of the sensor
 * The user specifies how frequently a reading is made, and ultimately
 * sent to Viper
 */
class SensorVariableEffect extends Effect {

    public var sensorData:SensorData;

    /* This will specify which components of a sensor to include
     * in calculations.  i.e. Accelerometer has 3 axes (x,y,z).  For
     * just x value the vectorComponents would only have the value [ 0 ]
     * If there are multiple values, we take the magnitude of the resulting
     * vector.
     */
    public var vectorComponents:Array<Int>;

    // Whether or not we ignore the sign of the sensor reading
    // This is useful for detecting general motion...etc
    public var absoluteValue:Bool;

    // These values correspond to the provided mediaProperties
    public var minDesiredValues:Array<Float>;
    public var maxDesiredValues:Array<Float>;

    // How long until we read from the sensor, and ultimately send to ViPER
    public var updateIntervalInMs:Int;

    // This represents how much time has passed for this effect
    // The ViperCommandController uses this to determine when to send
    // out the command;
    public var currentTimeInMs:Int = 0;

    public function new(?name:String, method:String, mediaProperties:Array<String>,
                        sensorData:SensorData,
                        minDesiredValues:Array<Float>, maxDesiredValues:Array<Float>,
                        updateIntervalInMs:Int, vectorComponents:Array<Int>, absoluteValue:Bool )
    {
        super(name, method, mediaProperties);
        this.sensorData = sensorData;
        this.minDesiredValues = minDesiredValues;
        this.maxDesiredValues = maxDesiredValues;
        this.updateIntervalInMs = updateIntervalInMs;
        this.vectorComponents = vectorComponents;
        this.absoluteValue = absoluteValue;
    }

    override public function isValid():Bool
    {
        return sensorData != null &&
            minDesiredValues != null && minDesiredValues.length > 0 &&
            maxDesiredValues != null && maxDesiredValues.length > 0 &&
            updateIntervalInMs > 0 && vectorComponents != null &&
            vectorComponents.length > 0;
    }

    override public function getData(mediaPropertyIndex:Int):Float
    {
        if(sensorData == null)
        {
            return 0;
        }

        var vectorIndex:Int = vectorComponents[0];
        var minValue:Float = sensorData.sensor.minValues[vectorIndex];
        var maxValue:Float = sensorData.sensor.maxValues[vectorIndex];
        var valToUse = sensorData.values[vectorIndex];

        // Here we take the magnitude
        if(vectorComponents.length > 1)
        {
            valToUse = sensorData.getMagnitude(vectorComponents);
            minValue = 0;
            maxValue = sensorData.sensor.getMaxMagnitude(vectorComponents);
        }
        
        if(absoluteValue == true)
        {
            valToUse = Math.abs(valToUse);
            minValue = 0;
        }
        return ((valToUse - minValue) / (maxValue - minValue)) * (maxDesiredValues[mediaPropertyIndex] - minDesiredValues[mediaPropertyIndex]) + minDesiredValues[mediaPropertyIndex];
    }

}