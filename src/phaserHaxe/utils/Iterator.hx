package phaserHaxe.utils;

final class Iterator
{
	public static inline function reverse(start:Int, end:Int):ReverseIterator
	{
		return new ReverseIterator(start, end);
	}

	public static inline function inclusive(start:Int, end:Int):InclusiveIterator
	{
		return new InclusiveIterator(start, end);
	}
}
