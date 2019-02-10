package phaserHaxe.math;

class MathUtility
{
	/**
	 * The value of PI.
	 *
	 * @since 1.0.0
	**/
	public static inline final PI = 3.141592653589793;

	/**
	 * The value of PI * 2.
	 *
	 * @since 1.0.0
	**/
	public static inline final PI2 = PI * 2;

	/**
	 * The value of PI * 0.5.
	 *
	 * @since 1.0.0
	**/
	public static inline final TAU = PI * 0.5;

	/**
	 * An epsilon value (1.0e-6)
	 *
	 * @since 1.0.0
	**/
	public static inline final EPSILON = 1.0e-6;

	/**
	 * For converting degrees to radians (PI / 180)
	 *
	 * @since 1.0.0
	**/
	public static inline final DEG_TO_RAD = PI / 180;

	/**
	 * For converting radians to degrees (180 / PI)
	 *
	 * @since 1.0.0
	**/
	public static inline final RAD_TO_DEG = 180 / PI;

	/**
	 * Wrap the given `value` between `min` and `max.
	 *
	 * @since 1.0.0
	 *
	 * @param value The value to wrap.
	 * @param min The minimum value.
	 * @param max The maximum value.
	 *
	 * @return The wrapped value.
	**/
	@:pure inline public static function Wrap(value:Float, min:Float, max:Float)
	{
		var range = max - min;
		return (min + ((((value - min) % range) + range) % range));
	}
}
