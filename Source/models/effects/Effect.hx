package models.effects;

/**
 * A base class for effects
 * In general effects have a list of media properties
 * that it will effect.  Currently the subclasses will
 * decide what values to assign to these properties
 *
 * Possible TODO: Refactor ViperCommands so that an effect can hold on to
 * one or possible several commands.  This would greatly simplify generating
 * a UI for effects.
 */
class Effect {

    public static inline var TYPE_SENSOR_VARIABLE:String = "sensor";
    public static inline var TYPE_SENSOR_THRESHOLD:String = "sensor threshold";
    public static inline var TYPE_GESTURE:String = "gesture";

    public var name:String;
    public var method:String;
    public var mediaProperties:Array<String>;

    public function new(?name:String, method:String, mediaProperties:Array<String>)
    {
        this.name = name;
        this.method = method;
        this.mediaProperties = mediaProperties;
    }
}