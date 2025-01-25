package lunarps.particles;

import lunarps.LunarShape;

class LunarParticle extends LunarBase
{
	/**
		This holds all custom values for this particle. These values are defined manually. eg:
		```haxe
		// Lifetime isn't defined yet, but by setting it to a value, it now exists.
		trace(values.lifetime); // null, not defined yet
		values.lifetime = 50;
		trace(values.lifetime); // 50

		// You can also store functions in this value aswell. eg:
		values.startDeathAnimation = (length:Int):String -> { 
				   trace('Starting death animation with length: $length');
		};
		trace(values.startDeathAnimation(30)); // Starting death animation with length 30
		```
		This is useful for storing custom values for particles that are defined by a particle behavior.
		You can make a whole state system if you really wanted to, you can define your own functions, and variables.
	 */
	public var values:lunarps.abstracts.LunarVarAbstract = new lunarps.abstracts.LunarVarAbstract();

	public var behavior(default, set):LunarParticleBehavior = new LunarParticleBehavior();
	public var emitter:LunarParticleEmitter;

	function set_behavior(value:LunarParticleBehavior):LunarParticleBehavior
	{
		if (value == null)
			return null;
		behavior = value;
		behavior.onParticleSpawn(this, emitter);
		return value;
	}

	override public function new(x:Float, y:Float, emitter:LunarParticleEmitter, ?behavior:LunarParticleBehavior)
	{
		super(x, y);
		this.emitter = emitter;
		if (behavior != null)
			this.behavior = behavior;
	}

	override public function onFrame(dt:Float)
	{
		super.onFrame(dt);
		behavior.onParticleFrame(this, emitter, dt);
	}

	override public function kill()
	{
		super.kill();
		// To prevent null access
		shape = new LunarRect(0x0, 0, 0);
		behavior = null;
		for (v in values)
			try
			{
				v = null;
			}
			catch (_) {}
	}
}
