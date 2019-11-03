package phaserHaxe.math.easing;

final class EasingLinear
{
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
}
