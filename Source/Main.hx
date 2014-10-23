package;


import openfl.display.Sprite;
import openfl.events.Event;


class Main extends Sprite {
	
	
	public function new () {
		
		super ();

		this.addEventListener(Event.ENTER_FRAME, frame);
	}

	private function frame(e:Event)
	{
		trace("Accel: " + SensorExtension.getAccel());
		trace("Gyro:"+SensorExtension.getGyro());
		trace("Gravity:" +SensorExtension.getGravity());
		trace("Linear Accel:" + SensorExtension.getLnaccel());
		trace("Orientation:"+SensorExtension.getOrient());
		trace("Pressure:"+SensorExtension.getPressure());
		trace("Ambient Temperature:"+SensorExtension.getAmtemp());
		trace("Rotation Vector:"+SensorExtension.getRotvect());
		trace("Proximity:"+ SensorExtension.getProximity());
		trace("Light:"+SensorExtension.getLight());
	

	}
	

	
}