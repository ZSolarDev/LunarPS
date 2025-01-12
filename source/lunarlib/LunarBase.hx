package lunarlib;

import lunarlib.LunarShape;

class LunarBase
{
	public var x:Float;
	public var y:Float;
	public var id:Int;
	public var visible:Bool = true;
	public var shape:LunarShape;

	public function new(x:Float, y:Float)
	{
		this.x = x;
		this.y = y;
	}

	public function onFrame(dt:Float) {}

	public function kill()
	{
		x = 0;
		y = 0;
		shape = null;
	}
}
