package lunarps.math;

using StringTools;

/**
 *  Thank you FlxEase!111!😈!11!1!1!!!
 */
class LunarEases
{
	/**
	 * Many easing functions to use.
	 * 
	 * Intended to use with easedInterp().
	 */
	public static var eases:Map<String, Float->Float> = [
		'linear' => (v) -> v,
		// v * v functions
		'quadIn' => (v) -> v * v,
		'quadOut' => (v) -> -v * (v - 2),
		'quadInOut' => (v) -> v <= .5 ? v * v * 2 : 1 - (--v) * v * 2,
		'cubeIn' => (v) -> v * v * v,
		'cubeOut' => (v) -> 1 + (--v) * v * v,
		'cubeInOut' => (v) -> v <= .5 ? v * v * v * 4 : 1 + (--v) * v * v * 4,
		'quartIn' => (v) -> v * v * v * v,
		'quartOut' => (v) -> 1 - (v -= 1) * v * v * v,
		'quartInOut' => (v) -> v <= .5 ? v * v * v * v * 8 : (1 - (v = v * 2 - 2) * v * v * v) / 2 + .5,
		'quintIn' => (v) -> v * v * v * v * v,
		'quintOut' => (v) -> (v = v - 1) * v * v * v * v + 1,
		'quintInOut' => (v) -> ((v *= 2) < 1) ? (v * v * v * v * v) / 2 : ((v -= 2) * v * v * v * v + 2) / 2,
		// Math.___ functions
		'sineIn' => (v) -> -Math.cos(Math.PI / 2 * v) + 1,
		'sineOut' => (v) -> Math.sin(Math.PI / 2 * v),
		'sineInOut' => (v) -> -Math.cos(Math.PI * v) / 2 + .5,
		'expoIn' => (v) -> Math.pow(2, 10 * (v - 1)),
		'expoOut' => (v) -> -Math.pow(2, -10 * v) + 1,
		'expoInOut' => (v) -> v < .5 ? Math.pow(2, 10 * (v * 2 - 1)) / 2 : (-Math.pow(2, -10 * (v * 2 - 1)) + 2) / 2,
		'circIn' => (v) -> -(Math.sqrt(1 - v * v) - 1),
		'circOut' => (v) -> Math.sqrt(1 - (v - 1) * (v - 1)),
		'circInOut' => (v) -> v <= .5 ? (Math.sqrt(1 - v * v * 4) - 1) / -2 : (Math.sqrt(1 - (v * 2 - 2) * (v * 2 - 2)) + 1) / 2,
		// Smooth step functions
		'smoothStepIn' => (v) -> 2 * (v / 2) * (v / 2) * ((v / 2) * -2 + 3),
		'smoothStepOut' => (v) -> 2 * (v / 2 + 0.5) * (v / 2 + 0.5) * ((v / 2 + 0.5) * -2 + 3) - 1,
		'smoothStepInOut' => (v) -> v * v * (v * -2 + 3),
		'smootherStepIn' => (v) -> 2 * (v / 2) * (v / 2) * (v / 2) * ((v / 2) * ((v / 2) * 6 - 15) + 10),
		'smootherStepOut' => (v) -> 2 * (v / 2 + 0.5) * (v / 2 + 0.5) * (v / 2 + 0.5) * ((v / 2 + 0.5) * ((v / 2 + 0.5) * 6 - 15) + 10) - 1,
		'smootherStepInOut' => (v) -> v * v * v * (v * (v * 6 - 15) + 10)
	];
}

class LunarInterp
{
	/**
	 * A basic linear interpolation.
	 * @param a Float
	 * @param b Float
	 * @param r The ratio in which to interpolate.
	 * @return Float
	 */
	public static function linearInterp(a:Float, b:Float, r:Float):Float
		return a + r * (b - a);

	/**
	 * An eased interpolation. If an ease doesnt exist, an error will be thrown.
	 * To prevent this, you can see a list of available ease functions in LunarEases.eases
	 * 
	 * NOTE: You must set the ratio to a constantly increasing value from 0-1.
	 * @param a Float
	 * @param b Float
	 * @param r Float: The ratio in which to interpolate.
	 * @param e String: The name of the ease to interpolate with.
	 * @return Float
	 */
	public static function easedInterp(a:Float, b:Float, r:Float, e:String):Float
		try
		{
			return a + (b - a) * LunarEases.eases.get(e)(r);
		}
		catch (_)
		{
			error('Unknown ease: $e: defaulting to a linear interpolation.');
			return linearInterp(a, b, r);
		}

	/**
	 * A sine interpolation.
	 * @param a Float
	 * @param b Float
	 * @param r The ratio in which to interpolate.
	 * @return Float
	 */
	public static function sinInterp(a:Float, b:Float, r:Float):Float
		return a + (b - a) * (1 - Math.cos(r * Math.PI)) / 2;
}
