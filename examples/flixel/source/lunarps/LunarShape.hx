package lunarps;

import flixel.util.FlxColor;
import lunarps.abstracts.LunarVarAbstract;
import lunarps.haxe.Copy;
import lunarps.math.LunarMath;
import lunarps.math.LunarVector2;
import lunarps.math.LunarVector3;
import lunarps.renderer.backends.flixel.Shaders;

enum LunarShapeType
{
	CIRCLE;
	RECTANGLE;
	TEXTURE;
}

class LunarShape
{
	public var color:Int;
	public var shapeType(default, null):LunarShapeType;
	public var alpha(default, set):Int = 256;

	public function new(color:Int)
	{
		this.color = color;
	}

	function set_alpha(val:Int):Int
	{
		alpha = val;
		color &= 0x00ffffff;
		color |= (alpha > 0xff ? 0xff : alpha < 0 ? 0 : alpha) << 24;
		return alpha;
	}

	public function copy():LunarShape
		return Copy.copy(this);
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

class LunarCircle extends LunarShape
{
	public var radius:Float;
	@:allow(lunarps.renderer.backends.flixel.MeshFactory)
	public var shader:CircleShader = new CircleShader();

	public function new(color:Int, radius:Float)
	{
		super(color);
		shapeType = CIRCLE;
		this.radius = radius;
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
