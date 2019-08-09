package phaserHaxe;

abstract Either<TLeft, TRight>(Dynamic) from TLeft from TRight
{
	private inline function new(value:Dynamic)
	{
		this = value;
	}
}
