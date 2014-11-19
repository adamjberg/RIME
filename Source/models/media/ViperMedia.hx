package models.media;

class ViperMedia {
    public var id:Int;
    public var filename:String;
    public var type:String;
    public var xPos:Int;
    public var yPos:Int;

    public function new(?id:Int, ?filename:String)
    {
        this.id = id;
        this.filename = filename;
    }

}