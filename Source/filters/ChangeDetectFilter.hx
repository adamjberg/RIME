package filters;

import msignal.Signal.Signal0;
import openfl.events.TimerEvent;
import openfl.utils.Timer;

class ChangeDetectFilter extends Filter {

    public var onChangeStarted:Signal0 = new Signal0();
    public var onChangeStopped:Signal0 = new Signal0();

    private static var DEFAULT_TIME_IDLE:Float = 190;

    private var timeIdleBeforeChangeDetected:Float = DEFAULT_TIME_IDLE;
    private var isChanging:Bool = false;
    private var changeStoppedTimer:Timer;

    public function new()
    {
        changeStoppedTimer = new Timer(DEFAULT_TIME_IDLE, 1);
        changeStoppedTimer.addEventListener(TimerEvent.TIMER_COMPLETE, changeStopped);
        super();
    }

    override public function reset()
    {
        super.reset();
        changeStoppedTimer.reset();
        isChanging = false;
    }

    override public function update(newValues:Array<Float>):Array<Float>
    {
        var valueHasChanged:Bool = false;
        for(i in 0...newValues.length)
        {
            if(newValues[i] != values[i])
            {
                valueHasChanged = true;
            }
        }

        if(valueHasChanged)
        {
            changeStoppedTimer.reset();
            changeStoppedTimer.start();
            // The value has started changing
            if(isChanging == false)
            {
                onChangeStarted.dispatch();
                isChanging = true;
            }
        }

        values = newValues;
        
        return values;
    }

    private function changeStopped(e:TimerEvent)
    {
        onChangeStopped.dispatch();
        reset();
    }
}