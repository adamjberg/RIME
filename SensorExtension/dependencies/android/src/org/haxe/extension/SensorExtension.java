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

	public static float getAccelX() {
		return accel[0];
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
	}
	
	@Override
	public void onAccuracyChanged(Sensor sensor, int accuracy) {	
	}

	@Override
	public void onSensorChanged(SensorEvent event) {        
	    if(event.sensor.getType() == Sensor.TYPE_ACCELEROMETER) {
	    	accel = event.values;
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