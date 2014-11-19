package controllers.media;

import controllers.Client;
import models.commands.ViperCreateCommand;
import models.commands.ViperDeleteCommand;
import models.commands.ViperCommand;
import models.commands.ViperMessage;
import osc.OscMessage;
import models.media.ViperMedia;
import msignal.Signal.Signal0;

class ViperMediaController {

    private static var currentId:Int = 0;

    public var onUpdated:Signal0 = new Signal0();

    public var activeMediaList:Array<ViperMedia> = new Array<ViperMedia>();

    private var client:Client;

    public function new(?client:Client)
    {
        this.client = client;
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
            command.addParam("filename", media.filename);
            client.send(command.fillOscMessage());

            activeMediaList.push(media);
            onUpdated.dispatch();
        }
    }

    public function deleteMedia(media:ViperMedia)
    {
        if(media != null)
        {
            var command:ViperDeleteCommand = new ViperDeleteCommand(media.id);
            command.addParam("filename", media.filename);
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
        client.receive(message);
    }
}