package phaserHaxe.utils.types;

abstract MultipleOrOne<T>(Dynamic) from Array<T> from T from Union<T, Array<T>>
	from Union<Array<T>, T> to Union<T, Array<T>> to Union<Array<T>, T>
{
	public inline function isArray():Bool
	{
		return Std.is(this, Array);
	}

	public inline function isOne():Bool
	{
		return !Std.is(this, Array);
	}

	public inline function getArray():Array<T>
	{
		return (cast this : Array<T>);
	}

	public inline function getOne():T
	{
		return (cast this : T);
	}
}
