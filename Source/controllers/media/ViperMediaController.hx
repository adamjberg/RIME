package controllers.media;

import controllers.Client;
import database.Database;
import models.commands.ViperCreateCommand;
import models.commands.ViperDeleteCommand;
import models.commands.ViperCommand;
import osc.OscMessage;
import models.media.ViperMedia;
import msignal.Signal.Signal0;
import haxe.io.Bytes;
import haxe.io.BytesInput;
import haxe.Timer;

class ViperMediaController {

    private static var currentId:Int = 0;

    public var onUpdated:Signal0 = new Signal0();

    public var mediaList:Array<ViperMedia> = new Array<ViperMedia>();

    public var fileList:Array<String> = new Array<String>();

    private var client:Client;

    public function new(?client:Client)
    {
        this.client = client;
        fileList.push("None");
    }

    public function loadMediaListFromDB()
    {
        var viperMediaListObj:Array<Dynamic> = Database.instance.db.viperMedia;
        if(viperMediaListObj == null)
        {
            return;
        }

        for(viperMediaObj in viperMediaListObj)
        {
            var media:ViperMedia = new ViperMedia();
            media.id = viperMediaObj.id;
            media.filename = viperMediaObj.filename;
            media.type = viperMediaObj.type;
            media.name = viperMediaObj.name;
            media.xPos = viperMediaObj.xPos;
            media.yPos = viperMediaObj.yPos;

            // If the medias ID is larger than our current id we need to
            // Set the current ID to a bigger number to prevent ID clashes
            if(media.id >= currentId)
            {
                currentId = media.id + 1;
            }

            mediaList.push(media);
        }
    }

    public function getViperMediaByName(mediaName:String):ViperMedia
    {
        for(viperMedia in mediaList)
        {
            if(viperMedia.name == mediaName)
            {
                return viperMedia;
            }
        }
        return null;
    }

    public function getMediaFromFilename(fileName:String):ViperMedia
    {
        var media:ViperMedia = new ViperMedia(currentId, fileName);
        currentId++;
        return media;
    }

    public function createMediaOnViper(media:ViperMedia)
    {
        var command:ViperCreateCommand = new ViperCreateCommand(media.id);
        command.addParam(media.type, media.filename);
        command.addParam("posX", media.xPos);
        command.addParam("posY", media.yPos);
        client.send(command.fillOscMessage());
    }

    public function removeMediaFromViper(media:ViperMedia)
    {
        if(media != null)
        {
            var command:ViperDeleteCommand = new ViperDeleteCommand(media.id);
            client.send(command.fillOscMessage());
        }
    }

    public function addMedia(media:ViperMedia)
    {
        if(media != null)
        {
            mediaList.push(media);
            onUpdated.dispatch();
            writeToDatabase();
        }
    }

    public function deleteMedia(media:ViperMedia)
    {
        if(media != null)
        {
            removeMediaFromViper(media);
            
            mediaList.remove(media);
            onUpdated.dispatch();
            writeToDatabase();
        }
    }

    private function writeToDatabase()
    {
        var viperMediaListObj:Array<Dynamic> = new Array<Dynamic>();

        for(media in mediaList)
        {
            var viperMediaObj:Dynamic = {};
            viperMediaObj.name = media.name;
            viperMediaObj.filename = media.filename;
            viperMediaObj.id = media.id;
            viperMediaObj.type = media.type;
            viperMediaObj.xPos = media.xPos;
            viperMediaObj.yPos = media.yPos;

            viperMediaListObj.push(viperMediaObj);
        }

        Database.instance.writeJSONObj("viperMedia", viperMediaListObj);
    }

    public function requestMedia()
    {
        // Send a request for media on Viper
        var command:ViperCommand = new ViperCommand(null,"datalist");
        client.send(command.fillOscMessage());

        var responseMessage:OscMessage =  client.receive();

        fileList = new Array<String>();
        if(responseMessage != null)
        {
            for(arg in responseMessage.arguments)
            {
                fileList.push(arg);
            }
        }
        // TODO: There should be a check before the user is shown
        // a list with just this value
        // (maybe give the option to type the filename?)
        else
        {
            fileList.push("None");
        }
    }
}