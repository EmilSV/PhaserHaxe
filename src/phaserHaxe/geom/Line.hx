package phaserHaxe.geom;

import phaserHaxe.math.Vector2Like;
import phaserHaxe.math.Vector2;

final class Line
{
	/**
	 * The x coordinate of the lines starting point.
	 *
	 * @since 1.0.0
	**/
	public var x1:Float;

	/**
	 * The y coordinate of the lines starting point.
	 *
	 * @since 1.0.0
	**/
	public var y1:Float;

	/**
	 * The x coordinate of the lines ending point.
	 *
	 * @since 1.0.0
	**/
	public var x2:Float;

	/**
	 * The y coordinate of the lines ending point.
	 *
	 * @since 1.0.0
	**/
	public var y2:Float;

	/**
	 * The left position of the Line.
	 *
	 * @since 1.0.0
	**/
	public var left(get, set):Float;

	/**
	 * The right position of the Line.
	 *
	 * @since 1.0.0
	**/
	public var right(get, set):Float;

	/**
	 * The top position of the Line.
	 *
	 * @since 1.0.0
	**/
	public var top(get, set):Float;

	/**
	 * The bottom position of the Line.
	 *
	 * @since 1.0.0
	**/
	public var bottom(get, set):Float;

	public function new(x1:Float = 0, y1:Float = 0, x2:Float = 0, y2:Float = 0)
	{
		this.x1 = x1;
		this.y1 = y1;
		this.x2 = x2;
		this.y2 = y2;
	}

	// #region GetterSetter
	private function get_left():Float
	{
		return Math.min(this.x1, this.x2);
	}

	private function set_left(value:Float):Float
	{
		if (this.x1 <= this.x2)
		{
			this.x1 = value;
		}
		else
		{
			this.x2 = value;
		}
		return value;
	}

	private function get_right():Float
	{
		return Math.max(this.x1, this.x2);
	}

	private function set_right(value:Float):Float
	{
		if (this.x1 > this.x2)
		{
			this.x1 = value;
		}
		else
		{
			this.x2 = value;
		}
		return value;
	}

	private function get_top():Float
	{
		return Math.min(this.y1, this.y2);
	}

	private function set_top(value:Float):Float
	{
		if (this.y1 <= this.y2)
		{
			this.y1 = value;
		}
		else
		{
			this.y2 = value;
		}
		return value;
	}

	private function get_bottom():Float
	{
		return Math.max(this.y1, this.y2);
	}

	private function set_bottom(value:Float):Float
	{
		if (this.y1 > this.y2)
		{
			this.y1 = value;
		}
		else
		{
			this.y2 = value;
		}
		return value;
	}

	// endregion

	/**
	 * Get a point on a line that's a given percentage along its length.
	 *
	 * @since 1.0.0
	 *
	 * @param position - A value between 0 and 1, where 0 is the start, 0.5 is the middle and 1 is the end of the line.
	 * @param output - An optional point to store the coordinates of the point on the line.
	 *
	 * @return A Point containing the coordinates of the point on the line.
	**/
	public function getPoint(position:Float, ?output:Point)
	{
		return LineUtil.GetPoint(this, position, output);
	}

	/**
	 * Get a point on a line that's a given percentage along its length.
	 *
	 * @since 1.0.0
	 *
	 * @param position - A value between 0 and 1, where 0 is the start, 0.5 is the middle and 1 is the end of the line.
	 * @param output - An point-like object to store the coordinates of the point on the line.
	 *
	 * @return A point-like object containing the coordinates of the point on the line.
	**/
	public function getPointAny<T:Vector2Like>(position:Float, ?output:T):T
	{
		return LineUtil.GetPointAny(this, position, output);
	}

	/**
	 * Get a number of points along a line's length.
	 *
	 * Provide a `quantity` to get an exact number of points along the line.
	 *
	 * Provide a `stepRate` to ensure a specific distance between each point on the line. Set `quantity` to `0` when
	 * providing a `stepRate`.
	 *
	 * @since 1.0.0
	 *
	 * @param quantity - The number of points to place on the line. Set to `0` to use `stepRate` instead.
	 * @param stepRate - The distance between each point on the line. When set, `quantity` is implied and should be set to `0`.
	 * @param output - An optional array of Points, to store the coordinates of the points on the line.
	 *
	 * @return An array of Points, containing the coordinates of the points on the line.
	**/
	public function getPoints(quantity:Int, stepRate:Float, ?output:Array<Point>)
	{
		return LineUtil.GetPoints(this, quantity, stepRate, output);
	}

	/**t
	 * Get a random Point on the Line.
	 *
	 * @since 1.0.0
	 *
	 * @param point - An instance of a Point to be modified.
	 *
	 * @return A random Point on the Line.
	**/
	public function getRandomPoint(point:Point):Point
	{
		return LineUtil.Random(this, point);
	}

	/**
	 * Get a random Point on the Line.
	 *
	 * @since 1.0.0
	 *
	 * @param point - An instance of a Point-like object to be modified.
	 *
	 * @return A random Point on the Line.
	**/
	public function getRandomPointAny<T:Vector2Like>(point:T):T
	{
		return LineUtil.RandomAny(this, point);
	}

	/**
	 * Set new coordinates for the line endpoints.
	 *
	 * @since 1.0.0
	 *
	 * @param x1 - The x coordinate of the lines starting point.
	 * @param y1 - The y coordinate of the lines starting point.
	 * @param x2 - The x coordinate of the lines ending point.
	 * @param y2 - The y coordinate of the lines ending point.
	 *
	 * @return This Line object.
	**/
	public function setTo(x1:Float = 0, y1:Float = 0, x2:Float = 0, y2:Float = 0):Line
	{
		this.x1 = x1;
		this.y1 = y1;
		this.x2 = x2;
		this.y2 = y2;
		return this;
	}

	/**
	 * Returns a Vector2 object that corresponds to the start of this Line.
	 *
	 * @since 1.0.0
	 *
	 * @param vec2 - A Vector2 object to set the results in. If `null` a new Vector2 will be created.
	 *
	 * @return A Vector2 object that corresponds to the start of this Line.
	**/
	public function getPointA(?vec2:Vector2):Vector2
	{
		if (vec2 == null)
		{
			vec2 = new Vector2();
		}

		vec2.set(this.x1, this.y1);

		return vec2;
	}

	/**
	 * Returns a Vector2 object that corresponds to the start of this Line.
	 *
	 * @since 1.0.0
	 *
	 * @param vec2 - A Vector2-like object to set the results in.
	 *
	 * @return A Vector2 object that corresponds to the start of this Line.
	**/
	public function getPointAAny<T:Vector2Like>(vec2:T):T
	{
		vec2.x = this.x1;
		vec2.y = this.y1;
		return vec2;
	}

	/**
	 * Returns a Vector2 object that corresponds to the end of this Line.
	 *
	 * @since 1.0.0
	 *
	 * @param vec2 - A Vector2 object to set the results in. If `undefined` a new Vector2 will be created.
	 *
	 * @return A Vector2 object that corresponds to the end of this Line.
	**/
	public function getPointB(?vec2:Vector2):Vector2
	{
		if (vec2 == null)
		{
			vec2 = new Vector2();
		}

		vec2.set(this.x2, this.y2);

		return vec2;
	}

	/**
	 * Returns a Vector2 object that corresponds to the end of this Line.
	 *
	 * @since 1.0.0
	 *
	 * @param vec2 - A Vector2 object to set the results in. If `undefined` a new Vector2 will be created.
	 *
	 * @return A Vector2 object that corresponds to the end of this Line.
	**/
	public function getPointBAny<T:Vector2Like>(?vec2:T):T
	{
		vec2.x = this.x2;
		vec2.y = this.y2;
		return vec2;
	}
}
