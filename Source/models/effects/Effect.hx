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

    public var name:String;
    public var method:String;
    public var mediaProperties:Array<String>;

    public function new(?name:String, method:String, mediaProperties:Array<String>)
    {
        this.name = name;
        this.method = method;
        this.mediaProperties = mediaProperties;
    }

    public function isValid():Bool
    {
        return name != null && name.length > 0 && method != null && method.length > 0 && mediaProperties != null && mediaProperties.length > 0;
    }

    public function getData(mediaPropertyIndex:Int):Float
    {
        return -1;
    }

    public function getErrorString():String
    {
        var errorString:String = "";
        if(name == null)
        {
            errorString += "No name is defined\n";
        }
        if(method == null)
        {
            errorString += "No method is defined\n";
        }
        if(mediaProperties == null || mediaProperties.length == 0)
        {
            errorString += "No mediaProperties defined\n";
        }
        return errorString;
    }

}