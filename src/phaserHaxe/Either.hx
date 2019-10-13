package phaserHaxe;

abstract Either<TLeft, TRight>(Dynamic) from TLeft from TRight from Either<TRight, TLeft>
{
	private inline function new(value:Dynamic)
	{
		this = value;
	}
}
