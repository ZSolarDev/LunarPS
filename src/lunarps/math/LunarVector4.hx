package lunarps.math;

/**
 * This class is meant purley for x, y, z, and w data storage.
 */
class LunarVector4<T> extends LunarVector3<T>
{
	public var w:T;

	public function new(x:T, y:T, z:T, w:T)
	{
		super(x, y, z);
		this.w = w;
	}
}
