package phaserHaxe.math;

#if js
import js.Syntax as JsSyntax;
#end

final class MathInt
{
	#if js
	public static inline function max(a:Int, b:Int):Int
	{
		return JsSyntax.code("Math.max({0},{1})", a, b);
	}

	public static inline function min(a:Int, b:Int):Int
	{
		return JsSyntax.code("Math.min({0},{1})", a, b);
	}

	public static inline function abs(value:Int):Int
	{
		return JsSyntax.code("Math.abs({0})", value);
	}
	#else
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
	#end
}
