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
		
		return null;
		
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
		
		return 0;
		
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
		
		return 0;
		
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
		
		return 0;
		
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
		
		return 0;
		
		#end

	}
	public static function getPressure ():Float {
		
		#if (android && openfl)
		
		return sensorextension_get_pressure();
		
		#else
		
		return 0;
		
		#end
		
	}

	public static function getAmtemp ():Float {
		
		#if (android && openfl)
		
		return sensorextension_get_amtemp();
		
		#else
		
		return 0;
		
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
		
		return 0;
		
		#end

	}

	public static function getProximity ():Float {
		
		#if (android && openfl)
		
		return sensorextension_get_proximity();
		
		#else
		
		return 0;
		
		#end
		
	}
	public static function getLight ():Float {
		
		#if (android && openfl)
		
		return sensorextension_get_light();
		
		#else
		
		return 0;
		
		#end
		
	}


	// public static function getHumidity ():Float {
		
	// 	#if (android && openfl)
		
	// 	return sensorextension_get_humidity();
		
	// 	#else
		
	// 	return 0;
		
	// 	#end
		
	// }

	// public static function getMagfield ():Array<Float>{
	// 	#if (android && openfl)
	// 	var array:Array<Float> = new Array<Float>();
	// 	array.push(sensorextension_get_magfield_x());
	// 	array.push(sensorextension_get_magfield_y());
	// 	array.push(sensorextension_get_magfield_z());
	
	// 	return array;
		
	// 	#else
		
	// 	return 0;
		
	// 	#end

	// }

	
	
	/*private static var sensorextension_sample_method = Lib.load ("sensorextension", "sensorextension_sample_method", 1);*/
	
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
	private static var sensorextension_get_rotvect_cos = JNI.createStaticMethod ("org.haxe.extension.SensorExtension", "getRotvectCOS", "()F");
	private static var sensorextension_get_rotvect_est = JNI.createStaticMethod ("org.haxe.extension.SensorExtension", "getRotvectEst", "()F");

	private static var sensorextension_get_proximity = JNI.createStaticMethod ("org.haxe.extension.SensorExtension", "getProximity", "()F");
	private static var sensorextension_get_light = JNI.createStaticMethod ("org.haxe.extension.SensorExtension", "getLight", "()F");

	


	#end
	
	
}