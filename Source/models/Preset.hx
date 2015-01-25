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
}