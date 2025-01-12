package lunarlib.abstracts;

@:forward
abstract LunarVarAbstract(Map<String, Any>)
{
	public inline function new()
	{
		this = new Map();
	}

	/* 
		Overload the 'a.b' operator to get a value from this map, it
		allows for the following syntax without defining the variable in this abstract: 
		abstract.value = 3;
		trace(abstract.value);
	 */
	@:op(a.b)
	public inline function get<T>(name:String):T
		return this.get(name);

	@:op(a.b)
	public inline function set<T>(name:String, value:T):T
	{
		this.set(name, value);
		return value;
	}
}
