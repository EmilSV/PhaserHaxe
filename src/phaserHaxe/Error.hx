package phaserHaxe;

#if js
abstract Error(js.lib.Error)
{
	public var message(get, never):String;

	private inline function get_message()
	{
		return this.message;
	}

	public function new(message:String)
	{
		this = new js.lib.Error(message);
	}
}
#else
final class Error
{
	public var message(default, null):String;

	public function new(message:String)
	{
		this.message = message;
	}
}
#end
