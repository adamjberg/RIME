package models;

import models.EffectToMedia;

class Preset {

    public var name:String;
    public var effectToMediaList:Array<EffectToMedia>;

    public function new(name:String, effectToMediaList:Array<EffectToMedia>)
    {
        this.name = name;
        this.effectToMediaList = effectToMediaList;
    }

    public function isValid():Bool
    {
        return name != null && effectToMediaList != null && effectToMediaList.length != 0;
    }

    public function getErrorString():String
    {
        var errorString:String = "";
        if(name == null)
        {
            errorString += "No name defined\n";
        }
        if(effectToMediaList == null || effectToMediaList.length == 0)
        {
            errorString += "No effectToMediaList defined\n";
        }
        return errorString;
    }
}