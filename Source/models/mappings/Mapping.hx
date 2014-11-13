package models.mappings;

import controllers.Client;
import models.mappings.MappingData;
import msignal.Signal.Signal1;
import msignal.Signal.Signal2;
import osc.OscMessage;

class Mapping {

    public var onRequestSend:Signal2<Mapping, MappingData> = new Signal2<Mapping, MappingData>();

    private var deviceId:Int = 0;
    private var mappingDatas:Array<MappingData> = new Array<MappingData>();
    public var targetIds:Array<Int> = new Array<Int>();

    public function new()
    {
        // TODO: This is for testing, we should specify a target via UI
        targetIds.push(0);
    }

    public function addMappingData(mappingData:MappingData)
    {
        if(mappingData != null)
        {
            mappingData.onRequestSend.add(requestSend);
            mappingDatas.push(mappingData);   
        }
    }

    public function addTarget(id:Int)
    {
        targetIds.push(id);
    }

    public function removeTarget(id:Int)
    {
        targetIds.remove(id);
    }

    public function removeAllTargets()
    {
        targetIds = new Array<Int>();
    }

    public function getOscMessage():OscMessage
    {
        return null;
    }

    public function send()
    {
        var message:OscMessage = getOscMessage();
    }

    private function requestSend(mappingData:MappingData)
    {
        onRequestSend.dispatch(this, mappingData);
    }
}