package models;

class ServerInfo {
    public var ipAddress:String;
    public var portNumber:Int;

    public function new() {
        ipAddress = "127.0.0.1";
        portNumber = 12000;
    }
}