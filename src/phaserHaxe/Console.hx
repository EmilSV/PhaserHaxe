package phaserHaxe;

final class Console
{
	public static function group(data:Dynamic):Void
	{
		js.Browser.console.group(data);
	}

	public static function groupEnd():Void
	{
		js.Browser.console.groupEnd();
	}

	public static function log(data:Dynamic):Void
	{
		js.Browser.console.log(data);
	}

	public static function warn(data:Dynamic):Void
	{
		js.Browser.console.warn(data);
	}

	public static function error(data:Dynamic):Void
	{
		js.Browser.console.error(data);
	}
}
