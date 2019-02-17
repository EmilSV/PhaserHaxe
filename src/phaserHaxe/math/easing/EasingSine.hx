package phaserHaxe.math.easing;

final class EasingSine
{
	/**
	 * Sinusoidal ease-in.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public static function In(v:Float):Float
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
	public static function InOut(v:Float):Float
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
	public static function Out(v:Float):Float
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
}
