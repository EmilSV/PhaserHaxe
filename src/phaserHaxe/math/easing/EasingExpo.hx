package phaserHaxe.math.easing;

final class EasingExpo
{
	/**
	 * Exponential ease-in.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public static function In(v:Float):Float
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
	public static function InOut(v:Float):Float
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
	public static function Out(v:Float):Float
	{
		return 1 - Math.pow(2, -10 * v);
	}
}
