package phaserHaxe.geom;

import phaserHaxe.math.Vector2;

@:forward(x, y)
abstract Point(Vector2) from Vector2 to Vector2
{
	public function new(x:Float = 0, ?y:Float)
	{
		this = new Vector2(x, y);
	}

	/**
	 * Set the x and y coordinates of the point to the given values.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The x coordinate of this Point.
	 * @param y - The y coordinate of this Point.
	 *
	 * @return This Point object.
	**/
	public inline function setTo(x:Float = 0, ?y:Float):Point
	{
		return this.set(x, y);
	}
}
