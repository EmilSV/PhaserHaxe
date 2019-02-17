package phaserHaxe.math;


final class Distance
{
	/**
	 * Calculate the distance between two sets of coordinates (points).
	 *
	 * @since 1.0.0
	 *
	 * @param x1 - The x coordinate of the first point.
	 * @param y1 - The y coordinate of the first point.
	 * @param x2 - The x coordinate of the second point.
	 * @param y2 - The y coordinate of the second point.
	 *
	 * @return The distance between each point.
	**/
	public static function DistanceBetween(x1:Float, y1:Float, x2:Float, y2:Float):Float
	{
		var dx = x1 - x2;
		var dy = y1 - y2;

		return Math.sqrt(dx * dx + dy * dy);
	}

	/**
	 * Calculate the distance between two sets of coordinates (points) to the power of `pow`.
	 *
	 * @since 1.0.0
	 *
	 * @param x1 - The x coordinate of the first point.
	 * @param y1 - The y coordinate of the first point.
	 * @param x2 - The x coordinate of the second point.
	 * @param y2 - The y coordinate of the second point.
	 * @param pow - The exponent.
	 *
	 * @return The distance between each point.
	**/
	public static function DistancePower(x1:Float, y1:Float, x2:Float, y2:Float, pow:Float = 2):Float
	{
		return Math.sqrt(Math.pow(x2 - x1, pow) + Math.pow(y2 - y1, pow));
	}

	/**
	 * Calculate the distance between two sets of coordinates (points), squared.
	 *
	 * @since 1.0.0
	 *
	 * @param x1 - The x coordinate of the first point.
	 * @param y1 - The y coordinate of the first point.
	 * @param x2 - The x coordinate of the second point.
	 * @param y2 - The y coordinate of the second point.
	 *
	 * @return The distance between each point, squared.
	**/
	public static function DistanceSquared(x1:Float, y1:Float, x2:Float, y2:Float)
	{
		var dx = x1 - x2;
		var dy = y1 - y2;
		return dx * dx + dy * dy;
	}
}
