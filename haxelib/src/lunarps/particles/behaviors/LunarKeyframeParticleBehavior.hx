package lunarps.particles.behaviors;

import lunarps.LGUtils.LunarTimer;

typedef LunarKeyframe = (keyframe:Int, timeInSecs:Float, particle:LunarParticle, dt:Float) -> Void;

class LunarKeyframeParticleBehavior extends LunarParticleBehavior
{
	public var keyframes:Map<Int, LunarKeyframe> = new Map();

	function toMS(v:Float):Int
		return cast v * 1000;

	public function new()
	{
		super();
	}

	override public function onParticleSpawn(particle:LunarParticle, emitter:LunarParticleEmitter)
	{
		if (particle.values.keyframeStopwatch == null)
			particle.values.keyframeStopwatch = new LunarTimer();

		if (particle.values.keyframesRan == null)
			particle.values.keyframesRan = new Array<Dynamic>();

		particle.values.keyframeStopwatch.startStopwatch();
	}

	override public function onParticleFrame(particle:LunarParticle, emitter:LunarParticleEmitter, dt:Float)
	{
		var time:Float = particle.values.keyframeStopwatch.time;
		var idx:Int = 0;
		for (keyframe in keyframes.keys())
		{
			if (keyframe <= toMS(time))
			{
				if (particle.values.keyframesRan[keyframe] == null)
				{
					particle.values.keyframesRan[keyframe] = 0;
					keyframes.get(keyframe)(idx, time, particle, dt);
				}
			}
			idx++;
		}
	}

	public function addKeyframe(timeInSecs:Float, keyframe:LunarKeyframe)
		return keyframes.set(toMS(timeInSecs), keyframe);

	public function getKeyframe(timeInSecs:Float):LunarKeyframe
		return keyframes.get(toMS(timeInSecs));

	public function removeKeyframe(timeInSecs:Float):Bool
		return keyframes.remove(toMS(timeInSecs));

	public function clearKeyframes(timeInSecs:Float)
		return keyframes.clear();
}
