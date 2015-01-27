package database;

import haxe.format.JsonParser;
import haxe.Json;
import models.ServerInfo;
import openfl.Assets;
import openfl.events.TimerEvent;
import openfl.utils.SystemPath;
import openfl.utils.Timer;
import sys.FileSystem;
import sys.io.File;

class Database {

    private static var _instance:Database;
    public static var instance(get, null):Database;
    private static function get_instance():Database {
        if (_instance == null) {
            _instance = new Database();
        }
        return _instance;
    }

    private static inline var SAVE_INTERVAL_MS:Int = 5000;

    private static inline var CURRENT_DATABASE_VERSION:Int = 3;

    private static var userDatabaseFileName:String = 
    #if (ios)
        SystemPath.documentsDirectory + "/rimedb.json";
    #elseif (android)
        SystemPath.documentsDirectory + "/RIME/rimedb.json";
    #else
        SystemPath.applicationStorageDirectory + "/rimedb.json";
    #end
    private static inline var defaultDBLocation:String = "assets/data/default_database.json";

    private var saveTimer:Timer;
    public var db:Dynamic;
    private var dirty:Bool = false;

    public function new()
    {
        saveTimer = new Timer(SAVE_INTERVAL_MS, 0);
        saveTimer.addEventListener(TimerEvent.TIMER, writeToFile);
        saveTimer.start();
    }

    public function load()
    {
        // Attempt to load user database first
        trace("Attempting to load database: " + userDatabaseFileName);
        if(FileSystem.exists(userDatabaseFileName))
        {
            try
            {
                db = JsonParser.parse(File.getContent(userDatabaseFileName));
                
                if(db.version == CURRENT_DATABASE_VERSION)
                {
                    trace("User Database successfully loaded");
                    return;
                }
                else
                {
                    trace("User Database is out of date, loading default");
                }

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
        trace("Loading default database: " + defaultDBLocation);
        if(Assets.exists(defaultDBLocation))
        {
            try
            {
                var dbText:String = Assets.getText(defaultDBLocation);                
                db = JsonParser.parse(dbText);
                dirty = true;
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

    public function getDeviceID():String
    {
        return db.deviceID;
    }

    public function saveDeviceID(deviceID:String)
    {
        dirty = true;
        db.deviceID = deviceID;
    }

    public function getServerInfo():ServerInfo
    {
        var serverInfo:ServerInfo = new ServerInfo();
        serverInfo.ipAddress = db.serverInfo.ipAddress;
        serverInfo.portNumber = db.serverInfo.portNumber;
        return serverInfo;
    }

    public function getErrors():Array<Dynamic>
    {
        return db.errors != null ? db.errors : new Array<Dynamic>();
    }

    public function writeErrors(errors:Array<Dynamic>)
    {
        writeJSONObj("errors", errors);
    }

    public function saveServerInfo(serverInfo:ServerInfo)
    {
        dirty = true;
        db.serverInfo.ipAddress = serverInfo.ipAddress;
        db.serverInfo.portNumber = serverInfo.portNumber;
    }

    public function writeJSONObj(fieldName:String, value:Dynamic)
    {
        Reflect.setField(db, fieldName, value);
        dirty = true;
    }

    public function writeToFile(?e:TimerEvent)
    {
        if(dirty == false)
        {
            return;
        }

        #if (android)
        if(FileSystem.exists(SystemPath.documentsDirectory + "/RIME") == false)
        {
            FileSystem.createDirectory(SystemPath.documentsDirectory + "/RIME");
        }
        #end

        if(FileSystem.exists(userDatabaseFileName))
        {
            FileSystem.deleteFile(userDatabaseFileName);
        }
        var fileOutput = File.write(userDatabaseFileName, false);
        fileOutput.writeString(Json.stringify(db, null, "\t"));
        fileOutput.close();
        dirty = false;
    }

}