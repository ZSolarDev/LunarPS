import lunarps.math.*;
import lunarps.particles.*;
import lunarps.particles.behaviors.*;

class CustomBehaviorPack extends LunarParticleBehaviorPack
{
	var fadeBehavior:LunarFadeParticleBehavior = new LunarFadeParticleBehavior();
	var growBehavior:GrowOnSpawnBehavior = new GrowOnSpawnBehavior();

	public function new()
	{
		super();
		sideBehaviors.set('time is ticking...!', fadeBehavior);
		sideBehaviors.set('let the particles grow', growBehavior);
		fadeBehavior.fadeStartedCallback = (particle, emitter, dt) ->
		{
			particle.behavior = new LunarGravityParticleBehavior(1);
		};
	}
}

class GrowOnSpawnBehavior extends LunarParticleBehavior
{
	override public function onParticleSpawn(particle:LunarParticle, emitter:LunarParticleEmitter)
	{
		if (particle.shape.shapeType == CIRCLE)
		{
			var circ = cast particle.shape;
			particle.values.r = 0.0;
			particle.values.oldRadius = circ.radius;
			circ.radius = 1;
		}
	}

	override public function onParticleFrame(particle:LunarParticle, emitter:LunarParticleEmitter, dt:Float)
	{
		if (particle.shape.shapeType == CIRCLE)
		{
			var circ = cast particle.shape;
			particle.values.r += dt / 2;
			circ.radius = cast LunarInterp.easedInterp(circ.radius, particle.values.oldRadius, particle.values.r, 'smootherStepInOut');
		}
	}
}
