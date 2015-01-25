package controllers;

import controllers.EffectController;
import controllers.media.ViperMediaController;
import database.Database;
import models.effects.Effect;
import models.EffectToMedia;
import models.media.ViperMedia;

/**
 * Controller for EffectToMedia objects
 *
 * Loads the EffectToMedia objects from the DB
 * Maintains a list of all objects, as well as only
 * those that are active.
 */
class EffectToMediaController {

    public var effectToMediaList:Array<EffectToMedia>;
    public var activeEffectToMediaList:Array<EffectToMedia>;

    private var effectController:EffectController;
    private var viperMediaController:ViperMediaController;

    public function new(effectController:EffectController, viperMediaController:ViperMediaController)
    {
        this.effectController = effectController;
        this.viperMediaController = viperMediaController;
        effectToMediaList = new Array<EffectToMedia>();
        activeEffectToMediaList = new Array<EffectToMedia>();
        loadEffectsToMediaListFromDB();
    }

    public function loadEffectsToMediaListFromDB()
    {
        var effectstoMediaListDBObj:Array<Dynamic> = Database.instance.db.effectsToMediaList;

        if(effectstoMediaListDBObj == null)
        {
            trace("No effects to media found");
            return;
        }

        var effectToMedia:EffectToMedia = null;
        for(effectToMediaObj in effectstoMediaListDBObj)
        {
            var name:String = effectToMediaObj.name;
            var effectName:String = effectToMediaObj.effect;
            var mediaName:String = effectToMediaObj.media;

            var effect:Effect = effectController.getEffectByName(effectName);
            var viperMedia:ViperMedia = viperMediaController.getViperMediaByName(mediaName);

            effectToMedia = new EffectToMedia(name, effect, viperMedia);

            effectToMediaList.push(effectToMedia);
        }
    }

    /*
     * Returns an array of EffectToMedia links that
     * are active.  This allows the ViperCommandController to batch
     * send commands
     */
    public function getActiveEffectToMediaForEffect(effect:Effect):Array<EffectToMedia>
    {
        return activeEffectToMediaList.filter(
            function(effectToMedia:EffectToMedia)
            {
                return effectToMedia.effect == effect;
            }
        );
    }

    public function getEffectToMediaByName(name:String):EffectToMedia
    {
        for(effectToMedia in effectToMediaList)
        {
            if(effectToMedia.name == name)
            {
                return effectToMedia;
            }
        }
        return null;
    }

    public function enableEffectToMediaByName(name:String)
    {
        var effectToMedia:EffectToMedia = getEffectToMediaByName(name);
        enableEffectToMedia(effectToMedia);
    }

    // 
    public function enableEffectToMedia(effectToMedia:EffectToMedia)
    {
        setStatus(effectToMedia, true);
    }

    public function disableEffectToMediaByName(name:String)
    {
        var effectToMedia:EffectToMedia = getEffectToMediaByName(name);
        disableEffectToMedia(effectToMedia);
    }

    // 
    public function disableEffectToMedia(effectToMedia:EffectToMedia)
    {
        setStatus(effectToMedia, false);
    }

    public function setStatus(effectToMedia:EffectToMedia, status:Bool)
    {
        if(effectToMedia != null && effectToMediaList.indexOf(effectToMedia) != -1)
        {
            if(status)
            {
                activeEffectToMediaList.push(effectToMedia);
            }
            else
            {
                activeEffectToMediaList.remove(effectToMedia);
            }
            effectController.setStatus(effectToMedia.effect, status);
        }
    }
}