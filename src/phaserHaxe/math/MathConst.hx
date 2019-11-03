package phaserHaxe.math;

final class MathConst
{
	/**
	 * The value of PI.
	 *
	 * @since 1.0.0
	**/
	public static inline var PI = 3.141592653589793;

	/**
	 * The value of PI * 2.
	 *
	 * @since 1.0.0
	**/
	public static inline var PI2 = PI * 2;

	/**
	 * The value of PI * 0.5.
	 *
	 * @since 1.0.0
	**/
	public static inline var TAU = PI * 0.5;

	/**
	 * An epsilon value (1.0e-6)
	 *
	 * @since 1.0.0
	**/
	public static inline var EPSILON = 1.0e-6;

	/**
	 * For Compatibilitying degrees to radians (PI / 180)
	 *
	 * @since 1.0.0
	**/
	public static inline var DEG_TO_RAD = PI / 180;

	/**
	 * For Compatibilitying radians to degrees (180 / PI)
	 *
	 * @since 1.0.0
	**/
	public static inline var RAD_TO_DEG = 180 / PI;

	/**
	 * 2 to the 32 power
	 *
	 * @since 1.0.0
	**/
	public static inline var POW2_32:Float = 4294967296;

	/**
	 * 2 to the 31 power
	 *
	 * @since 1.0.0
	**/
	public static inline var POW2_31:Float = 2147483648;

	/**
	 * 2 to the -32 power
	 *
	 * @since 1.0.0
	**/
	public static inline var POW2_NEGATIVE32:Float = 2.3283064365386963e-10;

	/**
	 * the lowest safe integer value
	 *
	 * @since 1.0.0
	**/
	public static inline var INT_MIN:Int = -2147483648;

	/**
	 * The closest number to zero that can be represented.
	 *
	 * @since 1.0.0
	**/
	public static inline var CLOSEST_TO_ZERO = 5e-324;

	/**
	 * the larges safe integer value
	 *
	 * @since 1.0.0
	**/
	public static inline var INT_MAX:Int = 2147483647;

	/**
	 * maximum numeric value for Number in javascript
	 *
	 * @since 1.0.0
	**/
	public static inline var FLOAT_MAX:Float = 1.7976931348623157e+308;

	/**
	 * constant represents the minimum safe integer in JavaScript
	 *
	 * @since 1.0.0
	**/
	public static inline var FLOAT_MIN_SAFE_INTEGER:Float = -900719925474099;
}
