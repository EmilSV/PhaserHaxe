package phaserHaxe.geom;

import phaserHaxe.math.Vector2Like;
import phaserHaxe.math.MathConst;
import phaserHaxe.math.MathUtility;

class Circle
{
	/**
	 * The x position of the center of the circle.
	 *
	 * @name Phaser.Geom.Circle#x
	 * @type {number}
	 * @default 0
	 * @since 3.0.0
	**/
	public var x:Float;

	/**
	 * The y position of the center of the circle.
	 *
	 * @name Phaser.Geom.Circle#y
	 * @type {number}
	 * @default 0
	 * @since 3.0.0
	**/
	public var y:Float;

	/**
	 * The internal radius of the circle.
	 *
	 * @name Phaser.Geom.Circle#_radius
	 * @type {number}
	 * @private
	 * @since 3.0.0
	 */
	private var _radius:Float;

	/**
	 * The internal diameter of the circle.
	 *
	 * @name Phaser.Geom.Circle#_diameter
	 * @type {number}
	 * @private
	 * @since 3.0.0
	 */
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

	/**
	 * Calculates the area of the circle.
	 *
	 * @function Phaser.Geom.Circle.Area
	 * @since 3.0.0
	 *
	 * @param {Phaser.Geom.Circle} circle - The Circle to get the area of.
	 *
	 * @return {number} The area of the Circle.
	 */
	public static function Area(circle)
	{
		return (circle.radius > 0) ? Math.PI * circle.radius * circle.radius : 0;
	}

	/**
	 * Returns a uniformly distributed random point from anywhere within the given Circle.
	 *
	 * @function Phaser.Geom.Circle.Random
	 * @since 3.0.0
	 *
	 * @generic {Phaser.Geom.Point} O - [out,$return]
	 *
	 * @param {Phaser.Geom.Circle} circle - The Circle to get a random point from.
	 * @param {(Phaser.Geom.Point|object)} [out] - A Point or point-like object to set the random `x` and `y` values in.
	 *
	 * @return {(Phaser.Geom.Point|object)} A Point object with the random values set in the `x` and `y` properties.
	 */
	public static function Random(circle:Circle, ?out:Point)
	{
		if (out == null)
		{
			out = new Point();
		}

		var t = 2 * Math.PI * Math.random();
		var u = Math.random() + Math.random();
		var r = (u > 1) ? 2 - u : u;
		var x = r * Math.cos(t);
		var y = r * Math.sin(t);
		out.x = circle.x + (x * circle.radius);
		out.y = circle.y + (y * circle.radius);
		return out;
	}

	/**
	 * Offsets the Circle by the values given in the `x` and `y` properties of the Point object.
	 *
	 * @function Phaser.Geom.Circle.OffsetPoint
	 * @since 3.0.0
	 *
	 * @generic {Phaser.Geom.Circle} O - [circle,$return]
	 *
	 * @param {Phaser.Geom.Circle} circle - The Circle to be offset (translated.)
	 * @param {(Phaser.Geom.Point|object)} point - The Point object containing the values to offset the Circle by.
	 *
	 * @return {Phaser.Geom.Circle} The Circle that was offset.
	 */
	public static function OffsetPoint(circle:Circle, point:Point)
	{
		circle.x += point.x;
		circle.y += point.y;
		return circle;
	}

	/**
	 * Offsets the Circle by the values given.
	 *
	 * @function Phaser.Geom.Circle.Offset
	 * @since 3.0.0
	 *
	 * @generic {Phaser.Geom.Circle} O - [circle,$return]
	 *
	 * @param {Phaser.Geom.Circle} circle - The Circle to be offset (translated.)
	 * @param {number} x - The amount to horizontally offset the Circle by.
	 * @param {number} y - The amount to vertically offset the Circle by.
	 *
	 * @return {Phaser.Geom.Circle} The Circle that was offset.
	 */
	public static function Offset(circle:Circle, x:Float, y:Float)
	{
		circle.x += x;
		circle.y += y;
		return circle;
	}

	/**
	 * Returns an array of Point objects containing the coordinates of the points around the circumference of the Circle,
	 * based on the given quantity or stepRate values.
	 *
	 * @since 1.0.0
	 *
	 * @param circle - The Circle to get the points from.
	 * @param quantity - The amount of points to return. If a falsey value the quantity will be derived from the `stepRate` instead.
	 * @param stepRate - Sets the quantity by getting the circumference of the circle and dividing it by the stepRate.
	 * @param output - An array to insert the points in to. If not provided a new array will be created.
	 *
	 * @return An array of Point objects pertaining to the points around the circumference of the circle.
	**/
	public static function GetPoints(circle:Circle, quantity:Int, stepRate:Float, ?out:Array<Point>):Array<Point>
	{
		if (out == null)
		{
			out = [];
		}

		//  If quantity is 0 then we calculate it based on the stepRate instead.
		if (quantity == 0)
		{
			quantity = Std.int(Circumference(circle) / stepRate);
		}
		for (i in 0...quantity)
		{
			var angle = MathUtility.FromPercent(i / quantity, 0, MathConst.PI2);
			out.push(CircumferencePoint(circle, angle, new Point()));
		}
		return out;
	}

	/**
	 * Returns a Point object containing the coordinates of a point on the circumference of the Circle
	 * based on the given angle normalized to the range 0 to 1. I.e. a value of 0.5 will give the point
	 * at 180 degrees around the circle.
	 *
	 * @since 1.0.0
	 *
	 * @param circle - The Circle to get the circumference point on.
	 * @param position - A value between 0 and 1, where 0 equals 0 degrees, 0.5 equals 180 degrees and 1 equals 360 around the circle.
	 * @param out - An object to store the return values in.
	 *
	 * @return A Point, or point-like object, containing the coordinates of the point around the circle.
	**/
	public static function GetPoint<T:Vector2Like>(circle:Circle, position:Float, out:T):T
	{
		var angle = MathUtility.FromPercent(position, 0, MathConst.PI2);
		return CircumferencePoint(circle, angle, out);
	}

	/**
	 * Returns the circumference of the given Circle.
	 *
	 * @since 1.0.0
	 *
	 * @param circle - The Circle to get the circumference of.
	 *
	 * @return The circumference of the Circle.
	**/
	public static function Circumference(circle:Circle):Float
	{
		return 2 * (Math.PI * circle.radius);
	}

	/**
	 * Returns a Point object containing the coordinates of a point on the circumference of the Circle based on the given angle.
	 *
	 * @since 1.0.0
	 *
	 * @param circle - The Circle to get the circumference point on.
	 * @param angle - The angle from the center of the Circle to the circumference to return the point from. Given in radians.
	 * @param out - A Point, or point-like object, to store the results in.
	 *
	 * @return A Point object where the `x` and `y` properties are the point on the circumference.
	**/
	public static inline function CircumferencePoint<T:Vector2Like>(circle:Circle, angle:Float, out:T):T
	{
		out.x = circle.x + (circle.radius * Math.cos(angle));
		out.y = circle.y + (circle.radius * Math.sin(angle));

		return out;
	}

	/**
	 * Returns the bounds of the Circle object.
	 *
	 * @since 1.0.0
	 *
	 * @param circle - The Circle to get the bounds from.
	 * @param out - A Rectangle, or rectangle-like object, to store the circle bounds in.
	 *
	 * @return The Rectangle object containing the Circles bounds.
	**/
	public static inline function GetBounds<T:RectangleLike>(circle:Circle, out:T):T
	{
		out.x = circle.left;
		out.y = circle.top;
		out.width = circle.diameter;
		out.height = circle.diameter;
		return out;
	}

	/**
	 * Compares the `x`, `y` and `radius` properties of the two given Circles.
	 * Returns `true` if they all match, otherwise returns `false`.
	 *
	 * @since 1.0.0
	 *
	 * @param circle - The first Circle to compare.
	 * @param toCompare - The second Circle to compare.
	 *
	 * @return `true` if the two Circles equal each other, otherwise `false`.
	**/
	public static function Equals(circle:Circle, toCompare:Circle)
	{
		return (circle.x == toCompare.x && circle.y == toCompare.y && circle.radius == toCompare.radius);
	}

	/**
	 * Copies the `x`, `y` and `radius` properties from the `source` Circle
	 * into the given `dest` Circle, then returns the `dest` Circle.
	 *
	 * @since 1.0.0
	 *
	 * @param source - The source Circle to copy the values from.
	 * @param dest - The destination Circle to copy the values to.
	 *
	 * @return The destination Circle.
	**/
	public static inline function CopyFrom<T:CircleLike>(source:Circle, dest:T):T
	{
		dest.x = source.x;
		dest.y = source.y;
		dest.radius = source.radius;
		return dest;
	}

	/**
	 * Check to see if the Circle contains all four points of the given Rectangle object.
	 *
	 * @since 1.0.0
	 *
	 * @param circle - The Circle to check.
	 * @param rect - The Rectangle object to check if it's within the Circle or not.
	 *
	 * @return True if all of the Rectangle coordinates are within the circle, otherwise false.
	**/
	public static function ContainsRect(circle:Circle, rect:Rectangle)
	{
		return (Contains(circle, rect.x, rect.y)
			&& Contains(circle, rect.right, rect.y)
			&& Contains(circle, rect.x, rect.bottom)
			&& Contains(circle, rect.right, rect.bottom));
	}

	/**
	 * Check to see if the Circle contains the given Point object.
	 *
	 * @since 1.0.0
	 *
	 * @param circle - The Circle to check.
	 * @param point - The Point object to check if it's within the Circle or not.
	 *
	 * @return True if the Point coordinates are within the circle, otherwise false.
	**/
	public static inline function ContainsPoint(circle:Circle, point:Point):Bool
	{
		return Contains(circle, point.x, point.y);
	}

	/**
	 * Check to see if the Circle contains the given x / y coordinates.
	 *
	 * @function Phaser.Geom.Circle.Contains
	 * @since 3.0.0
	 *
	 * @param {Phaser.Geom.Circle} circle - The Circle to check.
	 * @param {number} x - The x coordinate to check within the circle.
	 * @param {number} y - The y coordinate to check within the circle.
	 *
	 * @return {boolean} True if the coordinates are within the circle, otherwise false.
	**/
	public static function Contains(circle:Circle, x:Float, y:Float):Bool
	{
		//  Check if x/y are within the bounds first
		if (circle.radius > 0 && x >= circle.left && x <= circle.right && y >= circle.top && y <= circle.bottom)
		{
			var dx = (circle.x - x) * (circle.x - x);
			var dy = (circle.y - y) * (circle.y - y);
			return (dx + dy) <= (circle.radius * circle.radius);
		}
		else
		{
			return false;
		}
	}

	/**
	 * Creates a new Circle instance based on the values contained in the given source.
	 *
	 * @since 1.0.0
	 *
	 * @param {(Phaser.Geom.Circle|object)} source - The Circle to be cloned. Can be an instance of a Circle or a circle-like object, with x, y and radius properties.
	 *
	 * @return {Phaser.Geom.Circle} A clone of the source Circle.
	**/
	public static function Clone(source:Circle):Circle
	{
		return new Circle(source.x, source.y, source.radius);
	}
}
