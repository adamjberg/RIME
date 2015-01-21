#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>
#import "Sensors.h"
#import <AudioToolbox/AudioServices.h>
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVAudioSession.h>

namespace sensors {

CMMotionManager *motionManager;
AVAudioRecorder *audioRecorder;
AVAudioSession *audioSession;


  



void init()
{
NSArray *dirPaths;
NSString *docsDir;

dirPaths = NSSearchPathForDirectoriesInDomains(
        NSDocumentDirectory, NSUserDomainMask, YES);
docsDir = dirPaths[0];

NSString *soundFilePath = [docsDir
       stringByAppendingPathComponent:@"sound.caf"];

NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilePath];



NSDictionary *recordSettings = [NSDictionary
            dictionaryWithObjectsAndKeys:
            [NSNumber numberWithInt:AVAudioQualityMin],
            AVEncoderAudioQualityKey,
            [NSNumber numberWithInt:16],
            AVEncoderBitRateKey,
            [NSNumber numberWithInt: 2],
            AVNumberOfChannelsKey,
            [NSNumber numberWithFloat:44100.0],
            AVSampleRateKey,
            nil];

NSError *error = nil;
    
    audioRecorder = [[AVAudioRecorder alloc]
                  initWithURL:soundFileURL
                  settings:recordSettings
                  error:&error];
    if (error)
   {
           NSLog(@"error: %@", [error localizedDescription]);
   } else {
           [audioRecorder prepareToRecord];
   }
    audioRecorder.meteringEnabled = YES;

   audioSession = [[AVAudioSession sharedInstance] retain]; 
   
   [audioSession setCategory:AVAudioSessionCategoryRecord error: nil]; 
   [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error: nil];
   [audioSession setActive:YES error: nil];
   [audioRecorder updateMeters];
    motionManager = [[CMMotionManager alloc] init];
    motionManager.accelerometerUpdateInterval = 0.01;
    [motionManager startAccelerometerUpdates];
    [motionManager startGyroUpdates];
    [motionManager startDeviceMotionUpdates];
    [motionManager startMagnetometerUpdates];
    motionManager.gyroUpdateInterval = 0.01;
    motionManager.magnetometerUpdateInterval =0.01;

}

//Linear Accelerometer Data Access
bool isAccelerometerAvailable()
{
    return (motionManager.accelerometerAvailable);
}

float getiaccelX(){
    double x=motionManager.accelerometerData.acceleration.x;
    return x;
}

float getiaccelY(){
    double y=motionManager.accelerometerData.acceleration.y;
    return y;
}

float getiaccelZ(){
    double z=motionManager.accelerometerData.acceleration.z;
    return z;
}
//end
//User Accelerometer Data Access


float getiuseraccelX(){
    double x=motionManager.deviceMotion.userAcceleration.x;
    return x;
}

float getiuseraccelY(){
    double y=motionManager.deviceMotion.userAcceleration.y;
    return y;
}

float getiuseraccelZ(){
    double z=motionManager.deviceMotion.userAcceleration.z;
    return z;
}
//end

//attitude aka orientation
float getiorientRoll(){
    double x=motionManager.deviceMotion.attitude.roll;
    return x;
}
float getiorientPitch(){
    double y=motionManager.deviceMotion.attitude.pitch;
    return y;
}

float getiorientYaw(){
    double z=motionManager.deviceMotion.attitude.yaw;
    return z;
}

//Gyoscope Data Access
bool isGyroAvailable()
{
    return (motionManager.gyroAvailable);
}

float getigyroX(){
    double x=motionManager.gyroData.rotationRate.x;
    return x;
}

float getigyroY(){
    double y=motionManager.gyroData.rotationRate.y;
    return y;
}

float getigyroZ(){
    double z=motionManager.gyroData.rotationRate.z;
    return z;
}
//end

//Is deviceMotion Available
bool isdeviceMotionAvailalbe(){
   return (motionManager.deviceMotionAvailable); 
}
//end

//Magnetic field for deviceMotion
float getiMagX(){
   
   double x=motionManager.deviceMotion.magneticField.field.x;
    return x;
}
float getiMagY(){
   
   double y=motionManager.deviceMotion.magneticField.field.y;
    return y;
}
float getiMagZ(){
   
   double z=motionManager.deviceMotion.magneticField.field.z;
    return z;
}

//end

//Gavity for deviceMotion
float getigravX(){
   
   double x=motionManager.deviceMotion.gravity.x;
    return x;
}
float getigravY(){
   
   double y=motionManager.deviceMotion.gravity.y;
    return y;
}
float getigravZ(){
   
   double z=motionManager.deviceMotion.gravity.z;
    return z;
}

//end

//RotationRate for deviceMotion
float getirotX(){
   
   double x=motionManager.deviceMotion.rotationRate.x;
    return x;
}
float getirotY(){
   
   double y=motionManager.deviceMotion.rotationRate.y;
    return y;
}
float getirotZ(){
   
   double z=motionManager.deviceMotion.rotationRate.z;
    return z;
}

//Vibrate for iphone
void vibrate()
{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}
void enableMeter(){
    audioRecorder.meteringEnabled = YES;

}

float getsoundMeter(){
    [audioRecorder record];
    [audioRecorder updateMeters];
    double dBLevel = [audioRecorder averagePowerForChannel:0];

    return dBLevel;
    
}
float getpeaksoundMeter(){
    [audioRecorder record];
    [audioRecorder updateMeters];
     double dBLevel = [audioRecorder peakPowerForChannel:0];

    return dBLevel;
}



}

  
