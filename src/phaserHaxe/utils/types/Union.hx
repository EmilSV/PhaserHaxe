package phaserHaxe.utils.types;

abstract Union<TLeft, TRight>(Dynamic) from TLeft from TRight from Union<TRight, TLeft>
{
	private inline function new(value:Dynamic)
	{
		this = value;
	}
}
