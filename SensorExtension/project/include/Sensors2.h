#ifndef SENSOREXTENSION_H
#define SENSOREXTENSION_H

namespace SensorExtension{

	void init();
	float getiaccelX();
	float getiaccelY();
	float getiaccelZ();
	
	float getigyroX();
	float getigyroY();
	float getigyroZ();
	
	float getiMagX();
	float getiMagY();
	float getiMagZ();

	float getirotX();
	float getirotY();
	float getirotZ();

	float getigravX();
	float getigravY();
	float getigravZ();

	bool isMagAvailable();
	bool isdeviceMotionAvailalbe();
	bool isAccelerometerAvailable();
	bool isGyroAvailable();

	float getiuseraccelX();
	float getiuseraccelY();
	float getiuseraccelZ();

	float getiorientRoll();
	float getiorientPitch();
	float getiorientYaw();
}

#endif

