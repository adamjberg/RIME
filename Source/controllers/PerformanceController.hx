package controllers;

import controllers.PresetController;
import database.Database;
import models.Preset;
import models.Performance;
import msignal.Signal.Signal0; 

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

    public var onUpdated:Signal0 = new Signal0();

    private var presetController:PresetController;

    public function new(presetController:PresetController)
    {
        this.presetController = presetController;
        performances = new Array<Performance>();
        activePerformances = new Array<Performance>();
    }

    public function loadPerformancesFromDB()
    {
        performances.splice(0, performances.length);
        activePerformances.splice(0, activePerformances.length);

        var performancesDBObj:Array<Dynamic> = Database.instance.db.performances;
        var errorsDBObj:Array<Dynamic> = Database.instance.getErrors();

        if(performancesDBObj == null)
        {
            trace("No Performances found");
            return;
        }

        var performance:Performance = null;
        var performanceCount:Int = 0;
        for(performanceObj in performancesDBObj)
        {
            var name:String = performanceObj.name;
            var presetNameList:Array<String> = performanceObj.presets;
            var presetList:Array<Preset> = new Array<Preset>();
            var currentErrorString:String = "Performance[" + performanceCount + "]:\n";

            if(presetNameList != null)
            {
                for(presetName in presetNameList)
                {
                    var preset:Preset = presetController.getPresetByName(presetName);
                    if(preset != null)
                    {
                        presetList.push(preset);
                    }
                }
            }
            performance = new Performance(name, presetList);

            if(performance.isValid())
            {
                performances.push(performance);
            }
            else
            {
                currentErrorString += performance.getErrorString();
                errorsDBObj.push(currentErrorString);
            }
            performanceCount++;
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

    public function addPerformance(performance:Performance)
    {
        if(performance != null)
        {
            trace("Adding performance to list"); 
            performances.push(performance); 
            onUpdated.dispatch(); 
            writeToDatabase(); 
        }
    }

    public function deletePerformance(performance:Performance)
    {
        if(performance != null)
        {
            performances.remove(performance); 
            onUpdated.dispatch(); 
            writeToDatabase(); 
        }
    }

    public function writeToDatabase()
    {
        trace("writing performance to DB"); 
        var performanceListObj:Array<Dynamic> = new Array<Dynamic>(); 
        var presetNameList:Array<String> = new Array<String>(); 

        for(performance in performances)
        {

            for(preset in performance.presets)
            {
                presetNameList.push(preset.name); 
            }
            var performanceObj:Dynamic = {}; 

            performanceObj.name = performance.name;
            performanceObj.presets = presetNameList;  

            performanceListObj.push(performanceObj); 
        }

        Database.instance.writeJSONObj("performances", performanceListObj); 
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