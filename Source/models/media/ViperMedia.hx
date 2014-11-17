package models.media;

class ViperMedia {
    public var id:Int;
    public var filename:String;

    public function new(?id:Int, ?filename:String)
    {
        this.id = id;
        this.filename = filename;
    }

}