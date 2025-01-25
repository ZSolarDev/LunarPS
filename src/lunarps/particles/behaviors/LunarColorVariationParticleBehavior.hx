package lunarps.particles.behaviors;

import flixel.math.FlxRandom;

class LunarColorVariationParticleBehavior extends LunarParticleBehavior
{
	public var colorVariants:Array<Int> = [];

	override public function new(colorVariants:Array<Int>)
	{
		super();
		this.colorVariants = colorVariants;
	}

	override public function onParticleSpawn(particle:LunarParticle, emitter:LunarParticleEmitter)
	{
		if (colorVariants.length > 0)
			particle.shape.color = colorVariants[new FlxRandom().int(0, colorVariants.length)];
	}
}
