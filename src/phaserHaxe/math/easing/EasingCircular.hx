package phaserHaxe.math.easing;

final class EasingCircular
{
	/**
	 * Circular ease-out.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public static function Out(v:Float):Float
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
	public static function InOut(v:Float):Float
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
	public static function In(v:Float):Float
	{
		return 1 - Math.sqrt(1 - v * v);
	}
}
