package phaserHaxe.geom;

import phaserHaxe.math.Vector2Like;

class Triangle
{
	/**
	 * `x` coordinate of the first point.
	 *
	 * @since 1.0.0
	**/
	public var x1:Float;

	/**
	 * `y` coordinate of the first point.
	 *
	 * @since 1.0.0
	**/
	public var y1:Float;

	/**
	 * `x` coordinate of the second point.
	 *
	 * @since 1.0.0
	**/
	public var x2:Float;

	/**
	 * `y` coordinate of the second point.
	 *
	 * @since 1.0.0
	**/
	public var y2:Float;

	/**
	 * `x` coordinate of the third point.
	 *
	 * @since 1.0.0
	**/
	public var x3:Float;

	/**
	 * `y` coordinate of the third point.
	 *
	 * @since 1.0.0
	**/
	public var y3:Float;

	/**
	 * Left most X coordinate of the triangle. Setting it moves the triangle on the X axis accordingly.
	 *
	 * @since 1.0.0
	**/
	public var left(get, set):Float;

	/**
	 * Right most X coordinate of the triangle. Setting it moves the triangle on the X axis accordingly.
	 *
	 * @since 1.0.0
	**/
	public var right(get, set):Float;

	/**
	 * Top most Y coordinate of the triangle. Setting it moves the triangle on the Y axis accordingly.
	 *
	 * @since 1.0.0
	**/
	public var top(get, set):Float;

	/**
	 * Bottom most Y coordinate of the triangle. Setting it moves the triangle on the Y axis accordingly.
	 *
	 * @since 1.0.0
	**/
	public var bottom(get, set):Float;

	public function new(x1:Float = 0, y1:Float = 0, x2:Float = 0, y2:Float = 0, x3:Float = 0, y3:Float = 0)
	{
		this.x1 = x1;
		this.y1 = y1;
		this.x2 = x2;
		this.y2 = y2;
		this.x3 = x3;
		this.y3 = y3;
	}

	private inline function get_left():Float
	{
		return Math.min(Math.min(x1, x2), x3);
	}

	private function set_left(value:Float):Float
	{
		var diff = 0.0;
		if (x1 <= x2 && x1 <= x3)
		{
			diff = x1 - value;
		}
		else if (x2 <= x1 && x2 <= x3)
		{
			diff = x2 - value;
		}
		else
		{
			diff = x3 - value;
		}
		x1 -= diff;
		x2 -= diff;
		x3 -= diff;
		return value;
	}

	private inline function get_right():Float
	{
		return Math.max(Math.max(x1, x2), x3);
	}

	private function set_right(value:Float):Float
	{
		var diff = 0.0;
		if (x1 >= x2 && x1 >= x3)
		{
			diff = x1 - value;
		}
		else if (x2 >= x1 && x2 >= x3)
		{
			diff = x2 - value;
		}
		else
		{
			diff = x3 - value;
		}
		x1 -= diff;
		x2 -= diff;
		x3 -= diff;
		return value;
	}

	private inline function get_top():Float
	{
		return Math.min(Math.min(y1, y2), y3);
	}

	private function set_top(value:Float):Float
	{
		var diff = 0.0;
		if (y1 <= y2 && y1 <= y3)
		{
			diff = y1 - value;
		}
		else if (y2 <= y1 && y2 <= y3)
		{
			diff = y2 - value;
		}
		else
		{
			diff = y3 - value;
		}
		y1 -= diff;
		y2 -= diff;
		y3 -= diff;
		return value;
	}

	private inline function get_bottom():Float
	{
		return Math.max(Math.max(y1, y2), y3);
	}

	private function set_bottom(value:Float):Float
	{
		var diff = 0.0;
		if (y1 >= y2 && y1 >= y3)
		{
			diff = y1 - value;
		}
		else if (y2 >= y1 && y2 >= y3)
		{
			diff = y2 - value;
		}
		else
		{
			diff = y3 - value;
		}
		y1 -= diff;
		y2 -= diff;
		y3 -= diff;
		return value;
	}

	/**
	 * Checks whether a given points lies within the triangle.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The x coordinate of the point to check.
	 * @param y - The y coordinate of the point to check.
	 *
	 * @return `true` if the coordinate pair is within the triangle, otherwise `false`.
	**/
	public function contains(x, y)
	{
		return TriangleUtil.Contains(this, x, y);
	}

	/**
	 * Returns a specific point  on the triangle.
	 *
	 * @since 1.0.0
	 *
	 * @param position - Position as float within `0` and `1`. `0` equals the first point.
	 * @param output - Optional Point that the calculated point will be written to.
	 *
	 * @return Calculated `Point` that represents the requested position. It is the same as `output` when this parameter has been given.
	**/
	public function getPoint(position:Float, ?output:Point):Point
	{
		return TriangleUtil.GetPoint(this, position, output);
	}

	/**
	 * Returns a specific point  on the triangle.
	 *
	 * @since 1.0.0
	 *
	 * @param position - Position as float within `0` and `1`. `0` equals the first point.
	 * @param output - point-like object, that the calculated point will be written to.
	 *
	 * @return Calculated `Point` that represents the requested position. It is the same as `output` when this parameter has been given.
	**/
	public function getPointAny<T:Vector2Like>(position:Float, output:T):T
	{
		return TriangleUtil.GetPointAny(this, position, output);
	}

	/**
	 * Calculates a list of evenly distributed points on the triangle.
	 * It is either possible to pass an amount of points to be generated (`quantity`)
	 * or the distance between two points (`stepRate`).
	 *
	 * @since 1.0.0
	 *
	 * @param quantity - Number of points to be generated. Can be falsey when `stepRate` should be used. All points have the same distance along the triangle.
	 * @param stepRate - Distance between two points. Will only be used when `quantity` is falsey.
	 * @param output - Optional Array for writing the calculated points into. Otherwise a new array will be created.
	 *
	 * @return Returns a list of calculated `Point` instances or the filled array passed as parameter `output`.
	**/
	public function getPoints(quantity:Int, stepRate:Float = 0, ?output:Array<Point>):Array<Point>
	{
		return TriangleUtil.GetPoints(this, quantity, stepRate, output);
	}

	/**
	 * Returns a random point along the triangle.
	 *
	 * @since 1.0.0
	 *
	 * @param point - Optional `Point` that should be modified. Otherwise a new one will be created.
	 *
	 * @return Random `Point`. When parameter `point` has been provided it will be returned.
	**/
	public function getRandomPoint(?point:Point):Point
	{
		return TriangleUtil.Random(this, point);
	}

	/**
	 * Returns a random point along the triangle.
	 *
	 * @since 1.0.0
	 *
	 * @param point - `Point-like object` that should be modified. Otherwise a new one will be created.
	 *
	 * @return Random `Point`. When parameter `point` has been provided it will be returned.
	**/
	public function getRandomPointAny<T:Vector2Like>(point:T):T
	{
		return TriangleUtil.RandomAny(this, point);
	}

	/**
	 * Sets all three points of the triangle. Leaving out any coordinate sets it to be `0`.
	 *
	 * @since 1.0.0
	 *
	 * @param x1 - `x` coordinate of the first point.
	 * @param y1 - `y` coordinate of the first point.
	 * @param x2 - `x` coordinate of the second point.
	 * @param y2 - `y` coordinate of the second point.
	 * @param x3 - `x` coordinate of the third point.
	 * @param y3 - `y` coordinate of the third point.
	 *
	 * @return This Triangle object.
	**/
	public function setTo(x1:Float = 0, y1:Float = 0, x2:Float = 0, y2:Float = 0, x3:Float = 0, y3:Float = 0):Triangle
	{
		this.x1 = x1;
		this.y1 = y1;
		this.x2 = x2;
		this.y2 = y2;
		this.x3 = x3;
		this.y3 = y3;
		return this;
	}

	/**
	 * Returns a Line object that corresponds to Line A of this Triangle.
	 *
	 * @since 1.0.0
	 *
	 * @param line - A Line object to set the results in. If `undefined` a new Line will be created.
	 *
	 * @return A Line object that corresponds to line A of this Triangle.
	**/
	public function getLineA(?line:Line):Line
	{
		if (line == null)
		{
			line = new Line();
		}
		inline line.setTo(this.x1, this.y1, this.x2, this.y2);
		return line;
	}

	/**
	 * Returns a Line object that corresponds to Line B of this Triangle.
	 *
	 * @since 1.0.0
	 *
	 * @param line - A Line object to set the results in. If `undefined` a new Line will be created.
	 *
	 * @return A Line object that corresponds to line B of this Triangle.
	**/
	public function getLineB(?line:Line):Line
	{
		if (line == null)
		{
			line = new Line();
		}
		inline line.setTo(this.x2, this.y2, this.x3, this.y3);
		return line;
	}

	/**
	 * Returns a Line object that corresponds to Line C of this Triangle.
	 *
	 * @since 1.0.0
	 *
	 * @param line - A Line object to set the results in. If `undefined` a new Line will be created.
	 *
	 * @return A Line object that corresponds to line C of this Triangle.
	**/
	public function getLineC(?line:Line):Line
	{
		if (line == null)
		{
			line = new Line();
		}
		inline line.setTo(this.x3, this.y3, this.x1, this.y1);
		return line;
	}
}
