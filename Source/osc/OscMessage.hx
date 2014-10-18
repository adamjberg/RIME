package osc;

import haxe.io.Bytes;
import haxe.io.BytesBuffer;

class OscMessage {

    private var typeTag:BytesBuffer;
    private var data:BytesBuffer;
    private var addrPattern:String;

    public function new(addrPattern:String)
    {
        this.addrPattern = addrPattern;
        typeTag = new BytesBuffer();
        data = new BytesBuffer();
    }

    // This function nulls the BytesBuffers
    // You cannot use the OscMessage after calling it
    public function getBytes():Bytes
    {
        var bytesBuffer:BytesBuffer = new BytesBuffer();
        var typeBytes:Bytes = typeTag.getBytes();
        var dataBytes:Bytes = data.getBytes();

        bytesBuffer.add(typeBytes);
        bytesBuffer.add(dataBytes);

        return bytesBuffer.getBytes();
    }

    public function addInt(val:Int)
    {
        typeTag.addByte(0x69); // i
        data.addByte(val);
    }

    public function addFloat(val:Float)
    {
        typeTag.addByte(0x66); // f
        data.addFloat(val);
    }

    public function addDouble(val:Float)
    {
        typeTag.addByte(0x64); // d
        data.addDouble(val);
    }

    public function addString(val:String)
    {
        typeTag.addByte(0x53); // s
        data.addString(val);
    }

    public function addBool(val:Bool)
    {
        if(val)
            typeTag.addByte(0x54); // T
        else
            typeTag.addByte(0x46); // F
    }

    public function addMidi(channel:Int, status:Int, val1:Int, val2:Int)
    {
        typeTag.addByte(0x6d); // m
        data.addByte(channel);
        data.addByte(val1);
        data.addByte(val2);
    }

    // The following functions will ruin the BytesBuffer
    // For now use them only for debugging
    public function toString():String
    {
        return addrPattern + " " + typeTag.getBytes().toString() + " " + data.getBytes().toString();
    }

    public function toHex():String
    {
        return addrPattern + " " + typeTag.getBytes().toString() + " " + data.getBytes().toHex();
    }
}