package lunarps.particles.behaviors;

import flixel.math.FlxRandom;
import lunarps.math.LunarVector2;

class LunarRandomInitialVelocityParticleBehavior extends LunarVelocityParticleBehavior
{
	public var minMaxVelocityX:LunarVector2<Float> = new LunarVector2(0.0, 0.0);
	public var minMaxVelocityY:LunarVector2<Float> = new LunarVector2(0.0, 0.0);

	public function new(minVelocityX:Float = 0, maxVelocityX:Float = 0, minVelocityY:Float = 0, maxVelocityY:Float = 0)
	{
		super();
		minMaxVelocityX.x = minVelocityX;
		minMaxVelocityX.y = maxVelocityX;
		minMaxVelocityY.x = minVelocityY;
		minMaxVelocityY.y = maxVelocityY;
	}

	override public function onParticleSpawn(particle:LunarParticle, emitter:LunarParticleEmitter)
	{
		super.onParticleSpawn(particle, emitter);
		particle.values.velocity.x = new FlxRandom().float(minMaxVelocityX.x, minMaxVelocityX.y);
		particle.values.velocity.y = new FlxRandom().float(minMaxVelocityY.x, minMaxVelocityY.y);
	}
}
