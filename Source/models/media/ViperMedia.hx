package models.media;

import models.mappings.Mapping;

class ViperMedia {
    public var name:String;
    public var id:Int;
    public var filename:String;
    public var type:String;
    public var xPos:Int;
    public var yPos:Int;
    public var mapping:Mapping;

    public function new(?id:Int, ?filename:String)
    {
        this.id = id;
        this.filename = filename;
    }

}