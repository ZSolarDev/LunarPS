package lunarps.renderer.backends;

import flixel.FlxG;
import flixel.util.FlxSort;
import lunarps.LunarBase;
import lunarps.renderer.backends.flixel.MeshFactory;
import lunarps.renderer.backends.flixel.Shaders;

typedef TransformProperties =
{
	var x:Float;
	var y:Float;
	var width:Int;
	var height:Int;
}

class LunarFlixelBackend extends flixel.FlxBasic
{
	public var x:Float;
	public var y:Float;
	public var meshFactory:MeshFactory;

	public function new(?transformProps:TransformProperties)
	{
		super();
		this.x = transformProps.x;
		this.y = transformProps.y;
		meshFactory = new MeshFactory();
		meshFactory.setPosition(transformProps.x, transformProps.y);
		meshFactory.width = transformProps.width;
		meshFactory.height = transformProps.height;
		meshFactory.bgColor = 0x00000000;
		FlxG.cameras.add(meshFactory, false);
	}

	function sortByID(o1:Dynamic, o2:Dynamic):Int
		return FlxSort.byValues(FlxSort.ASCENDING, o1.id, o2.id);

	public function drawFrame(layers:Array<LunarRenderLayer>, bases:Array<LunarBase>)
	{
		layers.sort(sortByID);
		bases.sort(sortByID);

		for (base in bases)
			meshFactory.drawBase(base);
		for (layer in layers)
			for (base in layer.members)
				meshFactory.drawBase(base);
	}
}
