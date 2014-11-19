#ifndef SENSOREXTENSION_H
#define SENSOREXTENSION_H

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
@interface SensorExtension : UIViewController{
	@property(nonatomic) CMMotionManager *motionManager;
}
@end

namespace SensorExtension{


	int SampleMethod(int inputValue);
	float getiaccelX();
}

#endif