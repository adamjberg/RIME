package models.mappings;

import controllers.Client;
import models.mappings.MappingParameter;
import osc.OscMessage;

class Mapping {

    private var deviceId:Int = 0;
    private var parameters:Array<MappingParameter> = new Array<MappingParameter>();
    private var targetIds:Array<Int> = new Array<Int>();

    public function new()
    {
        
    }

    public function addParameter(mappingParam:MappingParameter)
    {
        parameters.push(mappingParam);
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
}