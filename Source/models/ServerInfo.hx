package models;

import msignal.Signal.Signal1;

class ServerInfo {
    public static inline var DISCONNECTED:Int = 0;
    public static inline var CONNECTING:Int = 1;
    public static inline var CONNECTED:Int = 2;

    public var ipAddress:String;
    public var portNumber:Int;
    public var connectionStatus(default, set):Int;
    public var onConnectionStatusChanged:Signal1<Int> = new Signal1<Int>();

    function set_connectionStatus(status:Int)
    {
        if(status != connectionStatus)
        {
            onConnectionStatusChanged.dispatch(status);
        }
        return connectionStatus = status;
    }

    public function new() {
        ipAddress = "127.0.0.1";
        portNumber = 12000;
        connectionStatus = DISCONNECTED;
    }
}