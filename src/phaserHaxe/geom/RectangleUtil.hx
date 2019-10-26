package phaserHaxe.geom;

import phaserHaxe.math.Vector2Like;
import phaserHaxe.math.MathConst;
import phaserHaxe.math.MathUtility;

final class RectangleUtil
{
	/**
	 * Calculates the area of the given Rectangle object.
	 *
	 * @since 1.0.0
	 *
	 * @param rect - The rectangle to calculate the area of.
	 *
	 * @return The area of the Rectangle object.
	**/
	public static function area(rect:Rectangle):Float
	{
		return rect.width * rect.height;
	}

	/**
	 * Creates a new Rectangle or repositions and/or resizes an existing Rectangle so that it encompasses the two given Rectangles, i.e. calculates their union.
	 *
	 * @since 1.0.0
	 *
	 * @param rectA - The first Rectangle to use.
	 * @param rectB - The second Rectangle to use.
	 * @param out - The Rectangle to store the union in.
	 *
	 * @return The modified `out` Rectangle, or a new Rectangle if none was provided.
	**/
	public static function union(rectA:Rectangle, rectB:Rectangle, ?out:Rectangle)
	{
		if (out == null)
		{
			out = new Rectangle();
		}

		//  Cache vars so we can use one of the input rects as the output rect
		var x = Math.min(rectA.x, rectB.x);
		var y = Math.min(rectA.y, rectB.y);
		var w = Math.max(rectA.right, rectB.right) - x;
		var h = Math.max(rectA.bottom, rectB.bottom) - y;

		return out.setTo(x, y, w, h);
	}

	/**
	 * Rounds a Rectangle's position up to the smallest integer greater than or equal to each current coordinate.
	 *
	 * @since 1.0.0
	 *
	 * @param rect - The Rectangle to adjust.
	 *
	 * @return The adjusted Rectangle.
	**/
	public static function ceil(rect:Rectangle):Rectangle
	{
		rect.x = Math.ceil(rect.x);
		rect.y = Math.ceil(rect.y);

		return rect;
	}

	/**
	 * Rounds a Rectangle's position and size up to the smallest integer greater than or equal to each respective value.
	 *
	 * @since 1.0.0
	 *
	 * @param rect - The Rectangle to modify.
	 *
	 * @return The modified Rectangle.
	**/
	public static function ceilAll(rect:Rectangle):Rectangle
	{
		rect.x = Math.ceil(rect.x);
		rect.y = Math.ceil(rect.y);
		rect.width = Math.ceil(rect.width);
		rect.height = Math.ceil(rect.height);

		return rect;
	}

	/**
	 * Moves the top-left corner of a Rectangle so that its center is at the given coordinates.
	 *
	 * @since 1.0.0
	 *
	 * @param rect - The Rectangle to be centered.
	 * @param x - The X coordinate of the Rectangle's center.
	 * @param y - The Y coordinate of the Rectangle's center.
	 *
	 * @return The centered rectangle.
	**/
	public static function centerOn(rect:Rectangle, x:Float, y:Float):Rectangle
	{
		rect.x = x - (rect.width / 2);
		rect.y = y - (rect.height / 2);
		return rect;
	}

	/**
	 * Creates a new Rectangle which is identical to the given one.
	 *
	 * @since 1.0.0
	 *
	 * @param source - The Rectangle to clone.
	 *
	 * @return The newly created Rectangle, which is separate from the given one.
	**/
	public static function clone(source:Rectangle):Rectangle
	{
		return new Rectangle(source.x, source.y, source.width, source.height);
	}

	/**
		* Creates a new Rectangle which is identical to the given one.
		*
		* @since 1.0.0
		*
		* @param source - The Rectangle to clone.
		*s
		* @return The newly created Rectangle, which is separate from the given one.
	**/
	public static inline function inlineClone(source:Rectangle):Rectangle
	{
		return inline new Rectangle(source.x, source.y, source.width, source.height);
	}

	/**
	 * Checks if a given point is inside a Rectangle's bounds.
	 *
	 * @since 1.0.0
	 *
	 * @param rect - The Rectangle to check.
	 * @param x - The X coordinate of the point to check.
	 * @param y - The Y coordinate of the point to check.
	 *
	 * @return `true` if the point is within the Rectangle's bounds, otherwise `false`.
	**/
	public static function contains(rect:Rectangle, x:Float, y:Float):Bool
	{
		if (rect.width <= 0 || rect.height <= 0)
		{
			return false;
		}
		return (rect.x <= x && rect.x + rect.width >= x && rect.y <= y && rect.y + rect.height >= y);
	}

	/**
	 * Determines whether the specified point is contained within the rectangular region defined by this Rectangle object.
	 *
	 * @since 1.0.0
	 *
	 * @param rect - The Rectangle object.
	 * @param point - The point object to be checked. Can be a Phaser Point object or any object with x and y values.
	 *
	 * @return A value of true if the Rectangle object contains the specified point, otherwise false.
	**/
	public static inline function containsPoint<T:Vector2Like>(rect:Rectangle, point:T):Bool
	{
		return contains(rect, point.x, point.y);
	}

	/**
	 * Tests if one rectangle fully contains another.
	 *
	 * @since 1.0.0
	 *
	 * @param rectA - The first rectangle.
	 * @param rectB - The second rectangle.
	 *
	 * @return True only if rectA fully contains rectB.
	**/
	public static function containsRect(rectA:Rectangle, rectB:Rectangle):Bool
	{
		//  Volume check (if rectB volume > rectA then rectA cannot contain it)
		if ((rectB.width * rectB.height) > (rectA.width * rectA.height))
		{
			return false;
		}

		return ((rectB.x > rectA.x && rectB.x < rectA.right)
			&& (rectB.right > rectA.x && rectB.right < rectA.right)
			&& (rectB.y > rectA.y && rectB.y < rectA.bottom)
			&& (rectB.bottom > rectA.y && rectB.bottom < rectA.bottom));
	}

	/**
	 * Copy the values of one Rectangle to a destination Rectangle.
	 *
	 * @since 1.0.0
	 *
	 * @param source - The source Rectangle to copy the values from.
	 * @param dest - The destination Rectangle to copy the values to.
	 *
	 * @return The destination Rectangle.
	**/
	public static function copyFrom(source:Rectangle, dest:Rectangle):Rectangle
	{
		return dest.setTo(source.x, source.y, source.width, source.height);
	}

	/**
	 * Create an array of points for each corner of a Rectangle
	 * If an array is specified, each point object will be added to the end of the array, otherwise a new array will be created.
	 *
	 * @since 1.0.0
	 *
	 * @param rect - The Rectangle object to be decomposed.
	 * @param out - If provided, each point will be added to this array.
	 *
	 * @return Will return the array you specified or a new array containing the points of the Rectangle.
	**/
	public static function decompose(rect:Rectangle, ?out:Array<Point>):Array<Point>
	{
		if (out == null)
		{
			out = [];
		}

		out.push(new Point(rect.x, rect.y));
		out.push(new Point(rect.right, rect.y));
		out.push(new Point(rect.right, rect.bottom));
		out.push(new Point(rect.x, rect.bottom));

		return out;
	}

	/**
	 * Compares the `x`, `y`, `width` and `height` properties of two rectangles.
	 *
	 * @since 1.0.0
	 *
	 * @param rect - Rectangle A
	 * @param toCompare - Rectangle B
	 *
	 * @return true` if the rectangles' properties are an exact match, otherwise `false`.
	**/
	public static function equals(rect, toCompare)
	{
		return (rect.x == toCompare.x && rect.y == toCompare.y && rect.width == toCompare.width
			&& rect.height == toCompare.height);
	}

	/**
	 * Adjusts the target rectangle, changing its width, height and position,
	 * so that it fits inside the area of the source rectangle, while maintaining its original
	 * aspect ratio.
	 *
	 * Unlike the `FitOutside` function, there may be some space inside the source area not covered.
	 *
	 * @since 1.0.0
	 *
	 * @param target - The target rectangle to adjust.
	 * @param source - The source rectangle to envlope the target in.
	 *
	 * @return The modified target rectangle instance.
	**/
	public static function fitInside(target:Rectangle, source:Rectangle):Rectangle
	{
		var ratio = getAspectRatio(target);

		if (ratio < getAspectRatio(source))
		{
			//  Taller than Wide
			target.setSize(source.height * ratio, source.height);
		}
		else
		{
			//  Wider than Tall
			target.setSize(source.width, source.width / ratio);
		}

		return target.setPosition(source.centerX - (target.width / 2), source.centerY - (target.height / 2));
	}

	/**
	 * Adjusts the target rectangle, changing its width, height and position,
	 * so that it fully covers the area of the source rectangle, while maintaining its original
	 * aspect ratio.
	 *
	 * Unlike the `FitInside` function, the target rectangle may extend further out than the source.
	 *
	 * @function Phaser.Geom.Rectangle.FitOutside
	 * @since 3.0.0
	 *
	 * @generic {Phaser.Geom.Rectangle} O - [target,$return]
	 *
	 * @param target - The target rectangle to adjust.
	 * @param source - The source rectangle to envlope the target in.
	 *
	 * @return The modified target rectangle instance.
	**/
	public static function fitOutside(target:Rectangle, source:Rectangle)
	{
		var ratio = getAspectRatio(target);

		if (ratio > getAspectRatio(source))
		{
			//  Wider than Tall
			target.setSize(source.height * ratio, source.height);
		}
		else
		{
			//  Taller than Wide
			target.setSize(source.width, source.width / ratio);
		}

		return target.setPosition(source.centerX - target.width / 2, source.centerY - target.height / 2);
	}

	/**
	 * Rounds down (floors) the top left X and Y co-ordinates of the given Rectangle to the largest integer less than or equal to them
	 *
	 * @function Phaser.Geom.Rectangle.Floor
	 * @since 3.0.0
	 *
	 * @generic {Phaser.Geom.Rectangle} O - [rect,$return]
	 *
	 * @param {Phaser.Geom.Rectangle} rect - The rectangle to floor the top left X and Y co-ordinates of
	 *
	 * @return {Phaser.Geom.Rectangle} The rectangle that was passed to this function with its co-ordinates floored.
	 */
	public static function floor(rect)
	{
		rect.x = Math.floor(rect.x);
		rect.y = Math.floor(rect.y);
		return rect;
	}

	/**
	 * Rounds a Rectangle's position and size down to the largest integer less than or equal to each current coordinate or dimension.
	 *
	 * @function Phaser.Geom.Rectangle.FloorAll
	 * @since 3.0.0
	 *
	 * @generic {Phaser.Geom.Rectangle} O - [rect,$return]
	 *
	 * @param {Phaser.Geom.Rectangle} rect - The Rectangle to adjust.
	 *
	 * @return {Phaser.Geom.Rectangle} The adjusted Rectangle.
	 */
	public static function floorAll(rect)
	{
		rect.x = Math.floor(rect.x);
		rect.y = Math.floor(rect.y);
		rect.width = Math.floor(rect.width);
		rect.height = Math.floor(rect.height);
		return rect;
	}

	/**
	 * Constructs new Rectangle or repositions and resizes an existing Rectangle so that all of the given points are on or within its bounds.
	 *
	 * @function Phaser.Geom.Rectangle.FromPoints
	 * @since 3.0.0
	 *
	 * @generic {Phaser.Geom.Rectangle} O - [out,$return]
	 *
	 * @param {array} points - An array of points (either arrays with two elements corresponding to the X and Y coordinate or an object with public `x` and `y` properties) which should be surrounded by the Rectangle.
	 * @param {Phaser.Geom.Rectangle} [out] - Optional Rectangle to adjust.
	 *
	 * @return {Phaser.Geom.Rectangle} The adjusted `out` Rectangle, or a new Rectangle if none was provided.
	**/
	public static function fromPoints(points:Array<Point>, out)
	{
		if (out == null)
		{
			out = new Rectangle();
		}
		if (points.length == 0)
		{
			return out;
		}

		var minX = MathConst.FLOAT_MAX;
		var minY = MathConst.FLOAT_MAX;
		var maxX = MathConst.FLOAT_MIN_SAFE_INTEGER;
		var maxY = MathConst.FLOAT_MIN_SAFE_INTEGER;

		var p;
		var px;
		var py;

		for (i in 0...points.length)
		{
			p = points[i];

			px = p.x;
			py = p.y;

			minX = Math.min(minX, px);
			minY = Math.min(minY, py);
			maxX = Math.max(maxX, px);
			maxY = Math.max(maxY, py);
		}
		out.x = minX;
		out.y = minY;
		out.width = maxX - minX;
		out.height = maxY - minY;
		return out;
	}

	/**
	 * Calculates the width/height ratio of a rectangle.
	 *
	 * @function Phaser.Geom.Rectangle.GetAspectRatio
	 * @since 3.0.0
	 *
	 * @param {Phaser.Geom.Rectangle} rect - The rectangle.
	 *
	 * @return {number} The width/height ratio of the rectangle.
	**/
	public static function getAspectRatio(rect:Rectangle):Float
	{
		return (rect.height == 0) ? Math.NaN : rect.width / rect.height;
	}

	/**
	 * Returns the center of a Rectangle as a Point.
	 *
	 * @function Phaser.Geom.Rectangle.GetCenter
	 * @since 3.0.0
	 *
	 * @generic {Phaser.Geom.Point} O - [out,$return]
	 *
	 * @param {Phaser.Geom.Rectangle} rect - The Rectangle to get the center of.
	 * @param {(Phaser.Geom.Point|object)} [out] - Optional point-like object to update with the center coordinates.
	 *
	 * @return {(Phaser.Geom.Point|object)} The modified `out` object, or a new Point if none was provided.
	**/
	public static function getCenter(rect, out)
	{
		if (out == null)
		{
			out = new Point();
		}
		out.x = rect.centerX;
		out.y = rect.centerY;
		return out;
	}

	/**
	 * Position is a value between 0 and 1 where 0 = the top-left of the rectangle and 0.5 = the bottom right.
	 *
	 * @since 1.0.0
	 *
	 * @param rectangle - [description]
	 * @param position - [description]
	 * @param out - [description]
	 *
	 * @return [description]
	**/
	public static function getPoint(rectangle:Rectangle, position:Float, ?out:Point)
	{
		if (out == null)
		{
			out = new Point();
		}
		if (position <= 0 || position >= 1)
		{
			out.x = rectangle.x;
			out.y = rectangle.y;
			return out;
		}
		var p = Perimeter(rectangle) * position;
		if (position > 0.5)
		{
			p -= (rectangle.width + rectangle.height);
			if (p <= rectangle.width)
			{
				//  Face 3
				out.x = rectangle.right - p;
				out.y = rectangle.bottom;
			}
			else
			{
				//  Face 4
				out.x = rectangle.x;
				out.y = rectangle.bottom - (p - rectangle.width);
			}
		}
		else if (p <= rectangle.width)
		{
			//  Face 1
			out.x = rectangle.x + p;
			out.y = rectangle.y;
		}
		else
		{
			//  Face 2
			out.x = rectangle.right;
			out.y = rectangle.y + (p - rectangle.width);
		}
		return out;
	}

	/**
	 * Return an array of points from the perimeter of the rectangle, each spaced out based on the quantity or step required.
	 *
	 * @since 1.0.0
	 *
	 * @param rectangle - The Rectangle object to get the points from.
	 * @param step - Step between points. Used to calculate the number of points to return when quantity is falsy. Ignored if quantity is positive.
	 * @param quantity - The number of evenly spaced points from the rectangles perimeter to return. If falsy, step param will be used to calculate the number of points.
	 * @param out - An optional array to store the points in.
	 *
	 * @return An array of Points from the perimeter of the rectangle.
	**/
	public static function getPoints(rectangle:Rectangle, quantity:Int, stepRate:Float, ?out:Array<Point>)
	{
		if (out == null)
		{
			out = [];
		}

		var quantityFloat:Float = quantity;

		//  If quantity is a falsey value (false, null, 0, undefined, etc) then we calculate it based on the stepRate instead.
		if (quantity < 0)
		{
			quantityFloat = Perimeter(rectangle) / stepRate;
			quantity = Std.int(quantityFloat);
		}

		for (i in 0...quantity)
		{
			var position = i / quantityFloat;

			out.push(getPoint(rectangle, position));
		}

		return out;
	}

	/**
	 * [description]
	 *
	 * @since 1.0.0
	 *
	 *
	 * @param rect - [description]
	 * @param out - [description]
	 *
	 * @return [description]
	**/
	public static function getSize(rect:Rectangle, out:Point):Point
	{
		if (out == null)
		{
			out = new Point();
		}
		out.x = rect.width;
		out.y = rect.height;
		return out;
	}

	/**
	 * Increases the size of a Rectangle by a specified amount.
	 *
	 * The center of the Rectangle stays the same.
	 * The amounts are added to each side, so the actual increase in
	 * width or height is two times bigger than the respective argument.
	 *
	 * @since 1.0.0
	 *
	 * @param rect - The Rectangle to inflate.
	 * @param x - How many pixels the left and the right side should be moved by horizontally.
	 * @param y - How many pixels the top and the bottom side should be moved by vertically.
	 *
	 * @return The inflated Rectangle.
	**/
	public static function inflate(rect:Rectangle, x:Float, y:Float):Rectangle
	{
		var cx = rect.centerX;
		var cy = rect.centerY;

		rect.setSize(rect.width + (x * 2), rect.height + (y * 2));

		return centerOn(rect, cx, cy);
	}

	/**
	 * Takes two Rectangles and first checks to see if they intersect.
	 * If they intersect it will return the area of intersection in the `out` Rectangle.
	 * If they do not intersect, the `out` Rectangle will have a width and height of zero.
	 *
	 * @since 1.0.0
	 *
	 * @param rectA - The first Rectangle to get the intersection from.
	 * @param rectB - The second Rectangle to get the intersection from.
	 * @param out - A Rectangle to store the intersection results in.
	 *
	 * @return The intersection result. If the width and height are zero, no intersection occurred.
	**/
	public static function intersection(rectA:Rectangle, rectB:Rectangle, ?out:Rectangle)
	{
		if (out == null)
		{
			out = new Rectangle();
		}

		if (Intersects.RectangleToRectangle(rectA, rectB))
		{
			out.x = Math.max(rectA.x, rectB.x);
			out.y = Math.max(rectA.y, rectB.y);
			out.width = Math.min(rectA.right, rectB.right) - out.x;
			out.height = Math.min(rectA.bottom, rectB.bottom) - out.y;
		}
		else
		{
			out.setEmpty();
		}

		return out;
	}

	/**
	 * [description]
	 *
	 * @since 1.0.0
	 *
	 *
	 * @param rect - [description]
	 * @param step - [description]
	 * @param quantity - [description]
	 * @param out - [description]
	 *
	 * @return [description]
	**/
	public static function MarchingAnts(rect:Rectangle, step:Float, quantity:Int = 0, ?out:Array<Point>):Array<Point>
	{
		if (out == null)
		{
			out = [];
		}
		if (step == 0 && quantity == 0)
		{
			//  Bail out
			return out;
		}
		//  If step is a falsey value (false, null, 0, undefined, etc) then we calculate
		//  it based on the quantity instead, otherwise we always use the step value
		if (step == 0)
		{
			step = Perimeter(rect) / quantity;
		}
		else
		{
			quantity = Math.round(Perimeter(rect) / step);
		}

		var x = rect.x;
		var y = rect.y;
		var face = 0;
		//  Loop across each face of the rectangle
		for (i in 0...quantity)
		{
			out.push(new Point(x, y));
			switch (face)
			{
				//  Top face
				case 0:
					x += step;
					if (x >= rect.right)
					{
						face = 1;
						y += (x - rect.right);
						x = rect.right;
					}
					break;
				//  Right face
				case 1:
					y += step;
					if (y >= rect.bottom)
					{
						face = 2;
						x -= (y - rect.bottom);
						y = rect.bottom;
					}
					break;
				//  Bottom face
				case 2:
					x -= step;
					if (x <= rect.left)
					{
						face = 3;
						y -= (rect.left - x);
						x = rect.left;
					}
					break;
				//  Left face
				case 3:
					y -= step;
					if (y <= rect.top)
					{
						face = 0;
						y = rect.top;
					}
					break;
			}
		}
		return out;
	}

	/**
	 * Merges a Rectangle with a list of points by repositioning and/or resizing it such that all points are located on or within its bounds.
	 *
	 * @since 1.0.0
	 *
	 * @param target - The Rectangle which should be merged.
	 * @param points - An array of Points (or any object with public `x` and `y` properties) which should be merged with the Rectangle.
	 *
	 * @return The modified Rectangle.
	**/
	public static function MergePoints(target:Rectangle, points:Array<Point>)
	{
		var minX = target.x;
		var maxX = target.right;
		var minY = target.y;
		var maxY = target.bottom;
		for (i in 0...points.length)
		{
			minX = Math.min(minX, points[i].x);
			maxX = Math.max(maxX, points[i].x);
			minY = Math.min(minY, points[i].y);
			maxY = Math.max(maxY, points[i].y);
		}
		target.x = minX;
		target.y = minY;
		target.width = maxX - minX;
		target.height = maxY - minY;
		return target;
	}

	/**
	 * Merges the source rectangle into the target rectangle and returns the target.
	 * Neither rectangle should have a negative width or height.
	 *
	 * @since 1.0.0
	 *
	 * @param target - Target rectangle. Will be modified to include source rectangle.
	 * @param source - Rectangle that will be merged into target rectangle.
	 *
	 * @return Modified target rectangle that contains source rectangle.
	**/
	public static function MergeRect(target:Rectangle, source:Rectangle):Rectangle
	{
		var minX = Math.min(target.x, source.x);
		var maxX = Math.max(target.right, source.right);

		target.x = minX;
		target.width = maxX - minX;

		var minY = Math.min(target.y, source.y);
		var maxY = Math.max(target.bottom, source.bottom);

		target.y = minY;
		target.height = maxY - minY;

		return target;
	}

	/**
	 * Merges a Rectangle with a point by repositioning and/or resizing it so that the point is on or within its bounds.
	 *
	 * @since 1.0.0
	 *
	 * @param target - The Rectangle which should be merged and modified.
	 * @param x - The X coordinate of the point which should be merged.
	 * @param y - The Y coordinate of the point which should be merged.
	 *
	 * @return The modified `target` Rectangle.
	**/
	public static function MergeXY(target:Rectangle, x:Float, y:Float):Rectangle
	{
		var minX = Math.min(target.x, x);
		var maxX = Math.max(target.right, x);
		target.x = minX;
		target.width = maxX - minX;
		var minY = Math.min(target.y, y);
		var maxY = Math.max(target.bottom, y);
		target.y = minY;
		target.height = maxY - minY;
		return target;
	}

	/**
	 * Nudges (translates) the top left corner of a Rectangle by a given offset.
	 *
	 * @since 1.0.0
	 *
	 * @param rect - The Rectangle to adjust.
	 * @param x - The distance to move the Rectangle horizontally.
	 * @param y - The distance to move the Rectangle vertically.
	 *
	 * @return The adjusted Rectangle.
	**/
	public static function Offset(rect:Rectangle, x:Float, y:Float):Rectangle
	{
		rect.x += x;
		rect.y += y;

		return rect;
	}

	/**
	 * Nudges (translates) the top-left corner of a Rectangle by the coordinates of a point (translation vector).
	 *
	 * @since 1.0.0
	 *
	 * @param rect - The Rectangle to adjust.
	 * @param point - The point whose coordinates should be used as an offset.
	 *
	 * @return The adjusted Rectangle.
	**/
	public static function OffsetPoint(rect:Rectangle, point:Point):Rectangle
	{
		rect.x += point.x;
		rect.y += point.y;
		return rect;
	}

	/**
	 * Checks if two Rectangles overlap. If a Rectangle is within another Rectangle, the two will be considered overlapping. Thus, the Rectangles are treated as "solid".
	 *
	 * @since 1.0.0
	 *
	 * @param rectA - The first Rectangle to check.
	 * @param rectB - The second Rectangle to check.
	 *
	 * @return`true` if the two Rectangles overlap, `false` otherwise.
	**/
	public static function Overlaps(rectA:Rectangle, rectB:Rectangle):Bool
	{
		return
			(rectA.x < rectB.right && rectA.right > rectB.x && rectA.y < rectB.bottom && rectA.bottom > rectB.y);
	}

	/**
	 * Calculates the perimeter of a Rectangle.
	 *
	 * @since 1.0.0
	 *
	 * @param rect - The Rectangle to use.
	 *
	 * @return The perimeter of the Rectangle, equal to `(width * 2) + (height * 2)`.
	**/
	public static function Perimeter(rect:Rectangle):Float
	{
		return 2 * (rect.width + rect.height);
	}

	/**
	 * [description]
	 *
	 * @since 1.0.0
	 *
	 * @param rectangle - [description]
	 * @param angle - [description]
	 * @param out - [description]
	 *
	 * @return [description]
	**/
	public static function PerimeterPoint(rectangle:Rectangle, angle:Int, ?out:Point):Point
	{
		if (out == null)
		{
			out = new Point();
		}
		var angle = MathUtility.degToRad(angle);
		var s = Math.sin(angle);
		var c = Math.cos(angle);
		var dx = (c > 0) ? rectangle.width / 2 : rectangle.width / -2;
		var dy = (s > 0) ? rectangle.height / 2 : rectangle.height / -2;
		if (Math.abs(dx * s) < Math.abs(dy * c))
		{
			dy = (dx * s) / c;
		}
		else
		{
			dx = (dy * c) / s;
		}
		out.x = dx + rectangle.centerX;
		out.y = dy + rectangle.centerY;
		return out;
	}

	/**
	 * Returns a random point within a Rectangle.
	 *
	 * @since 1.0.0
	 *
	 * @param rect - The Rectangle to return a point from.
	 * @param out - The object to update with the point's coordinates.
	 *
	 * @return The modified `out` object, or a new Point if none was provided.
	**/
	public static function Random(rect:Rectangle, ?out:Point):Point
	{
		if (out == null)
		{
			out = new Point();
		}
		out.x = rect.x + (Math.random() * rect.width);
		out.y = rect.y + (Math.random() * rect.height);
		return out;
	}

	/**
	 * Returns a random point within a Rectangle.
	 *
	 * @since 1.0.0
	 *
	 * @param rect - The Rectangle to return a point from.
	 * @param out - The object to update with the point's coordinates.
	 *
	 * @return The modified `out` object, or a new Point if none was provided.
	**/
	public static inline function RandomAny<T:Vector2Like>(rect:Rectangle, out:T):T
	{
		out.x = rect.x + (Math.random() * rect.width);
		out.y = rect.y + (Math.random() * rect.height);
		return out;
	}

	/**
	 * Calculates a random point that lies within the `outer` Rectangle, but outside of the `inner` Rectangle.
	 * The inner Rectangle must be fully contained within the outer rectangle.
	 *
	 * @since 1.0.0
	 *
	 * @param outer - The outer Rectangle to get the random point within.
	 * @param inner - The inner Rectangle to exclude from the returned point.
	 * @param out - A Point, or Point-like object to store the result in. If not specified, a new Point will be created.
	 *
	 * @return A Point object containing the random values in its `x` and `y` properties.
	**/
	public static function RandomOutside(outer:Rectangle, inner:Rectangle, ?out:Point):Point
	{
		if (out == null)
		{
			out = new Point();
		}
		if (containsRect(outer, inner))
		{
			//  Pick a random quadrant
			//
			//  The quadrants don't extend the full widths / heights of the outer rect to give
			//  us a better uniformed distribution, otherwise you get clumping in the corners where
			//  the 4 quads would overlap
			switch (MathUtility.between(0, 3))
			{
				case 0: // Top
					out.x = outer.x + (Math.random() * (inner.right - outer.x));
					out.y = outer.y + (Math.random() * (inner.top - outer.y));
				case 1: // Bottom
					out.x = inner.x + (Math.random() * (outer.right - inner.x));
					out.y = inner.bottom + (Math.random() * (outer.bottom - inner.bottom));
				case 2: // Left
					out.x = outer.x + (Math.random() * (inner.x - outer.x));
					out.y = inner.y + (Math.random() * (outer.bottom - inner.y));
				case 3: // Right
					out.x = inner.right + (Math.random() * (outer.right - inner.right));
					out.y = outer.y + (Math.random() * (inner.bottom - outer.y));
			}
		}
		return out;
	}

	/**
	 * Determines if the two objects (either Rectangles or Rectangle-like)
	 * have the same width and height values under strict equality.
	 *
	 * @since 1.0.0
	 *
	 * @param rect - The first Rectangle object.
	 * @param toCompare - The second Rectangle object.
	 *
	 * @return`true` if the objects have equivalent values for the `width` and `height` properties, otherwise `false`.
	**/
	public static function SameDimensions(rect:Rectangle, toCompare:Rectangle):Bool
	{
		return (rect.width == toCompare.width && rect.height == toCompare.height);
	}

	/**
	 * Scales the width and height of this Rectangle by the given amounts.
	 *
	 * @since 1.0.0
	 *
	 * @param rect - The `Rectangle` object that will be scaled by the specified amount(s).
	 * @param x - The factor by which to scale the rectangle horizontally.
	 * @param y - The amount by which to scale the rectangle vertically. If this is not specified, the rectangle will be scaled by the factor `x` in both directions.
	 *
	 * @return The rectangle object with updated `width` and `height` properties as calculated from the scaling factor(s).
	**/
	public static function Scale(rect:Rectangle, x:Float, ?y:Float):Rectangle
	{
		rect.width *= x;

		if (y == null)
		{
			rect.height *= x;
		}
		else
		{
			rect.height *= y;
		}
		return rect;
	}
}
