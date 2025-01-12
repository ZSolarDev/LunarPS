package lunarlib;

import flixel.util.FlxColor;
import lunarlib.abstracts.LunarVarAbstract;
import lunarlib.haxe.Copy;
import lunarlib.math.LunarMath;
import lunarlib.math.LunarVector2;
import lunarlib.math.LunarVector3;
import lunarlib.renderer.backends.flixel.Shaders;

enum LunarShapeType
{
	TRIANGLE;
	CIRCLE;
	RECTANGLE;
	POLYGON;
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
	#if flixelMode public var shader:CircleShader = new CircleShader(); #end

	public function new(color:Int, radius:Float)
	{
		super(color);
		shapeType = CIRCLE;
		this.radius = radius;
	}
}

class LunarTriangle extends LunarShape
{
	public var points:LunarVector3<LunarVector2<Float>>;

	public function new(color:Int, points:LunarVector3<LunarVector2<Float>>)
	{
		super(color);
		shapeType = TRIANGLE;
		this.points = points;
	}
}

class LunarTexture extends LunarRect
{
	public var texPath:String;
	public var graphicStorage:LunarVarAbstract = new LunarVarAbstract();
	#if flixelMode public var shader:AlphaShader = new AlphaShader(1); #end

	public function new(color:Int, texPath:String, ?width:Float = 0, ?height:Float = 0)
	{
		super(color, width, height);
		shapeType = TEXTURE;
		this.texPath = texPath;
	}

	#if flixelMode
	override private function set_alpha(val:Int):Int
	{
		shader.shaderAlpha = LunarMath.mapRange(val, 0, 255, 0, 1);
		return super.set_alpha(val);
	}
	#end
}

class LunarPolygon extends LunarShape
{
	public var points:Array<LunarVector2<Float>>;

	public function new(color:Int, points:Array<LunarVector2<Float>>)
	{
		super(color);
		shapeType = POLYGON;
		this.points = points;
	}
}
