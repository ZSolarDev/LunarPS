package lunarps;

class LunarPool<T>
{
	public var pool:Array<T> = [];
	public var length(get, null):Int = 0;
	public var deadPoolableAvailable(get, null):Bool = false;

	public function new() {}

	public function addToPool(poolable:T):Int
		return pool.push(poolable);

	public function removeFromPool(poolable:T):Bool
		return pool.remove(poolable);

	public function get_length():Int
	{
		return pool.length;
	}

	public function get_deadPoolableAvailable():Bool
	{
		var res = false;
		for (obj in pool)
		{
			try
			{
				var poolable:LunarPoolable = cast obj;
				if (poolable.dead)
					res = true;
			}
			catch (e)
			{
				lunarps.LGUtils.LunarLogger.error(e);
				return false;
			}
		}
		return res;
	}

	public function getDeadPoolable():T
	{
		for (obj in pool)
		{
			try
			{
				var poolable:LunarPoolable = cast obj;
				if (poolable.dead)
					return obj;
			}
			catch (e)
			{
				lunarps.LGUtils.LunarLogger.error(e);
				return null;
			}
		}
		return null;
	}

	public function iterator()
		return pool.iterator();
}
