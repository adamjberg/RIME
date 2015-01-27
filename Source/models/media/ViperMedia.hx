package models.media;

class ViperMedia {
    public var name:String = "";
    public var id:Int = -1;
    public var filename:String = "";
    public var type:String = "image";
    public var xPos:Int = 0;
    public var yPos:Int = 0;

    public function new(?id:Int, ?filename:String)
    {
        this.id = id;
        this.filename = filename;
    }

    public function isValid():Bool
    {
        return name != null && filename != "" && (type == "image" || type == "video") && !Math.isNaN(xPos) && !Math.isNaN(yPos);
    }

    public function getErrorString():String
    {
        var errorString:String = "";
        if(name == null)
        {
            errorString += "No name defined\n";
        }
        if(filename == null || filename == "")
        {
            errorString += "No filename defined\n";
        }
        if(type == null || (type != "image" || type != "video"))
        {
            errorString += "No type specified, must be image or video\n";
        }
        if(Math.isNaN(xPos))
        {
            errorString += "No xPos defined\n";
        }
        if(Math.isNaN(yPos))
        {
            errorString += "No yPos defined\n";
        }
        return errorString;
    }

}