package lunarps.particles.behaviors;

import lunarps.LunarShape.LunarRect;

class LunarVelocityStretchParticleBehavior extends LunarVelocityParticleBehavior
{
	public var stretchFactor:Float = 1;

	/**
	 * The divisor used to reduce the effect of the opposite velocity axis.
	 * explanation:
	 * if the y velocity is big, the width will be reduced by y velocity divided by this value.
	 * if the x velocity is big, the height will be reduced by x velocity divided by this value.
	 * visually meaning:
	 * if the particle is moving fast on the y axis, it will shrink on the x axis to give the illusion of speed.
	 * if the particle is moving fast on the x axis, it will shrink on the y axis to give the illusion of speed.
	 */
	public var oppVelAxesEffDivisor:Float = 3;

	public var applyOnX:Bool = true;
	public var applyOnY:Bool = true;

	override public function new(stretchFactor:Float = 1, oppVelAxesEffDivisor:Float = 3, applyOnX:Bool = true, applyOnY:Bool = true)
	{
		super();
		this.stretchFactor = stretchFactor;
		this.oppVelAxesEffDivisor = oppVelAxesEffDivisor;
		this.applyOnX = applyOnX;
		this.applyOnY = applyOnY;
	}

	override public function onParticleSpawn(particle:LunarParticle, emitter:LunarParticleEmitter)
	{
		var rect:LunarRect = cast particle.shape;
		if (particle.values.oldWidth == null)
			particle.values.oldWidth = rect.width;
		if (particle.values.oldHeight == null)
			particle.values.oldHeight = rect.height;
	}

	override public function onParticleFrame(particle:LunarParticle, emitter:LunarParticleEmitter, dt:Float)
	{
		var rect:LunarRect = cast particle.shape;
		var velX = Math.abs(particle.values.velocity.x);
		var velY = Math.abs(particle.values.velocity.y);
		if (applyOnX)
			rect.width = particle.values.oldWidth + velX * stretchFactor - (velY / oppVelAxesEffDivisor);
		if (applyOnY)
			rect.height = particle.values.oldHeight + velY * stretchFactor - (velX / oppVelAxesEffDivisor);
	}
}
