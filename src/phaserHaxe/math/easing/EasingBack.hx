package phaserHaxe.math.easing;

final class EasingBack
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
	public static function In(v:Float, overshoot:Float = 1.70158):Float
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
	public static function InOut(v:Float, overshoot:Float = 1.70158):Float
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
	public static function Out(v:Float, overshoot:Float = 1.70158):Float
	{
		return --v * v * ((overshoot + 1) * v + overshoot) + 1;
	}
}
