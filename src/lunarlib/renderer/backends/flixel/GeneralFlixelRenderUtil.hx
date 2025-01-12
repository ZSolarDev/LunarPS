package lunarlib.renderer.backends.flixel;

import flixel.math.FlxPoint;
import lunarlib.LunarShape;
import lunarlib.math.LunarVector2;

class GeneralFlixelRenderUtil
{
	public static function vector2ToFlxPoint(vector:LunarVector2<Float>, offset:LunarVector2<Float>):FlxPoint
		return new FlxPoint(vector.x + offset.x, vector.y + offset.y);

	public static function vector2ArrayToFlxPointArray(vector2Array:Array<LunarVector2<Float>>, offset:LunarVector2<Float>):Array<FlxPoint>
	{
		var points:Array<FlxPoint> = [];
		for (point in vector2Array)
			points.push(vector2ToFlxPoint(point, offset));
		return points;
	}
}
