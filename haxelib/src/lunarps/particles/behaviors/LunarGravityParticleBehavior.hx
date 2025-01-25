package lunarps.particles.behaviors;

class LunarGravityParticleBehavior extends LunarVelocityParticleBehavior
{
	public var gravity:Float = 9.81; // irl gravity

	public function new(gravity:Float = 9.81)
	{
		super();
		this.gravity = gravity;
	}

	override public function onParticleFrame(particle:LunarParticle, emitter:LunarParticleEmitter, dt:Float)
	{
		particle.values.velocity.y += gravity * dt;
	}
}
