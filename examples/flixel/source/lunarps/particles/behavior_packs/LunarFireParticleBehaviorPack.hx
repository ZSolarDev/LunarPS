package lunarps.particles.behavior_packs;

import lunarps.particles.behaviors.LunarVelocityParticleBehavior;

class LunarFireParticleBehaviorPack extends LunarParticleBehaviorPack
{
	public function new()
	{
		super();
	}
}

typedef LunarFireClump =
{
	var x:Float;
	var y:Float;
	var size:Float;
}

class LunarFireParticleBehavior extends LunarVelocityParticleBehavior
{
	public var clumps:Array<LunarFireClump> = [];

	public function new()
	{
		super();
	}

	public function onParticleSpawn(particle:LunarParticle, emitter:LunarParticleEmitter)
	{
		super.onParticleSpawn(particle, emitter);
		var clump:LunarFireClump = clumps[particle.id];
		if (clump != null)
		{
			particle.x = clump.x;
			particle.y = clump.y;
		}
	}

	public function onParticleFrame(particle:LunarParticle, emitter:LunarParticleEmitter, dt:Float)
	{
		super.onParticleFrame(particle, emitter, dt);
		var clump:LunarFireClump = clumps[particle.id];
		if (clump != null)
		{
			particle.x = clump.x;
			particle.y = clump.y;
			particle.shape.width = clump.size;
			particle.shape.height = clump.size;
		}
	}
}
