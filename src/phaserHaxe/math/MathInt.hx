package phaserHaxe.math;

final class MathInt
{
	public static inline function max(a:Int, b:Int):Int
	{
		return a > b ? a : b;
	}

	public static inline function min(a:Int, b:Int):Int
	{
		return a < b ? a : b;
	}

	public static inline function abs(value:Int):Int
	{
		return value < 0 ? -value : value;
	}
}
