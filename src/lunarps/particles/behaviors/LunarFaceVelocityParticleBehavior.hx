package lunarps.particles.behaviors;

import flixel.math.FlxAngle;

class LunarFaceVelocityParticleBehavior extends LunarVelocityParticleBehavior
{
	override public function onParticleFrame(particle:LunarParticle, emitter:LunarParticleEmitter, dt:Float)
	{
		particle.shape.angle = (FlxAngle.radiansFromOrigin(particle.values.velocity.x, particle.values.velocity.y) * FlxAngle.TO_DEG) + 90;
	}
}
