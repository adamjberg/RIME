package views.screens;

import controllers.ScreenManager;
import haxe.ui.toolkit.controls.Button;
import models.sensors.Sensor;
import models.ServerInfo;
import controllers.Client;
import msignal.Signal.Signal0;
import openfl.events.MouseEvent;
import views.screens.*;
import views.screens.Screen;
import views.SensorScrollList;
import views.ServerInfoRenderer;

class SensorsScreen extends Screen {

    private var sensors:Array<Sensor>;

    public function new(?sensors:Array<Sensor>) {
        super();

        this.sensors = sensors;

        var sensorList:SensorScrollList = new SensorScrollList(sensors);
        addChild(sensorList);

        this.onClosed.add(sensorList.stopUpdate);
        this.onOpened.add(sensorList.startUpdate);
    }
}