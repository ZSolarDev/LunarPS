package lunarps;

import flixel.FlxBasic;
import haxe.PosInfos;

/**
 * A simple logger with colors.
 * to make the color codes in the link below work with haxe, replace \e with \033.
 * @see https://gist.github.com/JBlond/2fea43a3049b38287e5e9cefc87b2124?permalink_comment_id=4474033
 */
class LunarLogger
{
	public static function log(msg:Dynamic, ?_posInfos:PosInfos) // white
		return Sys.println('\033[0;37m LOG: (${_posInfos.className}) $msg\033[0;0m');

	public static function info(msg:Dynamic, ?_posInfos:PosInfos) // light gray
		return LGUtils.infoLogs ? Sys.println('\033[0;250m INFO: (${_posInfos.className}) $msg\033[0;0m') : null;

	public static function warning(msg:Dynamic, ?_posInfos:PosInfos) // yellow
		return LGUtils.warningLogs ? Sys.println('\033[0;33m WARNING: (${_posInfos.className}) $msg\033[0;0m') : null;

	public static function debug(msg:Dynamic, ?_posInfos:PosInfos) // cyan
		return #if debug Sys.println('\033[0;36m DEBUG: (${_posInfos.className}) $msg\033[0;0m') #else null #end;

	public static function error(msg:Dynamic, ?_posInfos:PosInfos) // red
		return LGUtils.errorLogs ? Sys.println('\033[0;31m ERROR: (${_posInfos.className}) $msg\033[0;0m') : null;

	public static function fatalError(msg:Dynamic, ?_posInfos:PosInfos) // bright red bg -> red/bold
		return Sys.println('\033[41m FATAL ERROR: \033[0;0m\033[1;91m (${_posInfos.className}) $msg\033[0;0m');
}

class LunarTimer
{
	public var timeLeft:Float = 0;
	public var loopsLeft:Int = 0;
	public var running:Bool = false;
	public var stopped:Bool = false;
	public var paused:Bool = false;
	public var timerCompleted:() -> Void = () -> {};
	public var loopCompleted:(loopID:Int) -> Void = (loopID) -> {};

	public function new()
		return;

	public function pauseTimer()
	{
		paused = true;
	}

	public function unpauseTimer()
	{
		paused = false;
	}

	public function stopTimer()
	{
		running = false;
		paused = false;
		stopped = true;
		timeLeft = 0;
	}

	public function startTimer(dt:Float, ?durationSecs:Float = 1, ?loopsLeft:Int = 0)
	{
		running = true;
		timeLeft = durationSecs;
		stopped = false;
		this.loopsLeft = loopsLeft;
	}

	public function updateTimer(dt:Float)
	{
		if (running && !paused && timeLeft > 0)
			timeLeft -= dt;
		if (timeLeft <= 0 && !stopped && running)
		{
			if (loopsLeft == 0)
			{
				stopTimer();
				timerCompleted();
			}
			else
			{
				loopsLeft--;
				loopCompleted(loopsLeft);
			}
		}
	}
}

class LGUtils
{
	public static var infoLogs:Bool = true;
	public static var warningLogs:Bool = true;
	public static var errorLogs:Bool = true;

	public static function init()
	{
		#if flixelMode
		flixel.FlxG.fixedTimestep = false;
		#end
	}
}
