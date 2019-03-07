package phaserHaxe.geom;

import phaserHaxe.math.Vector2Like;
import phaserHaxe.math.MathConst;
import phaserHaxe.math.MathUtility;

/**
 * A Circle object.
 *
 * This is a geometry object, containing numerical values and related methods to inspect and modify them.
 * It is not a Game Object, in that you cannot add it to the display list, and it has no texture.
 * To render a Circle you should look at the capabilities of the Graphics class.
 *
 * @since 1.0.0
 *
**/
class Circle
{
	/**
	 * The x position of the center of the circle.
	 *
	 * @since 1.0.0
	**/
	public var x:Float;

	/**
	 * The y position of the center of the circle.
	 *
	 * @since 1.0.0
	**/
	public var y:Float;

	/**
	 * The internal radius of the circle.
	 *
	 * @since 1.0.0
	**/
	private var _radius:Float;

	/**
	 * The internal diameter of the circle.
	 *
	 * @since 1.0.0
	**/
	private var _diameter:Float;

	/**
	 * The radius of the Circle.
	 *
	 * @since 1.0.0
	**/
	public var radius(get, set):Float;

	/**
	 * The diameter of the Circle.
	 *
	 * @since 1.0.0
	**/
	public var diameter(get, set):Float;

	/**
	 * The left position of the Circle.
	 *
	 * @since 1.0.0
	**/
	public var left(get, set):Float;

	/**
	 * The right position of the Circle.
	 *
	 * @since 1.0.0
	**/
	public var right(get, set):Float;

	/**
	 * The top position of the Circle.
	 *
	 * @since 1.0.0
	**/
	public var top(get, set):Float;

	/**
	 * The bottom position of the Circle.
	 *
	 * @since 1.0.0
	**/
	public var bottom(get, set):Float;

	public function new(x:Float = 0, y:Float = 0, radius:Float = 0)
	{
		this.x = x;
		this.y = y;
		this._radius = radius;
		this._diameter = radius * 2;
	}

	// #region GettersAndSetters
	private inline function get_radius():Float
	{
		return this._radius;
	}

	private inline function set_radius(value:Float)
	{
		this._radius = value;
		this._diameter = value * 2;
		return value;
	}

	private inline function get_diameter():Float
	{
		return this._diameter;
	}

	private inline function set_diameter(value:Float):Float
	{
		this._diameter = value;
		this._radius = value * 0.5;
		return value;
	}

	private inline function get_left():Float
	{
		return this.x - this._radius;
	}

	private inline function set_left(value:Float):Float
	{
		this.x = value + this._radius;
		return value;
	}

	private inline function get_right():Float
	{
		return this.x + this._radius;
	}

	private inline function set_right(value:Float):Float
	{
		this.x = value - this._radius;
		return value;
	}

	private inline function get_top():Float
	{
		return this.y - this._radius;
	}

	private inline function set_top(value:Float):Float
	{
		this.y = value + this._radius;
		return value;
	}

	private inline function get_bottom():Float
	{
		return this.y + this._radius;
	}

	private inline function set_bottom(value:Float):Float
	{
		this.y = value - this._radius;
		return value;
	}

	// #endregion

	/**
	 * Check to see if the Circle contains the given x / y coordinates.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The x coordinate to check within the circle.
	 * @param y - The y coordinate to check within the circle.
	 *
	 * @return True if the coordinates are within the circle, otherwise false.
	**/
	public function contains(x:Float, y:Float):Bool
	{
		return inline CircleUtil.Contains(this, x, y);
	}

	/**
	 * Returns a Point object containing the coordinates of a point on the circumference of the Circle
	 * based on the given angle normalized to the range 0 to 1. I.e. a value of 0.5 will give the point
	 * at 180 degrees around the circle.
	 *
	 * @since 1.0.0
	 *
	 * @param position - A value between 0 and 1, where 0 equals 0 degrees, 0.5 equals 180 degrees and 1 equals 360 around the circle.
	 * @param out - An point to store the return values in. If not given a Point object will be created.
	 *
	 * @return A point, containing the coordinates of the point around the circle.
	**/
	public function getPoint(position:Float, ?point:Point):Point
	{
		return inline CircleUtil.GetPoint(this, position, point);
	}

	/**
	 * Returns a Point-like object containing the coordinates of a point on the circumference of the Circle
	 * based on the given angle normalized to the range 0 to 1. I.e. a value of 0.5 will give the point
	 * at 180 degrees around the circle.
	 *
	 * @since 1.0.0
	 *
	 * @param position - A value between 0 and 1, where 0 equals 0 degrees, 0.5 equals 180 degrees and 1 equals 360 around the circle.
	 * @param out - An point-like object to store the return values in.
	 *
	 * @return the object, containing the coordinates of the point around the circle.
	**/
	public function getPointAny<T:Vector2Like>(position:Float, point:T):T
	{
		return inline CircleUtil.GetPointAny(this, position, point);
	}

	/**
	 * Returns an array of Point objects containing the coordinates of the points around the circumference of the Circle,
	 * based on the given quantity or stepRate values.
	 *
	 * @since 1.0.0
	 *
	 * @param quantity - The amount of points to return. If 0 quantity will be derived from the `stepRate` instead.
	 * @param stepRate - Sets the quantity by getting the circumference of the circle and dividing it by the stepRate.
	 * @param output - An array to insert the points in to. If not provided a new array will be created.
	 *
	 * @return An array of Point objects pertaining to the points around the circumference of the circle.
	**/
	public function getPoints(quantity:Int, stepRate:Float = 0, ?output:Array<Point>):Array<Point>
	{
		return inline CircleUtil.GetPoints(this, quantity, stepRate, output);
	}

	/**
	 * Returns a uniformly distributed random point from anywhere within the Circle.
	 *
	 * @since 1.0.0
	 *
	 * @param point - A Point or point-like object to set the random `x` and `y` values in.
	 *
	 * @return A Point object with the random values set in the `x` and `y` properties.
	**/
	public function getRandomPoint<T:Vector2Like>(point:T):T
	{
		return inline CircleUtil.RandomAny(this, point);
	}

	/**
	 * Sets the x, y and radius of this circle.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The x position of the center of the circle.
	 * @param y - The y position of the center of the circle.
	 * @param radius - The radius of the circle.
	 *
	 * @return This Circle object.
	**/
	public function setTo(x:Float = 0, y:Float = 0, radius:Float = 0):Circle
	{
		this.x = x;
		this.y = y;
		this._radius = radius;
		this._diameter = radius * 2;

		return this;
	}

	/**
	 * Sets this Circle to be empty with a radius of zero.
	 * Does not change its position.
	 *
	 * @since 1.0.0
	 *
	 * @return This Circle object.
	**/
	public function setEmpty():Circle
	{
		this._radius = 0;
		this._diameter = 0;

		return this;
	}

	/**
	 * Sets the position of this Circle.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The x position of the center of the circle.
	 * @param y - The y position of the center of the circle.
	 *
	 * @return This Circle object.
	**/
	public function setPosition(x:Float, ?y:Float):Circle
	{
		if (y == null)
		{
			this.x = x;
			this.y = x;
		}
		else
		{
			this.x = x;
			this.y = y;
		}

		return this;
	}

	/**
	 * Checks to see if the Circle is empty: has a radius of zero.
	 *
	 * @since 1.0.0
	 *
	 * @return True if the Circle is empty, otherwise false.
	**/
	public function isEmpty():Bool
	{
		return (this._radius <= 0);
	}
}
