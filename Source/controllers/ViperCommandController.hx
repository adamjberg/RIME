package controllers;

import controllers.Client;
import controllers.EffectToMediaController;
import controllers.PresetController;
import models.commands.ViperCommand;
import models.commands.ViperCreateCommand;
import models.commands.ViperDeleteCommand;
import models.effects.Effect;
import models.effects.SensorVariableEffect;
import models.EffectToMedia;
import models.media.ViperMedia;
import osc.OscMessage;

/**
 * This class is responsible for creating and sending ViperCommands
 * based on active presets.
 */
class ViperCommandController {

    private var presetController:PresetController;
    private var effectToMediaController:EffectToMediaController;
    private var activeEffects:Array<Effect>;
    private var client:Client;
    private var effectsAwaitingSend:Array<Effect>;

    private var lastSystemTime:Float;

    public function new(presetController:PresetController, effectToMediaController:EffectToMediaController, activeEffects:Array<Effect>, client:Client)
    {
        this.presetController = presetController;
        this.effectToMediaController = effectToMediaController;
        this.activeEffects = activeEffects;
        this.client = client;

        lastSystemTime = Sys.time();
        effectsAwaitingSend = new Array<Effect>();

        effectToMediaController.onEffectToMediaEnabled.add(createMediaOnViperIfNotActive);
        effectToMediaController.onEffectToMediaDisabled.add(removeMediaFromViperIfNotActive);
    }

    /*
     * This is the central place for checking if we should send off
     * SensorVariableEffects
     */
    public function update()
    {
        var sysTime:Float = Sys.time();
        var sysTimeInt:Int = Std.int(sysTime);
        var elapsedTimeInMs:Int = Math.round((sysTime - lastSystemTime) * 1000);

        for(activeEffect in activeEffects)
        {
            if(Std.is(activeEffect, SensorVariableEffect))
            {
                var sensorVariableEffect:SensorVariableEffect = cast(activeEffect, SensorVariableEffect);
                sensorVariableEffect.currentTimeInMs += elapsedTimeInMs;

                // This SensorVariable effect is ready to fire, let's queue it up
                if(sensorVariableEffect.currentTimeInMs >= sensorVariableEffect.updateIntervalInMs)
                {
                    effectsAwaitingSend.push(activeEffect);

                    // Carry over any leftover time
                    sensorVariableEffect.currentTimeInMs = sensorVariableEffect.currentTimeInMs - sensorVariableEffect.updateIntervalInMs;
                }
            }
        }

        lastSystemTime = sysTime;

        // If we have effects to send, do it now
        if(effectsAwaitingSend.length > 0)
        {
            sendPendingEffects();
        }
    }

    private function sendPendingEffects()
    {
        var messageToSend:OscMessage = null;

        for(effect in effectsAwaitingSend)
        {
            var command:ViperCommand = new ViperCommand();
            command.method = effect.method;
            for(i in 0...effect.mediaProperties.length)
            {
                command.addParam(effect.mediaProperties[i], effect.getData(i));
            }

            for(activeEffectToMedia in effectToMediaController.getActiveEffectToMediaForEffect(effect))
            {
                command.id = activeEffectToMedia.media.id;
                messageToSend = command.fillOscMessage(messageToSend);
            }
        }
        effectsAwaitingSend = new Array<Effect>();

        client.send(messageToSend);
    }

    private function isMediaActive(media:ViperMedia):Bool
    {
        for(effectToMedia in effectToMediaController.activeEffectToMediaList)
        {
            if(media == effectToMedia.media)
            {
                trace("media is active " + media);
                return true;
            }
        }
        return false;
    }

    /**
     * Below is logic to only create or delete media if no other active
     * presets refer to this media.
     */
    private function createMediaOnViperIfNotActive(effectToMedia:EffectToMedia)
    {
        if(isMediaActive(effectToMedia.media) == false)
        {
            var createCommand = new ViperCreateCommand(effectToMedia.media.id);
            client.send(createCommand.fillOscMessage(null));
        }
    }

    private function removeMediaFromViperIfNotActive(effectToMedia:EffectToMedia)
    {
        if(isMediaActive(effectToMedia.media) == false)
        {
            var deleteCommand = new ViperDeleteCommand(effectToMedia.media.id);
            client.send(deleteCommand.fillOscMessage(null));
        }
    }
}