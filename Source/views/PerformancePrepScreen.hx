package views;
import controllers.Client;
import controllers.ScreenManager;
import flash.events.MouseEvent;
import haxe.ui.toolkit.containers.Container;
import haxe.ui.toolkit.controls.Button;
import haxe.ui.toolkit.controls.Text;
import openfl.events.MouseEvent;
import osc.OscMessage;
import views.PerformanceScreen;

class PerformancePrepScreen extends Container {

    private var client:Client;

    public function new(?client:Client)
    {
        super();

        this.client = client;

        this.percentWidth = 100;
        this.percentHeight = 100;

        var instructionalText:Text = new Text(); 
        instructionalText.text = "inscrutions n shit!";
 		addChild(instructionalText); 

 		var openPerformanceScreenButton:Button = new Button(); 
 		openPerformanceScreenButton.text = "Start Performance!"; 
 		openPerformanceScreenButton.percentWidth = 100; 
 		openPerformanceScreenButton.percentHeight = 10; 
 		openPerformanceScreenButton.addEventListener(MouseEvent.CLICK, openPerformanceScreen);
 		addChild(openPerformanceScreenButton); 

    }

    private function openPerformanceScreen(e:MouseEvent)
    {
    	ScreenManager.push( new PerformanceScreen(client)); 
    }
}