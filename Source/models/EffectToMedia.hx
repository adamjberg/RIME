package models;

import models.effects.Effect;
import models.EffectToMedia;
import models.media.ViperMedia;

class EffectToMedia {

    public var name:String;
    public var effect:Effect;
    public var media:ViperMedia;

    public function new(name:String, effect:Effect, media:ViperMedia)
    {
        this.name = name;
        this.effect = effect;
        this.media = media;
    }

    public function isValid():Bool
    {
        return name != null && effect != null && media != null;
    }

    public function getErrorString():String
    {
        var errorString:String = "";
        if(name == null)
        {
            errorString += "No name defined\n";
        }
        if(effect == null)
        {
            errorString += "No effect defined\n";
        }
        if(media == null)
        {
            errorString += "No media defined\n";
        }
        return errorString;
    }
}