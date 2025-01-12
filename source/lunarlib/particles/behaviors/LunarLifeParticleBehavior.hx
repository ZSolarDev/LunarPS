package lunarlib.particles.behaviors;

class LunarLifeParticleBehavior extends LunarParticleBehavior
{
	public var lifeSecs:Float = 1;
	public var lifeEndedCallback:(particle:LunarParticle, emitter:LunarParticleEmitter, dt:Float) -> Void = (particle, emitter, dt) ->
	{
		particle.kill();
		emitter.particles.remove(particle);
		emitter.renderer.remove(particle);
	};

	public function new(lifeSecs:Float = 1)
	{
		super();
		this.lifeSecs = lifeSecs;
	}

	override public function onParticleSpawn(particle:LunarParticle, emitter:LunarParticleEmitter)
	{
		if (particle.values.timer == null)
			particle.values.timer = new LunarTimer();
		particle.values.timer.startTimer(emitter.curDt, lifeSecs, 0);
		particle.values.timer.timerCompleted = () ->
		{
			trace('ee');
			lifeEndedCallback(particle, emitter, emitter.curDt);
		}
	}

	override public function onParticleFrame(particle:LunarParticle, emitter:LunarParticleEmitter, dt:Float)
	{
		particle.values.timer.updateTimer(dt);
		// trace(particle.values.timer.timeLeft);
	}
}
