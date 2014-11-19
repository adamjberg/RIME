package controllers.media;

import controllers.Client;
import models.commands.ViperCreateCommand;
import models.commands.ViperDeleteCommand;
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
            var command:ViperDeleteCommand = new ViperDeleteCommand(media.id);
            client.send(command.fillOscMessage());
            
            activeMediaList.remove(media);
            onUpdated.dispatch();
        }
    }
}