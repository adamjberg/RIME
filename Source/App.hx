package;

import controllers.ScreenManager;
import haxe.ui.toolkit.containers.Stack;
import haxe.ui.toolkit.containers.VBox;
import models.sensors.Sensor;
import models.sensors.Accelerometer;
import models.ServerInfo;
import controllers.Client;
import views.HeaderBar;
import views.HomeScreen;

class App extends VBox {

    private var headerBar:HeaderBar;
    private var homeScreen:HomeScreen;

    private var stack:Stack;
    private var client:Client;
    private var sensors:Array<Sensor>;
    private var accelerometer:Sensor;

    public function new () {
        super();

        percentWidth = 100;
        percentHeight = 100;
        style.backgroundColor = 0xDDDDDD;
        style.paddingBottom = 10;

        headerBar = new HeaderBar();
        addChild(headerBar);

        stack = new Stack();
        stack.percentHeight = 100;
        stack.percentWidth = 100;
        ScreenManager.init(stack, headerBar);
        addChild(stack);

        accelerometer = new Accelerometer();
        sensors = [
            accelerometer
        ];

        #if !neko
            client = new Client(serverInfo, sensors);
        #end

        homeScreen = new HomeScreen(
            headerBar,
            sensors,
            client
        );

        ScreenManager.push(homeScreen);
    }
}