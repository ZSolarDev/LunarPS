package lunarps;

import lunarps.LunarShape;

class LunarBase extends LunarPoolable
{
	public var x:Float;
	public var y:Float;
	public var id:Int;
	public var visible:Bool = true;
	public var shape:LunarShape;

	override public function new(x:Float, y:Float)
	{
		super();
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
