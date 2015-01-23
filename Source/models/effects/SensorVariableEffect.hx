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
}