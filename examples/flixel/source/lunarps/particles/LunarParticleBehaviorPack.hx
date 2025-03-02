package lunarps.particles;

class LunarParticleBehaviorPack
{
	public var particleConfig:LunarShape;
	public var mainBehavior:LunarParticleBehavior;
	public var sideBehaviors:Map<String, LunarParticleBehavior> = new Map();

	public function new() {}
}
