package phaserHaxe.geom;

import phaserHaxe.math.MathUtility;
import phaserHaxe.math.Vector2Like;
import phaserHaxe.math.MathConst;

class LineUtil
{
	/**
	 * Calculate the angle of the line in radians.
	 *
	 * @since 1.0.0
	 *
	 * @param line - The line to calculate the angle of.
	 *
	 * @return the angle of the line, in radians.
	**/
	public static function Angle(line:Line):Float
	{
		return Math.atan2(line.y2 - line.y1, line.x2 - line.x1);
	}

	/**
	 * Using Bresenham's line algorithm this will return an array of all coordinates on this line.
	 *
	 * The `start` and `end` points are rounded before this runs as the algorithm works on integers.
	 *
	 * @since 1.0.0
	 *
	 * @param line - The line.
	 * @param stepRate - The optional step rate for the points on the line.
	 * @param results - An optional array of points to push the resulting coordinates into.
	 *
	 * @return The array of coordinates on the line.
	**/
	public static function BresenhamPoints(line:Line, stepRate:Float = 1, ?results:Array<Point>):Array<Point>
	{
		if (results == null)
		{
			results = [];
		}

		var x1 = Math.round(line.x1);
		var y1 = Math.round(line.y1);
		var x2 = Math.round(line.x2);
		var y2 = Math.round(line.y2);
		var dx = Std.int(Math.abs(x2 - x1));
		var dy = Std.int(Math.abs(y2 - y1));
		var sx = (x1 < x2) ? 1 : -1;
		var sy = (y1 < y2) ? 1 : -1;
		var err = dx - dy;
		results.push({x: x1, y: y1});
		var i = 1;
		while (!((x1 == x2) && (y1 == y2)))
		{
			var e2 = err << 1;
			if (e2 > -dy)
			{
				err -= dy;
				x1 += sx;
			}
			if (e2 < dx)
			{
				err += dx;
				y1 += sy;
			}
			if (i % stepRate == 0)
			{
				results.push({x: x1, y: y1});
			}
			i++;
		}
		return results;
	}

	/**
	 * Center a line on the given coordinates.
	 *
	 * @since 1.0.0
	 *
	 * @param line - The line to center.
	 * @param x - The horizontal coordinate to center the line on.
	 * @param y - The vertical coordinate to center the line on.
	 *
	 * @return The centered line.
	**/
	public static function CenterOn(line:Line, x:Float, y:Float):Line
	{
		var tx = x - ((line.x1 + line.x2) / 2);
		var ty = y - ((line.y1 + line.y2) / 2);
		line.x1 += tx;
		line.y1 += ty;
		line.x2 += tx;
		line.y2 += ty;
		return line;
	}

	/**
	 * Clone the given line.
	 *
	 * @since 1.0.0
	 *
	 * @param source - The source line to clone.
	 *
	 * @return The cloned line.
	**/
	public static function Clone(source:Line):Line
	{
		return new Line(source.x1, source.y1, source.x2, source.y2);
	}

	/**
	 * inline Clone the given line.
	 *
	 * @since 1.0.0
	 *
	 * @param source - The source line to clone.
	 *
	 * @return The cloned line.
	**/
	public static inline function InlineClone(source:Line):Line
	{
		return inline new Line(source.x1, source.y1, source.x2, source.y2);
	}

	/**
	 * Copy the values of one line to a destination line.
	 *
	 * @since 1.0.0
	 *
	 * @param source - The source line to copy the values from.
	 * @param dest - The destination line to copy the values to.
	 *
	 * @return {Phaser.Geom.Line} The destination line.
	**/
	public static function CopyFrom(source:Line, dest:Line):Line
	{
		return dest.setTo(source.x1, source.y1, source.x2, source.y2);
	}

	/**
	 * Compare two lines for strict equality.
	 *
	 * @since 1.0.0
	 *
	 * @param line - The first line to compare.
	 * @param toCompare - The second line to compare.
	 *
	 * @return Whether the two lines are equal.
	**/
	public static function Equals(line:Line, toCompare:Line):Bool
	{
		return
			(line.x1 == toCompare.x1 && line.y1 == toCompare.y1 && line.x2 == toCompare.x2 && line.y2 == toCompare.y2);
	}

	/**
	 * Extends the start and end points of a Line by the given amounts.
	 *
	 * The amounts can be positive or negative. Positive points will increase the length of the line,
	 * while negative ones will decrease it.
	 *
	 * If no `right` value is provided it will extend the length of the line equally in both directions.
	 *
	 * Pass a value of zero to leave the start or end point unchanged.
	 *
	 * @since 1.0.0
	 *
	 * @param line - The line instance to extend.
	 * @param left - The amount to extend the start of the line by.
	 * @param right - The amount to extend the end of the line by. If not given it will be set to the `left` value.
	 *
	 * @return The modified Line instance.
	**/
	public static function Extend(line:Line, left:Float, ?right:Float)
	{
		var right:Float = right != null ? right : left;

		var length = Length(line);
		var slopX = line.x2 - line.x1;
		var slopY = line.y2 - line.y1;
		if (left != 0)
		{
			line.x1 = line.x1 - slopX / length * left;
			line.y1 = line.y1 - slopY / length * left;
		}
		if (right != 0)
		{
			line.x2 = line.x2 + slopX / length * right;
			line.y2 = line.y2 + slopY / length * right;
		}
		return line;
	}

	/**
	 * Get the midpoint of the given line.
	 *
	 * @since 1.0.0
	 *
	 * @param line - The line to get the midpoint of.
	 * @param out - An optional point object to store the midpoint in.
	 *
	 * @return The midpoint of the Line.
	**/
	public static function GetMidPoint(line:Line, ?out:Point)
	{
		if (out == null)
		{
			out = new Point();
		}
		out.x = (line.x1 + line.x2) / 2;
		out.y = (line.y1 + line.y2) / 2;
		return out;
	}

	/**
	 * Get the midpoint of the given line.
	 *
	 * @since 1.0.0
	 *
	 * @param line - The line to get the midpoint of.
	 * @param out - An optional point object to store the midpoint in.
	 *
	 * @return The midpoint of the Line.
	**/
	public static inline function GetMidPointAny<T:Vector2Like>(line:Line, out:T):T
	{
		out.x = (line.x1 + line.x2) / 2;
		out.y = (line.y1 + line.y2) / 2;
		return out;
	}

	/**
	 * Get the nearest point on a line perpendicular to the given point.
	 *
	 * @since 1.0.0
	 *
	 * @param line - The line to get the nearest point on.
	 * @param point - The point to get the nearest point to.
	 * @param out - An optional point to store the coordinates of the nearest point on the line.
	 *
	 * @return The nearest point on the line.
	**/
	public static function GetNearestPoint(line:Line, point:Point, ?out:Point):Point
	{
		if (out == null)
		{
			out = new Point();
		}
		var x1 = line.x1;
		var y1 = line.y1;
		var x2 = line.x2;
		var y2 = line.y2;
		var L2 = (((x2 - x1) * (x2 - x1)) + ((y2 - y1) * (y2 - y1)));
		if (L2 == 0)
		{
			return out;
		}
		var r = (((point.x - x1) * (x2 - x1)) + ((point.y - y1) * (y2 - y1))) / L2;
		out.x = x1 + (r * (x2 - x1));
		out.y = y1 + (r * (y2 - y1));
		return out;
	}

	/**
	 * Get the nearest point on a line perpendicular to the given point.
	 *
	 * @since 1.0.0
	 *
	 * @param line - The line to get the nearest point on.
	 * @param point - The point to get the nearest point to.
	 * @param out - an point-like object to store the coordinates of the nearest point on the line.
	 *
	 * @return The nearest point on the line.
	**/
	public static function GetNearestPointAny<T:Vector2Like>(line:Line, point:Point, out:T):T
	{
		var x1 = line.x1;
		var y1 = line.y1;
		var x2 = line.x2;
		var y2 = line.y2;
		var L2 = (((x2 - x1) * (x2 - x1)) + ((y2 - y1) * (y2 - y1)));
		if (L2 == 0)
		{
			return out;
		}
		var r = (((point.x - x1) * (x2 - x1)) + ((point.y - y1) * (y2 - y1))) / L2;
		out.x = x1 + (r * (x2 - x1));
		out.y = y1 + (r * (y2 - y1));
		return out;
	}

	/**
	 * Calculate the normal of the given line.
	 *
	 * The normal of a line is a vector that points perpendicular from it.
	 *
	 * @since 1.0.0
	 *
	 * @param line - The line to calculate the normal of.
	 * @param out - An optional point object to store the normal in.
	 *
	 * @return The normal of the Line.
	**/
	public static function GetNormal(line:Line, ?out:Point):Point
	{
		if (out == null)
		{
			out = new Point();
		}
		var a = Angle(line) - MathConst.TAU;
		out.x = Math.cos(a);
		out.y = Math.sin(a);
		return out;
	}

	/**
	 * Calculate the normal of the given line.
	 *
	 * The normal of a line is a vector that points perpendicular from it.
	 *
	 * @since 1.0.0
	 *
	 * @param line - The line to calculate the normal of.
	 * @param out - An optional point object to store the normal in.
	 *
	 * @return The normal of the Line.
	**/
	public static inline function GetNormalAny<T:Vector2Like>(line:Line, out:T):T
	{
		var a = Angle(line) - MathConst.TAU;
		out.x = Math.cos(a);
		out.y = Math.sin(a);
		return out;
	}

	/**
	 * Get a point on a line that's a given percentage along its length.
	 *
	 * @since 1.0.0
	 *
	 * @param line - The line.
	 * @param position - A value between 0 and 1, where 0 is the start, 0.5 is the middle and 1 is the end of the line.
	 * @param out - An optional point, or point-like object, to store the coordinates of the point on the line.
	 *
	 * @return The point on the line.
	**/
	public static function GetPoint(line:Line, position:Float, ?out:Point):Point
	{
		if (out == null)
		{
			out = new Point();
		}
		out.x = line.x1 + (line.x2 - line.x1) * position;
		out.y = line.y1 + (line.y2 - line.y1) * position;
		return out;
	}

	/**
	 * Get a point on a line that's a given percentage along its length.
	 *
	 * @since 1.0.0
	 *
	 * @param line - The line.
	 * @param position - A value between 0 and 1, where 0 is the start, 0.5 is the middle and 1 is the end of the line.
	 * @param out - An optional point, or point-like object, to store the coordinates of the point on the line.
	 *
	 * @return The point on the line.
	**/
	public static inline function GetPointAny<T:Vector2Like>(line:Line, position:Float, out:T):T
	{
		out.x = line.x1 + (line.x2 - line.x1) * position;
		out.y = line.y1 + (line.y2 - line.y1) * position;
		return out;
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
	 * @param line - The line.
	 * @param quantity - The number of points to place on the line. Set to `0` to use `stepRate` instead.
	 * @param stepRate - The distance between each point on the line. When set, `quantity` is implied and should be set to `0`.
	 * @param out - An optional array of Points to store the coordinates of the points on the line.
	 *
	 * @return An array of Points containing the coordinates of the points on the line.
	**/
	public static function GetPoints(line:Line, quantity:Int, stepRate:Float = 0, ?out:Array<Point>):Array<Point>
	{
		if (out == null)
		{
			out = [];
		}

		var quantityFloat:Float = quantity;

		// If quantity is a 0 then we calculate it based on the stepRate instead.
		if (quantity == 0)
		{
			quantityFloat = Length(line) / stepRate;
			quantity = Std.int(quantityFloat);
		}
		var x1 = line.x1;
		var y1 = line.y1;
		var x2 = line.x2;
		var y2 = line.y2;
		for (i in 0...quantity)
		{
			var position = i / quantityFloat;
			var x = x1 + (x2 - x1) * position;
			var y = y1 + (y2 - y1) * position;
			out.push(new Point(x, y));
		}
		return out;
	}

	/**
	 * Get the shortest distance from a Line to the given Point.
	 *
	 * @since 1.0.0
	 *
	 * @generic {Phaser.Geom.Point} O - [out,$return]
	 *
	 * @param line - The line to get the distance from.
	 * @param point - The point to get the shortest distance to.
	 *
	 * @return The shortest distance from the line to the point.
	**/
	public static function GetShortestDistance(line:Line, point:Point):Float
	{
		var x1 = line.x1;
		var y1 = line.y1;
		var x2 = line.x2;
		var y2 = line.y2;
		var L2 = (((x2 - x1) * (x2 - x1)) + ((y2 - y1) * (y2 - y1)));
		if (L2 == 0)
		{
			return Math.NaN;
		}
		var s = (((y1 - point.y) * (x2 - x1)) - ((x1 - point.x) * (y2 - y1))) / L2;
		return Math.abs(s) * Math.sqrt(L2);
	}

	/**
	 * Get the shortest distance from a Line to the given Point.
	 *
	 * @since 1.0.0
	 *
	 * @param line - The line to get the distance from.
	 * @param point - The point to get the shortest distance to.
	 *
	 * @return The shortest distance from the line to the point.
	**/
	public static function GetShortestDistanceAny<T:Vector2Like>(line:Line, point:T):Float
	{
		var x1 = line.x1;
		var y1 = line.y1;
		var x2 = line.x2;
		var y2 = line.y2;
		var L2 = (((x2 - x1) * (x2 - x1)) + ((y2 - y1) * (y2 - y1)));
		if (L2 == 0)
		{
			return Math.NaN;
		}
		var s = (((y1 - point.y) * (x2 - x1)) - ((x1 - point.x) * (y2 - y1))) / L2;
		return Math.abs(s) * Math.sqrt(L2);
	}

	/**
	 * Calculate the height of the given line.
	 *
	 * @since 1.0.0
	 *
	 * @param line - The line to calculate the height of.
	 *
	 * @return The height of the line.
	**/
	public static inline function Height(line:Line):Float
	{
		return Math.abs(line.y1 - line.y2);
	}

	/**
	 * Calculate the length of the given line.
	 *
	 * @since 1.0.0
	 *
	 * @param line - The line to calculate the length of.
	 *
	 * @return The length of the line.
	**/
	public static function Length(line:Line):Float
	{
		return Math.sqrt((line.x2 - line.x1) * (line.x2 - line.x1) + (line.y2 - line.y1) * (line.y2 - line
			.y1));
	}

	/**
	 * Get the angle of the normal of the given line in radians.
	 *
	 * @since 1.0.0
	 *
	 * @param line - The line to calculate the angle of the normal of.
	 *
	 * @return The angle of the normal of the line in radians.
	**/
	public static function NormalAngle(line:Line):Float
	{
		var angle = Angle(line) - MathConst.TAU;
		return MathUtility.wrap(angle, -Math.PI, Math.PI);
	}

	/**
	 * [description]
	 *
	 * @since 1.0.0
	 *
	 * @param line - The Line object to get the normal value from.
	 *
	 * @return [description]
	**/
	public static function NormalX(line:Line):Float
	{
		return Math.cos(Angle(line) - MathConst.TAU);
	}

	/**
	 * The Y value of the normal of the given line.
	 * The normal of a line is a vector that points perpendicular from it.
	 *
	 * @since 1.0.0
	 *
	 * @param line - The line to calculate the normal of.
	 *
	 * @return The Y value of the normal of the Line.
	**/
	public static function NormalY(line:Line):Float
	{
		return Math.sin(Angle(line) - MathConst.TAU);
	}

	/**
	 * Offset a line by the given amount.
	 *
	 * @since 1.0.0
	 *
	 * @param line - The line to offset.
	 * @param x - The horizontal offset to add to the line.
	 * @param y - The vertical offset to add to the line.
	 *
	 * @return The offset line.
	**/
	public static function Offset(line:Line, x:Float, y:Float):Line
	{
		line.x1 += x;
		line.y1 += y;
		line.x2 += x;
		line.y2 += y;
		return line;
	}

	/**
	 * Calculate the perpendicular slope of the given line.
	 *
	 * @since 1.0.0
	 *
	 * @param line - The line to calculate the perpendicular slope of.
	 *
	 * @return The perpendicular slope of the line.
	**/
	public static function PerpSlope(line:Line):Float
	{
		return -((line.x2 - line.x1) / (line.y2 - line.y1));
	}

	/**
	 * Returns a random point on a given Line.
	 *
	 * @since 1.0.0
	 *
	 * @param line - The Line to calculate the random Point on.
	 * @param out - An instance of a Point to be modified.
	 *
	 * @return A random Point on the Line.
	**/
	public static function Random(line:Line, ?out:Point):Point
	{
		if (out == null)
		{
			out = new Point();
		}
		var t = Math.random();
		out.x = line.x1 + t * (line.x2 - line.x1);
		out.y = line.y1 + t * (line.y2 - line.y1);
		return out;
	}

	/**
	 * Returns a random point on a given Line.
	 *
	 * @since 1.0.0
	 *
	 * @param line - The Line to calculate the random Point on.
	 * @param out - An instance of a Point-like to be modified.
	 *
	 * @return A random Point on the Line.
	**/
	public static function RandomAny<T:Vector2Like>(line:Line, out:T):T
	{
		var t = Math.random();
		out.x = line.x1 + t * (line.x2 - line.x1);
		out.y = line.y1 + t * (line.y2 - line.y1);
		return out;
	}

	/**
	 * Calculate the reflected angle between two lines.
	 *
	 * This is the outgoing angle based on the angle of Line 1 and the normalAngle of Line 2.
	 *
	 * @since 1.0.0
	 *
	 * @param lineA - The first line.
	 * @param lineB - The second line.
	 *
	 * @return The reflected angle between each line.
	**/
	public static function ReflectAngle(lineA:Line, lineB:Line):Float
	{
		return (2 * NormalAngle(lineB) - Math.PI - Angle(lineA));
	}

	/**
	 * Rotate a line around its midpoint by the given angle in radians.
	 *
	 * @since 1.0.0
	 *
	 * @param line - The line to rotate.
	 * @param angle - The angle of rotation in radians.
	 *
	 * @return The rotated line.
	**/
	public static function Rotate(line:Line, angle:Float):Line
	{
		var x = (line.x1 + line.x2) / 2;
		var y = (line.y1 + line.y2) / 2;
		return RotateAroundXY(line, x, y, angle);
	}

	/**
	 * Rotate a line around a point by the given angle in radians.
	 *
	 * @since 1.0.0
	 *
	 * @param line - The line to rotate.
	 * @param point - The point to rotate the line around.
	 * @param angle - The angle of rotation in radians.
	 *
	 * @return The rotated line.
	**/
	public static function RotateAroundPoint(line:Line, point:Point, angle:Float):Line
	{
		return RotateAroundXY(line, point.x, point.y, angle);
	}

	/**
	 * Rotate a line around the given coordinates by the given angle in radians.
	 *
	 * @since 1.0.0
	 *
	 * @param line - The line to rotate.
	 * @param x - The horizontal coordinate to rotate the line around.
	 * @param y - The vertical coordinate to rotate the line around.
	 * @param angle - The angle of rotation in radians.
	 *
	 * @return The rotated line.
	**/
	public static function RotateAroundXY(line:Line, x:Float, y:Float, angle:Float):Line
	{
		var c = Math.cos(angle);
		var s = Math.sin(angle);
		var tx = line.x1 - x;
		var ty = line.y1 - y;
		line.x1 = tx * c - ty * s + x;
		line.y1 = tx * s + ty * c + y;
		tx = line.x2 - x;
		ty = line.y2 - y;
		line.x2 = tx * c - ty * s + x;
		line.y2 = tx * s + ty * c + y;
		return line;
	}

	/**
	 * Set a line to a given position, angle and length.
	 *
	 * @since 1.0.0
	 *
	 * @param line - The line to set.
	 * @param x - The horizontal start position of the line.
	 * @param y - The vertical start position of the line.
	 * @param angle - The angle of the line in radians.
	 * @param length - The length of the line.
	 *
	 * @return {Phaser.Geom.Line} The updated line.
	**/
	public static function SetToAngle(line:Line, x:Float, y:Float, angle:Float, length:Float)
	{
		line.x1 = x;
		line.y1 = y;
		line.x2 = x + (Math.cos(angle) * length);
		line.y2 = y + (Math.sin(angle) * length);
		return line;
	}

	/**
	 * Calculate the slope of the given line.
	 *
	 * @since 1.0.0
	 *
	 * @param line - The line to calculate the slope of.
	 *
	 * @return The slope of the line.
	**/
	public static function Slope(line:Line):Float
	{
		return (line.y2 - line.y1) / (line.x2 - line.x1);
	}

	/**
	 * Calculate the width of the given line.
	 *
	 * @since 1.0.0
	 *
	 * @param line - The line to calculate the width of.
	 *
	 * @return The width of the line.
	**/
	public static function Width(line:Line):Float
	{
		return Math.abs(line.x1 - line.x2);
	}
}
