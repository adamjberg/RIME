package org.haxe.extension;

import android.app.Activity;
import android.content.res.AssetManager;
import android.content.Context;
import android.content.Intent;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;
import android.view.View;


public class SensorExtension extends Extension implements SensorEventListener {
	

	public static float[] accel = new float[3];
	public static float[] gyroscope = new float[3];
	public static float[] gravity = new float[3];
	public static float[] lnaccel = new float[3];
	public static float[] orient = new float[3];
	public static float pressure=0.0f;
	public static float amtemp=0.0f;
	public static float[] rotvect=new float[5];
	public static float proximity=0.0f;
	public static float light=0.0f;
	public static float[] magfield = new float[3];
	public static float humidity=0.0f;

	
	

	/*Accelerometer get method */
	public static float getAccelX(){
		return accel[0];
	}
	public static float getAccelY() {

		return accel[1];
	}
	public static float getAccelZ() {

		return accel[2];
	}
	/*Gyroscope get method */
	public static float getGyroX() {
		return gyroscope[0];
	}
	public static float getGyroY() {
		return gyroscope[1];
	}
	public static float getGyroZ() {
		return gyroscope[2];
	}
	/*Gravity get method */
	public static float getGravityX() {
		return gravity[0];
	}

	public static float getGravityY() {
		return gravity[1];
	}
	public static float getGravityZ() {
		return gravity[2];
	}
	/*Linear Acceleration get method */
	public static float getLnaccelX() {
		return lnaccel[0];
	}

	public static float getLnaccelY() {
		return lnaccel[1];
	}
	public static float getLnaccelZ() {
		return lnaccel[2];
	}

	/*Orientation get method */
	public static float getOrientX() {
		return orient[0];
	}

	public static float getOrientY() {
		return orient[1];
	}
	public static float getOrientZ() {
		return orient[2];
	}
	/*Pressure get method */
	public static float getPressure() {
		return pressure;
	}
	/*Temperature get method*/
	public static float getAmtemp() {
		return amtemp;
	}
	/*Rotation Vetor get method */
	public static float getRotvectX() {
		return rotvect[0];
	}
	public static float getRotvectY() {
		return rotvect[1];
	}
	public static float getRotvectZ() {
		return rotvect[2];
	}
	// public static float getRotvectCOS() {
	// 	return rotvect[3];
	// }
	// public static float getRotvectEst() {
		
	// 	return rotvect[4];
	// }
	/*Proximity get Method*/
	public static float getProximity() {
		return proximity;
	}
	/*Light get method */
	public static float getLight() {
		return light;
	}






	/**
	 * Called when an activity you launched exits, giving you the requestCode 
	 * you started it with, the resultCode it returned, and any additional data 
	 * from it.
	 */
	public boolean onActivityResult (int requestCode, int resultCode, Intent data) {
		
		return true;
	}
	
	
	/**
	 * Called when the activity is starting.
	 */
	public void onCreate (Bundle savedInstanceState) {
		
		SensorManager sm = (SensorManager) Extension.mainActivity.getSystemService(Context.SENSOR_SERVICE);
		
		sm.registerListener(this, sm.getDefaultSensor(Sensor.TYPE_ACCELEROMETER), 0);
		sm.registerListener(this, sm.getDefaultSensor(Sensor.TYPE_GYROSCOPE), 0);
		sm.registerListener(this, sm.getDefaultSensor(Sensor.TYPE_GRAVITY), 0);
		sm.registerListener(this, sm.getDefaultSensor(Sensor.TYPE_LINEAR_ACCELERATION), 0);
		sm.registerListener(this, sm.getDefaultSensor(Sensor.TYPE_ORIENTATION), 0);
		sm.registerListener(this, sm.getDefaultSensor(Sensor.TYPE_PRESSURE), 0);
		sm.registerListener(this, sm.getDefaultSensor(Sensor.TYPE_AMBIENT_TEMPERATURE), 0);
		sm.registerListener(this, sm.getDefaultSensor(Sensor.TYPE_ROTATION_VECTOR), 0);
		sm.registerListener(this, sm.getDefaultSensor(Sensor.TYPE_PROXIMITY), 0);
		sm.registerListener(this, sm.getDefaultSensor(Sensor.TYPE_LIGHT), 0);



	}
	
	@Override
	public void onAccuracyChanged(Sensor sensor, int accuracy) {	
	}

	@Override
	public void onSensorChanged(SensorEvent event) {        
	    if(event.sensor.getType() == Sensor.TYPE_ACCELEROMETER) {
	    	accel = event.values;
		}
		if(event.sensor.getType() == Sensor.TYPE_GYROSCOPE) {
			gyroscope = event.values;
		}
		if(event.sensor.getType() == Sensor.TYPE_GRAVITY) {
			gravity = event.values;
		}
		if(event.sensor.getType() == Sensor.TYPE_LINEAR_ACCELERATION) {
			lnaccel = event.values;
		}
		if(event.sensor.getType() == Sensor.TYPE_ORIENTATION) {
			orient = event.values;
		}
		if(event.sensor.getType() == Sensor.TYPE_PRESSURE) {
			pressure = event.values[0];
		}
		if(event.sensor.getType() == Sensor.TYPE_AMBIENT_TEMPERATURE) {
			amtemp = event.values[0];
		}
		if(event.sensor.getType() == Sensor.TYPE_ROTATION_VECTOR) {
			rotvect = event.values;
		}
		if(event.sensor.getType() == Sensor.TYPE_PROXIMITY) {
			proximity = event.values[0];
		}
		if(event.sensor.getType() == Sensor.TYPE_LIGHT) {
			light = event.values[0];
		}
		
	}
	
	/**
	 * Perform any final cleanup before an activity is destroyed.
	 */
	public void onDestroy () {	
	}
	
	
	/**
	 * Called as part of the activity lifecycle when an activity is going into
	 * the background, but has not (yet) been killed.
	 */
	public void onPause () {
	}
	
	
	/**
	 * Called after {@link #onStop} when the current activity is being 
	 * re-displayed to the user (the user has navigated back to it).
	 */
	public void onRestart () {
	}
	
	
	/**
	 * Called after {@link #onRestart}, or {@link #onPause}, for your activity 
	 * to start interacting with the user.
	 */
	public void onResume () {		
	}
	
	
	/**
	 * Called after {@link #onCreate} &mdash; or after {@link #onRestart} when  
	 * the activity had been stopped, but is now again being displayed to the 
	 * user.
	 */
	public void onStart () {	
	}
	
	
	/**
	 * Called when the activity is no longer visible to the user, because 
	 * another activity has been resumed and is covering this one. 
	 */
	public void onStop () {
	}
	
	
}