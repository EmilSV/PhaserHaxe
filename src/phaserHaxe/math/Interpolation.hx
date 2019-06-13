package phaserHaxe.math;

import haxe.ds.ReadOnlyArray;
import phaserHaxe.math.MathUtility.*;

final class Interpolation
{
	/**
	 * A Smooth Step interpolation method.
	 *
	 * @since 1.0.0
	 * @see https://en.wikipedia.org/wiki/Smoothstep
	 *
	 * @param t - The percentage of interpolation, between 0 and 1.
	 * @param min - The minimum value, also known as the 'left edge', assumed smaller than the 'right edge'.
	 * @param max - The maximum value, also known as the 'right edge', assumed greater than the 'left edge'.
	 *
	 * @return The interpolated value.
	**/
	public static function smoothStepInterpolation(t:Float, min:Float, max:Float):Float
	{
		return min + (max - min) * smoothStep(t, 0, 1);
	}

	/**
	 * A Smoother Step interpolation method.
	 *
	 * @since 1.0.0
	 * @see https://en.wikipedia.org/wiki/Smoothstep#Variations
	 *
	 * @param t - The percentage of interpolation, between 0 and 1.
	 * @param min - The minimum value, also known as the 'left edge', assumed smaller than the 'right edge'.
	 * @param max - The maximum value, also known as the 'right edge', assumed greater than the 'left edge'.
	 *
	 * @return The interpolated value.
	**/
	public static function smootherStepInterpolation(t:Float, min:Float, max:Float):Float
	{
		return min + (max - min) * smootherStep(t, 0, 1);
	}

	/**
	 * A linear interpolation method.
	 *
	 * @since 1.0.0
	 * @see https://en.wikipedia.org/wiki/linear_interpolation
	 *
	 * @param v - The input array of values to interpolate between.
	 * @param k - The percentage of interpolation, between 0 and 1.
	 *
	 * @return The interpolated value.
	**/
	public static function linearInterpolation(v:ReadOnlyArray<Float>, k:Float):Float
	{
		var m = v.length - 1;
		var f = m * k;
		var i = Math.floor(f);
		if (k < 0)
		{
			return linear(v[0], v[1], f);
		}
		else if (k > 1)
		{
			return linear(v[m], v[m - 1], m - f);
		}
		else
		{
			return linear(v[i], v[(i + 1 > m) ? m : i + 1], f - i);
		}
	}

	/**
	 * A cubic bezier interpolation method.
	 *
	 * https://medium.com/@adrian_cooney/bezier-interpolation-13b68563313a
	 *
	 * @since 1.0.0
	 *
	 * @param t - The percentage of interpolation, between 0 and 1.
	 * @param p0 - The start point.
	 * @param p1 - The first control point.
	 * @param p2 - The second control point.
	 * @param p3 - The end point.
	 *
	 * @return The interpolated value.
	**/
	public function cubicBezierInterpolation(t:Float, p0:Float, p1:Float, p2:Float,
			p3:Float):Float
	{
		inline function p0f(t:Float, p:Float)
		{
			var k = 1 - t;

			return k * k * k * p;
		}

		inline function p1f(t:Float, p:Float)
		{
			var k = 1 - t;

			return 3 * k * k * t * p;
		}

		inline function p2f(t:Float, p:Float)
		{
			return 3 * (1 - t) * t * t * p;
		}

		inline function p3f(t:Float, p:Float)
		{
			return t * t * t * p;
		}

		return p0f(t, p0) + p1f(t, p1) + p2f(t, p2) + p3f(t, p3);
	}

	/**
	 * A Catmull-Rom interpolation method.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The input array of values to interpolate between.
	 * @param k - The percentage of interpolation, between 0 and 1.
	 *
	 * @return The interpolated value.
	**/
	public static function CatmullRomInterpolation(v:ReadOnlyArray<Float>, k:Float):Float
	{
		var m = v.length - 1;
		var f = m * k;
		var i = Math.floor(f);
		if (v[0] == v[m])
		{
			if (k < 0)
			{
				i = Math.floor(f = m * (1 + k));
			}
			return catmullRom(f - i, v[(i - 1 + m) % m], v[i], v[(i + 1) % m], v[(i +
				2) % m]);
		}
		else
		{
			if (k < 0)
			{
				return v[0] - (catmullRom(-f, v[0], v[0], v[1], v[1]) - v[0]);
			}
			if (k > 1)
			{
				return v[m] - (catmullRom(f - m, v[m], v[m], v[m - 1], v[m - 1]) - v[m]);
			}
			return
				catmullRom(f - i, v[i != 0 ? i - 1 : 0], v[i], v[m < i + 1 ? m : i + 1], v[m < i + 2 ? m : i + 2]);
		}
	}

	/**
	 * A bezier interpolation method.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The input array of values to interpolate between.
	 * @param k - The percentage of interpolation, between 0 and 1.
	 *
	 * @return The interpolated value.
	**/
	public static function bezierInterpolation(v:ReadOnlyArray<Float>, k:Float):Float
	{
		var b:Float = 0.0;
		var n:Int = v.length - 1;
		for (i in 0...n)
		{
			b += Math.pow(1 - k, n - i) * Math.pow(k, i) * v[i] * bernstein(n, i);
		}
		return b;
	}

	/**
	 * A quadratic bezier interpolation method.
	 *
	 * @since 1.0.0
	 *
	 * @param t - The percentage of interpolation, between 0 and 1.
	 * @param p0 - The start point.
	 * @param p1 - The control point.
	 * @param p2 - The end point.
	 *
	 * @return The interpolated value.
	**/
	public static function quadraticBezierInterpolation(t:Float, p0:Float, p1:Float,
			p2:Float):Float
	{
		inline function p0f(t:Float, p:Float):Float
		{
			var k = 1 - t;

			return k * k * p;
		}

		inline function p1f(t:Float, p:Float):Float
		{
			return 2 * (1 - t) * t * p;
		}

		inline function p2f(t:Float, p:Float):Float
		{
			return t * t * p;
		}

		return p0f(t, p0) + p1f(t, p1) + p2f(t, p2);
	}
}
