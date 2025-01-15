package lunarps.renderer;

class LunarRenderLayer
{
	public var id:Int = 1;
	public var members:Array<LunarBase> = [];

	public function new(?id:Int = 1)
	{
		this.id = id;
	}

	public function add(base:LunarBase)
		return members.push(base);

	public function remove(base:LunarBase)
		return members.remove(base);
}
