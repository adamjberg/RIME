package controllers;

import controllers.EffectController;
import controllers.media.ViperMediaController;
import database.Database;
import models.effects.Effect;
import models.EffectToMedia;
import models.media.ViperMedia;
import msignal.Signal.Signal1;
import msignal.Signal.Signal0; 

/**
 * Controller for EffectToMedia objects
 *
 * Loads the EffectToMedia objects from the DB
 * Maintains a list of all objects, as well as only
 * those that are active.
 */
class EffectToMediaController 
{

    public var onEffectToMediaEnabled:Signal1<EffectToMedia> = new Signal1<EffectToMedia>();
    public var onEffectToMediaDisabled:Signal1<EffectToMedia> = new Signal1<EffectToMedia>();
    public var onUpdate:Signal0 = new Signal0(); 

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
    }

    public function loadEffectsToMediaListFromDB()
    {
        effectToMediaList.splice(0, effectToMediaList.length);
        activeEffectToMediaList.splice(0, activeEffectToMediaList.length);

        var effectstoMediaListDBObj:Array<Dynamic> = Database.instance.db.effectsToMediaList;
        var errorsDBObj:Array<Dynamic> = Database.instance.getErrors();

        if(effectstoMediaListDBObj == null)
        {
            trace("No effects to media found");
            return;
        }

        var effectToMedia:EffectToMedia = null;
        var effectToMediaCount:Int = 0;
        for(effectToMediaObj in effectstoMediaListDBObj)
        {
            var name:String = effectToMediaObj.name;
            var effectName:String = effectToMediaObj.effect;
            var mediaName:String = effectToMediaObj.media;
            var currentErrorString:String = "EffectToMedia[" + effectToMediaCount + "]:\n";

            var effect:Effect = effectController.getEffectByName(effectName);
            var viperMedia:ViperMedia = viperMediaController.getViperMediaByName(mediaName);

            effectToMedia = new EffectToMedia(name, effect, viperMedia);

            if(effectToMedia.isValid())
            {
                effectToMediaList.push(effectToMedia);
            }
            else
            {
                currentErrorString += effectToMedia.getErrorString();
                errorsDBObj.push(currentErrorString);
            }
            effectToMediaCount++;
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

    public function addEffectToMediaObject(effectToMedia:EffectToMedia)
    {
        if(effectToMedia != null)
        {
            trace("Adding effectToMediaObject"); 
            effectToMediaList.push(effectToMedia); 
            onUpdate.dispatch(); 
            writeToDatabase(); 
        }
    }

    public function deleteEffectToMedia(effectToMedia:EffectToMedia)
    {
        if(effectToMedia != null)
        {
            effectToMediaList.remove(effectToMedia); 
            onUpdate.dispatch(); 
            writeToDatabase(); 
        }
    }

    private function writeToDatabase()
    {
        trace("Writing to effecttoMedia database"); 

        var effectToMediaListObj:Array<Dynamic> = new Array<Dynamic>(); 

        for(effectToMedia in effectToMediaList)
        {
            var effectToMediaObj:Dynamic = {}; 

            effectToMediaObj.name = effectToMedia.name; 
            effectToMediaObj.effect = effectToMedia.effect.name; 
            effectToMediaObj.media = effectToMedia.media.name; 

            effectToMediaListObj.push(effectToMediaObj); 
        }

        Database.instance.writeJSONObj("effectsToMedia", effectToMediaListObj); 
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
                // Send this signal before, so we can search the active list without the new entry
                onEffectToMediaEnabled.dispatch(effectToMedia);
                activeEffectToMediaList.push(effectToMedia);
            }
            else
            {
                // Send the signal after so we can search the resulting activeEffectToMediaList
                activeEffectToMediaList.remove(effectToMedia);
                onEffectToMediaDisabled.dispatch(effectToMedia);
            }
            effectController.setStatus(effectToMedia.effect, status);
        }
    }
}