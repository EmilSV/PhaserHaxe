package phaserHaxe.geom;

import phaserHaxe.math.MathUtility;
import phaserHaxe.math.MathConst;
import phaserHaxe.math.Vector2Like;

class EllipseTools
{
	/**
	 * Calculates the area of the Ellipse.
	 *
	 * @since 1.0.0
	 *
	 * @param ellipse - The Ellipse to get the area of.
	 *
	 * @return The area of the Ellipse.
	**/
	public static function area(ellipse:Ellipse):Float
	{
		if (ellipse.isEmpty())
		{
			return 0.0;
		}

		//  units squared
		return (ellipse.getMajorRadius() * ellipse.getMinorRadius() * Math.PI);
	}

	/**
	 * Returns the circumference of the given Ellipse.
	 *
	 * @since 1.0.0
	 *
	 * @param ellipse - The Ellipse to get the circumference of.
	 *
	 * @return The circumference of the Ellipse.
	 */
	public static function circumference(ellipse:Ellipse)
	{
		var rx = ellipse.width / 2;
		var ry = ellipse.height / 2;
		var h = Math.pow((rx - ry), 2) / Math.pow((rx + ry), 2);

		return (Math.PI * (rx + ry)) * (1 + ((3 * h) / (10 + Math.sqrt(4 - (3 * h)))));
	}

	/**
	 * Returns a Point object containing the coordinates of a point on the circumference of the Ellipse based on the given angle.
	 *
	 * @since 1.0.0
	 *
	 * @param ellipse - The Ellipse to get the circumference point on.
	 * @param angle - The angle from the center of the Ellipse to the circumference to return the point from. Given in radians.
	 * @param out - A Point, or point-like object, to store the results in. If not given a Point will be created.
	 *
	 * @return A Point object where the `x` and `y` properties are the point on the circumference.
	**/
	public static function circumferencePoint(ellipse:Ellipse, angle:Float, ?out:Point):Point
	{
		if (out == null)
		{
			out = new Point();
		}

		var halfWidth = ellipse.width / 2;
		var halfHeight = ellipse.height / 2;

		out.x = ellipse.x + halfWidth * Math.cos(angle);
		out.y = ellipse.y + halfHeight * Math.sin(angle);

		return out;
	}

	/**
	 * Returns a Point object containing the coordinates of a point on the circumference of the Ellipse based on the given angle.
	 *
	 * @since 1.0.0
	 *
	 * @generic {Phaser.Geom.Point} O - [out,$return]
	 *
	 * @param ellipse - The Ellipse to get the circumference point on.
	 * @param angle - The angle from the center of the Ellipse to the circumference to return the point from. Given in radians.
	 * @param out - A Point, or point-like object, to store the results in. If not given a Point will be created.
	 *
	 * @return A Point object where the `x` and `y` properties are the point on the circumference.
	**/
	public static function circumferencePointAny<T:Vector2Like>(ellipse:Ellipse,
			angle:Float, out:T):T
	{
		var halfWidth = ellipse.width / 2;
		var halfHeight = ellipse.height / 2;

		out.x = ellipse.x + halfWidth * Math.cos(angle);
		out.y = ellipse.y + halfHeight * Math.sin(angle);

		return out;
	}

	/**
	 * Creates a new Ellipse instance based on the values contained in the given source.
	 *
	 * @since 1.0.0
	 *
	 * @param source - The Ellipse to be cloned.
	 *
	 * @return A clone of the source Ellipse.
	**/
	public static function clone(source)
	{
		return new Ellipse(source.x, source.y, source.width, source.height);
	}

	/**
	 * Check to see if the Ellipse contains the given x / y coordinates.
	 *
	 * @since 1.0.0
	 *
	 * @param ellipse - The Ellipse to check.
	 * @param x - The x coordinate to check within the ellipse.
	 * @param y - The y coordinate to check within the ellipse.
	 *
	 * @return True if the coordinates are within the ellipse, otherwise false.
	**/
	public static function contains(ellipse:Ellipse, x:Float, y:Float)
	{
		if (ellipse.width <= 0 || ellipse.height <= 0)
		{
			return false;
		}

		//  Normalize the coords to an ellipse with center 0,0 and a radius of 0.5
		var normx = ((x - ellipse.x) / ellipse.width);
		var normy = ((y - ellipse.y) / ellipse.height);

		normx *= normx;
		normy *= normy;

		return (normx + normy < 0.25);
	}

	/**
	 * Check to see if the Ellipse contains the given Point object.
	 *
	 * @since 1.0.0
	 *
	 * @param ellipse - The Ellipse to check.
	 * @param point - The Point object to check if it's within the Circle or not.
	 *
	 * @return True if the Point coordinates are within the circle, otherwise false.
	 */
	public static function containsPoint(ellipse:Ellipse, point:Point)
	{
		return contains(ellipse, point.x, point.y);
	}

	/**
	 * Check to see if the Ellipse contains all four points of the given Rectangle object.
	 *
	 * @since 1.0.0
	 *
	 * @param ellipse - The Ellipse to check.
	 * @param rect - The Rectangle object to check if it's within the Ellipse or not.
	 *
	 * @return True if all of the Rectangle coordinates are within the ellipse, otherwise false.
	 */
	public static function containsRect(ellipse:Ellipse, rect:Rectangle):Bool
	{
		return (contains(ellipse, rect.x, rect.y)
			&& contains(ellipse, rect.right, rect.y)
			&& contains(ellipse, rect.x, rect.bottom)
			&& contains(ellipse, rect.right, rect.bottom));
	}

	/**
	 * Copies the `x`, `y`, `width` and `height` properties from the `source` Ellipse
	 * into the given `dest` Ellipse, then returns the `dest` Ellipse.
	 *
	 * @since 1.0.0
	 *
	 * @param source - The source Ellipse to copy the values from.
	 * @param dest - The destination Ellipse to copy the values to.
	 *
	 * @return The destination Ellipse.
	**/
	public static function CopyFrom(source:Ellipse, dest:Ellipse):Ellipse
	{
		return dest.setTo(source.x, source.y, source.width, source.height);
	}

	/**
	 * Compares the `x`, `y`, `width` and `height` properties of the two given Ellipses.
	 * Returns `true` if they all match, otherwise returns `false`.
	 *
	 * @since 1.0.0
	 *
	 * @param ellipse - The first Ellipse to compare.
	 * @param toCompare - The second Ellipse to compare.
	 *
	 * @return `true` if the two Ellipse equal each other, otherwise `false`.
	**/
	public static function Equals(ellipse:Ellipse, toCompare:Ellipse):Bool
	{
		return (ellipse.x == toCompare.x && ellipse.y == toCompare.y
			&& ellipse.width == toCompare.width && ellipse.height == toCompare.height);
	}

	/**
	 * Returns the bounds of the Ellipse object.
	 *
	 * @since 1.0.0
	 *
	 * @param ellipse - The Ellipse to get the bounds from.
	 * @param out - A Rectangle, or rectangle-like object, to store the ellipse bounds in. If not given a new Rectangle will be created.
	 *
	 * @return {(Phaser.Geom.Rectangle|object)} The Rectangle object containing the Ellipse bounds.
	 */
	public static function GetBounds(ellipse:Ellipse, ?out:Rectangle):Rectangle
	{
		if (out == null)
		{
			out = new Rectangle();
		}

		out.x = ellipse.left;
		out.y = ellipse.top;
		out.width = ellipse.width;
		out.height = ellipse.height;

		return out;
	}

	/**
	 * Returns a Point object containing the coordinates of a point on the circumference of the Ellipse
	 * based on the given angle normalized to the range 0 to 1. I.e. a value of 0.5 will give the point
	 * at 180 degrees around the circle.
	 *
	 * @since 1.0.0
	 *
	 * @param ellipse - The Ellipse to get the circumference point on.
	 * @param position - A value between 0 and 1, where 0 equals 0 degrees, 0.5 equals 180 degrees and 1 equals 360 around the ellipse.
	 * @param out - An Point to store the return values in. If not given a Point object will be created.
	 *
	 * @return A Point, or point-like object, containing the coordinates of the point around the ellipse.
	**/
	public static function GetPoint(ellipse:Ellipse, position:Float, ?out:Point)
	{
		if (out == null)
		{
			out = new Point();
		}

		var angle = MathUtility.fromPercent(position, 0, MathConst.PI2);

		return circumferencePoint(ellipse, angle, out);
	}

	/**
	 * Returns a Point object containing the coordinates of a point on the circumference of the Ellipse
	 * based on the given angle normalized to the range 0 to 1. I.e. a value of 0.5 will give the point
	 * at 180 degrees around the circle.
	 *
	 * @since 1.0.0
	 *
	 * @param ellipse - The Ellipse to get the circumference point on.
	 * @param position - A value between 0 and 1, where 0 equals 0 degrees, 0.5 equals 180 degrees and 1 equals 360 around the ellipse.
	 * @param out - An object to store the return values in.
	 *
	 * @return A Point, or point-like object, containing the coordinates of the point around the ellipse.
	**/
	public static inline function getPointAny<T:Vector2Like>(ellipse:Ellipse,
			position:Float, out:T):T
	{
		var angle = MathUtility.fromPercent(position, 0, MathConst.PI2);
		return circumferencePointAny(ellipse, angle, out);
	}

	/**
	 * Returns an array of Point objects containing the coordinates of the points around the circumference of the Ellipse,
	 * based on the given quantity or stepRate values.
	 *
	 * @since 1.0.0
	 *
	 * @param ellipse - The Ellipse to get the points from.
	 * @param quantity - The amount of points to return. If a falsey value the quantity will be derived from the `stepRate` instead.
	 * @param stepRate - Sets the quantity by getting the circumference of the ellipse and dividing it by the stepRate.
	 * @param out - An array to insert the points in to. If not provided a new array will be created.
	 *
	 * @return An array of Point objects pertaining to the points around the circumference of the ellipse.
	**/
	public static function getPoints(ellipse:Ellipse, quantity:Int, stepRate:Float = 0,
			?out:Array<Point>):Array<Point>
	{
		if (out == null)
		{
			out = [];
		}

		var quantityFloat:Float = quantity;

		if (quantity == 0)
		{
			quantityFloat = circumference(ellipse) / stepRate;
			quantity = Std.int(quantityFloat);
		}

		for (i in 0...quantity)
		{
			var angle = MathUtility.fromPercent(i / quantityFloat, 0, MathConst.PI2);

			out.push(circumferencePoint(ellipse, angle));
		}

		return out;
	}

	/**
	 * Offsets the Ellipse by the values given.
	 *
	 * @since 1.0.0
	 *
	 * @param ellipse - The Ellipse to be offset (translated.)
	 * @param x - The amount to horizontally offset the Ellipse by.
	 * @param y - The amount to vertically offset the Ellipse by.
	 *
	 * @return The Ellipse that was offset.
	**/
	public static function offset(ellipse:Ellipse, x:Float, y:Float)
	{
		ellipse.x += x;
		ellipse.y += y;

		return ellipse;
	}

	/**
	 * Offsets the Ellipse by the values given in the `x` and `y` properties of the Point object.
	 *
	 * @since 1.0.0
	 *
	 * @param ellipse - The Ellipse to be offset (translated.)
	 * @param point - The Point object containing the values to offset the Ellipse by.
	 *
	 * @return The Ellipse that was offset.
	**/
	public static function offsetPoint(ellipse:Ellipse, point:Point):Ellipse
	{
		ellipse.x += point.x;
		ellipse.y += point.y;

		return ellipse;
	}

	/**
	 * Returns a uniformly distributed random point from anywhere within the given Ellipse.
	 *
	 * @since 1.0.0
	 *
	 * @param ellipse - The Ellipse to get a random point from.
	 * @param out - A Point or point-like object to set the random `x` and `y` values in.
	 *
	 * @return A Point object with the random values set in the `x` and `y` properties.
	**/
	public static function random(ellipse:Ellipse, ?out:Point):Point
	{
		if (out == null)
		{
			out = new Point();
		}

		var p = Math.random() * Math.PI * 2;
		var s = Math.sqrt(Math.random());

		out.x = ellipse.x + ((s * Math.cos(p)) * ellipse.width / 2);
		out.y = ellipse.y + ((s * Math.sin(p)) * ellipse.height / 2);

		return out;
	}

	/**
	 * Returns a uniformly distributed random point from anywhere within the given Ellipse.
	 *
	 * @since 1.0.0
	 *
	 * @param ellipse - The Ellipse to get a random point from.
	 * @param out - A Point or point-like object to set the random `x` and `y` values in.
	 *
	 * @return A Point object with the random values set in the `x` and `y` properties.
	**/
	public static function randomAny<T:Vector2Like>(ellipse:Ellipse, out:T):T
	{
		var p = Math.random() * Math.PI * 2;
		var s = Math.sqrt(Math.random());

		out.x = ellipse.x + ((s * Math.cos(p)) * ellipse.width / 2);
		out.y = ellipse.y + ((s * Math.sin(p)) * ellipse.height / 2);

		return out;
	}
}
