package database;

import haxe.format.JsonParser;
import haxe.Json;
import models.ServerInfo;
import openfl.Assets;
import openfl.utils.SystemPath;
import sys.FileSystem;
import sys.io.File;

class Database {

    private static var _instance:Database;
    public static var instance(get, null):Database;
    private static function get_instance():Database {
        if (_instance == null) {
            _instance = new Database();
            System.deviceID = _instance.getDeviceId();
        }
        return _instance;
    }

    private static var userDatabaseFileName:String = 
    #if (ios || android)
        SystemPath.documentsDirectory + "/rimedb.json";
    #else
        SystemPath.applicationStorageDirectory + "/rimedb.json";
    #end
    private static inline var defaultDBLocation:String = "assets/data/default_database.json";

    private var db:Dynamic;

    public function new()
    {
        // Attempt to load user database first
        trace("Attempting to load database: " + userDatabaseFileName);
        if(FileSystem.exists(userDatabaseFileName))
        {
            try
            {
                db = JsonParser.parse(File.getContent(userDatabaseFileName));
                trace("User Database successfully loaded");
                return;
            }
            catch(msg:String)
            {
                trace("Cannot load user JSON file. Error:" + msg);
            }
        }
        
        /*
         * If there is no user database load our default one
         * then immediately save it to the user database location
         */ 
        trace("Loading default databse: " + defaultDBLocation);
        if(Assets.exists(defaultDBLocation))
        {
            try
            {
                var dbText:String = Assets.getText(defaultDBLocation);                
                db = JsonParser.parse(dbText);
                writeToFile();
                trace("Default database successfully loaded");
            }
            catch(msg:String)
            {
                trace("Failed to load default database. Error: " + msg);
            }
        }
        else
        {
            trace("Cannot find database file");
        }
    }

    public function getDeviceId():String
    {
        return db.deviceId;
    }

    public function getServerInfo():ServerInfo
    {
        var serverInfo:ServerInfo = new ServerInfo();
        serverInfo.ipAddress = db.serverInfo.ipAddress;
        serverInfo.portNumber = db.serverInfo.portNumber;
        return serverInfo;
    }

    public function saveServerInfo(serverInfo:ServerInfo)
    {
        db.serverInfo.ipAddress = serverInfo.ipAddress;
        db.serverInfo.portNumber = serverInfo.portNumber;
        writeToFile();
    }

    public function writeToFile()
    {
        if(FileSystem.exists(userDatabaseFileName))
        {
            FileSystem.deleteFile(userDatabaseFileName);
        }
        File.saveContent(userDatabaseFileName, Json.stringify(db, null, "\t"));
    }

}