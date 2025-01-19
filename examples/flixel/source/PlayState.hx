package;

import flixel.FlxG;
import flixel.FlxState;
import lunarps.LunarBase;
import lunarps.LunarShape.LunarCircle;
import lunarps.LunarShape.LunarRect;
import lunarps.LunarShape.LunarTexture;
import lunarps.particles.LunarParticleEmitter;
import lunarps.particles.behaviors.*;
import lunarps.renderer.LunarRenderLayer;
import lunarps.renderer.LunarRenderer;

class PlayState extends FlxState
{
	var emitter:LunarParticleEmitter;
	var coolBehaviorPack:CustomBehaviorPack = new CustomBehaviorPack();
	var renderer:LunarRenderer;
	var tmr:LunarTimer = new LunarTimer();

	override public function create()
	{
		super.create();
		FlxG.updateFramerate = 250;
		FlxG.drawFramerate = 250;
		renderer = new LunarRenderer({
			x: 0,
			y: 0,
			width: FlxG.width,
			height: FlxG.height
		});
		add(renderer);
		emitter = new LunarParticleEmitter(60, 60, renderer, new LunarCircle(0xFFAD0A0A, 60), {}, {});
		emitter.addBehavior('reheheheha', new LunarRandSpawnOffsetParticleBehavior(100, 100));
		emitter.addBehaviorPack(coolBehaviorPack, false);

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
