package phaserHaxe;

abstract Either3<T1, T2, T3>(Dynamic) from T1 from T2 from T3 from Either<T1, T2> from Either<T1, T3> from Either<T2, T3>
{
	private inline function new(value:Dynamic)
	{
		this = value;
	}
}
