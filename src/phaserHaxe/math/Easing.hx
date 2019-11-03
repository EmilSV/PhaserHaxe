package phaserHaxe.math;

import phaserHaxe.math.easing.*;

final class Easing
{
	/**
	 * Back ease-in.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 * @param overshoot - The overshoot amount.
	 *
	 * @return The tweened value.
	**/
	public static function backIn(v:Float, overshoot:Float = 1.70158):Float
	{
		return v * v * ((overshoot + 1) * v - overshoot);
	}

	/**
	 * Back ease-in/out.
	 *
	 * @since 1.0.0
	 *
	 * @param number v - The value to be tweened.
	 * @param number overshoot - The overshoot amount.
	 *
	 * @return number The tweened value.
	**/
	public static function backInOut(v:Float, overshoot:Float = 1.70158):Float
	{
		var s = overshoot * 1.525;
		if ((v *= 2) < 1)
		{
			return 0.5 * (v * v * ((s + 1) * v - s));
		}
		else
		{
			return 0.5 * ((v -= 2) * v * ((s + 1) * v + s) + 2);
		}
	}

	/**
	 * Back ease-out.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 * @param overshoot - The overshoot amount.
	 *
	 * @return The tweened value.
	**/
	public static function backOut(v:Float, overshoot:Float = 1.70158):Float
	{
		return --v * v * ((overshoot + 1) * v + overshoot) + 1;
	}

	/**
	 * Bounce ease-in.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public static function bounceIn(v:Float):Float
	{
		v = 1 - v;
		if (v < 1 / 2.75)
		{
			return 1 - (7.5625 * v * v);
		}
		else if (v < 2 / 2.75)
		{
			return 1 - (7.5625 * (v -= 1.5 / 2.75) * v + 0.75);
		}
		else if (v < 2.5 / 2.75)
		{
			return 1 - (7.5625 * (v -= 2.25 / 2.75) * v + 0.9375);
		}
		else
		{
			return 1 - (7.5625 * (v -= 2.625 / 2.75) * v + 0.984375);
		}
	}

	/**
	 * Bounce ease-in/out.
	 *
	 * @since 1.0.0
	 *
	 * @param  v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public static function bounceInOut(v:Float):Float
	{
		var reverse = false;
		if (v < 0.5)
		{
			v = 1 - (v * 2);
			reverse = true;
		}
		else
		{
			v = (v * 2) - 1;
		}
		if (v < 1 / 2.75)
		{
			v = 7.5625 * v * v;
		}
		else if (v < 2 / 2.75)
		{
			v = 7.5625 * (v -= 1.5 / 2.75) * v + 0.75;
		}
		else if (v < 2.5 / 2.75)
		{
			v = 7.5625 * (v -= 2.25 / 2.75) * v + 0.9375;
		}
		else
		{
			v = 7.5625 * (v -= 2.625 / 2.75) * v + 0.984375;
		}
		if (reverse)
		{
			return (1 - v) * 0.5;
		}
		else
		{
			return v * 0.5 + 0.5;
		}
	}

	/**
	 * Bounce ease-out.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public static function bounceOut(v:Float):Float
	{
		if (v < 1 / 2.75)
		{
			return 7.5625 * v * v;
		}
		else if (v < 2 / 2.75)
		{
			return 7.5625 * (v -= 1.5 / 2.75) * v + 0.75;
		}
		else if (v < 2.5 / 2.75)
		{
			return 7.5625 * (v -= 2.25 / 2.75) * v + 0.9375;
		}
		else
		{
			return 7.5625 * (v -= 2.625 / 2.75) * v + 0.984375;
		}
	}

	/**
	 * Circular ease-out.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public static function circularOut(v:Float):Float
	{
		return Math.sqrt(1 - (--v * v));
	}

	/**
	 * Circular ease-in/out.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public static function circularInOut(v:Float):Float
	{
		if ((v *= 2) < 1)
		{
			return -0.5 * (Math.sqrt(1 - v * v) - 1);
		}
		else
		{
			return 0.5 * (Math.sqrt(1 - (v -= 2) * v) + 1);
		}
	}

	/**
	 * Circular ease-in.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public static function circularIn(v:Float):Float
	{
		return 1 - Math.sqrt(1 - v * v);
	}

	/**
	 * Cubic ease-in.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public static function cubicIn(v:Float):Float
	{
		return v * v * v;
	}

	/**
	 * Cubic ease-in/out.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public static function cubicInOut(v:Float):Float
	{
		if ((v *= 2) < 1)
		{
			return 0.5 * v * v * v;
		}
		else
		{
			return 0.5 * ((v -= 2) * v * v + 2);
		}
	}

	/**
	 * Cubic ease-out.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public static function cubicOut(v:Float):Float
	{
		return --v * v * v + 1;
	}

	/**
	 * Elastic ease-in.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 * @param amplitude - The amplitude of the elastic ease.
	 * @param period - Sets how tight the sine-wave is, where smaller values are tighter waves, which result in more cycles.
	 *
	 * @return The tweened value.
	**/
	public static function elasticIn(v:Float, amplitude:Float = 0.1,
			period:Float = 0.1):Float
	{
		if (v == 0)
		{
			return 0;
		}
		else if (v == 1)
		{
			return 1;
		}
		else
		{
			var s = period / 4;
			if (amplitude < 1)
			{
				amplitude = 1;
			}
			else
			{
				s = period * Math.asin(1 / amplitude) / (2 * Math.PI);
			}
			return
				-(amplitude * Math.pow(2, 10 * (v -= 1)) * Math.sin((v - s) * (2 * Math.PI) / period));
		}
	}

	/**
	 * Elastic ease-in/out.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 * @param amplitude - The amplitude of the elastic ease.
	 * @param period - Sets how tight the sine-wave is, where smaller values are tighter waves, which result in more cycles.
	 *
	 * @return The tweened value.
	**/
	public static function elasticInOut(v:Float, amplitude:Float = 0.1,
			period:Float = 0.1):Float
	{
		if (v == 0)
		{
			return 0;
		}
		else if (v == 1)
		{
			return 1;
		}
		else
		{
			var s = period / 4;
			if (amplitude < 1)
			{
				amplitude = 1;
			}
			else
			{
				s = period * Math.asin(1 / amplitude) / (2 * Math.PI);
			}
			if ((v *= 2) < 1)
			{
				return
					-0.5 * (amplitude * Math.pow(2, 10 * (v -= 1)) * Math.sin((v - s) * (2 * Math.PI) / period));
			}
			else
			{
				return
					amplitude * Math.pow(2, -10 * (v -= 1)) * Math.sin((v - s) * (2 * Math.PI) / period) * 0.5 +
					1;
			}
		}
	}

	/**
	 * Elastic ease-out.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 * @param amplitude - The amplitude of the elastic ease.
	 * @param period - Sets how tight the sine-wave is, where smaller values are tighter waves, which result in more cycles.
	 *
	 * @return The tweened value.
	**/
	public static function elasticOut(v:Float, amplitude:Float = 0.1,
			period:Float = 0.1):Float
	{
		if (v == 0)
		{
			return 0;
		}
		else if (v == 1)
		{
			return 1;
		}
		else
		{
			var s = period / 4;
			if (amplitude < 1)
			{
				amplitude = 1;
			}
			else
			{
				s = period * Math.asin(1 / amplitude) / (2 * Math.PI);
			}
			return
				(amplitude * Math.pow(2, -10 * v) * Math.sin((v - s) * (2 * Math.PI) / period) +
					1);
		}
	}

	/**
	 * Exponential ease-in.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public static function expoIn(v:Float):Float
	{
		return Math.pow(2, 10 * (v - 1)) - 0.001;
	}

	/**
	 * Exponential ease-in/out.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public static function expoInOut(v:Float):Float
	{
		if ((v *= 2) < 1)
		{
			return 0.5 * Math.pow(2, 10 * (v - 1));
		}
		else
		{
			return 0.5 * (2 - Math.pow(2, -10 * (v - 1)));
		}
	}

	/**
	 * Exponential ease-out.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public static function expoOut(v:Float):Float
	{
		return 1 - Math.pow(2, -10 * v);
	}

	/**
	 * Linear easing (no variation).
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public static function linear(v:Float):Float
	{
		return v;
	}

	/**
	 * Quadratic ease-in.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public static function quadraticIn(v:Float):Float
	{
		return v * v;
	}

	/**
	 * Quadratic ease-in/out.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public static function quadraticInOut(v:Float):Float
	{
		if ((v *= 2) < 1)
		{
			return 0.5 * v * v;
		}
		else
		{
			return -0.5 * (--v * (v - 2) - 1);
		}
	}

	/**
	 * Quadratic ease-out.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public static function quadraticOut(v:Float):Float
	{
		return v * (2 - v);
	}

	/**
	 * Quintic ease-in.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public static function quinticIn(v:Float):Float
	{
		return v * v * v * v * v;
	}

	/**
	 * Quintic ease-in.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public static function quinticInOut(v:Float):Float
	{
		if ((v *= 2) < 1)
		{
			return 0.5 * v * v * v * v;
		}
		else
		{
			return -0.5 * ((v -= 2) * v * v * v - 2);
		}
	}

	/**
	 * Quintic ease-in.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public static function quinticOut(v:Float):Float
	{
		return 1 - (--v * v * v * v);
	}

	/**
	 * Quartic ease-in.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public static function quarticIn(v:Float):Float
	{
		return v * v * v * v;
	}

	/**
	 * Quintic ease-in/out.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public static function quarticInOut(v:Float):Float
	{
		if ((v *= 2) < 1)
		{
			return 0.5 * v * v * v * v * v;
		}
		else
		{
			return 0.5 * ((v -= 2) * v * v * v * v + 2);
		}
	}

	/**
	 * Quintic ease-out.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public static function quarticOut(v:Float):Float
	{
		return 1 - (--v * v * v * v);
	}

	/**
	 * Sinusoidal ease-in.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public static function sineIn(v:Float):Float
	{
		if (v == 0)
		{
			return 0;
		}
		else if (v == 1)
		{
			return 1;
		}
		else
		{
			return 1 - Math.cos(v * Math.PI / 2);
		}
	}

	/**
	 * Sinusoidal ease-in/out.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public static function sineInOut(v:Float):Float
	{
		if (v == 0)
		{
			return 0;
		}
		else if (v == 1)
		{
			return 1;
		}
		else
		{
			return 0.5 * (1 - Math.cos(Math.PI * v));
		}
	}

	/**
	 * Sinusoidal ease-out.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public static function sineOut(v:Float):Float
	{
		if (v == 0)
		{
			return 0;
		}
		else if (v == 1)
		{
			return 1;
		}
		else
		{
			return Math.sin(v * Math.PI / 2);
		}
	}

	/**
	 * Stepped easing.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 * @param steps - The number of steps in the ease.
	 *
	 * @return The tweened value.
	**/
	public static function stepped(v:Float, steps:Float = 1):Float
	{
		if (v <= 0)
		{
			return 0;
		}
		else if (v >= 1)
		{
			return 1;
		}
		else
		{
			return (Compatibility.toJSIntRange(steps * v) + 1) * (1 / steps);
		}
	}
}
