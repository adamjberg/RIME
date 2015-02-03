package controllers;

import controllers.EffectToMediaController;
import database.Database;
import models.EffectToMedia;
import models.Preset;
import msignal.Signal.Signal0; 

/**
 * Controller for Preset objects
 *
 * Loads the Preset objects from the DB
 * Maintains a list of all Presets, as well as only
 * those that are active.
 */
class PresetController {

    public var presets:Array<Preset>;
    public var activePresets:Array<Preset>;

    public var onUpdated:Signal0 = new Signal0();

    private var effectToMediaController:EffectToMediaController;

    public function new(effectToMediaController:EffectToMediaController)
    {
        this.effectToMediaController = effectToMediaController;
        presets = new Array<Preset>();
        activePresets = new Array<Preset>();
    }

    public function loadPresetsFromDB()
    {
        presets.splice(0, presets.length);
        activePresets.splice(0, activePresets.length);

        var presetsDBObj:Array<Dynamic> = Database.instance.db.presets;
        var errorsDBObj:Array<Dynamic> = Database.instance.getErrors();

        if(presetsDBObj == null)
        {
            trace("No Presets found");
            return;
        }

        var preset:Preset = null;
        var presetCount:Int = 0;
        for(presetObj in presetsDBObj)
        {
            var name:String = presetObj.name;
            var effectToMediaNameList:Array<String> = presetObj.effectToMediaList;
            var effectToMediaList:Array<EffectToMedia> = new Array<EffectToMedia>();
            var currentErrorString:String = "Preset[" + presetCount + "]:\n";

            if(effectToMediaNameList != null)
            {
                for(effectToMediaName in effectToMediaNameList)
                {
                    var effectToMedia:EffectToMedia = effectToMediaController.getEffectToMediaByName(effectToMediaName);
                    if(effectToMedia != null)
                    {
                        trace("Pushing effect to media"); 
                        effectToMediaList.push(effectToMedia);
                    }
                }
            }
            preset = new Preset(name, effectToMediaList);

            if(preset.isValid())
            {
                trace("Pushing Preset from DB"); 
                presets.push(preset);
            }
            else
            {
                currentErrorString += preset.getErrorString();
                errorsDBObj.push(currentErrorString);
            }
            presetCount++;
        }
    }

    public function getPresetByName(name:String):Preset
    {
        for(preset in presets)
        {
            if(preset.name == name)
            {
                return preset;
            }
        }
        return null;
    }

    public function deletePreset(preset:Preset)
    {
        if(preset != null)
        {
            presets.remove(preset); 
            onUpdated.dispatch(); 
            writeToDatabase(); 
        }
    }

    public function writeToDatabase()
    {
        trace("writing preset to DB"); 
        var presetListObj:Array<Dynamic> = new Array<Dynamic>(); 

        for(preset in presets)
        {
            var presetObj:Dynamic = {};

            presetObj.name = preset.name; 

            presetListObj.push(presetObj); 
        }

        Database.instance.writeJSONObj("presets", presetListObj); 
    }

    public function enablePresetByName(name:String)
    {
        var preset:Preset = getPresetByName(name);
        enablePreset(preset);
    }

    // 
    public function enablePreset(preset:Preset)
    {
        setStatus(preset, true);
    }

    public function disablePresetByName(name:String)
    {
        var preset:Preset = getPresetByName(name);
        disablePreset(preset);
    }

    // 
    public function disablePreset(preset:Preset)
    {
        setStatus(preset, false);
    }

    public function setStatus(preset:Preset, status:Bool)
    {
        if(preset != null && presets.indexOf(preset) != -1)
        {
            for(effectToMedia in preset.effectToMediaList)
            {
                effectToMediaController.setStatus(effectToMedia, status);
            }
            if(status)
            {
                activePresets.push(preset);
            }
            else
            {
                activePresets.remove(preset);
            }
        }
    }
}