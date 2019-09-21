package phaserHaxe;

final class Console
{
	public static function warn(data:Dynamic):Void
	{
		js.Browser.console.warn(data);
	}

	public static function error(data:Dynamic):Void
	{
		js.Browser.console.error(data);
	}
}
