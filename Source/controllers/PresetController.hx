package controllers;

import controllers.EffectToMediaController;
import database.Database;
import models.EffectToMedia;
import models.Preset;

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

    private var effectToMediaController:EffectToMediaController;

    public function new(effectToMediaController:EffectToMediaController)
    {
        this.effectToMediaController = effectToMediaController;
        presets = new Array<Preset>();
        activePresets = new Array<Preset>();
        loadPresetsFromDB();
    }

    public function loadPresetsFromDB()
    {
        var presetsDBObj:Array<Dynamic> = Database.instance.db.presets;

        if(presetsDBObj == null)
        {
            trace("No Presets found");
            return;
        }

        var preset:Preset = null;
        for(presetObj in presetsDBObj)
        {
            var name:String = presetObj.name;
            var effectToMediaNameList:Array<String> = presetObj.effectToMediaList;
            var effectToMediaList:Array<EffectToMedia> = new Array<EffectToMedia>();
            for(effectToMediaName in effectToMediaNameList)
            {
                var effectToMedia:EffectToMedia = effectToMediaController.getEffectToMediaByName(effectToMediaName);
                effectToMediaList.push(effectToMedia);
            }
            preset = new Preset(name, effectToMediaList);
            presets.push(preset);
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