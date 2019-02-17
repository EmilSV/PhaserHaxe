package phaserHaxe.math;

final class Fuzzy
{
	/**
	 * Calculate the fuzzy ceiling of the given value.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The value.
	 * @param epsilon - The epsilon.
	 *
	 * @return The fuzzy ceiling of the value.
	**/
	public static function Ceil(value:Float, epsilon:Float = 0.0001):Float
	{
		return Math.ceil(value - epsilon);
	}

	/**
	 * Check whether the given values are fuzzily equal.
	 *
	 * Two numbers are fuzzily equal if their difference is less than `epsilon`.
	 *
	 * @since 1.0.0
	 *
	 * @param a - The first value.
	 * @param b - The second value.
	 * @param epsilon - The epsilon.
	 *
	 * @return`true` if the values are fuzzily equal, otherwise `false`.
	**/
	public static function Equal(a:Float, b:Float, epsilon:Float = 0.0001):Bool
	{
		return Math.abs(a - b) < epsilon;
	}

	/**
	 * Calculate the fuzzy floor of the given value.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The value.
	 * @param epsilon - The epsilon.
	 *
	 * @return The floor of the value.
	**/
	public static function Floor(value:Float, epsilon:Float = 0.0001):Float
	{
		return Math.floor(value + epsilon);
	}

	/**
	 * Check whether `a` is fuzzily greater than `b`.
	 *
	 * `a` is fuzzily greater than `b` if it is more than `b - epsilon`.
	 *
	 * @since 1.0.0
	 *
	 * @param a - The first value.
	 * @param b - The second value.
	 * @param epsilon - The epsilon.
	 *
	 * @return `true` if `a` is fuzzily greater than than `b`, otherwise `false`.
	**/
	public static function GreaterThan(a:Float, b:Float, epsilon:Float = 0.0001):Bool
	{
		return a > b - epsilon;
	}

	/**
	 * Check whether `a` is fuzzily less than `b`.
	 *
	 * `a` is fuzzily less than `b` if it is less than `b + epsilon`.
	 *
	 * @since 1.0.0
	 *
	 * @param a - The first value.
	 * @param b - The second value.
	 * @param epsilon - The epsilon.
	 *
	 * @return `true` if `a` is fuzzily less than `b`, otherwise `false`.
	**/
	public function LessThan(a:Float, b:Float, epsilon:Float = 0.0001):Bool
	{
		return a < b + epsilon;
	}
}
