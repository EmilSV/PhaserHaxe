package phaserHaxe;

typedef StringOrNumberPatten =
{
	var t_string:(s:String) -> Void;
	var t_number:(n:Float) -> Void;
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

	public inline function match<T:StringOrNumberPatten>(patten:T)
	{
		if (Std.is(this, String))
		{
			patten.t_string(this);
		}
		else
		{
			patten.t_number(this);
		}
	}
}
