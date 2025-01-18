package lunarps.particles.behaviors;

class LunarSignalParticleBehavior extends LunarParticleBehavior
{
	public var preParticleSpawnCallback:(config:LunarShape, emitter:LunarParticleEmitter) -> Bool = (particle, emitter) ->
	{
		return true;
	};
	public var onParticleSpawnCallback:(particle:LunarParticle, emitter:LunarParticleEmitter) -> Void = (particle, emitter) -> {};
	public var onParticleFrameCallback:(particle:LunarParticle, emitter:LunarParticleEmitter, dt:Float) -> Void = (particle, emitter, dt) -> {};

	override public function preParticleSpawn(config:LunarShape, emitter:LunarParticleEmitter):Bool
	{
		return preParticleSpawnCallback(config, emitter);
	}

	override public function onParticleSpawn(particle:LunarParticle, emitter:LunarParticleEmitter)
	{
		onParticleSpawnCallback(particle, emitter);
	}

	override public function onParticleFrame(particle:LunarParticle, emitter:LunarParticleEmitter, dt:Float)
	{
		onParticleFrameCallback(particle, emitter, dt);
	}
}
