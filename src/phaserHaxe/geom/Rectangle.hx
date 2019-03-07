package phaserHaxe.geom;

import phaserHaxe.math.Vector2Like;
import phaserHaxe.math.MathConst;
import phaserHaxe.math.MathUtility;

/**
 * Encapsulates a 2D rectangle defined by its corner point
 * in the top-left and its extends in x (width) and y (height)
 *
 * @since 1.0.0
 *
**/
class Rectangle
{
	/**
	 * The X coordinate of the top left corner of the Rectangle.
	 *
	 * @since 1.0.0
	**/
	public var x:Float;

	/**
	 * The Y coordinate of the top left corner of the Rectangle.
	 *
	 * @since 1.0.0
	**/
	public var y:Float;

	/**
	 * The width of the Rectangle, i.e. the distance between its left side (defined by `x`) and its right side.
	 *
	 * @since 1.0.0
	**/
	public var width:Float;

	/**
	 * The height of the Rectangle, i.e. the distance between its top side (defined by `y`) and its bottom side.
	 *
	 * @since 1.0.0
	**/
	public var height:Float;

	/**
	 * The x coordinate of the left of the Rectangle.
	 * Changing the left property of a Rectangle object has no effect on the y and height properties.
	 * However it does affect the width property, whereas changing the x value does not affect the width property.
	 *
	 * @since 1.0.0
	**/
	public var left(get, set):Float;

	/**
	 * The sum of the x and width properties.
	 * Changing the right property of a Rectangle object has no effect on the x, y and height properties,
	 * however it does affect the width property.
	 *
	 * @since 1.0.0
	**/
	public var right(get, set):Float;

	/**
	 * The y coordinate of the top of the Rectangle.
	 * Changing the top property of a Rectangle object has no effect on the x and width properties.
	 * However it does affect the height property, whereas changing the y value does not affect the height property.
	 *
	 * @since 1.0.0
	**/
	public var top(get, set):Float;

	/**
	 * The sum of the y and height properties.
	 * Changing the bottom property of a Rectangle object has no effect on the x, y and width properties,
	 * but does change the height property.
	 *
	 * @since 1.0.0
	**/
	public var bottom(get, set):Float;

	/**
	 * The x coordinate of the center of the Rectangle.
	 *
	 * @since 1.0.0
	**/
	public var centerX(get, set):Float;

	/**
	 * The y coordinate of the center of the Rectangle.
	 *
	 * @since 1.0.0
	**/
	public var centerY(get, set):Float;

	/**
	 * @param x - The X coordinate of the top left corner of the Rectangle.
	 * @param y - The Y coordinate of the top left corner of the Rectangle.
	 * @param width - The width of the Rectangle.
	 * @param height - The height of the Rectangle.
	**/
	public function new(x:Float = 0, y:Float = 0, width:Float = 0, height:Float = 0)
	{
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
	}

	// #region GettersAndSetters
	private inline function get_left():Float
	{
		return this.x;
	}

	private function set_left(value:Float):Float
	{
		if (value >= this.right)
		{
			this.width = 0;
		}
		else
		{
			this.width = this.right - value;
		}
		return value;
	}

	private inline function get_right():Float
	{
		return this.x + this.width;
	}

	private function set_right(value:Float):Float
	{
		if (value <= this.x)
		{
			this.width = 0;
		}
		else
		{
			this.width = value - this.x;
		}
		return value;
	}

	private inline function get_top():Float
	{
		return this.y;
	}

	private function set_top(value:Float):Float
	{
		if (value >= this.bottom)
		{
			this.height = 0;
		}
		else
		{
			this.height = (this.bottom - value);
		}

		this.y = value;
		return value;
	}

	private inline function get_bottom():Float
	{
		return this.y + this.height;
	}

	private function set_bottom(value:Float):Float
	{
		if (value <= this.y)
		{
			this.height = 0;
		}
		else
		{
			this.height = value - this.y;
		}
		return value;
	}

	private inline function get_centerX():Float
	{
		return this.x + (this.width / 2);
	}

	private inline function set_centerX(value:Float):Float
	{
		this.x = value - (this.width / 2);
		return value;
	}

	private inline function get_centerY():Float
	{
		return this.y + (this.height / 2);
	}

	private inline function set_centerY(value:Float):Float
	{
		this.y = value - (this.height / 2);
		return value;
	}

	// #endregion

	/**
	 * Checks if the given point is inside the Rectangle's bounds.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The X coordinate of the point to check.
	 * @param y - The Y coordinate of the point to check.
	 *
	 * @return`true` if the point is within the Rectangle's bounds, otherwise `false`.
	**/
	public function contains(x:Float, y:Float)
	{
		return inline RectangleUtil.Contains(this, x, y);
	}

	/**
	 * Calculates the coordinates of a point at a certain `position` on the Rectangle's perimeter.
	 *
	 * The `position` is a fraction between 0 and 1 which defines how far into the perimeter the point is.
	 *
	 * A value of 0 or 1 returns the point at the top left corner of the rectangle,
	 * while a value of 0.5 returns the point at the bottom right corner of the rectangle.
	 * Values between 0 and 0.5 are on the top or the right side and values between 0.5 and 1 are on the bottom or the left side.
	 *
	 * @since 1.0.0
	 *
	 * @param position - The normalized distance into the Rectangle's perimeter to return.
	 * @param output - An object to update with the `x` and `y` coordinates of the point.
	 *
	 * @return The updated `output` object, or a new Point if no `output` object was given.
	**/
	public function getPoint(position:Float, ?output:Point):Point
	{
		return inline RectangleUtil.GetPoint(this, position, output);
	}

	/**
	 * Returns an array of points from the perimeter of the Rectangle, each spaced out based on the quantity or step required.
	 *
	 * @since 1.0.0
	 *
	 * @param quantity - The number of points to return. Set to `false` or 0 to return an arbitrary number of points (`perimeter / stepRate`) evenly spaced around the Rectangle based on the `stepRate`.
	 * @param stepRate - If `quantity` is 0, determines the normalized distance between each returned point.
	 * @param output - An array to which to append the points.
	 *
	 * @return The modified `output` array, or a new array if none was provided.
	**/
	public function getPoints(quantity:Int, stepRate:Float, ?output:Array<Point>):Array<Point>
	{
		return inline RectangleUtil.GetPoints(this, quantity, stepRate, output);
	}

	/**
	 * Returns a random point within the Rectangle's bounds.
	 *
	 * @since 1.0.0
	 *
	 * @param point - The point in which to store the `x` and `y` coordinates of the point.
	 *
	 * @return The updated `point`, or a new Point if none was provided.
	**/
	public function getRandomPoint(?point:Point):Point
	{
		return inline RectangleUtil.Random(this, point);
	}

	/**
	 * Returns a random point within the Rectangle's bounds.
	 *
	 * @since 1.0.0
	 *
	 * @param point - The object in which to store the `x` and `y` coordinates of the point.
	 *
	 * @return The updated `object`.
	**/
	public inline function getRandomPointAny<T:Vector2Like>(point:T):T
	{
		return RectangleUtil.RandomAny(this, point);
	}

	/**
	 * Sets the position, width, and height of the Rectangle.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The X coordinate of the top left corner of the Rectangle.
	 * @param y - The Y coordinate of the top left corner of the Rectangle.
	 * @param width - The width of the Rectangle.
	 * @param height - The height of the Rectangle.
	 *
	 * @return This Rectangle object.
	**/
	public function setTo(x:Float, y:Float, width:Float, height:Float):Rectangle
	{
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;

		return this;
	}

	/**
	 * Resets the position, width, and height of the Rectangle to 0.
	 *
	 * @since 1.0.0
	 *
	 * @return This Rectangle object.
	**/
	public function setEmpty():Rectangle
	{
		return this.setTo(0, 0, 0, 0);
	}

	/**
	 * Sets the position of the Rectangle.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The X coordinate of the top left corner of the Rectangle.
	 * @param y - The Y coordinate of the top left corner of the Rectangle.
	 *
	 * @return This Rectangle object.
	**/
	public function setPosition(x:Float, ?y:Float):Rectangle
	{
		this.x = x;
		this.y = y != null ? y : x;
		return this;
	}

	/**
	 * Sets the width and height of the Rectangle.
	 *
	 * @since 1.0.0
	 *
	 * @param width - The width to set the Rectangle to.
	 * @param height - The height to set the Rectangle to.
	 *
	 * @return This Rectangle object.
	**/
	public function setSize(width:Float, ?height:Float):Rectangle
	{
		this.width = width;
		this.height = height != null ? height : width;

		return this;
	}

	/**
	 * Determines if the Rectangle is empty. A Rectangle is empty if its width or height is less than or equal to 0.
	 *
	 * @since 1.0.0
	 *
	 * @return`true` if the Rectangle is empty.
	 * A Rectangle object is empty if its width or height is less than or equal to 0.
	**/
	public function isEmpty()
	{
		return (this.width <= 0 || this.height <= 0);
	}

	/**
	 * Returns a Line object that corresponds to the top of this Rectangle.
	 *
	 * @since 1.0.0
	 *
	 * @param line - A Line object to set the results in. If `undefined` a new Line will be created.
	 *
	 * @return A Line object that corresponds to the top of this Rectangle.
	**/
	public function getLineA(?line:Line):Line
	{
		if (line == null)
		{
			line = new Line();
		}

		line.setTo(this.x, this.y, this.right, this.y);

		return line;
	}

	/**
	 * Returns a Line object that corresponds to the right of this Rectangle.
	 *
	 * @since 1.0.0
	 *
	 * @param line - A Line object to set the results in. If `undefined` a new Line will be created.
	 *
	 * @return A Line object that corresponds to the right of this Rectangle.
	**/
	public function getLineB(?line:Line):Line
	{
		if (line == null)
		{
			line = new Line();
		}

		line.setTo(this.right, this.y, this.right, this.bottom);

		return line;
	}

	/**
	 * Returns a Line object that corresponds to the bottom of this Rectangle.
	 *
	 * @since 1.0.0
	 *
	 * @param line - A Line object to set the results in. If `undefined` a new Line will be created.
	 *
	 * @return A Line object that corresponds to the bottom of this Rectangle.
	**/
	public function getLineC(?line:Line):Line
	{
		if (line == null)
		{
			line = new Line();
		}

		line.setTo(this.right, this.bottom, this.x, this.bottom);

		return line;
	}

	/**
	 * Returns a Line object that corresponds to the left of this Rectangle.
	 *
	 * @since 1.0.0
	 *
	 * @param line - A Line object to set the results in. If `undefined` a new Line will be created.
	 *
	 * @return A Line object that corresponds to the left of this Rectangle.
	**/
	public function getLineD(?line:Line):Line
	{
		if (line == null)
		{
			line = new Line();
		}

		line.setTo(this.x, this.bottom, this.x, this.y);

		return line;
	}
}
