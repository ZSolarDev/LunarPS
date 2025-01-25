package lunarps.particles.behaviors;

class LunarInitialVelocityParticleBehavior extends LunarVelocityParticleBehavior
{
	public var velocityX:Float = 0;
	public var velocityY:Float = 0;

	public function new(velocityX:Float = 0, velocityY:Float = 0)
	{
		super();
		this.velocityX = velocityX;
		this.velocityY = velocityY;
	}

	override public function onParticleSpawn(particle:LunarParticle, emitter:LunarParticleEmitter)
	{
		super.onParticleSpawn(particle, emitter);
		particle.values.velocity.x = velocityX;
		particle.values.velocity.y = velocityY;
	}
}
