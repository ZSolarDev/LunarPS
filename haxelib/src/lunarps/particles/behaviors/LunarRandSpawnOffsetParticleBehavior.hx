package lunarps.particles.behaviors;

class LunarRandSpawnOffsetParticleBehavior extends LunarParticleBehavior
{
	public var rangeX:Float = 20;
	public var rangeY:Float = 20;

	public function new(rangeX:Float = 20, rangeY:Float = 20)
	{
		super();
		this.rangeX = rangeX;
		this.rangeY = rangeY;
	}

	override public function onParticleSpawn(particle:LunarParticle, emitter:LunarParticleEmitter)
	{
		particle.x += Math.random() * rangeX;
		particle.y += Math.random() * rangeY;
	}
}
