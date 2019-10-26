package phaserHaxe.utils.types;

abstract StringOrInt(Dynamic) from Int from String
{
	public inline function isInt():Bool
	{
		return Std.is(this, Int);
	}

	public inline function isString():Bool
	{
		return Std.is(this, String);
	}

	public inline function getString():String
	{
		return (cast this : String);
	}

	public inline function getInt():Int
	{
		return (cast this : Int);
	}

	public inline function forceString():String
	{
		return isString() ? getString() : Std.string(getInt());
	}
}
