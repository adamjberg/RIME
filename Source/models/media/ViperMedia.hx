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

}