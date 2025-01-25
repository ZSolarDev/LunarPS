package lunarps;

import lunarps.abstracts.LunarVarAbstract;
import lunarps.math.LunarMath;
import lunarps.renderer.backends.flixel.Shaders;

enum LunarShapeType
{
	NONE;
	CIRCLE;
	RECTANGLE;
	TEXTURE;
}

class LunarShape
{
	public var color(default, set):Int;
	public var shapeType(default, null):LunarShapeType = NONE;

	public var alpha(default, set):Int = 256;
	public var angle:Float = 0;

	@:allow(lunarps.renderer.backends.flixel.MeshFactory)
	var _angle(get, default):Float;

	public function new(color:Int, alpha:Int = 256, angle:Float = 0)
	{
		this.color = color;
		this.alpha = alpha;
		this.angle = angle;
	}

	function get__angle():Float
	{
		return angle * (Math.PI / 180);
	}

	var fromAlpha:Bool = false; // preventing stack overflow

	function set_color(val:Int):Int
	{
		color = val;
		if (!fromAlpha)
			set_alpha(alpha);
		return color;
	}

	function set_alpha(val:Int):Int
	{
		alpha = val;
		fromAlpha = true;
		color &= 0x00ffffff;
		color |= (alpha > 0xff ? 0xff : alpha < 0 ? 0 : alpha) << 24;
		fromAlpha = false;
		return alpha;
	}
}

class LunarRect extends LunarShape
{
	public var width:Float;
	public var height:Float;

	public function new(color:Int, width:Float, height:Float)
	{
		super(color);
		shapeType = RECTANGLE;
		this.width = width;
		this.height = height;
	}
}

class LunarCircle extends LunarRect
{
	@:allow(lunarps.renderer.backends.flixel.MeshFactory)
	public var shader:CircleShader = new CircleShader();

	public function new(color:Int, ?width:Float = 0, ?height:Float = 0)
	{
		super(color, width, height);
		shapeType = CIRCLE;
	}
}

class LunarTexture extends LunarRect
{
	public var texPath:String;
	public var graphicStorage:LunarVarAbstract = new LunarVarAbstract();

	@:allow(lunarps.renderer.backends.flixel.MeshFactory)
	private var shader:AlphaShader = new AlphaShader(1);

	public function new(color:Int, texPath:String, ?width:Float = 0, ?height:Float = 0)
	{
		super(color, width, height);
		shapeType = TEXTURE;
		this.texPath = texPath;
	}

	override private function set_alpha(val:Int):Int
	{
		shader.shaderAlpha = LunarMath.mapRange(val, 0, 255, 0, 1);
		return super.set_alpha(val);
	}
}
