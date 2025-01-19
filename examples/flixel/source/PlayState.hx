package;

import flixel.FlxState;
import lunarps.LunarShape.LunarCircle;
import lunarps.particles.LunarParticleEmitter;
import lunarps.particles.behaviors.LunarGravityParticleBehavior;
import lunarps.particles.behaviors.LunarVelocityParticleBehavior;
import lunarps.renderer.LunarRenderer;
import lunarps.renderer.backends.LunarFlixelBackend;

class PlayState extends FlxState
{
	var renderer:LunarRenderer;
	var emitter:LunarParticleEmitter;

	override public function create()
	{
		super.create();

		renderer = new LunarRenderer({
			x: 0,
			y: 0,
			width: 512,
			height: 512
		});
		emitter = new LunarParticleEmitter(256, 0, renderer, new LunarCircle(0xFFFFFFFF, 10.0), {}, {});
		emitter.addBehavior("gravity", new LunarGravityParticleBehavior());
		add(renderer);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		emitter.onFrame(elapsed);
	}
}
