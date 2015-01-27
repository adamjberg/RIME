package controllers;

import controllers.SensorDataController;
import database.Database;
import gestures.controllers.GestureController;
import gestures.models.GestureModel;
import models.effects.Effect;
import models.effects.GestureEffect;
import models.effects.SensorVariableEffect;
import models.sensors.data.SensorData;
import models.sensors.data.FilteredSensorData;
import models.sensors.data.RawSensorData;

class EffectController {
    public var effects:Array<Effect>;
    public var activeEffects:Array<Effect>;

    private var sensorDataController:SensorDataController;
    private var gestureController:GestureController;

    public function new(sensorDataController:SensorDataController, gestureController:GestureController)
    {
        this.sensorDataController = sensorDataController;
        this.gestureController = gestureController;

        this.effects = new Array<Effect>();
        this.activeEffects = new Array<Effect>();
        loadEffectsFromDB();
    }

    public function loadEffectsFromDB()
    {
        var effectsDBObj:Array<Dynamic> = Database.instance.db.effects;
        var errorsDBObj:Array<Dynamic> = Database.instance.getErrors();
        if(effectsDBObj == null)
        {
            trace("No effects found in DB");
            return;
        }

        var effectCount:Int = 0;
        for(effectDBObj in effectsDBObj)
        {
            var effect:Effect = null;
            var name:String = effectDBObj.name;
            var mediaProperties:Array<String> = effectDBObj.mediaProperties;
            var method:String = effectDBObj.method;
            var currentErrorString:String = "Effect[" + effectCount + "]:\n";

            // Below we determine the Effect type by exclusive required properties

            // If an interval is defined, this is a SensorVariableEffect
            if(effectDBObj.updateIntervalInMs != null)
            {
                var sensorName:String = effectDBObj.sensorName;
                var sensorData:SensorData;
                var filterSensorData:Bool = effectDBObj.filtered;
                if(filterSensorData)
                {
                    sensorData = sensorDataController.getFilteredWithName(sensorName);
                }
                else
                {
                    sensorData = sensorDataController.getRawWithName(sensorName);
                }
                var minDesiredValues:Array<Float> = effectDBObj.minDesiredValues;
                var maxDesiredValues:Array<Float> = effectDBObj.maxDesiredValues;
                var updateIntervalInMs:Int = effectDBObj.updateIntervalInMs;
                var vectorComponents:Array<Int> = effectDBObj.vectorComponents;
                var absoluteValue:Bool = effectDBObj.absoluteValue;
                effect = new SensorVariableEffect(
                    name,
                    method,
                    mediaProperties,
                    sensorData,
                    minDesiredValues,
                    maxDesiredValues,
                    updateIntervalInMs,
                    vectorComponents,
                    absoluteValue
                    );
            }
            // If a gesture name is specified, this is a GestureEffect
            else if(effectDBObj.gestureName != null)
            {
                var gestureName:String = effectDBObj.gestureName;
                var gestureModel:GestureModel = gestureController.getGestureModelByName(gestureName);
                var desiredValues:Array<Float> = effectDBObj.desiredValues;
                effect = new GestureEffect(
                    name,
                    method,
                    mediaProperties,
                    gestureModel,
                    desiredValues
                );
            }

            if(effect != null)
            {
                if(effect.isValid())
                {
                    this.effects.push(effect);
                }
                else
                {
                    currentErrorString += effect.getErrorString();
                    errorsDBObj.push(currentErrorString);
                }
            }

            effectCount++;
        }

        Database.instance.writeErrors(errorsDBObj);
    }

    public function getEffectByName(effectName:String):Effect
    {
        for(effect in effects)
        {
            if(effect.name == effectName)
            {
                return effect;
            }
        }
        return null;
    }

    public function enableEffectByName(effectName:String)
    {
        var effect:Effect = getEffectByName(effectName);
        enableEffect(effect);
    }

    // 
    public function enableEffect(effect:Effect)
    {
        setStatus(effect, true);
    }

    public function disableEffectByName(effectName:String)
    {
        var effect:Effect = getEffectByName(effectName);
        disableEffect(effect);
    }

    // 
    public function disableEffect(effect:Effect)
    {
        setStatus(effect, false);
    }

    public function setStatus(effect:Effect, status:Bool)
    {
        if(effect != null && effects.indexOf(effect) != -1)
        {
            if(status)
            {
                activeEffects.push(effect);
            }
            else
            {
                activeEffects.remove(effect);
            }
        }
    }
}