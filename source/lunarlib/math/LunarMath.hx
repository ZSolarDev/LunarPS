package lunarlib.math;

class LunarMath
{
	/**
	 * Maps a value from one range to another.
	 * @param n Value to map
	 * @param fromMin Min value of starting range
	 * @param fromMax Max value of starting range
	 * @param toMin Min value of target range
	 * @param toMax Max value of target range
	 * @return Float
	 */
	public static function mapRange(n:Float, fromMin:Float, fromMax:Float, toMin:Float, toMax:Float)
		return (n - fromMin) * (toMax - toMin) / (fromMax - fromMin) + toMin;
}
