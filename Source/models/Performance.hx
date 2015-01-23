package models;

import models.Preset;

/**
 * This model has a collection of presets.  The user
 * will then be able to enable or disable these presets
 * when they are in the middle of a performance.
 */
class Performance {

    public var name:String;

    // Contains a list of presets associated with this performance
    public var presets:Array<Preset>;

    public function new(name:String, presets:Array<Preset>)
    {
        this.name = name;
        this.presets = presets;
    }
}