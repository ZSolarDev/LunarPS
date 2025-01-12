package lunarlib.renderer.backends.flixel;

import flixel.FlxSprite;
import flixel.FlxStrip;
import flixel.graphics.FlxGraphic;
import flixel.math.FlxPoint;
import flixel.util.FlxSpriteUtil;
import lime.graphics.Image;
import lunarlib.LunarBase;
import lunarlib.LunarShape;
import lunarlib.math.LunarMath;
import lunarlib.math.LunarVector2;
import lunarlib.renderer.backends.flixel.GeneralFlixelRenderUtil.*;
import openfl.display.BitmapData;

class SingleBitmapManager extends FlxSprite
{
	public static var curClearColor:Int = 0x00000000;

	public static function setClearColor(color:Int)
		return curClearColor = color;

	public function clear()
	{
		pixels.fillRect(new openfl.geom.Rectangle(x, y, width, height), curClearColor);
	}

	public function drawBase(base:LunarBase)
	{
		switch (base.shape.shapeType)
		{
			case RECTANGLE:
				var rect:LunarRect = cast base.shape;
				if (rect.width < 1 || rect.height < 1)
					return;
				FlxSpriteUtil.drawRect(this, base.x, base.y, rect.width, rect.height, rect.color);
			case CIRCLE:
				var circ:LunarCircle = cast base.shape;
				if (circ.radius < 1)
					return;
				FlxSpriteUtil.drawCircle(this, base.x, base.y, circ.radius, circ.color);
			case TRIANGLE:
				var tri:LunarTriangle = cast base.shape;
				FlxSpriteUtil.drawPolygon(this, [
					vector2ToFlxPoint(tri.points.x, new LunarVector2<Float>(base.x, base.y)),
					vector2ToFlxPoint(tri.points.y, new LunarVector2<Float>(base.x, base.y)),
					vector2ToFlxPoint(tri.points.z, new LunarVector2<Float>(base.x, base.y))
				], tri.color);
			case POLYGON:
				var poly:LunarPolygon = cast base.shape;
				FlxSpriteUtil.drawPolygon(this, vector2ArrayToFlxPointArray(poly.points, new LunarVector2<Float>(base.x, base.y)), poly.color);
			case TEXTURE:
				var tex:LunarTexture = cast base.shape;
				if (tex.graphicStorage.graphic == null)
					tex.graphicStorage.graphic = FlxGraphic.fromBitmapData(BitmapData.fromImage(Image.fromFile(tex.texPath)));
				var spr = new FlxSprite(base.x, base.y, tex.graphicStorage.graphic);
				var tx = spr.x;
				var ty = spr.y;
				tx -= spr.width / 2 - tex.width / 2;
				ty -= spr.height / 2 - tex.height / 2;
				spr.setGraphicSize(tex.width, tex.height);
				spr.updateHitbox();
				spr.alpha = LunarMath.mapRange(tex.alpha, 0, 255, 0, 1);
				stamp(spr, cast tx, cast ty);
		}
	}
}
