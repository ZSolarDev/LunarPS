package lunarlib.math;

/**
 * This class is meant purley for x and y data storage.
 */
class LunarVector2<T>
{
	public var x:T;
	public var y:T;

	public function new(x:T, y:T)
	{
		this.x = x;
		this.y = y;
	}
}
