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
}