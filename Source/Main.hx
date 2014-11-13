package;


import openfl.display.Sprite;
import openfl.events.Event;


class Main extends Sprite {
	
	




	
	public function new () {
		
		super ();

		this.addEventListener(Event.ENTER_FRAME, frame);
		SensorExtension.init();
	}

	private function frame(e:Event)
	{
		trace("Accel: " + SensorExtension.getaccelSupported() + SensorExtension.getAccel());
		trace("Gyro:"+SensorExtension.getgyroSupported()+SensorExtension.getGyro());
		trace("Gravity:" +SensorExtension.getgravitySupported()+SensorExtension.getGravity());
		trace("Linear Accel:" + SensorExtension.getlnaccelSupported()+SensorExtension.getLnaccel());
		trace("Orientation:"+SensorExtension.getorientSupported()+SensorExtension.getOrient());
		trace("Rotation Vector:"+SensorExtension.getrotvectSupported()+SensorExtension.getRotvect());
		trace("Magnetic Field:"+SensorExtension.getmagfieldSupported()+SensorExtension.getMagfield());
		trace("Pressure:"+SensorExtension.getpressureSupported()+SensorExtension.getPressure());
		trace("Ambient Temperature:"+SensorExtension.getamtempSupported()+SensorExtension.getAmtemp());
		trace("Proximity:"+ SensorExtension.getproximitySupported()+SensorExtension.getProximity());
		trace("Light:"+SensorExtension.getlightSupported()+SensorExtension.getLight());
		trace("Humidity:"+SensorExtension.gethumiditySupported()+SensorExtension.getHumidity());
	

	}
	
	
	
}