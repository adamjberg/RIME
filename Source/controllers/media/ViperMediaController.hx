package controllers.media;

import controllers.Client;
import controllers.MappingController;
import models.commands.ViperCreateCommand;
import models.commands.ViperDeleteCommand;
import models.commands.ViperCommand;
import models.commands.ViperMessage;
import osc.OscMessage;
import models.media.ViperMedia;
import msignal.Signal.Signal0;
import haxe.io.Bytes;
import haxe.io.BytesInput;

class ViperMediaController {

    private static var currentId:Int = 0;

    public var onUpdated:Signal0 = new Signal0();

    public var activeMediaList:Array<ViperMedia> = new Array<ViperMedia>();

    public var fileList:Array<String> = new Array<String>();

    private var client:Client;
    private var mappingController:MappingController;

    public function new(?client:Client, ?mappingController:MappingController)
    {
        this.client = client;
        this.mappingController = mappingController;
    }

    public function addMediaFromFilename(fileName:String)
    {
        var media:ViperMedia = new ViperMedia(currentId, fileName);
        currentId++;
        addMedia(media);
    }

    private function addMedia(media:ViperMedia)
    {
        if(media != null)
        {
            var command:ViperCreateCommand = new ViperCreateCommand(media.id);
            command.addParam("image", media.filename);
            command.addParam("posX", 100);
            command.addParam("posY", 100);
            client.send(command.fillOscMessage());

            activeMediaList.push(media);
            onUpdated.dispatch();
        }
    }

    public function deleteMedia(media:ViperMedia)
    {
        if(media != null)
        {
            mappingController.removeIdFromAllMappings(media.id);
            var command:ViperDeleteCommand = new ViperDeleteCommand(media.id);
            client.send(command.fillOscMessage());
            
            activeMediaList.remove(media);
            onUpdated.dispatch();
        }
    }

// Requesting media from Viper server
    public function requestMedia()
    {
        var message:OscMessage = new OscMessage();
        var command:ViperCommand = new ViperCommand();
        command.method = "dataList";
        client.send(command.fillOscMessage());
        var str = client.receive(message);

        trace ("String is " + str);
        trace("String is " + str.length + " long.");

        var clipName = "";
        var x = 0;
        var fileList:Array<String> = new Array<String>();
        for(x in 0...str.length)
        {
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
        fileList.shift();
        fileList.shift();
        trace("Removed first two elements: ");
        trace(fileList);
    }
}