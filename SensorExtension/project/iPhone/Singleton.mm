#include <CoreMotion/CoreMotion.h>
#include <Singleton.h>

namespace SensorExtension
{
    class OrientationManagerPrivate : public EventReceiver 
    {
    public:
        OrientationManagerPrivate() : manager(0), accelEnabled(false), gyroEnabled(false), updating(false)
        {
            _oq = [[NSOperationQueue alloc] init];
            _motionManager = [[CMMotionManager alloc] init];
            _motionManager.deviceMotionUpdateInterval = 1.0f / 100.0f;
        }
        
        ~OrientationManagerPrivate()
        {
            [_motionManager release];
            [_oq release];
        }
        
        void update()
        {
            bool shouldSwitch = updating != (gyroEnabled || accelEnabled);
            if (!shouldSwitch) return;
            
            updating = gyroEnabled || accelEnabled;
            if (updating)
            {
                __block float t = 0.0f;
                
                [_motionManager startDeviceMotionUpdatesToQueue:_oq withHandler:^(CMDeviceMotion *motion, NSError *error)
                 {
                     float dt = (t == 0.0f) ? 0.0f : (motion.timestamp - t);
                     
                     if (gyroEnabled)
                     {
                         et::GyroscopeData d;
                         d.rate.x = motion.rotationRate.x;
                         d.rate.y = motion.rotationRate.y;
                         d.rate.z = motion.rotationRate.z;
                         d.orientation.x = motion.attitude.pitch;
                         d.orientation.y = motion.attitude.yaw;
                         d.orientation.z = motion.attitude.roll;
                         d.timestamp = motion.timestamp;
                         d.interval = dt;
                         manager->gyroscopeDataUpdated.invokeInMainRunLoop(d);
                     }
                     
                     if (accelEnabled)
                     {
                         et::AccelerometerData d;
                         d.value.x = motion.gravity.x;
                         d.value.y = motion.gravity.y;
                         d.value.z = motion.gravity.z;
                         d.timestamp = motion.timestamp;
                         d.interval = dt;
                         manager->accelerometerDataUpdated.invokeInMainRunLoop(d);
                     }
                     
                     t = motion.timestamp;
                 }];
            }
            else 
            {
                [_motionManager stopDeviceMotionUpdates];
            }
        }
        
        void setGyroEnabled(bool e)
        {
            if (gyroEnabled == e) return;   
            gyroEnabled = e;
            update();
        }
        
        void setAccelEnabled(bool e)
        {
            if (accelEnabled == e) return;  
            accelEnabled = e;
            update();
        }
        
    public:
        NSOperationQueue* _oq;
        CMMotionManager* _motionManager;
        OrientationManager* manager;
        
        bool accelEnabled;
        bool gyroEnabled;
        bool updating;
                
    };
}

using namespace SensorExtension;

bool OrientationManager::accelerometerAvailable()
{
    return [[[CMMotionManager alloc] init] autorelease].accelerometerAvailable;
}

bool OrientationManager::gyroscopeAvailable()
{
    return [[[CMMotionManager alloc] init] autorelease].gyroAvailable;
}

OrientationManager::OrientationManager() : _private(new OrientationManagerPrivate)
    { _private->manager = this; }

OrientationManager::~OrientationManager()
    { delete _private; }

void OrientationManager::setAccelerometerEnabled(bool e)
    { _private->setAccelEnabled(e); }

bool OrientationManager::accelerometerEnabled() const
    { return _private->accelEnabled; }

void OrientationManager::setGyroscopeEnabled(bool e)
    { _private->setGyroEnabled(e); }

bool OrientationManager::gyroscopeEnabled() const
    { return _private->gyroEnabled; }
