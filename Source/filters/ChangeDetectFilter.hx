package filters;

import openfl.events.TimerEvent;
import openfl.utils.Timer;

class ChangeDetectFilter extends Filter {

    private static var DEFAULT_TIME_IDLE:Float = 190;

    private var timeIdleBeforeChangeDetected:Float = DEFAULT_TIME_IDLE;
    private var isChanging:Bool = false;
    private var changeStoppedTimer:Timer;

    public function new()
    {
        super();
        changeStoppedTimer = new Timer(DEFAULT_TIME_IDLE, 1);
        changeStoppedTimer.addEventListener(TimerEvent.TIMER_COMPLETE, changeStopped);
    }

    override public function reset()
    {
        super.reset();
        changeStoppedTimer.reset();
        changeStoppedTimer.start();
        isChanging = false;
    }

    override public function update(newValue:Float):Float
    {
        // This will be null if no change was detected
        if(newValue != null)
        {
            changeStoppedTimer.reset();
            changeStoppedTimer.start();

            // The value has started changing
            if(isChanging == false)
            {
                isChanging = true;
            }
        }
        return newValue;
    }

    private function changeStopped(e:TimerEvent)
    {
        isChanging = false;
    }
}