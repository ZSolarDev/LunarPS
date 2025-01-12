package lunarlib.math;

/**
 * This class is meant purley for x, y, and z data storage.
 */
class LunarVector3<T> extends LunarVector2<T>
{
	public var z:T;

	public function new(x:T, y:T, z:T)
	{
		super(x, y);
		this.z = z;
	}
}
