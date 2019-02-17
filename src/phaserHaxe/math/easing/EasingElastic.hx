package phaserHaxe.math.easing;

final class EasingElastic
{
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
	public static function In(v:Float, amplitude:Float = 0.1, period:Float = 0.1):Float
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
			return -(amplitude * Math.pow(2, 10 * (v -= 1)) * Math
				.sin((v - s) * (2 * Math.PI) / period));
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
	public static function InOut(v:Float, amplitude:Float = 0.1, period:Float = 0.1):Float
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
				return -0.5 * (amplitude * Math.pow(2, 10 * (v -= 1)) * Math
					.sin((v - s) * (2 * Math.PI) / period));
			}
			else
			{
				return amplitude * Math.pow(2, -10 * (v -= 1)) * Math
					.sin((v - s) * (2 * Math.PI) / period) * 0.5 + 1;
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
	public static function Out(v:Float, amplitude:Float = 0.1, period:Float = 0.1):Float
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
			return (amplitude * Math.pow(2, -10 * v) * Math
				.sin((v - s) * (2 * Math.PI) / period) + 1);
		}
	}
}