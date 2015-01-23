package controllers;

import controllers.PresetController;
import database.Database;
import models.Preset;
import models.Performance;

/**
 * Controller for Performance objects
 *
 * Loads the Performance objects from the DB
 * Maintains a list of all Performances, as well as only
 * those that are active.
 */
class PerformanceController {

    public var performances:Array<Performance>;
    public var activePerformances:Array<Performance>;

    private var presetController:PresetController;

    public function new(presetController:PresetController)
    {
        this.presetController = presetController;
        performances = new Array<Performance>();
        activePerformances = new Array<Performance>();
        loadPerformancesFromDB();
    }

    public function loadPerformancesFromDB()
    {
        var performancesDBObj:Array<Dynamic> = Database.instance.db.performances;

        if(performancesDBObj == null)
        {
            trace("No Performances found");
            return;
        }

        var performance:Performance = null;
        for(performanceObj in performancesDBObj)
        {
            var name:String = performanceObj.name;
            var presetNameList:Array<String> = performanceObj.presets;
            var presetList:Array<Preset> = new Array<Preset>();
            for(presetName in presetNameList)
            {
                var preset:Preset = presetController.getPresetByName(presetName);
                presetList.push(preset);
            }
            performance = new Performance(name, presetList);
            performances.push(performance);
        }
    }

    public function getPerformanceByName(name:String):Performance
    {
        for(performance in performances)
        {
            if(performance.name == name)
            {
                return performance;
            }
        }
        return null;
    }

    public function enablePerformanceByName(name:String)
    {
        var performance:Performance = getPerformanceByName(name);
        enablePerformance(performance);
    }

    // 
    public function enablePerformance(performance:Performance)
    {
        if(performance != null && performances.indexOf(performance) != -1)
        {
            activePerformances.push(performance);
        }
    }

    public function disablePerformanceByName(name:String)
    {
        var performance:Performance = getPerformanceByName(name);
        disablePerformance(performance);
    }

    // 
    public function disablePerformance(performance:Performance)
    {
        activePerformances.remove(performance);
    }
}