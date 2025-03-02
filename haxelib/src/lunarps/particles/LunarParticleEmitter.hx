package lunarps.particles;

import flixel.FlxG;
import lunarps.abstracts.LunarVarAbstract;
import lunarps.renderer.LunarRenderLayer;
import lunarps.renderer.LunarRenderer;
import openfl.events.Event;

typedef MiscProps =
{
	var ?mainParticleBehavior:LunarParticleBehavior;
	var ?sideParticleBehaviors:Map<String, LunarParticleBehavior>;
	var ?maxParticles:Int;
	var ?particlesPerWaitingSecs:Int;
	var ?autoSpawning:Bool;
	var ?waitingSecs:Float;
}

class LunarParticleEmitter
{
	public var x:Float = 0;
	public var y:Float = 0;
	public var emitterLayer:LunarRenderLayer;
	public var particleConfig:LunarShape;
	public var renderer:LunarRenderer;
	public var particles:LunarPool<LunarParticle> = new LunarPool<LunarParticle>();
	public var mainParticleBehavior:LunarParticleBehavior;
	public var sideParticleBehaviors:Map<String, LunarParticleBehavior> = new Map();
	public var waitingSecs:Float = 0.1;
	public var particlesPerWaitingSecs:Int = 1;
	public var maxParticles:Int = 0;
	public var curSecs:Float = 0;
	public var autoSpawning:Bool = true;
	public var curDt:Float = 0;

	public function new(x:Float = 0, y:Float = 0, renderer:LunarRenderer, particleConfig:LunarShape, ?emitterLayer:LunarRenderLayer, ?miscProps:MiscProps)
	{
		this.x = x;
		this.y = y;

		this.renderer = renderer;
		this.emitterLayer = emitterLayer;
		this.particleConfig = particleConfig;
		if (miscProps != null)
		{
			this.mainParticleBehavior = miscProps.mainParticleBehavior;
			if (miscProps.autoSpawning != null)
				this.autoSpawning = miscProps.autoSpawning;
			if (miscProps.waitingSecs != null)
				this.waitingSecs = miscProps.waitingSecs;
			if (miscProps.particlesPerWaitingSecs != null)
				this.particlesPerWaitingSecs = miscProps.particlesPerWaitingSecs;
			if (miscProps.maxParticles != null)
				this.maxParticles = miscProps.maxParticles;
		}

		FlxG.stage.addEventListener(Event.ENTER_FRAME, onFrame);
	}

	public function addBehaviorPack(pack:LunarParticleBehaviorPack, overwriteMainBehavior:Bool = true, overwriteParticleConfig:Bool = true)
	{
		if (overwriteParticleConfig && pack.particleConfig != null)
			particleConfig = pack.particleConfig;
		if (overwriteMainBehavior && pack.mainBehavior != null)
			mainParticleBehavior = pack.mainBehavior;
		for (behavior in pack.sideBehaviors.keys())
			addBehavior(behavior, pack.sideBehaviors.get(behavior));
	}

	public function spawnParticle(shape:LunarShape)
	{
		inline function spawn()
		{
			if (maxParticles > 0 && particles.length >= maxParticles)
				return;
			var particle:LunarParticle;
			if (particles.deadPoolableAvailable)
			{
				particle = particles.getDeadPoolable();
				particle.shape = LGUtils.copyClass(shape);
				particle.x = x;
				particle.y = y;
				particle.behavior = null;
				particle.dead = false;
				particle.visible = true;
				particle.id = 0;
				particle.values = null;
				particle.values = new LunarVarAbstract();
				particle.emitter = this;
			}
			else
			{
				particle = new LunarParticle(x, y, this);
				particle.shape = LGUtils.copyClass(shape);
				particles.addToPool(particle);
				if (emitterLayer != null)
					emitterLayer.add(particle);
				else
					renderer.add(particle);
			}
			if (mainParticleBehavior != null)
				mainParticleBehavior.onParticleSpawn(particle, this);
			for (behavior in sideParticleBehaviors)
				behavior.onParticleSpawn(particle, this);
		}
		if (mainParticleBehavior != null)
		{
			if (mainParticleBehavior.preParticleSpawn(shape, this))
				spawn();
		}
		else
			spawn();
	}

	public function addBehavior(name:String, behavior:LunarParticleBehavior)
		return sideParticleBehaviors.set(name, behavior);

	public function removeBehavior(name:String)
		return sideParticleBehaviors.remove(name);

	public function getBehavior(name:String)
		return sideParticleBehaviors.get(name);

	public function spawnParticleBatch(shape:LunarShape, amount:Int)
	{
		for (_ in 0...amount)
			spawnParticle(shape);
	}

	public function onFrame(_)
	{
		var dt:Float = FlxG.elapsed;
		curDt = dt;
		if (autoSpawning)
		{
			if (curSecs <= 0)
			{
				curSecs = waitingSecs;
				spawnParticleBatch(particleConfig, particlesPerWaitingSecs);
			}
			curSecs -= dt;
		}
		for (p in particles)
		{
			p.onFrame(dt);
			try
			{
				if (p != null)
				{
					if (mainParticleBehavior != null)
						mainParticleBehavior.onParticleFrame(p, this, dt);
					for (behavior in sideParticleBehaviors)
						behavior.onParticleFrame(p, this, dt);
				}
			}
			catch (e)
			{
				lunarps.LGUtils.LunarLogger.error('On particle frame error(${e.message}) Stack: ${e.stack.toString()}\n');
			}
		}
	}

	public function kill()
	{
		for (p in particles)
			p.kill();
		particles = null;
		particleConfig = null;
		mainParticleBehavior = null;
	}
}
