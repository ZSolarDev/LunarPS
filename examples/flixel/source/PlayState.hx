package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import lunarps.LunarShape;
import lunarps.particles.*;
import lunarps.particles.behavior_packs.*;
import lunarps.particles.behaviors.*;
import lunarps.renderer.LunarRenderer;

enum Demo
{
	RAIN;
	SNOW;
	FIRE;
	STRESS_TEST;
}

class PlayState extends FlxState
{
	var demo:Demo = FIRE;
	var spawnBatches:Bool = false;
	var system:LunarParticleSystem = new LunarParticleSystem();

	override public function create()
	{
		super.create();
		FlxG.autoPause = false;
		var renderer = new LunarRenderer({
			x: 0,
			y: 0,
			width: FlxG.width,
			height: FlxG.height
		});
		add(renderer);
		switch (demo)
		{
			case RAIN:
				var signal:LunarSignalParticleBehavior = new LunarSignalParticleBehavior();
				signal.onParticleFrameCallback = (particle:LunarParticle, emitter:LunarParticleEmitter, dt:Float) ->
				{
					if (particle.y > FlxG.height || particle.x > FlxG.width)
						LunarParticleBehavior.killParticle(particle);
				}
				var r = new LunarCircle(0xFFFFFFFF, 2, 6);
				r.alpha = 160;
				var emitter = new LunarParticleEmitter(-150, -20, renderer, r, null, {autoSpawning: true, waitingSecs: 0, particlesPerWaitingSecs: 5});
				emitter.addBehavior('spawn in range', new LunarSpawnInRangeParticleBehavior(FlxG.width + 150, 0));
				emitter.addBehavior('velocity', new LunarVelocityParticleBehavior());
				emitter.addBehavior('initial velocity', new LunarRandomInitialVelocityParticleBehavior(5, 8, 10, 20));
				emitter.addBehavior('face velocity', new LunarFaceVelocityParticleBehavior());
				emitter.addBehavior('random color', new LunarColorVariationParticleBehavior([0xFF59B0DB, 0xFFA8D5FF, 0xFFD3EFFF]));
				emitter.addBehavior('stretch to velocity', new LunarVelocityStretchParticleBehavior(2, 2, false, true));
				emitter.addBehavior('signal', signal);
				system.addEmitter('rainMidground', emitter);
				var rBG = new LunarCircle(0xFFFFFFFF, 1, 3);
				rBG.alpha = 100;
				var emitterBG = new LunarParticleEmitter(-150, -20, renderer, rBG, null, {autoSpawning: true, waitingSecs: 0, particlesPerWaitingSecs: 5});
				emitterBG.addBehavior('spawn in range but in the bg', new LunarSpawnInRangeParticleBehavior(FlxG.width + 150, 0));
				emitterBG.addBehavior('velocity but in the bg x2', new LunarVelocityParticleBehavior());
				emitterBG.addBehavior('initial velocity but in the bg x3', new LunarRandomInitialVelocityParticleBehavior(5, 8, 10, 20));
				emitterBG.addBehavior('face velocity but in the bg x4', new LunarFaceVelocityParticleBehavior());
				emitterBG.addBehavior('random color but in the bg x5', new LunarColorVariationParticleBehavior([0xFF98DDFF, 0xFFA8D5FF, 0xFF9FCCFF]));
				emitterBG.addBehavior('stretch to velocity but in the bg x6', new LunarVelocityStretchParticleBehavior(1.5, 1, false, true));
				emitterBG.addBehavior('signal but in the bg x7', signal);
				system.addEmitter('rainBackground', emitterBG);
			case SNOW:
				var signal:LunarSignalParticleBehavior = new LunarSignalParticleBehavior();
				signal.onParticleFrameCallback = (particle:LunarParticle, emitter:LunarParticleEmitter, dt:Float) ->
				{
					if (particle.y > FlxG.height || particle.x > FlxG.width)
						LunarParticleBehavior.killParticle(particle);
				}
				var emitter = new LunarParticleEmitter(-1000, -20, renderer, new LunarCircle(0xFFFFFFFF, 40, 40), null,
					{autoSpawning: true, waitingSecs: 0.1, particlesPerWaitingSecs: 5});
				emitter.addBehavior('spawn in range', new LunarSpawnInRangeParticleBehavior(FlxG.width + 1000, 0));
				emitter.addBehavior('velocity', new LunarVelocityParticleBehavior());
				emitter.addBehavior('initial velocity', new LunarRandomInitialVelocityParticleBehavior(2, 5, 3, 6));
				emitter.addBehavior('signal', signal);
				system.addEmitter('blizzardMidground', emitter);
				var signalBG:LunarSignalParticleBehavior = new LunarSignalParticleBehavior();
				signalBG.onParticleFrameCallback = (particle:LunarParticle, emitter:LunarParticleEmitter, dt:Float) ->
				{
					var rect:LunarRect = cast particle.shape;
					if (particle.y > FlxG.height || particle.x + rect.width < 0)
						LunarParticleBehavior.killParticle(particle);
				}
				var sBG = new LunarCircle(0xFFFFFFFF, 40, 40);
				sBG.alpha = 100;
				var emitterBG = new LunarParticleEmitter(1000, -20, renderer, sBG, null, {autoSpawning: true, waitingSecs: 0.1, particlesPerWaitingSecs: 5});
				emitterBG.addBehavior('spawn in range but in the bg', new LunarSpawnInRangeParticleBehavior(FlxG.width - 2000, 0));
				emitterBG.addBehavior('velocity but in the bg x2', new LunarVelocityParticleBehavior());
				emitterBG.addBehavior('initial velocity', new LunarRandomInitialVelocityParticleBehavior(-2, -5, 3, 6));
				emitterBG.addBehavior('signal but in the bg x3', signalBG);
				system.addEmitter('blizzardBackground', emitterBG);
			case FIRE:
				var emitter = new LunarParticleEmitter(0, 0, renderer, new LunarRect(0xFF, 10, 10), null, {});
				emitter.addBehaviorPack(new LunarFireParticleBehaviorPack());
				system.addEmitter('fire', emitter);
			case STRESS_TEST:
				var stressTest = new LunarParticleEmitter(0, 0, renderer, new LunarCircle(0xFFFFFFFF, 10, 10), null,
					{autoSpawning: true, waitingSecs: 0, particlesPerWaitingSecs: 10});
				stressTest.addBehavior('spawn in range', new LunarSpawnInRangeParticleBehavior(FlxG.width, FlxG.height));
				stressTest.addBehavior('random color', new LunarColorVariationParticleBehavior([
					0xFFFF0000, 0xFFFF7700, 0xFFFFAA00, 0xFFFFFF00, 0xFF00FF00, 0xFF00FFAA, 0xFF00AACC, 0xFF0000FF, 0xFFAA00FF, 0xFFFF00FF
				]));
				system.addEmitter('stressing', stressTest);
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		if (FlxG.keys.justPressed.ENTER && demo != STRESS_TEST && demo != FIRE)
			spawnBatches = !spawnBatches;

		if (demo != STRESS_TEST && demo != FIRE)
			system.setEmitterProperty('autoSpawning', spawnBatches ? false : true);

		if (FlxG.keys.justPressed.SPACE && demo != STRESS_TEST && demo != FIRE)
		{
			if (spawnBatches)
			{
				switch (demo)
				{
					case RAIN:
						var r = new LunarCircle(0xFFFFFFFF, 2, 6);
						r.alpha = 160;
						system.spawnParticleBatch([
							{
								emitterName: 'rainMidground',
								shape: r,
								amount: 50
							}
						]);
						var rBG = new LunarCircle(0xFFFFFFFF, 1, 3);
						rBG.alpha = 100;
						system.spawnParticleBatch([
							{
								emitterName: 'rainBackground',
								shape: rBG,
								amount: 50
							}
						]);
					case SNOW:
						system.spawnParticleBatch([
							{
								emitterName: 'blizzardMidground',
								shape: new LunarCircle(0xFFFFFFFF, 40, 40),
								amount: 50
							}
						]);
						var sBG = new LunarCircle(0xFFFFFFFF, 40, 40);
						sBG.alpha = 100;
						system.spawnParticleBatch([
							{
								emitterName: 'blizzardBackground',
								shape: sBG,
								amount: 50
							}
						]);
					default:
				}
			}
			else
				system.setEmitterProperty('autoSpawning', true);
		}

		if (demo == STRESS_TEST)
			FlxG.watch.addQuick('Particles', system.getEmitter('stressing').particles.length);
	}
}
