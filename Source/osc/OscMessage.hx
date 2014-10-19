package osc;

import haxe.io.Bytes;
import haxe.io.BytesBuffer;
import openfl.utils.ByteArray;

class OscMessage {

    private static inline var OSC_STRING_BYTE_MOD:Int = 4;

    private var typeTag:ByteArray;
    private var data:ByteArray;
    private var addrPattern:ByteArray;

    public function new(?addrPattern:String)
    {
        addrPattern = "/" + addrPattern;
        this.addrPattern = new ByteArray();
        this.addrPattern.writeUTFBytes(addrPattern);
        padToMultipleOf4Bytes(this.addrPattern);
        typeTag = new ByteArray();
        typeTag.writeUTFBytes(",");
        data = new ByteArray();
    }

    public function clear()
    {
        typeTag.clear();
        data.clear();
        typeTag.writeUTFBytes(",");
    }

    public function getBytes():ByteArray
    {
        var byteArray:ByteArray = new ByteArray();

        byteArray.writeBytes(addrPattern, 0, addrPattern.length);

        var tempTypeTag:ByteArray = new ByteArray();
        tempTypeTag.writeBytes(typeTag, 0, typeTag.length);
        padToMultipleOf4Bytes(tempTypeTag);
        byteArray.writeBytes(tempTypeTag, 0, tempTypeTag.length);

        byteArray.writeBytes(data, 0, data.length);

        return byteArray;
    }

    public function addInt(val:Int)
    {
        typeTag.writeByte(0x69); // i
        data.writeInt(val);
    }

    public function addFloat(val:Float)
    {
        typeTag.writeByte(0x66); // f
        data.writeFloat(val);
    }

    public function addDouble(val:Float)
    {
        typeTag.writeByte(0x64); // d
        data.writeDouble(val);
    }

    public function addString(val:String)
    {
        var tempBytes:ByteArray = new ByteArray();
        typeTag.writeByte(0x53); // s
        tempBytes.writeUTFBytes(val);
        padToMultipleOf4Bytes(tempBytes);
        data.writeBytes(tempBytes, 0, tempBytes.length);
    }

    public function addBool(val:Bool)
    {
        if(val)
            typeTag.writeByte(0x54); // T
        else
            typeTag.writeByte(0x46); // F
    }

    public function addMidi(channel:Int, status:Int, val1:Int, val2:Int)
    {
        typeTag.writeByte(0x6d); // m
        data.writeByte(channel);
        data.writeByte(val1);
        data.writeByte(val2);
    }

    public function toString():String
    {
        return getBytes().toString();
    }

    public function toHex():String
    {
        return getBytes().toHex();
    }

    private function padToMultipleOf4Bytes(byteArray:ByteArray)
    {
        byteArray.writeByte(0x0);

        var numNullsToAdd:Int = OSC_STRING_BYTE_MOD - byteArray.length % OSC_STRING_BYTE_MOD;

        if(numNullsToAdd == OSC_STRING_BYTE_MOD)
        {
            return;
        }

        for(i in 0...numNullsToAdd)
        {
            byteArray.writeByte(0x0);
        }
    }
}