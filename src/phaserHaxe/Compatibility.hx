package phaserHaxe;

import phaserHaxe.math.MathConst;

final class Compatibility
{
	public static inline function toJSUintRange(number:Float):Float
	{
		#if js
		return js.Syntax.code("(({0}) >>> 0)", number);
		#else
		inline function sign(n:Float):Float
		{
			return n >= 0 ? 1 : -1;
		}

		number = sign(number) * Math.ffloor(Math.abs(number));
		number = number % MathConst.POW2_32;

		if (number < 0)
		{
			number = MathConst.POW2_32 + number;
		}

		return number;
		#end
	}

	public static inline function toJSIntRange(number:Float):Float
	{
		#if js
		return js.Syntax.code("(({0}) | 0)", number);
		#else
		inline function sign(n:Float)
		{
			return n >= 0 ? 1 : -1;
		}

		if (number >= MathConst.INT_MIN && number <= MathConst.INT_MAX)
		{
			return Std.int(number);
		}

		number = sign(number) * Math.ffloor(Math.abs(number));
		number = number % MathConst.POW2_32;

		if (number >= MathConst.POW2_31)
		{
			number = number - MathConst.POW2_32;
		}

		return number;
		#end
	}

	public static inline function toIntSafe(number:Float):Int
	{
		#if js
		return js.Syntax.code("(({0}) | 0)", number);
		#else
		inline function sign(n:Float)
		{
			return n >= 0 ? 1 : -1;
		}

		if (number >= MathConst.INT_MIN && number <= MathConst.INT_MAX)
		{
			return Std.int(number);
		}
		number = sign(number) * Math.ffloor(Math.abs(number));
		number = number % MathConst.POW2_32;

		if (number >= MathConst.POW2_31)
		{
			number = number - MathConst.POW2_32;
		}

		return Std.int(number);
		#end
	}

	#if js
	public static inline function forceIntValue(number:Int):Int
	{
		return js.Syntax.code("(({0}) | 0)", number);
	}
	#else
	public static inline function forceIntValue(number:Int):Int
	{
		return number;
	}
	#end
