package;

#if cpp
import cpp.Lib;
#elseif neko
import neko.Lib;
#end

#if (android && openfl)
import openfl.utils.JNI;
#end


class SensorExtension {

	public static function getAccel ():Array<Float> {
		
		#if (android && openfl)
		
		var array:Array<Float> = new Array<Float>();
		array.push(sensorextension_get_accel_x());
		array.push(sensorextension_get_accel_y());
		array.push(sensorextension_get_accel_z());
		return array;
		
		#else
		
		var array:Array<Float> = new Array<Float>();
		array.push(Math.random());
		array.push(Math.random());
		array.push(Math.random());
		return array;
		
		#end
		
	}


	public static function getGyro ():Array<Float>{
		#if (android && openfl)
		var array:Array<Float> = new Array<Float>();
		array.push(sensorextension_get_gyro_x());
		array.push(sensorextension_get_gyro_y());
		array.push(sensorextension_get_gyro_z());

		return array;
		
		#else
		
		return null;
		
		#end

	}

	public static function getGravity ():Array<Float>{
		#if (android && openfl)
		var array:Array<Float> = new Array<Float>();
		array.push(sensorextension_get_gravity_x());
		array.push(sensorextension_get_gravity_y());
		array.push(sensorextension_get_gravity_z());

		return array;
		
		#else
		
		return null;
		
		#end

	}

	public static function getLnaccel ():Array<Float>{
		#if (android && openfl)
		var array:Array<Float> = new Array<Float>();
		array.push(sensorextension_get_lnaccel_x());
		array.push(sensorextension_get_lnaccel_y());
		array.push(sensorextension_get_lnaccel_z());

		return array;
		
		#else
		
		return null;
		
		#end

	}

	public static function getOrient ():Array<Float>{
		#if (android && openfl)
		var array:Array<Float> = new Array<Float>();
		array.push(sensorextension_get_orient_x());
		array.push(sensorextension_get_orient_y());
		array.push(sensorextension_get_orient_z());

		return array;
		
		#else
		
		return null;
		
		#end

	}
	public static function getPressure ():Float {
		
		#if (android && openfl)
		
		return sensorextension_get_pressure();
		
		#else
		
		return null;
		
		#end
		
	}

	public static function getAmtemp ():Float {
		
		#if (android && openfl)
		
		return sensorextension_get_amtemp();
		
		#else
		
		return null;
		
		#end
		
	}
	
	public static function getRotvect ():Array<Float>{
		#if (android && openfl)
		var array:Array<Float> = new Array<Float>();
		array.push(sensorextension_get_rotvect_x());
		array.push(sensorextension_get_rotvect_y());
		array.push(sensorextension_get_rotvect_z());
	
		return array;
		
		#else
		
		return null;
		
		#end

	}

	public static function getProximity ():Float {
		
		#if (android && openfl)
		
		return sensorextension_get_proximity();
		
		#else
		
		return null;
		
		#end
		
	}
	public static function getLight ():Float {
		
		#if (android && openfl)
		
		return sensorextension_get_light();
		
		#else
		
		return null;
		
		#end
		
	}
	public static function getMagneticField ():Array<Float>{
		#if (android && openfl)
		var array:Array<Float> = new Array<Float>();
		array.push(sensorextension_get_magfield_x());
		array.push(sensorextension_get_magfield_y());
		array.push(sensorextension_get_magfield_z());
	
		return array;
		
		#else
		
		return null;
		
		#end

	}


	public static function getHumidity ():Float {
		
		#if (android && openfl)
		
		return sensorextension_get_humidity();
		
		#else
		
		return null;
		
		#end
		
	}


	public static function isAccelerometerSupported ():Bool {
		
		#if (android && openfl)
		
		return is_accel_supported();
		
		#else
		
		return true;
		
		#end
		
	}

	public static function isGyroscopeSupported ():Bool {
		
		#if (android && openfl)
		
		return is_gyro_supported();
		
		#else
		
		return false;
		
		#end
		
	}

	public static function isGravitySupported ():Bool {
		
		#if (android && openfl)
		
		return is_gravity_supported();
		
		#else
		
		return false;
		
		#end
		
	}

	public static function isLinearAccelerometerSupported ():Bool {
		
		#if (android && openfl)
		
		return is_lnaccel_supported();
		
		#else
		
		return false;
		
		#end
		
	}

	public static function isOrientationSupported ():Bool {
		
		#if (android && openfl)
		
		return is_orient_supported();
		
		#else
		
		return false;
		
		#end
		
	}

	public static function isPressureSupported ():Bool {
		
		#if (android && openfl)
		
		return is_pressure_supported();
		
		#else
		
		return false;
		
		#end
		
	}

	public static function isAmbientTemperatureSupported ():Bool {
		
		#if (android && openfl)
		
		return is_amtemp_supported();
		
		#else
		
		return false;
		
		#end
		
	}

	public static function isRotationSupported ():Bool {
		
		#if (android && openfl)
		
		return is_rotvect_supported();
		
		#else
		
		return false;
		
		#end
		
	}

	public static function isProximitySupported ():Bool {
		
		#if (android && openfl)
		
		return is_proximity_supported();
		
		#else
		
		return false;
		
		#end
		
	}

	public static function isLightSupported ():Bool {
		
		#if (android && openfl)
		
		return is_light_supported();
		
		#else
		
		return false;
		
		#end
		
	}

	public static function isMagneticSupported ():Bool {
		
		#if (android && openfl)
		
		return is_magfield_supported();
		
		#else
		
		return false;
		
		#end
		
	}

	public static function isHumiditySupported ():Bool {
		
		#if (android && openfl)
		
		return is_humidity_supported();
		
		#else
		
		return false;
		
		#end
		
	}
	
	#if (android && openfl)
	private static var sensorextension_get_accel_x = JNI.createStaticMethod ("org.haxe.extension.SensorExtension", "getAccelX", "()F");
	private static var sensorextension_get_accel_y = JNI.createStaticMethod ("org.haxe.extension.SensorExtension", "getAccelY", "()F");
	private static var sensorextension_get_accel_z = JNI.createStaticMethod ("org.haxe.extension.SensorExtension", "getAccelZ", "()F");

	private static var sensorextension_get_gyro_x = JNI.createStaticMethod ("org.haxe.extension.SensorExtension", "getGyroX", "()F");
	private static var sensorextension_get_gyro_y = JNI.createStaticMethod ("org.haxe.extension.SensorExtension", "getGyroY", "()F");
	private static var sensorextension_get_gyro_z = JNI.createStaticMethod ("org.haxe.extension.SensorExtension", "getGyroZ", "()F");

	private static var sensorextension_get_gravity_x = JNI.createStaticMethod ("org.haxe.extension.SensorExtension", "getGravityX", "()F");
	private static var sensorextension_get_gravity_y = JNI.createStaticMethod ("org.haxe.extension.SensorExtension", "getGravityY", "()F");
	private static var sensorextension_get_gravity_z = JNI.createStaticMethod ("org.haxe.extension.SensorExtension", "getGravityZ", "()F");
	
	private static var sensorextension_get_lnaccel_x = JNI.createStaticMethod ("org.haxe.extension.SensorExtension", "getLnaccelX", "()F");
	private static var sensorextension_get_lnaccel_y = JNI.createStaticMethod ("org.haxe.extension.SensorExtension", "getLnaccelY", "()F");
	private static var sensorextension_get_lnaccel_z = JNI.createStaticMethod ("org.haxe.extension.SensorExtension", "getLnaccelZ", "()F");

	private static var sensorextension_get_orient_x = JNI.createStaticMethod ("org.haxe.extension.SensorExtension", "getOrientX", "()F");
	private static var sensorextension_get_orient_y = JNI.createStaticMethod ("org.haxe.extension.SensorExtension", "getOrientY", "()F");
	private static var sensorextension_get_orient_z = JNI.createStaticMethod ("org.haxe.extension.SensorExtension", "getOrientZ", "()F");
	
	private static var sensorextension_get_pressure = JNI.createStaticMethod ("org.haxe.extension.SensorExtension", "getPressure", "()F");
	private static var sensorextension_get_amtemp = JNI.createStaticMethod ("org.haxe.extension.SensorExtension", "getAmtemp", "()F");

	private static var sensorextension_get_rotvect_x = JNI.createStaticMethod ("org.haxe.extension.SensorExtension", "getRotvectX", "()F");
	private static var sensorextension_get_rotvect_y = JNI.createStaticMethod ("org.haxe.extension.SensorExtension", "getRotvectY", "()F");
	private static var sensorextension_get_rotvect_z = JNI.createStaticMethod ("org.haxe.extension.SensorExtension", "getRotvectZ", "()F");

	private static var sensorextension_get_proximity = JNI.createStaticMethod ("org.haxe.extension.SensorExtension", "getProximity", "()F");
	private static var sensorextension_get_light = JNI.createStaticMethod ("org.haxe.extension.SensorExtension", "getLight", "()F");

	private static var sensorextension_get_magfield_x = JNI.createStaticMethod ("org.haxe.extension.SensorExtension", "getMagfieldX", "()F");
	private static var sensorextension_get_magfield_y = JNI.createStaticMethod ("org.haxe.extension.SensorExtension", "getMagfieldY", "()F");
	private static var sensorextension_get_magfield_z = JNI.createStaticMethod ("org.haxe.extension.SensorExtension", "getMagfieldZ", "()F");
	
	private static var sensorextension_get_humidity = JNI.createStaticMethod ("org.haxe.extension.SensorExtension", "getHumidity", "()F");

	private static var is_accel_supported = JNI.createStaticMethod ("org.haxe.extension.SensorExtension", "getaccelSupported", "()Z");
	private static var is_gyro_supported = JNI.createStaticMethod ("org.haxe.extension.SensorExtension", "getgyroSupported", "()Z");
	private static var is_gravity_supported = JNI.createStaticMethod ("org.haxe.extension.SensorExtension", "getgravitySupported", "()Z");
	private static var is_lnaccel_supported = JNI.createStaticMethod ("org.haxe.extension.SensorExtension", "getlnaccelSupported", "()Z");
	private static var is_orient_supported = JNI.createStaticMethod ("org.haxe.extension.SensorExtension", "getorientSupported", "()Z");
	private static var is_pressure_supported = JNI.createStaticMethod ("org.haxe.extension.SensorExtension", "getpressureSupported", "()Z");
	private static var is_amtemp_supported = JNI.createStaticMethod ("org.haxe.extension.SensorExtension", "getamtempSupported", "()Z");
	private static var is_rotvect_supported = JNI.createStaticMethod ("org.haxe.extension.SensorExtension", "getrotvectSupported", "()Z");
	private static var is_proximity_supported = JNI.createStaticMethod ("org.haxe.extension.SensorExtension", "getproximitySupported", "()Z");
	private static var is_light_supported = JNI.createStaticMethod ("org.haxe.extension.SensorExtension", "getlightSupported", "()Z");
	private static var is_magfield_supported = JNI.createStaticMethod ("org.haxe.extension.SensorExtension", "getmagfieldSupported", "()Z");
	private static var is_humidity_supported = JNI.createStaticMethod ("org.haxe.extension.SensorExtension", "gethumiditySupported", "()Z");

	#end
	
	
}