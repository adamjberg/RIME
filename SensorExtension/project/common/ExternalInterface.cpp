#ifndef STATIC_LINK
#define IMPLEMENT_API
#endif

#if defined(HX_WINDOWS) || defined(HX_MACOS) || defined(HX_LINUX)
#define NEKO_COMPATIBLE
#endif

#if defined(IPHONE)

#include <hx/CFFI.h>
#include "Sensors2.h"

using namespace SensorExtension;

//sensor initialization
static void sensorsextension_init(){
	 SensorExtension::init();
}
DEFINE_PRIM(sensorsextension_init, 0);
//end

//accelerometer get method
static value sensorsextension_getiaccelX(){
	return alloc_float(SensorExtension::getiaccelX());
}
DEFINE_PRIM(sensorsextension_getiaccelX, 0);

static value sensorsextension_getiaccelY(){
	return alloc_float(SensorExtension::getiaccelY());
}
DEFINE_PRIM(sensorsextension_getiaccelY, 0);

static value sensorsextension_getiaccelZ(){
	return alloc_float(SensorExtension::getiaccelZ());
}
DEFINE_PRIM(sensorsextension_getiaccelZ, 0);
//end

//user accelerometer get method
static value sensorsextension_getiuseraccelX(){
	return alloc_float(SensorExtension::getiuseraccelX());
}
DEFINE_PRIM(sensorsextension_getiuseraccelX, 0);

static value sensorsextension_getiuseraccelY(){
	return alloc_float(SensorExtension::getiuseraccelY());
}
DEFINE_PRIM(sensorsextension_getiuseraccelY, 0);

static value sensorsextension_getiuseraccelZ(){
	return alloc_float(SensorExtension::getiuseraccelZ());
}
DEFINE_PRIM(sensorsextension_getiuseraccelZ, 0);
//end

//gyroscope get methods
static value sensorsextension_getigyroX(){
	return alloc_float(SensorExtension::getigyroX());
}
DEFINE_PRIM(sensorsextension_getigyroX, 0);

static value sensorsextension_getigyroY(){
	return alloc_float(SensorExtension::getigyroY());
}
DEFINE_PRIM(sensorsextension_getigyroY, 0);

static value sensorsextension_getigyroZ(){
	return alloc_float(SensorExtension::getigyroZ());
}
DEFINE_PRIM(sensorsextension_getigyroZ, 0);

//end

//attitude aka orientation get methods
static value sensorsextension_getiorientX(){
	return alloc_float(SensorExtension::getiorientRoll());
}
DEFINE_PRIM(sensorsextension_getiorientX, 0);

static value sensorsextension_getiorientY(){
	return alloc_float(SensorExtension::getiorientPitch());
}
DEFINE_PRIM(sensorsextension_getiorientY, 0);

static value sensorsextension_getiorientZ(){
	return alloc_float(SensorExtension::getiorientYaw());
}
DEFINE_PRIM(sensorsextension_getiorientZ, 0);

//end

//Magnetic field get method
static value sensorsextension_getiMagX(){
	return alloc_float(SensorExtension::getiMagX());
}
DEFINE_PRIM(sensorsextension_getiMagX, 0);
static value sensorsextension_getiMagY(){
	return alloc_float(SensorExtension::getiMagY());
}
DEFINE_PRIM(sensorsextension_getiMagY, 0);
static value sensorsextension_getiMagZ(){
	return alloc_float(SensorExtension::getiMagZ());
}
DEFINE_PRIM(sensorsextension_getiMagZ, 0);
//end

//Gravity get method
static value sensorsextension_getigravX(){
	return alloc_float(SensorExtension::getigravX());
}
DEFINE_PRIM(sensorsextension_getigravX, 0);
static value sensorsextension_getigravY(){
	return alloc_float(SensorExtension::getigravY());
}
DEFINE_PRIM(sensorsextension_getigravY, 0);
static value sensorsextension_getigravZ(){
	return alloc_float(SensorExtension::getigravZ());
}
DEFINE_PRIM(sensorsextension_getigravZ, 0);
//end

//Rotation Rate get method
static value sensorsextension_getirotX(){
	return alloc_float(SensorExtension::getirotX());
}
DEFINE_PRIM(sensorsextension_getirotX, 0);
static value sensorsextension_getirotY(){
	return alloc_float(SensorExtension::getirotY());
}
DEFINE_PRIM(sensorsextension_getirotY, 0);
static value sensorsextension_getirotZ(){
	return alloc_float(SensorExtension::getirotZ());
}
DEFINE_PRIM(sensorsextension_getirotZ, 0);
//end




//Check if Sensor Available
static value sensorsextension_isAccelAvailable(){
	return alloc_bool(SensorExtension::isAccelerometerAvailable());
}
DEFINE_PRIM(sensorsextension_isAccelAvailable, 0);

static value sensorsextension_isGyroAvailable(){
	return alloc_bool(SensorExtension::isGyroAvailable());
}
DEFINE_PRIM(sensorsextension_isGyroAvailable, 0);

static value sensorsextension_isDMAvailable(){
	return alloc_bool(SensorExtension::isdeviceMotionAvailalbe());
}
DEFINE_PRIM(sensorsextension_isDMAvailable, 0);

//end

extern "C" void sensorextension_main () {
	
	val_int(0); // Fix Neko init
	
}
DEFINE_ENTRY_POINT (sensorextension_main);



extern "C" int sensorextension_register_prims () { return 0; }

#endif