package utils;

class ArrayUtils {

    public static function init2DIntArray(arr:Array<Array<Dynamic>>, size:Int)
    {
        for(i in 0...size)
        {
            arr[i] = new Array<Int>();
        }
    }

    public static function init2DFloatArray(arr:Array<Array<Dynamic>>, size:Int)
    {
        for(i in 0...size)
        {
            arr[i] = new Array<Float>();
        }
    }
}