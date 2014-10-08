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
	
	
	public static function sampleMethod (inputValue:Int):Int {
		
		#if (android && openfl)
		
		var resultJNI = sensorextension_sample_method_jni(inputValue);
		var resultNative = sensorextension_sample_method(inputValue);
		
		if (resultJNI != resultNative) {
			
			throw "Fuzzy math!";
			
		}
		
		return resultNative;
		
		#else
		
		return sensorextension_sample_method(inputValue);
		
		#end
		
	}
	
	
	private static var sensorextension_sample_method = Lib.load ("sensorextension", "sensorextension_sample_method", 1);
	
	#if (android && openfl)
	private static var sensorextension_sample_method_jni = JNI.createStaticMethod ("org.haxe.extension.SensorExtension", "sampleMethod", "(I)I");
	#end
	
	
}