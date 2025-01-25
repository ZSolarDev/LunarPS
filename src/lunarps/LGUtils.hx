package lunarps;

import flixel.FlxG;
import haxe.PosInfos;
import openfl.events.Event;

/**
 * A simple logger with colors.
 * to make the color codes in the link below work with haxe, replace \e with \033.
 * @see https://gist.github.com/JBlond/2fea43a3049b38287e5e9cefc87b2124?permalink_comment_id=4474033
 */
class LunarLogger
{
	public static function log(msg:Dynamic, ?_posInfos:PosInfos) // white
		return
			#if !html5
			Sys.println('\033[0;37m LOG: (${_posInfos.className}) $msg\033[0;0m');
			#else
			trace('\033[0;37m LOG: $msg\033[0;0m');
			#end

	public static function info(msg:Dynamic, ?_posInfos:PosInfos) // light gray
		return
			#if !html5
			LGUtils.infoLogs ? Sys.println('\033[0;250m INFO: (${_posInfos.className}) $msg\033[0;0m') : null;
			#else
			LGUtils.infoLogs ? trace('\033[0;250m INFO: $msg\033[0;0m') : null;
			#end

	public static function warning(msg:Dynamic, ?_posInfos:PosInfos) // yellow
		return
			#if !html5
			LGUtils.warningLogs ? Sys.println('\033[0;33m WARNING: (${_posInfos.className}) $msg\033[0;0m') : null;
			#else
			LGUtils.warningLogs ? trace('\033[0;33m WARNING: $msg\033[0;0m') : null;
			#end

	public static function debug(msg:Dynamic, ?_posInfos:PosInfos) // cyan
		#if debug
		return #if !html5
			Sys.println('\033[0;36m DEBUG: (${_posInfos.className}) $msg\033[0;0m');
		#else
			trace('\033[0;36m DEBUG: $msg\033[0;0m');
		#end
		#else
		return null;
		#end

	public static function error(msg:Dynamic, ?_posInfos:PosInfos) // red
		return
			#if !html5
			LGUtils.errorLogs ? Sys.println('\033[0;31m ERROR: (${_posInfos.className}) $msg\033[0;0m') : null;
			#else
			LGUtils.errorLogs ? trace('\033[0;31m ERROR: $msg\033[0;0m') : null;
			#end

	public static function fatalError(msg:Dynamic, ?_posInfos:PosInfos) // bright red bg -> red/bold
		return
			#if !html5
			Sys.println('\033[41m FATAL ERROR: \033[0;0m\033[1;91m (${_posInfos.className}) $msg\033[0;0m');
			#else
			trace('\033[41m FATAL ERROR: \033[0;0m\033[1;91m $msg\033[0;0m');
			#end
}

enum LunarTimerMode
{
	TIMER;
	STOPWATCH;
}

class LunarTimer
{
	var _mode:LunarTimerMode = TIMER;

	public var time:Float = 0;
	public var loopsLeft:Int = 0;
	public var running:Bool = false;
	public var stopped:Bool = false;
	public var paused:Bool = false;
	public var timerCompleted:() -> Void = () -> {};
	public var loopCompleted:(loopID:Int) -> Void = (loopID) -> {};

	public function new()
	{
		FlxG.stage.addEventListener(Event.ENTER_FRAME, onFrame);
	}

	public function pause()
	{
		paused = true;
	}

	public function unpause()
	{
		paused = false;
	}

	public function stop()
	{
		running = false;
		paused = false;
		stopped = true;
		time = 0;
	}

	public function startTimer(?durationSecs:Float = 1, ?loops:Int = 0)
	{
		_mode = TIMER;
		running = true;
		time = durationSecs;
		stopped = false;
		this.loopsLeft = loops;
	}

	public function startStopwatch()
	{
		_mode = STOPWATCH;
		running = true;
		time = 0;
		stopped = false;
		loopsLeft = 0;
	}

	public function onFrame(_)
	{
		var dt:Float = FlxG.elapsed;
		switch (_mode)
		{
			case TIMER:
				if (running && !paused && time > 0)
					time -= dt;
				if (time <= 0 && !stopped && running)
				{
					if (loopsLeft == 0)
					{
						stop();
						timerCompleted();
					}
					else
					{
						loopsLeft--;
						loopCompleted(loopsLeft);
					}
				}
			case STOPWATCH:
				if (running && !paused)
					time += dt;
		}
	}
}

class LGUtils
{
	public static var infoLogs:Bool = true;
	public static var warningLogs:Bool = true;
	public static var errorLogs:Bool = true;

	public static function copyClass<T>(c:T):T
	{
		var cls:Class<T> = Type.getClass(c);
		var inst:T = Type.createEmptyInstance(cls);
		var fields = Type.getInstanceFields(cls);
		for (field in fields)
		{
			var val:Dynamic = Reflect.field(c, field);
			if (!Reflect.isFunction(val))
			{
				Reflect.setField(inst, field, val);
			}
		}
		return inst;
	}
}
