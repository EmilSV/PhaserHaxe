package phaserHaxe.geom;

import phaserHaxe.math.Vector2Like;

/**
 * An Ellipse object.
 *
 * This is a geometry object, containing numerical values and related methods to inspect and modify them.
 * It is not a Game Object, in that you cannot add it to the display list, and it has no texture.
 * To render an Ellipse you should look at the capabilities of the Graphics class.
 *
 * @since 1.0.0
 *
**/
class Ellipse
{
	/**
	 * The x position of the center of the ellipse.
	 *
	 * @since 1.0.0
	**/
	public var x:Float;

	/**
	 * The y position of the center of the ellipse.
	 *
	 * @since 1.0.0
	**/
	public var y:Float;

	/**
	 * The width of the ellipse.
	 *
	 * @since 1.0.0
	**/
	public var width:Float;

	/**
	 * The height of the ellipse.
	 *
	 * @since 1.0.0
	**/
	public var height:Float;

	/**
	 * The left position of the Ellipse.
	 *
	 * @since 1.0.0
	**/
	public var left(get, set):Float;

	/**
	 * The right position of the Ellipse.
	 *
	 * @since 1.0.0
	**/
	public var right(get, set):Float;

	/**
	 * The top position of the Ellipse.
	 *
	 * @since 1.0.0
	**/
	public var top(get, set):Float;

	/**
	 * The bottom position of the Ellipse.
	 *
	 * @since 1.0.0
	**/
	public var bottom(get, set):Float;

	public function new(x:Float = 0, y:Float = 0, width:Float = 0, height:Float = 0)
	{
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
	}

	// #region GetterAndSetters
	public inline function get_left():Float
	{
		return x - (width / 2);
	}

	public inline function set_left(value:Float):Float
	{
		x = value + (width / 2);
		return value;
	}

	public inline function get_right():Float
	{
		return x - (width / 2);
	}

	public inline function set_right(value:Float):Float
	{
		x = value + (width / 2);
		return value;
	}

	public inline function get_top():Float
	{
		return y - (height / 2);
	}

	public inline function set_top(value:Float):Float
	{
		y = value + (height / 2);
		return value;
	}

	public inline function get_bottom():Float
	{
		return y + (height / 2);
	}

	public inline function set_bottom(value:Float):Float
	{
		y = value - (height / 2);
		return value;
	}

	// #endregion

	/**
	 * Check to see if the Ellipse contains the given x / y coordinates.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The x coordinate to check within the ellipse.
	 * @param y - The y coordinate to check within the ellipse.
	 *
	 * @return True if the coordinates are within the ellipse, otherwise false.
	**/
	public function contains(x:Float, y:Float):Bool
	{
		return EllipseUtil.Contains(this, x, y);
	}

	/**
	 * Returns a Point object containing the coordinates of a point on the circumference of the Ellipse
	 * based on the given angle normalized to the range 0 to 1. I.e. a value of 0.5 will give the point
	 * at 180 degrees around the circle.
	 *
	 * @since 1.0.0
	 *
	 * @param position - A value between 0 and 1, where 0 equals 0 degrees, 0.5 equals 180 degrees and 1 equals 360 around the ellipse.
	 * @param out - An point to store the return values in. If not given a Point object will be created.
	 *
	 * @return A Point containing the coordinates of the point around the ellipse.
	**/
	public function getPoint(position, ?out:Point):Point
	{
		return EllipseUtil.GetPoint(this, position, out);
	}

	/**
	 * Returns a Point object containing the coordinates of a point on the circumference of the Ellipse
	 * based on the given angle normalized to the range 0 to 1. I.e. a value of 0.5 will give the point
	 * at 180 degrees around the circle.
	 *
	 * @since 1.0.0
	 *
	 * @param position - A value between 0 and 1, where 0 equals 0 degrees, 0.5 equals 180 degrees and 1 equals 360 around the ellipse.
	 * @param out - An object to store the return values in.
	 *
	 * @return A point-like object containing the coordinates of the point around the ellipse.
	**/
	public function getPointAny<T:Vector2Like>(position, out:T):T
	{
		return EllipseUtil.GetPointAny(this, position, out);
	}

	/**
	 * Returns an array of Point objects containing the coordinates of the points around the circumference of the Ellipse,
	 * based on the given quantity or stepRate values.
	 *
	 * @since 1.0.0
	 *
	 * @param quantity - The amount of points to return. If a falsey value the quantity will be derived from the `stepRate` instead.
	 * @param stepRate - Sets the quantity by getting the circumference of the ellipse and dividing it by the stepRate.
	 * @param output - An array to insert the points in to. If not provided a new array will be created.
	 *
	 * @return An array of Point objects pertaining to the points around the circumference of the ellipse.
	**/
	public function getPoints(quantity:Int, stepRate:Float = 0, ?output:Array<Point>):Array<Point>
	{
		return EllipseUtil.GetPoints(this, quantity, stepRate, output);
	}

	/**
	 * Returns a uniformly distributed random point from anywhere within the given Ellipse.
	 *
	 * @since 1.0.0
	 *
	 * @param point - A Point or point-like object to set the random `x` and `y` values in.
	 *
	 * @return A Point object with the random values set in the `x` and `y` properties.
	**/
	public function getRandomPoint(?point:Point):Point
	{
		return EllipseUtil.Random(this, point);
	}

	/**
	 * Returns a uniformly distributed random point from anywhere within the given Ellipse.
	 *
	 * @since 1.0.0
	 *
	 * @param point - A point-like object to set the random `x` and `y` values in.
	 *
	 * @return the object with the random values set in the `x` and `y` properties.
	**/
	public function getRandomPointAny<T:Vector2Like>(point:T):T
	{
		return EllipseUtil.RandomAny(this, point);
	}

	/**
	 * Sets the x, y, width and height of this ellipse.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The x position of the center of the ellipse.
	 * @param y - The y position of the center of the ellipse.
	 * @param width - The width of the ellipse.
	 * @param height - The height of the ellipse.
	 *
	 * @return This Ellipse object.
	**/
	public function setTo(x:Float, y:Float, width:Float, height:Float):Ellipse
	{
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
		return this;
	}

	/**
	 * Sets this Ellipse to be empty with a width and height of zero.
	 * Does not change its position.
	 *
	 * @since 1.0.0
	 *
	 * @return his Ellipse object.
	**/
	public function setEmpty():Ellipse
	{
		this.width = 0;
		this.height = 0;
		return this;
	}

	/**
	 * Sets the position of this Ellipse.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The x position of the center of the ellipse.
	 * @param y - The y position of the center of the ellipse.
	 *
	 * @return This Ellipse object.
	**/
	public function setPosition(x:Float, ?y:Float):Ellipse
	{
		this.x = x;
		this.y = y != null ? y : x;
		return this;
	}

	/**
	 * Sets the size of this Ellipse.
	 * Does not change its position.
	 *
	 * @since 1.0.0
	 *
	 * @param width - The width of the ellipse.
	 * @param height - The height of the ellipse.
	 *
	 * @return This Ellipse object.
	**/
	public function setSize(width:Float, ?height:Float):Ellipse
	{
		this.width = width;
		this.height = height != null ? height : width;
		return this;
	}

	/**
	 * Checks to see if the Ellipse is empty: has a width or height equal to zero.
	 *
	 * @since 1.0.0
	 *
	 * @return True if the Ellipse is empty, otherwise false.
	**/
	public function isEmpty():Bool
	{
		return (this.width <= 0 || this.height <= 0);
	};

	/**
	 * Returns the minor radius of the ellipse. Also known as the Semi Minor Axis.
	 *
	 * @since 1.0.0
	 *
	 * @return The minor radius.
	**/
	public function getMinorRadius():Float
	{
		return Math.min(this.width, this.height) / 2;
	}

	/**
	 * Returns the major radius of the ellipse. Also known as the Semi Major Axis.
	 *
	 * @since 1.0.0
	 *
	 * @return The major radius.
	**/
	public function getMajorRadius():Float
	{
		return Math.max(this.width, this.height) / 2;
	}
}
