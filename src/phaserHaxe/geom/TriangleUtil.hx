package phaserHaxe.geom;

import phaserHaxe.geom.earcut.EarcutApi;
import phaserHaxe.math.Vector2;
import phaserHaxe.math.Vector2Like;
import phaserHaxe.iterator.StepIterator;

final class TriangleUtil
{
	/**
	 * Returns the area of a Triangle.
	 *
	 * @since 1.0.0
	 *
	 * @param triangle - The Triangle to use.
	 *
	 * @return The area of the Triangle, always non-negative.
	**/
	public static function Area(triangle:Triangle):Float
	{
		var x1 = triangle.x1;
		var y1 = triangle.y1;
		var x2 = triangle.x2;
		var y2 = triangle.y2;
		var x3 = triangle.x3;
		var y3 = triangle.y3;
		return Math.abs(((x3 - x1) * (y2 - y1) - (x2 - x1) * (y3 - y1)) / 2);
	}

	/**
	 * Builds an equilateral triangle. In the equilateral triangle, all the sides are the same length (congruent) and all the angles are the same size (congruent).
	 * The x/y specifies the top-middle of the triangle (x1/y1) and length is the length of each side.
	 *
	 * @since 1.0.0
	 *
	 * @param x - x coordinate of the top point of the triangle.
	 * @param y - y coordinate of the top point of the triangle.
	 * @param length - Length of each side of the triangle.
	 *
	 * @return The Triangle object of the given size.
	**/
	public static function BuildEquilateral(x:Float, y:Float, length:Float):Triangle
	{
		var height = length * (Math.sqrt(3) / 2);
		var x1 = x;
		var y1 = y;
		var x2 = x + (length / 2);
		var y2 = y + height;
		var x3 = x - (length / 2);
		var y3 = y + height;
		return new Triangle(x1, y1, x2, y2, x3, y3);
	}

	/**
	 * [description]
	 *
	 * @since 1.0.0
	 *
	 * @param data - A flat array of vertice coordinates like [x0,y0, x1,y1, x2,y2, ...]
	 * @param holes - An array of hole indices if any (e.g. [5, 8] for a 12-vertice input would mean one hole with vertices 5–7 and another with 8–11).
	 * @param scaleX - [description]
	 * @param scaleY - [description]
	 * @param out - [description]
	 *
	 * @return [description]
	**/
	public static function BuildFromPolygon(data:Array<Int>, holes:Array<Int> = null, scaleX:Int = 1,
			scaleY:Int = 1, out:Array<Triangle> = null):Array<Triangle>
	{
		if (holes == null)
		{
			holes = null;
		}
		if (out == null)
		{
			out = [];
		}
		var tris = EarcutApi.earcut(data, holes);
		var a;
		var b;
		var c;
		var x1;
		var y1;
		var x2;
		var y2;
		var x3;
		var y3;
		for (i in new StepIterator(0, tris.length, 3))
		{
			a = Std.int(tris[i]);
			b = Std.int(tris[i + 1]);
			c = Std.int(tris[i + 2]);
			x1 = data[a * 2] * scaleX;
			y1 = data[(a * 2) + 1] * scaleY;
			x2 = data[b * 2] * scaleX;
			y2 = data[(b * 2) + 1] * scaleY;
			x3 = data[c * 2] * scaleX;
			y3 = data[(c * 2) + 1] * scaleY;
			out.push(new Triangle(x1, y1, x2, y2, x3, y3));
		}
		return out;
	}

	/**
	 * Builds a right triangle, i.e. one which has a 90-degree angle and two acute angles.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The X coordinate of the right angle, which will also be the first X coordinate of the constructed Triangle.
	 * @param y - The Y coordinate of the right angle, which will also be the first Y coordinate of the constructed Triangle.
	 * @param width - The length of the side which is to the left or to the right of the right angle.
	 * @param height - The length of the side which is above or below the right angle.
	 *
	 * @return The constructed right Triangle.
	**/
	public static function BuildRight(x:Float, y:Float, width:Float, ?height:Float):Triangle
	{
		var height = (height != null ? (height : Float) : width);

		//  90 degree angle
		var x1 = x;
		var y1 = y;
		var x2 = x;
		var y2 = y - height;
		var x3 = x + width;
		var y3 = y;
		return new Triangle(x1, y1, x2, y2, x3, y3);
	}

	/**
	 * Positions the Triangle so that it is centered on the given coordinates.
	 *
	 * @since 1.0.0
	 *
	 * @param triangle - The triangle to be positioned.
	 * @param x - The horizontal coordinate to center on.
	 * @param y - The vertical coordinate to center on.
	 * @param centerFunc - The function used to center the triangle. Defaults to Centroid centering.
	 *
	 * @return The Triangle that was centered.
	**/
	public static function CenterOn(triangle:Triangle, x:Float, y:Float, ?centerFunc:(Triangle) -> Point):Triangle
	{
		//  Get the center of the triangle
		var center = centerFunc != null ? centerFunc(triangle) : Centroid(triangle);
		//  Difference
		var diffX = x - center.x;
		var diffY = y - center.y;
		return inline Offset(triangle, diffX, diffY);
	}

	/**
	 * Calculates the position of a Triangle's centroid, which is also its center of mass (center of gravity).
	 *
	 * The centroid is the point in a Triangle at which its three medians (the lines drawn from the vertices to the bisectors of the opposite sides) meet. It divides each one in a 2:1 ratio.
	 *
	 * @since 1.0.0
	 *
	 * @param triangle - The Triangle to use.
	 * @param out - An object to store the coordinates in.
	 *
	 * @return The `out` object with modified `x` and `y` properties, or a new Point if none was provided.
	**/
	public static function Centroid(triangle:Triangle, ?out:Point):Point
	{
		if (out == null)
		{
			out = new Point();
		}
		out.x = (triangle.x1 + triangle.x2 + triangle.x3) / 3;
		out.y = (triangle.y1 + triangle.y2 + triangle.y3) / 3;
		return out;
	}

	/**
	 * Calculates the position of a Triangle's centroid, which is also its center of mass (center of gravity).
	 *
	 * The centroid is the point in a Triangle at which its three medians (the lines drawn from the vertices to the bisectors of the opposite sides) meet. It divides each one in a 2:1 ratio.
	 *
	 * @since 1.0.0
	 *
	 * @param triangle - The Triangle to use.
	 * @param out - An object to store the coordinates in.
	 *
	 * @return The `out` object with modified `x` and `y` properties, or a new Point if none was provided.
	**/
	public static inline function CentroidAny<T:Vector2Like>(triangle:Triangle, out:T):T
	{
		out.x = (triangle.x1 + triangle.x2 + triangle.x3) / 3;
		out.y = (triangle.y1 + triangle.y2 + triangle.y3) / 3;
		return out;
	}

	/**
	 * Computes the circumcentre of a triangle. The circumcentre is the centre of
	 * the circumcircle, the smallest circle which encloses the triangle. It is also
	 * the common intersection point of the perpendicular bisectors of the sides of
	 * the triangle, and is the only point which has equal distance to all three
	 * vertices of the triangle.
	 *
	 * @since 1.0.0
	 *
	 * @param triangle - [description]
	 * @param out - [description]
	 *
	 * @return [description]
	**/
	public static function CircumCenter(triangle:Triangle, ?out:Vector2):Vector2
	{
		/**
		 * Computes the determinant of a 2x2 matrix. Uses standard double-precision arithmetic, so is susceptible to round-off error.
		 *
		 * @since 1.0.0
		 *
		 * @param  m00 - The [0,0] entry of the matrix.
		 * @param  m01 - The [0,1] entry of the matrix.
		 * @param  m10 - The [1,0] entry of the matrix.
		 * @param  m11 - The [1,1] entry of the matrix.
		 *
		 * @return {number} the determinant.
		**/
		inline function det(m00:Float, m01:Float, m10:Float, m11:Float)
		{
			return (m00 * m11) - (m01 * m10);
		}

		if (out == null)
		{
			out = new Vector2();
		}
		var cx = triangle.x3;
		var cy = triangle.y3;
		var ax = triangle.x1 - cx;
		var ay = triangle.y1 - cy;
		var bx = triangle.x2 - cx;
		var by = triangle.y2 - cy;
		var denom = 2 * det(ax, ay, bx, by);
		var numx = det(ay, ax * ax + ay * ay, by, bx * bx + by * by);
		var numy = det(ax, ax * ax + ay * ay, bx, bx * bx + by * by);
		out.x = cx - numx / denom;
		out.y = cy + numy / denom;
		return out;
	}

	/**
	 * Computes the circumcentre of a triangle. The circumcentre is the centre of
	 * the circumcircle, the smallest circle which encloses the triangle. It is also
	 * the common intersection point of the perpendicular bisectors of the sides of
	 * the triangle, and is the only point which has equal distance to all three
	 * vertices of the triangle.
	 *
	 * @since 1.0.0
	 *
	 * @param triangle - [description]
	 * @param out - [description]
	 *
	 * @return [description]
	**/
	public static function CircumCenterAny<T:Vector2Like>(triangle:Triangle, out:T):T
	{
		/**
		 * Computes the determinant of a 2x2 matrix. Uses standard double-precision arithmetic, so is susceptible to round-off error.
		 *
		 * @since 1.0.0
		 *
		 * @param  m00 - The [0,0] entry of the matrix.
		 * @param  m01 - The [0,1] entry of the matrix.
		 * @param  m10 - The [1,0] entry of the matrix.
		 * @param  m11 - The [1,1] entry of the matrix.
		 *
		 * @return {number} the determinant.
		**/
		inline function det(m00:Float, m01:Float, m10:Float, m11:Float)
		{
			return (m00 * m11) - (m01 * m10);
		}
		var cx = triangle.x3;
		var cy = triangle.y3;
		var ax = triangle.x1 - cx;
		var ay = triangle.y1 - cy;
		var bx = triangle.x2 - cx;
		var by = triangle.y2 - cy;
		var denom = 2 * det(ax, ay, bx, by);
		var numx = det(ay, ax * ax + ay * ay, by, bx * bx + by * by);
		var numy = det(ax, ax * ax + ay * ay, bx, bx * bx + by * by);
		out.x = cx - numx / denom;
		out.y = cy + numy / denom;
		return out;
	}

	/**
	 * Finds the circumscribed circle (circumcircle) of a Triangle object. The circumcircle is the circle which touches all of the triangle's vertices.
	 *
	 * @since 1.0.0
	 *
	 * @param triangle - The Triangle to use as input.
	 * @param out - An optional Circle to store the result in.
	 *
	 * @return The updated `out` Circle, or a new Circle if none was provided.
	**/
	public static function CircumCircle(triangle:Triangle, ?out:Circle):Circle
	{
		if (out == null)
		{
			out = new Circle();
		}
		//  A
		var x1 = triangle.x1;
		var y1 = triangle.y1;
		//  B
		var x2 = triangle.x2;
		var y2 = triangle.y2;
		//  C
		var x3 = triangle.x3;
		var y3 = triangle.y3;
		var A = x2 - x1;
		var B = y2 - y1;
		var C = x3 - x1;
		var D = y3 - y1;
		var E = A * (x1 + x2) + B * (y1 + y2);
		var F = C * (x1 + x3) + D * (y1 + y3);
		var G = 2 * (A * (y3 - y2) - B * (x3 - x2));
		var dx;
		var dy;
		//  If the points of the triangle are collinear, then just find the
		//  extremes and use the midpoint as the center of the circumcircle.
		if (Math.abs(G) < 0.000001)
		{
			var minX = Math.min(Math.min(x1, x2), x3);
			var minY = Math.min(Math.min(y1, y2), y3);
			dx = (Math.max(Math.max(x1, x2), x3) - minX) * 0.5;
			dy = (Math.max(Math.max(y1, y2), y3) - minY) * 0.5;
			out.x = minX + dx;
			out.y = minY + dy;
			out.radius = Math.sqrt(dx * dx + dy * dy);
		}
		else
		{
			out.x = (D * E - B * F) / G;
			out.y = (A * F - C * E) / G;
			dx = out.x - x1;
			dy = out.y - y1;
			out.radius = Math.sqrt(dx * dx + dy * dy);
		}
		return out;
	}

	/**
	 * Clones a Triangle object.
	 *
	 * @since 1.0.0
	 *
	 * @param source - The Triangle to clone.
	 *
	 * @return A new Triangle identical to the given one but separate from it.
	**/
	public static function Clone(source:Triangle):Triangle
	{
		return new Triangle(source.x1, source.y1, source.x2, source.y2, source.x3, source.y3);
	}

	/**
	 * Clones a Triangle object.
	 *
	 * @since 1.0.0
	 *
	 * @param source - The Triangle to clone.
	 *
	 * @return A new inline Triangle identical to the given one but separate from it.
	**/
	public static inline function CloneInline(source:Triangle):Triangle
	{
		return inline new Triangle(source.x1, source.y1, source.x2, source.y2, source.x3, source.y3);
	}

	/**
	 * Checks if a point (as a pair of coordinates) is inside a Triangle's bounds.
	 *
	 * @since 1.0.0
	 *
	 * @param triangle - The Triangle to check.
	 * @param x - The X coordinate of the point to check.
	 * @param y - The Y coordinate of the point to check.
	 *
	 * @return `true` if the point is inside the Triangle, otherwise `false`.
	**/
	public static function Contains(triangle:Triangle, x:Float, y:Float):Bool
	{
		var v0x = triangle.x3 - triangle.x1;
		var v0y = triangle.y3 - triangle.y1;
		var v1x = triangle.x2 - triangle.x1;
		var v1y = triangle.y2 - triangle.y1;
		var v2x = x - triangle.x1;
		var v2y = y - triangle.y1;
		var dot00 = (v0x * v0x) + (v0y * v0y);
		var dot01 = (v0x * v1x) + (v0y * v1y);
		var dot02 = (v0x * v2x) + (v0y * v2y);
		var dot11 = (v1x * v1x) + (v1y * v1y);
		var dot12 = (v1x * v2x) + (v1y * v2y);
		// Compute barycentric coordinates
		var b = ((dot00 * dot11) - (dot01 * dot01));
		var inv = (b == 0) ? 0 : (1 / b);
		var u = ((dot11 * dot02) - (dot01 * dot12)) * inv;
		var v = ((dot00 * dot12) - (dot01 * dot02)) * inv;
		return (u >= 0 && v >= 0 && (u + v < 1));
	}

	/**
	 * Filters an array of point-like objects to only those contained within a triangle.
	 * If `returnFirst` is true, will return an array containing only the first point in
	 * the provided array that is within the triangle (or an empty array if there are no such points).
	 *
	 * @since 1.0.0
	 *
	 * @param triangle - The triangle that the points are being checked in.
	 * @param points - An array of point-like objects (objects that have an `x` and `y` property)
	 * @param returnFirst - If `true`, return an array containing only the first point found that is within the triangle.
	 * @param out - If provided, the points that are within the triangle will be appended to this array instead of being added to a new array. If `returnFirst` is true, only the first point found within the triangle will be appended. This array will also be returned by this function.
	 *
	 * @return An array containing all the points from `points` that are within the triangle, if an array was provided as `out`, points will be appended to that array and it will also be returned here.
	**/
	public static function ContainsArray(triangle:Triangle, points:Array<Point>, returnFirst:Bool = false, ?out:Array<Point>):Array<Point>
	{
		if (out == null)
		{
			out = [];
		}
		var v0x = triangle.x3 - triangle.x1;
		var v0y = triangle.y3 - triangle.y1;
		var v1x = triangle.x2 - triangle.x1;
		var v1y = triangle.y2 - triangle.y1;
		var dot00 = (v0x * v0x) + (v0y * v0y);
		var dot01 = (v0x * v1x) + (v0y * v1y);
		var dot11 = (v1x * v1x) + (v1y * v1y);
		// Compute barycentric coordinates
		var b = ((dot00 * dot11) - (dot01 * dot01));
		var inv = (b == 0) ? 0 : (1 / b);
		var u;
		var v;
		var v2x;
		var v2y;
		var dot02;
		var dot12;
		var x1 = triangle.x1;
		var y1 = triangle.y1;
		for (i in 0...points.length)
		{
			v2x = points[i].x - x1;
			v2y = points[i].y - y1;
			dot02 = (v0x * v2x) + (v0y * v2y);
			dot12 = (v1x * v2x) + (v1y * v2y);
			u = ((dot11 * dot02) - (dot01 * dot12)) * inv;
			v = ((dot00 * dot12) - (dot01 * dot02)) * inv;
			if (u >= 0 && v >= 0 && (u + v < 1))
			{
				out.push({x: points[i].x, y: points[i].y});
				if (returnFirst)
				{
					break;
				}
			}
		}
		return out;
	}

	/**
	 * Tests if a triangle contains a point.
	 *
	 * @since 1.0.0
	 *
	 * @param {Phaser.Geom.Triangle} triangle - The triangle.
	 * @param {(Phaser.Geom.Point|Phaser.Math.Vector2|any)} point - The point to test, or any point-like object with public `x` and `y` properties.
	 *
	 * @return `true` if the point is within the triangle, otherwise `false`.
	**/
	public static function ContainsPoint(triangle:Triangle, point:Point):Bool
	{
		return Contains(triangle, point.x, point.y);
	}

	/**
	 * Copy the values of one Triangle to a destination Triangle.
	 *
	 * @since 1.0.0
	 *
	 * @param source - The source Triangle to copy the values from.
	 * @param dest - The destination Triangle to copy the values to.
	 *
	 * @return The destination Triangle.
	**/
	public static function CopyFrom(source:Triangle, dest:Triangle):Triangle
	{
		return inline dest.setTo(source.x1, source.y1, source.x2, source.y2, source.x3, source.y3);
	}

	/**
	 * Decomposes a Triangle into an array of its points.
	 *
	 * @since 1.0.0
	 *
	 * @param triangle - The Triangle to decompose.
	 * @param out - An array to store the points into.
	 *
	 * @return The provided `out` array, or a new array if none was provided, with three objects with `x` and `y` properties representing each point of the Triangle appended to it.
	**/
	public static function Decompose(triangle:Triangle, ?out:Array<Point>):Array<Point>
	{
		if (out == null)
		{
			out = [];
		}
		out.push({x: triangle.x1, y: triangle.y1});
		out.push({x: triangle.x2, y: triangle.y2});
		out.push({x: triangle.x3, y: triangle.y3});
		return out;
	}

	/**
	 * Returns true if two triangles have the same coordinates.
	 *
	 * @since 1.0.0
	 *
	 * @param triangle - The first triangle to check.
	 * @param toCompare - The second triangle to check.
	 *
	 * @return `true` if the two given triangles have the exact same coordinates, otherwise `false`.
	**/
	public static function Equals(triangle:Triangle, toCompare:Triangle)
	{
		return (triangle.x1 == toCompare.x1 && triangle.y1 == toCompare.y1 && triangle.x2 == toCompare.x2
			&& triangle.y2 == toCompare.y2 && triangle.x3 == toCompare.x3 && triangle.y3 == toCompare.y3);
	}

	/**
	 * Returns a Point from around the perimeter of a Triangle.
	 *
	 * @since 1.0.0
	 *
	 * @param triangle - The Triangle to get the point on its perimeter from.
	 * @param position - The position along the perimeter of the triangle. A value between 0 and 1.
	 * @param out - An option Point to store the value in. If not given a new Point will be created.
	 *
	 * @return A Point object containing the given position from the perimeter of the triangle.
	**/
	public static function GetPoint(triangle:Triangle, position:Float, ?out:Point):Point
	{
		inline function length(line)
		{
			return LineUtil.Length(line);
		}

		if (out == null)
		{
			out = new Point();
		}
		var line1 = triangle.getLineA();
		var line2 = triangle.getLineB();
		var line3 = triangle.getLineC();
		if (position <= 0 || position >= 1)
		{
			out.x = line1.x1;
			out.y = line1.y1;
			return out;
		}
		var length1 = length(line1);
		var length2 = length(line2);
		var length3 = length(line3);
		var perimeter = length1 + length2 + length3;
		var p = perimeter * position;
		var localPosition = 0.0;
		//  Which line is it on?
		if (p < length1)
		{
			//  Line 1
			localPosition = p / length1;
			out.x = line1.x1 + (line1.x2 - line1.x1) * localPosition;
			out.y = line1.y1 + (line1.y2 - line1.y1) * localPosition;
		}
		else if (p > length1 + length2)
		{
			//  Line 3
			p -= length1 + length2;
			localPosition = p / length3;
			out.x = line3.x1 + (line3.x2 - line3.x1) * localPosition;
			out.y = line3.y1 + (line3.y2 - line3.y1) * localPosition;
		}
		else
		{
			//  Line 2
			p -= length1;
			localPosition = p / length2;
			out.x = line2.x1 + (line2.x2 - line2.x1) * localPosition;
			out.y = line2.y1 + (line2.y2 - line2.y1) * localPosition;
		}
		return out;
	}

	/**
	 * Returns a Point from around the perimeter of a Triangle.
	 *
	 * @since 1.0.0
	 *
	 * @param triangle - The Triangle to get the point on its perimeter from.
	 * @param position - The position along the perimeter of the triangle. A value between 0 and 1.
	 * @param out - An Point-like object to store the value in. If not given a new Point will be created.
	 *
	 * @return A Point object containing the given position from the perimeter of the triangle.
	**/
	public static function GetPointAny<T:Vector2Like>(triangle:Triangle, position:Float, out:T):T
	{
		inline function length(line)
		{
			return LineUtil.Length(line);
		}

		var line1 = triangle.getLineA();
		var line2 = triangle.getLineB();
		var line3 = triangle.getLineC();
		if (position <= 0 || position >= 1)
		{
			out.x = line1.x1;
			out.y = line1.y1;
			return out;
		}
		var length1 = length(line1);
		var length2 = length(line2);
		var length3 = length(line3);
		var perimeter = length1 + length2 + length3;
		var p = perimeter * position;
		var localPosition = 0.0;
		//  Which line is it on?
		if (p < length1)
		{
			//  Line 1
			localPosition = p / length1;
			out.x = line1.x1 + (line1.x2 - line1.x1) * localPosition;
			out.y = line1.y1 + (line1.y2 - line1.y1) * localPosition;
		}
		else if (p > length1 + length2)
		{
			//  Line 3
			p -= length1 + length2;
			localPosition = p / length3;
			out.x = line3.x1 + (line3.x2 - line3.x1) * localPosition;
			out.y = line3.y1 + (line3.y2 - line3.y1) * localPosition;
		}
		else
		{
			//  Line 2
			p -= length1;
			localPosition = p / length2;
			out.x = line2.x1 + (line2.x2 - line2.x1) * localPosition;
			out.y = line2.y1 + (line2.y2 - line2.y1) * localPosition;
		}
		return out;
	}

	/**
	 * Returns an array of evenly spaced points on the perimeter of a Triangle.
	 *
	 * @since 1.0.0
	 *
	 * @param triangle - The Triangle to get the points from.
	 * @param quantity - The number of evenly spaced points to return. Set to 0 to return an arbitrary number of points based on the `stepRate`.
	 * @param stepRate - If `quantity` is 0, the distance between each returned point.
	 * @param out - An array to which the points should be appended.
	 *
	 * @return The modified `out` array, or a new array if none was provided.
	**/
	public static function GetPoints(triangle:Triangle, quantity:Int, stepRate:Float = 0, ?out:Array<Point>):Array<Point>
	{
		if (out == null)
		{
			out = [];
		}
		var line1 = triangle.getLineA();
		var line2 = triangle.getLineB();
		var line3 = triangle.getLineC();
		var length1 = LineUtil.Length(line1);
		var length2 = LineUtil.Length(line2);
		var length3 = LineUtil.Length(line3);
		var perimeter = length1 + length2 + length3;
		//  If quantity is a falsey value (false, null, 0, undefined, etc) then we calculate it based on the stepRate instead.

		var quantityFloat = (quantity : Float);
		if (quantity == 0)
		{
			quantityFloat = perimeter / stepRate;
			quantity = Std.int(quantityFloat);
		}
		for (i in 0...quantity)
		{
			var p = perimeter * (i / quantityFloat);
			var localPosition = 0.0;
			var point = new Point();
			//  Which line is it on?
			if (p < length1)
			{
				//  Line 1
				localPosition = p / length1;
				point.x = line1.x1 + (line1.x2 - line1.x1) * localPosition;
				point.y = line1.y1 + (line1.y2 - line1.y1) * localPosition;
			}
			else if (p > length1 + length2)
			{
				//  Line 3
				p -= length1 + length2;
				localPosition = p / length3;
				point.x = line3.x1 + (line3.x2 - line3.x1) * localPosition;
				point.y = line3.y1 + (line3.y2 - line3.y1) * localPosition;
			}
			else
			{
				//  Line 2
				p -= length1;
				localPosition = p / length2;
				point.x = line2.x1 + (line2.x2 - line2.x1) * localPosition;
				point.y = line2.y1 + (line2.y2 - line2.y1) * localPosition;
			}
			out.push(point);
		}
		return out;
	}

	/**
	 * Calculates the position of the incenter of a Triangle object.
	 * This is the point where its three angle bisectors meet and it's also the center of the incircle,
	 * which is the circle inscribed in the triangle.
	 *
	 * @since 1.0.0
	 *
	 * @param triangle - The Triangle to find the incenter of.
	 * @param out - An optional Point in which to store the coordinates.
	 *
	 * @return Point (x, y) of the center pixel of the triangle.
	**/
	public static function InCenter(triangle:Triangle, ?out:Point):Point
	{
		function getLength(x1:Float, y1:Float, x2:Float, y2:Float):Float
		{
			var x = x1 - x2;
			var y = y1 - y2;
			var magnitude = (x * x) + (y * y);
			return Math.sqrt(magnitude);
		}
		if (out == null)
		{
			out = new Point();
		}
		var x1 = triangle.x1;
		var y1 = triangle.y1;
		var x2 = triangle.x2;
		var y2 = triangle.y2;
		var x3 = triangle.x3;
		var y3 = triangle.y3;
		var d1 = getLength(x3, y3, x2, y2);
		var d2 = getLength(x1, y1, x3, y3);
		var d3 = getLength(x2, y2, x1, y1);
		var p = d1 + d2 + d3;
		out.x = (x1 * d1 + x2 * d2 + x3 * d3) / p;
		out.y = (y1 * d1 + y2 * d2 + y3 * d3) / p;
		return out;
	}

	/**
	 * Calculates the position of the incenter of a Triangle object.
	 * This is the point where its three angle bisectors meet and it's also the center of the incircle,
	 * which is the circle inscribed in the triangle.
	 *
	 * @since 1.0.0
	 *
	 * @param triangle - The Triangle to find the incenter of.
	 * @param out - An point-like object in which to store the coordinates.
	 *
	 * @return Point (x, y) of the center pixel of the triangle.
	**/
	public static function InCenterAny<T:Vector2Like>(triangle:Triangle, out:T):T
	{
		function getLength(x1:Float, y1:Float, x2:Float, y2:Float):Float
		{
			var x = x1 - x2;
			var y = y1 - y2;
			var magnitude = (x * x) + (y * y);
			return Math.sqrt(magnitude);
		}
		var x1 = triangle.x1;
		var y1 = triangle.y1;
		var x2 = triangle.x2;
		var y2 = triangle.y2;
		var x3 = triangle.x3;
		var y3 = triangle.y3;
		var d1 = getLength(x3, y3, x2, y2);
		var d2 = getLength(x1, y1, x3, y3);
		var d3 = getLength(x2, y2, x1, y1);
		var p = d1 + d2 + d3;
		out.x = (x1 * d1 + x2 * d2 + x3 * d3) / p;
		out.y = (y1 * d1 + y2 * d2 + y3 * d3) / p;
		return out;
	}

	/**
	 * Moves each point (vertex) of a Triangle by a given offset, thus moving the entire Triangle by that offset.
	 *
	 * @since 1.0.0
	 *
	 * @param triangle - The Triangle to move.
	 * @param x - The horizontal offset (distance) by which to move each point. Can be positive or negative.
	 * @param y - The vertical offset (distance) by which to move each point. Can be positive or negative.
	 *
	 * @return The modified Triangle.
	**/
	public static function Offset(triangle:Triangle, x:Float, y:Float):Triangle
	{
		triangle.x1 += x;
		triangle.y1 += y;
		triangle.x2 += x;
		triangle.y2 += y;
		triangle.x3 += x;
		triangle.y3 += y;
		return triangle;
	}

	/**
	 * Gets the length of the perimeter of the given triangle.
	 *
	 * @since 1.0.0
	 *
	 * @param {Phaser.Geom.Triangle} triangle - [description]
	 *
	 * @return [description]
	**/
	public static function Perimeter(triangle:Triangle):Float
	{
		inline function length(line)
		{
			return LineUtil.Length(line);
		}

		var line1 = triangle.getLineA();
		var line2 = triangle.getLineB();
		var line3 = triangle.getLineC();
		return (length(line1) + length(line2) + length(line3));
	}

	/**
	 * [description]
	 *
	 * @since 1.0.0
	 *
	 * @param triangle - [description]
	 * @param out - [description]
	 *
	 * @return [description]
	**/
	public static function Random(triangle:Triangle, ?out:Point)
	{
		if (out == null)
		{
			out = new Point();
		}
		//  Basis vectors
		var ux = triangle.x2 - triangle.x1;
		var uy = triangle.y2 - triangle.y1;
		var vx = triangle.x3 - triangle.x1;
		var vy = triangle.y3 - triangle.y1;
		//  Random point within the unit square
		var r = Math.random();
		var s = Math.random();
		//  Point outside the triangle? Remap it.
		if (r + s >= 1)
		{
			r = 1 - r;
			s = 1 - s;
		}
		out.x = triangle.x1 + ((ux * r) + (vx * s));
		out.y = triangle.y1 + ((uy * r) + (vy * s));
		return out;
	}

	/**
	 * [description]
	 *
	 * @since 1.0.0
	 *
	 * @param triangle - [description]
	 * @param out - [description]
	 *
	 * @return [description]
	**/
	public static function RandomAny<T:Vector2Like>(triangle:Triangle, out:T):T
	{
		//  Basis vectors
		var ux = triangle.x2 - triangle.x1;
		var uy = triangle.y2 - triangle.y1;
		var vx = triangle.x3 - triangle.x1;
		var vy = triangle.y3 - triangle.y1;
		//  Random point within the unit square
		var r = Math.random();
		var s = Math.random();
		//  Point outside the triangle? Remap it.
		if (r + s >= 1)
		{
			r = 1 - r;
			s = 1 - s;
		}
		out.x = triangle.x1 + ((ux * r) + (vx * s));
		out.y = triangle.y1 + ((uy * r) + (vy * s));
		return out;
	}

	/**
	 * Rotates a Triangle about its incenter, which is the point at which its three angle bisectors meet.
	 *
	 * @since 1.0.0
	 *
	 * @param triangle - The Triangle to rotate.
	 * @param angle - The angle by which to rotate the Triangle, in radians.
	 *
	 * @return The rotated Triangle.
	**/
	public static function Rotate(triangle:Triangle, angle:Float):Triangle
	{
		var point = InCenter(triangle);
		return RotateAroundXY(triangle, point.x, point.y, angle);
	}

	/**
	 * Rotates a Triangle at a certain angle about a given Point or object with public `x` and `y` properties.
	 *
	 * @since 1.0.0
	 *
	 * @param triangle - The Triangle to rotate.
	 * @param point - The Point to rotate the Triangle about.
	 * @param angle - The angle by which to rotate the Triangle, in radians.
	 *
	 * @return The rotated Triangle.
	**/
	public static function RotateAroundPoint(triangle:Triangle, point:Point, angle:Float):Triangle
	{
		return RotateAroundXY(triangle, point.x, point.y, angle);
	}

	/**
	 * Rotates an entire Triangle at a given angle about a specific point.
	 *
	 * @since 1.0.0
	 *
	 * @param triangle - The Triangle to rotate.
	 * @param x - The X coordinate of the point to rotate the Triangle about.
	 * @param y - The Y coordinate of the point to rotate the Triangle about.
	 * @param angle - The angle by which to rotate the Triangle, in radians.
	 *
	 * @return The rotated Triangle.
	**/
	public static function RotateAroundXY(triangle:Triangle, x:Float, y:Float, angle:Float):Triangle
	{
		var c = Math.cos(angle);
		var s = Math.sin(angle);
		var tx = triangle.x1 - x;
		var ty = triangle.y1 - y;
		triangle.x1 = tx * c - ty * s + x;
		triangle.y1 = tx * s + ty * c + y;
		tx = triangle.x2 - x;
		ty = triangle.y2 - y;
		triangle.x2 = tx * c - ty * s + x;
		triangle.y2 = tx * s + ty * c + y;
		tx = triangle.x3 - x;
		ty = triangle.y3 - y;
		triangle.x3 = tx * c - ty * s + x;
		triangle.y3 = tx * s + ty * c + y;
		return triangle;
	}
}
