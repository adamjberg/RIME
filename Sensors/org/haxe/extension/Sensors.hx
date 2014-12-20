package org.haxe.extension;

#if cpp
import cpp.Lib;
#elseif neko
import neko.Lib;
#end

#if (android && openfl)
import openfl.utils.JNI;
#end

@:build(ShortCuts.mirrors()) 
class Sensors {
	
	#if (android && openfl)
		@JNI public static function getAccel():Array<Float>;
        @JNI public static function getGyro():Array<Float>;
        @JNI public static function getGravity():Array<Float>;
        @JNI public static function getLnaccel():Array<Float>;
        @JNI public static function getOrient():Array<Float>;
        @JNI public static function getPressure():Float;
        @JNI public static function getAmtemp():Float;
        @JNI public static function getRotvect():Array<Float>;
        @JNI public static function getProximity():Float;
        @JNI public static function getLight():Float;
        @JNI public static function getMagneticField():Array<Float>;
        @JNI public static function getHumidity():Float;

        @JNI public static function isAccelerometerSupported():Bool;
        @JNI public static function isGyroscopeSupported():Bool;
        @JNI public static function isGravitySupported():Bool;
        @JNI public static function isLinearAccelerometerSupported():Bool;
        @JNI public static function isOrientationSupported():Bool;
        @JNI public static function isPressureSupported():Bool;
        @JNI public static function isAmbientTemperatureSupported():Bool;
        @JNI public static function isRotationSupported():Bool;
        @JNI public static function isProximitySupported():Bool;
        @JNI public static function isLightSupported():Bool;
        @JNI public static function isMagneticFieldSupported():Bool;
        @JNI public static function isHumiditySupported():Bool;
    #else

	#end

}