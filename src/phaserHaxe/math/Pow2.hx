package phaserHaxe.math;

final class Pow2
{
	/**
	 * Returns the nearest power of 2 to the given `value`.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The value.
	 *
	 * @return The nearest power of 2 to `value`.
	**/
	public static function getPowerOfTwo(value:Int):Int
	{
		var index = Math.log(value) / 0.6931471805599453;
		return (1 << Math.ceil(index));
	}

	/**
	 * Checks if the given `width` and `height` are a power of two.
	 * Useful for checking texture dimensions.
	 *
	 * @since 1.0.0
	 *
	 * @param width - The width.
	 * @param height - The height.
	 *
	 * @return`true` if `width` and `height` are a power of two, otherwise `false`.
	**/
	public static function isSizePowerOfTwo(width:Int, height:Int):Bool
	{
		return (width > 0 && (width & (width - 1)) == 0 && height > 0 && (height & (height - 1)) == 0);
	}

	/**
	 * Tests the value and returns `true` if it is a power of two.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The value to check if it's a power of two.
	 *
	 * @return Returns `true` if `value` is a power of two, otherwise `false`.
	**/
	public static function isValuePowerOfTwo(value:Int):Bool
	{
		return (value > 0 && (value & (value - 1)) == 0);
	}
}
