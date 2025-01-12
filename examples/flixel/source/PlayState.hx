package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.util.FlxTimer;
import lunarlib.LunarBase;
import lunarlib.LunarShape.LunarCircle;
import lunarlib.LunarShape.LunarRect;
import lunarlib.LunarShape.LunarTexture;
import lunarlib.particles.LunarParticleEmitter;
import lunarlib.particles.behaviors.*;
import lunarlib.renderer.LunarRenderLayer;
import lunarlib.renderer.LunarRenderer;

class PlayState extends FlxState
{
	var emitter:LunarParticleEmitter;
	var fadeBehavior:LunarFadeParticleBehavior = new LunarFadeParticleBehavior();
	var spawnEffectBehavior:GrowOnSpawnBehavior = new GrowOnSpawnBehavior();
	var renderer:LunarRenderer;
	var tmr:LunarTimer = new LunarTimer();

	override public function create()
	{
		super.create();
		FlxG.updateFramerate = 250;
		FlxG.drawFramerate = 250;
		renderer = new LunarRenderer(SINGLE_BITMAP, {
			x: 0,
			y: 0,
			width: FlxG.width,
			height: FlxG.height
		});
		add(renderer);
		emitter = new LunarParticleEmitter(60, 60, renderer, true, new LunarTexture(0xFFAD0A0A, 'assets/breh.png', 60, 60),
			new LunarRandSpawnOffsetParticleBehavior(100, 100));
		emitter.addBehavior('spawn effect brahh..', spawnEffectBehavior);
		emitter.addBehavior('time is ticking!', fadeBehavior);
		fadeBehavior.fadeStartedCallback = (particle, emitter, dt) ->
		{
			particle.behavior = new LunarGravityParticleBehavior(1);
		};
		var basic:LunarBase = new LunarBase(10, 10);
		basic.shape = new LunarTexture(0xFFAD0A0A, 'assets/breh.png', 60, 60);
		var basic2:LunarBase = new LunarBase(60, 60);
		basic2.shape = new LunarRect(0xFFF02D2D, 20, 20);
		var layer = new LunarRenderLayer();
		renderer.addLayer(layer);
		layer.add(basic);
		layer.add(basic2);
		layer.id++;
		tmr.startTimer(FlxG.elapsed);
		FlxG.autoPause = false;
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		emitter.onFrame(elapsed);
		tmr.updateTimer(FlxG.elapsed);
	}
}
