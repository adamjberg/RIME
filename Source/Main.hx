package;

import views.*;

import haxe.io.Bytes;
import haxe.ui.toolkit.containers.VBox;
import haxe.ui.toolkit.controls.Button;
import haxe.ui.toolkit.core.Root;
import haxe.ui.toolkit.core.Toolkit;
import haxe.ui.toolkit.themes.GradientMobileTheme;

import openfl.display.Sprite;
import openfl.events.MouseEvent;

import hxudp.UdpSocket;

class Main extends Sprite {
	
	private var vBox:VBox;
	private var sendButton:Button;

	public function new () {
		super ();

		vBox = new VBox();
		vBox.percentWidth = 100;
		vBox.percentHeight = 100;

		Toolkit.theme = new GradientMobileTheme();
		Toolkit.init();
		Toolkit.openFullscreen(function(root:Root) {
			root.addChild(vBox);

			sendButton = new Button();
			sendButton.text = "send";
			vBox.addChild(sendButton);
			sendButton.addEventListener(MouseEvent.CLICK, function(e) {
				var udpSock = new UdpSocket();
				udpSock.create();
				udpSock.connect("127.0.0.1", 12000);
				var bytes:Bytes = Bytes.ofString("I am the King");
				udpSock.send(bytes);
				udpSock.close();
			});
		});
	}
	
	
}