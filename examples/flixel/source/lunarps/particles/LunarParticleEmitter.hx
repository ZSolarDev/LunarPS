package lunarps.particles;

import lunarps.renderer.LunarRenderLayer;
import lunarps.renderer.LunarRenderer;

typedef RendererProps =
{
	var ?width:Int;
	var ?height:Int;
	var ?emitterLayer:LunarRenderLayer;
	var ?addRendererToCurState:Bool;
}

typedef MiscProps =
{
	var ?mainParticleBehavior:LunarParticleBehavior;
	var ?autoSpawning:Bool;
	var ?waitingSecs:Float;
}

class LunarParticleEmitter
{
	public var x:Float = 0;
	public var y:Float = 0;
	public var rendererWidth:Int = 0;
	public var rendererHeight:Int = 0;
	public var emitterLayer:LunarRenderLayer;
	public var particleConfig:LunarShape;
	public var personalRenderer:Bool = false;
	public var personalEmitter:Bool = false;
	public var renderer:LunarRenderer;
	public var particles:Array<LunarParticle> = [];
	public var mainParticleBehavior:LunarParticleBehavior;
	public var sideParticleBehaviors:Map<String, LunarParticleBehavior> = new Map();
	public var waitingSecs:Float = 0.1;
	public var curSecs:Float = 0;
	public var autoSpawning:Bool = true;
	public var curDt:Float = 0;

	public function new(x:Float = 0, y:Float = 0, renderer:LunarRenderer, particleConfig:LunarShape, rendererProps:RendererProps, miscProps:MiscProps)
	{
		this.x = x;
		this.y = y;
		if (rendererProps.width != null)
			this.rendererWidth = rendererProps.width;
		if (rendererProps.height != null)
			this.rendererHeight = rendererProps.height;

		setRenderer(renderer, rendererProps.emitterLayer, rendererProps.addRendererToCurState);
		this.particleConfig = particleConfig;
		this.mainParticleBehavior = miscProps.mainParticleBehavior;
		if (miscProps.autoSpawning != null)
			this.autoSpawning = miscProps.autoSpawning;
		if (miscProps.waitingSecs != null)
			this.waitingSecs = miscProps.waitingSecs;
	}

	public function setRenderer(renderer:LunarRenderer, particleEmitterLayer:LunarRenderLayer, addRendererToCurState:Bool = true)
	{
		if (particleEmitterLayer != null)
		{
			emitterLayer = particleEmitterLayer;
			personalEmitter = false;
		}
		else
		{
			personalEmitter = true;
			emitterLayer = new LunarRenderLayer();
		}
		if (renderer != null)
		{
			this.renderer = renderer;
			personalRenderer = false;
		}
		else
		{
			this.renderer = new LunarRenderer({
				x: x,
				y: y,
				width: rendererWidth,
				height: rendererHeight
			});
			personalRenderer = true;
		}
		this.renderer.addLayer(emitterLayer);
		#if flixelMode
		try
		{
			if (addRendererToCurState)
				flixel.FlxG.state.add(this.renderer);
		}
		catch (e:Dynamic) {}
		#end
	}

	public function addBehaviorPack(pack:LunarParticleBehaviorPack, overwriteMainBehavior:Bool = true)
	{
		if (overwriteMainBehavior)
			mainParticleBehavior = pack.mainBehavior;
		for (behavior in pack.sideBehaviors.keys())
			addBehavior(behavior, pack.sideBehaviors.get(behavior));
	}

	public function spawnParticle(shape:LunarShape)
	{
		inline function spawn()
		{
			var particle = new LunarParticle(x, y, this);
			particle.shape = shape.copy();
			particles.push(particle);
			renderer.add(particle);
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

	public function onFrame(dt:Float)
	{
		curDt = dt;
		if (autoSpawning)
		{
			if (curSecs <= 0)
			{
				curSecs = waitingSecs;
				spawnParticle(particleConfig);
			}
			curSecs -= dt;
		}
		for (p in particles)
		{
			p.onFrame(dt);
			if (p != null)
			{
				mainParticleBehavior.onParticleFrame(p, this, dt);
				for (behavior in sideParticleBehaviors)
					behavior.onParticleFrame(p, this, dt);
			}
		}
	}

	public function kill()
	{
		for (p in particles)
			p.kill();
		particles = null;
		if (personalRenderer)
			renderer = null;
		particleConfig = null;
		mainParticleBehavior = null;
	}
}
