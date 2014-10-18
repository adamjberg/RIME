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

	public static function getAccelX ():Int {
		
		#if (android && openfl)
		
		return sensorextension_get_accel_x();
		
		#else
		
		return 0;
		
		#end
		
	}
	
	
	/*private static var sensorextension_sample_method = Lib.load ("sensorextension", "sensorextension_sample_method", 1);*/
	
	#if (android && openfl)
	private static var sensorextension_get_accel_x = JNI.createStaticMethod ("org.haxe.extension.SensorExtension", "getAccelX", "()F");
	#end
	
	
}