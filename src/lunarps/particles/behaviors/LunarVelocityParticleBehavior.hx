package lunarps.particles.behaviors;

class LunarVelocityParticleBehavior extends LunarParticleBehavior
{
	override public function onParticleSpawn(particle:LunarParticle, emitter:LunarParticleEmitter)
	{
		if (particle.values.velocity == null)
			particle.values.velocity = {x: 0, y: 0};
		if (particle.values.maxVelocity == null)
			particle.values.maxVelocity = {x: 100, y: 100};
	}

	override public function onParticleFrame(particle:LunarParticle, emitter:LunarParticleEmitter, dt:Float)
	{
		particle.x += particle.values.velocity.x;
		particle.y += particle.values.velocity.y;
		if (particle.values.velocity.x > particle.values.maxVelocity.x)
			particle.values.velocity.x = particle.values.maxVelocity.x;
		if (particle.values.velocity.y > particle.values.maxVelocity.y)
			particle.values.velocity.y = particle.values.maxVelocity.y;
	}
}
