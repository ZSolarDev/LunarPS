package lunarps.renderer;

import lunarps.LunarBase;

class LunarRenderer extends lunarps.renderer.backends.LunarFlixelBackend
{
	public var layers:Array<LunarRenderLayer> = [];
	public var members:Array<LunarBase> = [];

	public function add(base:LunarBase)
		return members.push(base);

	public function remove(base:LunarBase)
		return members.remove(base);

	public function addLayer(layer:LunarRenderLayer)
		return layers.push(layer);

	public function removeLayer(layer:LunarRenderLayer)
		return layers.remove(layer);

	override public function draw()
		return drawFrame(layers, members);
}
