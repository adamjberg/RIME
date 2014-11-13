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


	public static function init (){
		
		sensorsextension_init();
		
	}





	public static function getAccel ():Array<Float> {
		
		#if (android && openfl)
		
		var array:Array<Float> = new Array<Float>();
		array.push(sensorextension_get_accel_x());
		array.push(sensorextension_get_accel_y());
		array.push(sensorextension_get_accel_z());
		return array;
		
		#end

		#if (ios && openfl)
		var array:Array<Float> = new Array<Float>();
		array.push(sensorsextension_get_iuseraccelX());
		array.push(sensorsextension_get_iuseraccelX());
		array.push(sensorsextension_get_iuseraccelX());
		return array;
		
		#end
		return null;
	}


	public static function getGyro ():Array<Float>{
		#if (android && openfl)
		var array:Array<Float> = new Array<Float>();
		array.push(sensorextension_get_gyro_x());
		array.push(sensorextension_get_gyro_y());
		array.push(sensorextension_get_gyro_z());

		return array;
		
		


		#end

		#if (ios && openfl)
		var array:Array<Float> = new Array<Float>();
		array.push(sensorsextension_get_igyroX());
		array.push(sensorsextension_get_igyroY());
		array.push(sensorsextension_get_igyroZ());
		return array;

		#end
		return null;

	}

	public static function getGravity ():Array<Float>{
		#if (android && openfl)
		var array:Array<Float> = new Array<Float>();
		array.push(sensorextension_get_gravity_x());
		array.push(sensorextension_get_gravity_y());
		array.push(sensorextension_get_gravity_z());

		return array;

		#end

		#if (ios && openfl)
		var array:Array<Float> = new Array<Float>();
		array.push(sensorsextension_get_igravX());
		array.push(sensorsextension_get_igravY());
		array.push(sensorsextension_get_igravZ());

		return array;
		
		
		#end

	}

	public static function getLnaccel ():Array<Float>{
		#if (android && openfl)
		var array:Array<Float> = new Array<Float>();
		array.push(sensorextension_get_lnaccel_x());
		array.push(sensorextension_get_lnaccel_y());
		array.push(sensorextension_get_lnaccel_z());

		return array;

	
		
		#end
		#if (ios && openfl)
		
		var array:Array<Float> = new Array<Float>();
		array.push(sensorsextension_get_iaccelX());
		array.push(sensorsextension_get_iaccelX());
		array.push(sensorsextension_get_iaccelX());

		return array;
		
		#end
		return null;

	}

	public static function getOrient ():Array<Float>{
		#if (android && openfl)
		var array:Array<Float> = new Array<Float>();
		array.push(sensorextension_get_orient_x());
		array.push(sensorextension_get_orient_y());
		array.push(sensorextension_get_orient_z());

		return array;

		#end
		
		#if (ios && openfl)
		var array:Array<Float> = new Array<Float>();
		array.push(sensorsextension_get_iorientX());
		array.push(sensorsextension_get_iorientX());
		array.push(sensorsextension_get_iorientX());

		return array;
		
		
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
		#end
		
		#if (ios && openfl)
		var array:Array<Float> = new Array<Float>();
		array.push(sensorsextension_get_irotX());
		array.push(sensorsextension_get_irotX());
		array.push(sensorsextension_get_irotX());
	
		return array;
		
		
		#end
		return null;

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
	public static function getMagfield ():Array<Float>{
		#if (android && openfl)
		var array:Array<Float> = new Array<Float>();
		array.push(sensorextension_get_magfield_x());
		array.push(sensorextension_get_magfield_y());
		array.push(sensorextension_get_magfield_z());
	
		return array;
		
		#end

		#if (ios && openfl)

		var array:Array<Float> = new Array<Float>();
		array.push(sensorsextension_get_iMagX());
		array.push(sensorsextension_get_iMagY());
		array.push(sensorsextension_get_iMagZ());
	
		return array;
		
		#end
		return null;

	}


	public static function getHumidity ():Float {
		
		#if (android && openfl)
		
		return sensorextension_get_humidity();
		
		#else
		
		return 0;
		
		#end
		
	}


	public static function getaccelSupported ():String {
		
		#if (android && openfl)
		
		return is_accel_supported();
		
		#end
		#if (ios && openfl)
		
		return is_iDMSupported();
		
		#end

		return null;
		
	}

	public static function getgyroSupported ():String {
		
		#if (android && openfl)
		
		return is_gyro_supported();
		
		#end

		#if (ios && openfl)
		return is_igyroSupported();
		
		#end
		return null;
		
	}

	public static function getgravitySupported ():String {
		
		#if (android && openfl)
		
		return is_gravity_supported();
		
		#end

		#if (ios && openfl)
		
		return is_iDMSupported();
		
		#end
		
	}

	public static function getlnaccelSupported ():String {
		
		#if (android && openfl)
		
		return is_lnaccel_supported();
		
		#end

		#if (ios && openfl)
		
		return is_ilnaccelSupported();
		
		#end
		
	}

	public static function getorientSupported ():String {
		
		#if (android && openfl)
		
		return is_orient_supported();
		
		#end
		#if (ios && openfl)
		
		return is_iDMSupported();
		
		#end
		return null;
		
	}

	public static function getpressureSupported ():String {
		
		#if (android && openfl)
		
		return is_pressure_supported();
		
		#else
		
		return null;
		
		#end
		
	}

	public static function getamtempSupported ():String {
		
		#if (android && openfl)
		
		return is_amtemp_supported();
		
		#else
		
		return null;
		
		#end
		
	}

	public static function getrotvectSupported ():String {
		
		#if (android && openfl)
		
		return is_rotvect_supported();
		
		#end

		#if (ios && openfl)
		
		return is_iDMSupported();
		
		#end
		
	}

	public static function getproximitySupported ():String {
		
		#if (android && openfl)
		
		return is_proximity_supported();
		
		#else
		
		return null;
		
		#end
		
	}

	public static function getlightSupported ():String {
		
		#if (android && openfl)
		
		return is_light_supported();
		
		#else
		
		return null;
		
		#end
		
	}

	public static function getmagfieldSupported ():String {
		
		#if (android && openfl)
		
		return is_magfield_supported();
		
		#end

		#if (ios && openfl)

		return is_iDMSupported();
		
		#end
		return null;
		
	}

	public static function gethumiditySupported ():String {
		
		#if (android && openfl)
		
		return is_humidity_supported();
		
		#else
		
		return null;
		
		#end
		
	}






	
	
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
	#if (ios && openfl)
	private static var sensorsextension_init = Lib.load("SensorExtension", "sensorsextension_init", 0);
	private static var sensorsextension_get_iaccelX = Lib.load("SensorExtension", "sensorsextension_getiaccelX", 0);
	private static var sensorsextension_get_iaccelY = Lib.load("SensorExtension", "sensorsextension_getiaccelY", 0);
	private static var sensorsextension_get_iaccelZ = Lib.load("SensorExtension", "sensorsextension_getiaccelZ", 0);
	private static var is_ilnaccelSupported= Lib.load("SensorExtension", "sensorsextension_isAccelAvailable", 0);

	private static var sensorsextension_get_iuseraccelX = Lib.load("SensorExtension", "sensorsextension_getiuseraccelX", 0);
	private static var sensorsextension_get_iuseraccelY = Lib.load("SensorExtension", "sensorsextension_getiuseraccelY", 0);
	private static var sensorsextension_get_iuseraccelZ = Lib.load("SensorExtension", "sensorsextension_getiuseraccelZ", 0);


	private static var sensorsextension_get_igyroX = Lib.load("SensorExtension", "sensorsextension_getigyroX", 0);
	private static var sensorsextension_get_igyroY = Lib.load("SensorExtension", "sensorsextension_getigyroY", 0);
	private static var sensorsextension_get_igyroZ = Lib.load("SensorExtension", "sensorsextension_getigyroZ", 0);
	
	private static var sensorsextension_get_iorientX = Lib.load("SensorExtension", "sensorsextension_getiorientX", 0);
	private static var sensorsextension_get_iorientY = Lib.load("SensorExtension", "sensorsextension_getiorientY", 0);
	private static var sensorsextension_get_iorientZ = Lib.load("SensorExtension", "sensorsextension_getiorientZ", 0);
	
	private static var sensorsextension_get_iMagX = Lib.load("SensorExtension", "sensorsextension_getiMagX", 0);
	private static var sensorsextension_get_iMagY = Lib.load("SensorExtension", "sensorsextension_getiMagY", 0);
	private static var sensorsextension_get_iMagZ = Lib.load("SensorExtension", "sensorsextension_getiMagZ", 0);

	private static var sensorsextension_get_irotX = Lib.load("SensorExtension", "sensorsextension_getirotX", 0);
	private static var sensorsextension_get_irotY = Lib.load("SensorExtension", "sensorsextension_getirotY", 0);
	private static var sensorsextension_get_irotZ = Lib.load("SensorExtension", "sensorsextension_getirotZ", 0);

	private static var sensorsextension_get_igravX = Lib.load("SensorExtension", "sensorsextension_getigravX", 0);
	private static var sensorsextension_get_igravY = Lib.load("SensorExtension", "sensorsextension_getigravY", 0);
	private static var sensorsextension_get_igravZ = Lib.load("SensorExtension", "sensorsextension_getigravZ", 0);



	private static var is_igyroSupported= Lib.load("SensorExtension", "sensorsextension_isGyroAvailable", 0);
	private static var is_iDMSupported= Lib.load("SensorExtension", "sensorsextension_isDMAvailable", 0);

	

	#end
	
	
}