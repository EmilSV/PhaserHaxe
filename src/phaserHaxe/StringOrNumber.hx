package phaserHaxe;

@:structInit
class StringOrNumberPatten
{
	public final dynamic function string(s:String):Void {};

	public final dynamic function number(n:Float):Void {};

	public inline function new(string:(s:String) -> Void, number:(n:Float) -> Void)
	{
		this.string = string;
		this.number = number;
	}
}

abstract StringOrNumber(Dynamic)
{
	private inline function new(value:Dynamic)
	{
		this = value;
	}

	@:from
	public static inline function fromString(s:String)
	{
		return new StringOrNumber(s);
	}

	@:from
	public static inline function fromNumber(f:Float)
	{
		return new StringOrNumber(f);
	}

	// public inline function match(patten:StringOrNumberPatten)
	{
		if (Std.is(this, String))
		{
			patten.string(this);
		}
		else
		{
			patten.number(this);
		}
	}
}
