package phaserHaxe.input.keyboard.web;

@:forward()
@:forwardStatics()
abstract WebKeyboardEvent(js.html.KeyboardEvent)
{
	public var cancelled(get, set):Null<Int>;

	public var stopImmediatePropagation(get, set):Null<() -> Void>;

	public var stopPropagation(get, set):Null<() -> Void>;

	private inline function set_cancelled(value:Null<Int>):Null<Int>
	{
		return (cast this).cancelled = value;
	}

	private inline function get_cancelled():Null<Int>
	{
		return (cast this).cancelled;
	}

	private inline function set_stopImmediatePropagation(value:Null<() ->
		Void>):Null<() -> Void>
	{
		return (cast this).stopImmediatePropagation = value;
	}

	private inline function get_stopImmediatePropagation():Null<() -> Void>
	{
		return (cast this).stopImmediatePropagation;
	}

	private inline function set_stopPropagation(value:Null<() -> Void>):Null<() -> Void>
	{
		return (cast this).stopPropagation = value;
	}

	private inline function get_stopPropagation():Null<() -> Void>
	{
		return (cast this).stopPropagation;
	}
}
