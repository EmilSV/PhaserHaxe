package phaserHaxe;

#if !js
import phaserHaxe.math.MathConst;
#end

#if js
final class Compatibility
{
	public static inline function toJSUIntRange(number:Float):Float
	{
		return js.Syntax.code("(({0}) >>> 0)", number);
	}

	public static inline function toJSIntRange(number:Float):Float
	{
		return js.Syntax.code("(({0}) | 0)", number);
	}

	public static inline function toIntSafe(number:Float):Int
	{
		return js.Syntax.code("(({0}) | 0)", number);
	}

	public static inline function forceIntValue(number:Int):Int
	{
		return js.Syntax.code("(({0}) | 0)", number);
	}
}
#else
final class Compatibility
{
	public static function toJSUIntRange(number:Float):Float
	{
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
	}

	public static function toJSIntRange(number:Float):Float
	{
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
	}

	public static function toIntSafe(number:Float):Int
	{
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
	}

	public static inline function forceIntValue(number:Int):Int
	{
		return number;
	}
}
#end
