package lunarlib.particles;

class LunarParticleBehavior
{
	public function new() {}

	/**
	 * This function is called before a particle is spawned. If false is returned, the particle emitter will not spawn a particle.
	 * This is useful for spawning a modified particle instead of a normal one spawned by the emitter.
	 * @param config 
	 * @param emitter 
	 * @return Bool
	 */
	public function preParticleSpawn(config:LunarShape, emitter:LunarParticleEmitter):Bool
	{
		return true;
	}

	/**
	 * This function is called when a particle is spawned.
	 * @param particle 
	 * @param emitter 
	 */
	public function onParticleSpawn(particle:LunarParticle, emitter:LunarParticleEmitter) {}

	/**
	 * This function is called on each particle every frame.
	 * @param particle 
	 * @param emitter 
	 * @param dt 
	 */
	public function onParticleFrame(particle:LunarParticle, emitter:LunarParticleEmitter, dt:Float) {}
}
