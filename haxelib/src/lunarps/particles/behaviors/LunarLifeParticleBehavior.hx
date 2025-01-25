package lunarps.particles.behaviors;

class LunarLifeParticleBehavior extends LunarParticleBehavior
{
	public var lifeSecs:Float = 1;
	public var lifeEndedCallback:(particle:LunarParticle, emitter:LunarParticleEmitter, dt:Float) -> Void = (particle, emitter, dt) ->
	{
		LunarParticleBehavior.killParticle(particle);
	};

	public function new(lifeSecs:Float = 1)
	{
		super();
		this.lifeSecs = lifeSecs;
	}

	override public function onParticleSpawn(particle:LunarParticle, emitter:LunarParticleEmitter)
	{
		if (particle.values.timer == null)
			particle.values.timer = new lunarps.LGUtils.LunarTimer();
		particle.values.timer.startTimer(lifeSecs, 0);
		particle.values.timer.timerCompleted = () ->
		{
			lifeEndedCallback(particle, emitter, emitter.curDt);
		}
	}
}
