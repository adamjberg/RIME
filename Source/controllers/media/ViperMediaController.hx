package controllers.media;

import controllers.Client;
import controllers.MappingController;
import database.Database;
import models.commands.ViperCreateCommand;
import models.commands.ViperDeleteCommand;
import models.commands.ViperCommand;
import models.mappings.Mapping;
import osc.OscMessage;
import models.media.ViperMedia;
import msignal.Signal.Signal0;
import haxe.io.Bytes;
import haxe.io.BytesInput;

class ViperMediaController {

    private static var currentId:Int = 0;

    public var onUpdated:Signal0 = new Signal0();

    public var mediaList:Array<ViperMedia> = new Array<ViperMedia>();

    public var fileList:Array<String> = new Array<String>();

    private var client:Client;
    private var mappingController:MappingController;

    public function new(?client:Client, ?mappingController:MappingController)
    {
        this.client = client;
        this.mappingController = mappingController;
        loadMediaListFromDB();
    }

    private function loadMediaListFromDB()
    {
        var viperMediaListObj:Array<Dynamic> = Database.instance.db.viperMedia;

        for(viperMediaObj in viperMediaListObj)
        {
            var media:ViperMedia = new ViperMedia();
            media.id = viperMediaObj.id;
            media.filename = viperMediaObj.filename;
            media.type = viperMediaObj.type;
            media.name = viperMediaObj.name;
            media.xPos = viperMediaObj.xPos;
            media.yPos = viperMediaObj.yPos;

            var mapping:Mapping = mappingController.getMappingWithName(viperMediaObj.mapping);
            media.mapping = mapping;
            addMedia(media);

            // If the medias ID is larger than our current id we need to
            // Set the current ID to a bigger number to prevent ID clashes
            if(media.id >= currentId)
            {
                currentId = media.id + 1;
            }
        }
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

        media.mapping.addTarget(media.id);
    }

    public function removeMediaFromViper(media:ViperMedia)
    {
        if(media != null)
        {
            mappingController.removeIdFromAllMappings(media.id);
            var command:ViperDeleteCommand = new ViperDeleteCommand(media.id);
            client.send(command.fillOscMessage());
            media.mapping.removeTarget(media.id);
        }
    }

    public function addMedia(media:ViperMedia)
    {
        if(media != null)
        {
            mediaList.push(media);
            onUpdated.dispatch();
        }
    }

    public function deleteMedia(media:ViperMedia)
    {
        if(media != null)
        {
            removeMediaFromViper(media);
            
            mediaList.remove(media);
            onUpdated.dispatch();
        }
    }

// Requesting media from Viper server
    public function requestMedia()
    {

        // Sends Osc Message to prepare Viper to send RIME the file list
        var message:OscMessage = new OscMessage();
        var command:ViperCommand = new ViperCommand();
        command.method = "dataList";
        client.send(command.fillOscMessage());

        // Preps RIME to receive the message from Viper
        client.setTimeoutReceive(5);
        var str = client.receive(message);


        trace ("String is " + str);
        trace("String is " + str.length + " long.");

        // Parses continuous string into an array of strings to separate names
        var clipName = "";
        var x = 0;
        var fileList:Array<String> = new Array<String>();
        for(x in 0...str.length)
        {
            // Viper's string Uses "," as separator to indicate different objects, use as indicator to move on to next item
            if (str.charAt(x) != ",")
                clipName += str.charAt(x);
            else
            {
            trace(clipName);
            fileList.push(clipName);
            clipName = "";
            }
        }

        trace("FileList: ");
        trace(fileList);
        trace("");

        // Removes the first two objects in the list, as they are just the ID and identifier, not needed in our array.
        fileList.shift();
        fileList.shift();
        trace("Removed first two elements: ");
        trace(fileList);
    }
}