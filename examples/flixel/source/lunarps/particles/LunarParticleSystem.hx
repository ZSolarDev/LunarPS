package lunarps.particles;

typedef LunarParticleBatchData =
{
	var emitterName:String;
	var shape:LunarShape;
	var amount:Int;
}

class LunarParticleSystem
{
	public var emitters:Map<String, LunarParticleEmitter> = new Map();

	public function new() {}

	public function spawnParticleBatch(data:Array<LunarParticleBatchData>)
	{
		for (batchData in data)
		{
			var emitter = emitters.get(batchData.emitterName);
			if (emitter != null)
				emitter.spawnParticleBatch(batchData.shape, batchData.amount);
		}
	}

	public function addEmitter(name:String, emitter:LunarParticleEmitter)
		return emitters.set(name, emitter);

	public function getEmitter(name:String)
		return emitters.get(name);

	public function removeEmitter(name:String)
		return emitters.remove(name);

	public function setEmitterProperty(prop:String, val:Dynamic)
	{
		for (e in emitters)
			Reflect.setProperty(e, prop, val);
	}

	public function onFrame(dt:Float)
	{
		for (e in emitters)
			e.onFrame(dt);
	}

	public function kill()
	{
		for (emitter in emitters)
			emitter.kill();
		emitters = null;
	}
}
