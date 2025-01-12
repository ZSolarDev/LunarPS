package lunarlib.renderer.backends;

import flixel.FlxG;
import flixel.util.FlxSort;
import lunarlib.LunarBase;
import lunarlib.renderer.backends.flixel.MeshFactory;
import lunarlib.renderer.backends.flixel.Shaders;
import lunarlib.renderer.backends.flixel.SingleBitmapManager;

typedef TransformProperties =
{
	var x:Float;
	var y:Float;
	var width:Int;
	var height:Int;
}

enum LunarFlixeRenderMode
{
	MESH_FACTORY;
	SINGLE_BITMAP;
}

class LunarFlixelBackend extends flixel.FlxBasic
{
	public var x:Float;
	public var y:Float;
	public var bitmapMgr:SingleBitmapManager;
	public var meshFactory:MeshFactory;
	public var renderMode:LunarFlixeRenderMode = MESH_FACTORY;

	public function new(?renderMode:LunarFlixeRenderMode = MESH_FACTORY, ?transformProps:TransformProperties)
	{
		super();
		this.renderMode = renderMode;
		this.x = transformProps.x;
		this.y = transformProps.y;
		switch (renderMode)
		{
			case MESH_FACTORY:
				meshFactory = new MeshFactory();
				meshFactory.setPosition(transformProps.x, transformProps.y);
				meshFactory.width = transformProps.width;
				meshFactory.height = transformProps.height;
				meshFactory.bgColor = 0x00000000;
				FlxG.cameras.add(meshFactory, false);
			case SINGLE_BITMAP:
				bitmapMgr = new SingleBitmapManager(transformProps.x, transformProps.y);
				bitmapMgr.makeGraphic(transformProps.width, transformProps.height, 0x00000000);
		}
	}

	function sortByID(o1:Dynamic, o2:Dynamic):Int
		return FlxSort.byValues(FlxSort.ASCENDING, o1.id, o2.id);

	public function drawFrame(layers:Array<LunarRenderLayer>, bases:Array<LunarBase>)
	{
		layers.sort(sortByID);
		bases.sort(sortByID);

		switch (renderMode)
		{
			case MESH_FACTORY:
				for (base in bases)
					meshFactory.drawBase(base);
				for (layer in layers)
					for (base in layer.members)
						meshFactory.drawBase(base);
			case SINGLE_BITMAP:
				bitmapMgr.clear();
				for (base in bases)
					bitmapMgr.drawBase(base);
				for (layer in layers)
					for (base in layer.members)
						bitmapMgr.drawBase(base);
				bitmapMgr.draw();
		}
	}
}
