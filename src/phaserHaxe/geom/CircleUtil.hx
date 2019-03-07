package phaserHaxe.geom;

import phaserHaxe.math.Vector2Like;
import phaserHaxe.math.MathConst;
import phaserHaxe.math.MathUtility;

/**
 *
 * @since 1.0.0
 *
**/
final class CircleUtil
{
	/**
	 * Calculates the area of the circle.
	 *
	 * @since 1.0.0
	 *
	 * @param circle - The Circle to get the area of.
	 *
	 * @return The area of the Circle.
	**/
	public static function Area(circle:Circle):Float
	{
		return (circle.radius > 0) ? Math.PI * circle.radius * circle.radius : 0;
	}

	/**
	 * Returns a uniformly distributed random point from anywhere within the given Circle.
	 *
	 * @since 1.0.0
	 *
	 * @param circle - The Circle to get a random point from.
	 * @param out - A Point to set the random `x` and `y` values in.
	 *
	 * @return A Point object with the random values set in the `x` and `y` properties.
	**/
	public static function Random(circle:Circle, ?out:Point):Point
	{
		if (out == null)
		{
			out = new Point();
		}
		return inline RandomAny(circle, out);
	}

	/**
	 * Returns a uniformly distributed random point from anywhere within the given Circle.
	 *
	 * @since 1.0.0
	 *
	 * @param circle - The Circle to get a random point from.
	 * @param out - A point-like object to set the random `x` and `y` values in.
	 *
	 * @return A Point object with the random values set in the `x` and `y` properties.
	**/
	public static function RandomAny<T:Vector2Like>(circle:Circle, out:T):T
	{
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
	 * @since 1.0.0
	 *
	 * @param circle - The Circle to be offset (translated.)
	 * @param point - The Point object containing the values to offset the Circle by.
	 *
	 * @return The Circle that was offset.
	**/
	public static inline function OffsetPoint<T:CircleLike>(circle:T, point:Point):T
	{
		circle.x += point.x;
		circle.y += point.y;

		return circle;
	}

	/**
	 * Offsets the Circle by the values given.
	 *
	 * @since 1.0.0
	 *
	 * @param circle - The Circle or circle-like to be offset (translated.)
	 * @param x - The amount to horizontally offset the Circle by.
	 * @param y - The amount to vertically offset the Circle by.
	 *
	 * @return The Circle that was offset.
	**/
	public static inline function Offset<T:CircleLike>(circle:T, x:Float, y:Float):T
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
	 * @param quantity - The amount of points to return. If 0 the quantity will be derived from the `stepRate` instead.
	 * @param stepRate - Sets the quantity by getting the circumference of the circle and dividing it by the stepRate.
	 * @param output - An array to insert the points in to. If not provided a new array will be created.
	 *
	 * @return An array of Point objects pertaining to the points around the circumference of the circle.
	**/
	public static function GetPoints(circle:Circle, quantity:Int, stepRate:Float = 0, ?out:Array<Point>):Array<Point>
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
			out.push(inline CircumferencePointAny(circle, angle, new Point()));
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
	 * @param out - An point to store the return values in. If not given a Point object will be created.
	 *
	 * @return A Point, containing the coordinates of the point around the circle.
	**/
	public static function GetPoint(circle:Circle, position:Float, ?out:Point):Point
	{
		if (out == null)
		{
			out = new Point();
		}

		var angle = MathUtility.FromPercent(position, 0, MathConst.PI2);
		return CircumferencePoint(circle, angle, out);
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
	 * @return A point-like object, containing the coordinates of the point around the circle.
	**/
	public static function GetPointAny<T:Vector2Like>(circle:Circle, position:Float, out:T):T
	{
		var angle = MathUtility.FromPercent(position, 0, MathConst.PI2);
		return CircumferencePointAny(circle, angle, out);
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
	 * @param out - A Point to store the results in. If not given a Point will be created.
	 *
	 * @return A Point object where the `x` and `y` properties are the point on the circumference.
	**/
	public static function CircumferencePoint(circle:Circle, angle:Float, ?out:Point):Point
	{
		if (out != null)
		{
			out = new Point();
		}

		return inline CircumferencePointAny(circle, angle, out);
	}

	/**
	 * Returns a Point object containing the coordinates of a point on the circumference of the Circle based on the given angle.
	 *
	 * @since 1.0.0
	 *
	 * @param circle - The Circle to get the circumference point on.
	 * @param angle - The angle from the center of the Circle to the circumference to return the point from. Given in radians.
	 * @param out - A point-like object, to store the results in.
	 *
	 * @return A Point object where the `x` and `y` properties are the point on the circumference.
	**/
	public static inline function CircumferencePointAny<T:Vector2Like>(circle:Circle, angle:Float, out:T):T
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
	 * @since 1.0.0
	 *
	 * @param circle - The Circle to check.
	 * @param x - The x coordinate to check within the circle.
	 * @param y - The y coordinate to check within the circle.
	 *
	 * @return True if the coordinates are within the circle, otherwise false.
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
	 * @param source - The Circle to be cloned. Can be an instance of a Circle or a circle-like object, with x, y and radius properties.
	 *
	 * @return A clone of the source Circle.
	**/
	public static inline function Clone<T:CircleLike>(source:CircleLike):Circle
	{
		return new Circle(source.x, source.y, source.radius);
	}

	/**
	 * Creates a new inline Circle instance based on the values contained in the given source.
	 *
	 * @since 1.0.0
	 *
	 * @param source - The Circle to be cloned. Can be an instance of a Circle or a circle-like object, with x, y and radius properties.
	 *
	 * @return A inline clone of the source Circle.
	**/
	public static inline function CloneInline<T:CircleLike>(source:CircleLike):Circle
	{
		return inline new Circle(source.x, source.y, source.radius);
	}
}
