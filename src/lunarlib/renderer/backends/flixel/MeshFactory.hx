package lunarlib.renderer.backends.flixel;

import flixel.FlxCamera;
import flixel.FlxSprite;
import flixel.FlxStrip;
import flixel.graphics.FlxGraphic;
import flixel.graphics.tile.FlxDrawTrianglesItem.DrawData;
import flixel.math.FlxPoint;
import flixel.util.FlxSpriteUtil;
import lime.graphics.Image;
import lunarlib.LunarBase;
import lunarlib.LunarShape;
import lunarlib.math.LunarMath;
import lunarlib.math.LunarVector2;
import lunarlib.math.LunarVector4;
import lunarlib.renderer.backends.flixel.GeneralFlixelRenderUtil.*;
import lunarlib.renderer.backends.flixel.Shaders.AlphaShader;
import lunarlib.renderer.backends.flixel.Shaders.CircleShader;
import openfl.display.BitmapData;

typedef MeshData =
{
	var vertices:DrawData<Float>;
	var uvs:DrawData<Float>;
	var indices:DrawData<Int>;
	var colors:DrawData<Int>;
	var graphic:FlxGraphic;
}

class MeshFactory extends FlxCamera
{
	/*
		public static function createCircle(radius:Float, segments:Int):LunarShape
		{
			var shape = new LunarShape();
			var angle = 0;
			var angleStep = 360 / segments;
			for (i in 0...segments)
			{
				var x = Math.cos(angle * Math.PI / 180) * radius;
				var y = Math.sin(angle * Math.PI / 180) * radius;
				shape.addPoint(x, y);
				angle += angleStep;
			}
			return shape;
		}
	 */
	public function getMeshFromRect(rect:LunarVector4<Float>, color:Int):MeshData
	{
		var vertices:DrawData<Float>;
		var uvs:DrawData<Float>;
		var indices:DrawData<Int>;
		var colors:DrawData<Int>;
		vertices = new DrawData<Float>(0, false, [
			rect.x,
			rect.y,
			rect.x + rect.z,
			rect.y,
			rect.x,
			rect.y + rect.w,
			rect.x + rect.z,
			rect.y + rect.w
		]);
		uvs = new DrawData<Float>(0, false, [0.0, 0.0, 1.0, 0.0, 0.0, 1.0, 1.0, 1.0]);
		indices = new DrawData<Int>(0, false, [0, 1, 2, 1, 3, 2]);
		colors = new DrawData<Int>(0, false, [color, color, color, color]);
		return {
			vertices: vertices,
			uvs: uvs,
			indices: indices,
			colors: colors,
			graphic: null
		};
	}

	public function constructRectangle(base:LunarBase)
	{
		var rect:LunarRect = cast base.shape;
		var rectData = new LunarVector4<Float>(base.x, base.y, rect.width, rect.height);
		var meshData = getMeshFromRect(rectData, rect.color);
		meshData.graphic = FlxGraphic.fromRectangle(cast rect.width, cast rect.height, rect.color);
		drawTriangles(meshData.graphic, meshData.vertices, meshData.indices, meshData.uvs, meshData.colors, null, null, false, false, null, null);
	}

	public function constructCircle(base:LunarBase)
	{
		var circ:LunarCircle = cast base.shape;
		var rectData = new LunarVector4<Float>(base.x, base.y, circ.radius, circ.radius);
		var meshData = getMeshFromRect(rectData, circ.color);
		meshData.graphic = FlxGraphic.fromRectangle(cast circ.radius, cast circ.radius, circ.color);
		drawTriangles(meshData.graphic, meshData.vertices, meshData.indices, meshData.uvs, meshData.colors, null, null, false, false, null, circ.shader);
	}

	public function constructTexture(base:LunarBase)
	{
		var tex:LunarTexture = cast base.shape;
		if (tex.graphicStorage.graphic == null)
			tex.graphicStorage.graphic = FlxGraphic.fromBitmapData(BitmapData.fromImage(Image.fromFile(tex.texPath)));
		var graph = tex.graphicStorage.graphic;
		var dims = tex.width == 0
			&& tex.height == 0 ? new LunarVector2<Float>(graph.height, graph.width) : new LunarVector2<Float>(tex.width, tex.height);
		var rectData = new LunarVector4<Float>(base.x, base.y, dims.x, dims.y);
		var meshData = getMeshFromRect(rectData, 0xFFFFFFFF);
		meshData.graphic = graph;
		drawTriangles(meshData.graphic, meshData.vertices, meshData.indices, meshData.uvs, meshData.colors, null, null, false, false, null, tex.shader);
	}

	public function drawBase(base:LunarBase)
	{
		switch (base.shape.shapeType)
		{
			case RECTANGLE:
				constructRectangle(base);
			case CIRCLE:
				constructCircle(base);
			case TRIANGLE:
				var tri:LunarTriangle = cast base.shape;
			case POLYGON:
				var poly:LunarPolygon = cast base.shape;
			case TEXTURE:
				constructTexture(base);
		}
	}
}
