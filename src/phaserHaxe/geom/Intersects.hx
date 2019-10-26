package phaserHaxe.geom;

import phaserHaxe.math.Distance.*;

final class Intersects
{
	private static var tempPoint:Point = {x: 0, y: 0};

	/**
	 * Checks if two Circles intersect.
	 *
	 * @since 1.0.0
	 *
	 * @param circleA - The first Circle to check for intersection.
	 * @param circleB - The second Circle to check for intersection.
	 *
	 * @return `true` if the two Circles intersect, otherwise `false`.
	**/
	public static function CircleToCircle(circleA:Circle, circleB:Circle):Bool
	{
		return (DistanceBetween(circleA.x, circleA.y, circleB.x, circleB
			.y) <= (circleA.radius + circleB.radius));
	}

	/**
	 * Checks for intersection between a circle and a rectangle.
	 *
	 * @since 1.0.0
	 *
	 * @param circle - The circle to be checked.
	 * @param rect - The rectangle to be checked.
	 *
	 * @return `true` if the two objects intersect, otherwise `false`.
	**/
	public static function CircleToRectangle(circle:Circle, rect:Rectangle):Bool
	{
		var halfWidth = rect.width / 2;
		var halfHeight = rect.height / 2;

		var cx = Math.abs(circle.x - rect.x - halfWidth);
		var cy = Math.abs(circle.y - rect.y - halfHeight);
		var xDist = halfWidth + circle.radius;
		var yDist = halfHeight + circle.radius;

		if (cx > xDist || cy > yDist)
		{
			return false;
		}
		else if (cx <= halfWidth || cy <= halfHeight)
		{
			return true;
		}
		else
		{
			var xCornerDist = cx - halfWidth;
			var yCornerDist = cy - halfHeight;
			var xCornerDistSq = xCornerDist * xCornerDist;
			var yCornerDistSq = yCornerDist * yCornerDist;
			var maxCornerDistSq = circle.radius * circle.radius;

			return (xCornerDistSq + yCornerDistSq <= maxCornerDistSq);
		}
	}

	/**
	 * Checks if two Rectangle shapes intersect and returns the area of this intersection as Rectangle object.
	 *
	 * If optional `output` parameter is omitted, new Rectangle object is created and returned. If there is intersection, it will contain intersection area. If there is no intersection, it wil be empty Rectangle (all values set to zero).
	 *
	 * If Rectangle object is passed as `output` and there is intersection, then intersection area data will be loaded into it and it will be returned. If there is no intersetion, it will be returned without any change.
	 *
	 * @since 1.0.0
	 *
	 * @param rectA - The first Rectangle object.
	 * @param rectB - The second Rectangle object.
	 * @param output - Optional Rectangle object. If given, the intersection data will be loaded into it (in case of no intersection, it will be left unchanged). Otherwise, new Rectangle object will be created and returned with either intersection data or empty (all values set to zero), if there is no intersection.
	 *
	 * @return A rectangle object with intersection data.
	**/
	public static function GetRectangleIntersection(rectA:Rectangle, rectB:Rectangle, ?output:Rectangle):Rectangle
	{
		if (output == null)
		{
			output = new Rectangle();
		}

		if (RectangleToRectangle(rectA, rectB))
		{
			output.x = Math.max(rectA.x, rectB.x);
			output.y = Math.max(rectA.y, rectB.y);
			output.width = Math.min(rectA.right, rectB.right) - output.x;
			output.height = Math.min(rectA.bottom, rectB.bottom) - output.y;
		}

		return output;
	}

	/**
	 * Checks for intersection between the line segment and circle.
	 *
	 * Based on code by [Matt DesLauriers](https://github.com/mattdesl/line-circle-collision/blob/master/LICENSE.md).
	 *
	 * @since 1.0.0
	 *
	 * @param line - The line segment to check.
	 * @param circle - The circle to check against the line.
	 * @param nearest - An optional Point-like object. If given the closest point on the Line where the circle intersects will be stored in this object.
	 *
	 * @return `true` if the two objects intersect, otherwise `false`.
	**/
	public static function LineToCircle(line:Line, circle:Circle, ?nearest:Point):Bool
	{
		if (nearest == null)
		{
			nearest = tempPoint;
		}

		if (CircleUtil.Contains(circle, line.x1, line.y1))
		{
			nearest.x = line.x1;
			nearest.y = line.y1;

			return true;
		}

		if (CircleUtil.Contains(circle, line.x2, line.y2))
		{
			nearest.x = line.x2;
			nearest.y = line.y2;

			return true;
		}

		var dx = line.x2 - line.x1;
		var dy = line.y2 - line.y1;

		var lcx = circle.x - line.x1;
		var lcy = circle.y - line.y1;

		//  project lc onto d, resulting in vector p
		var dLen2 = (dx * dx) + (dy * dy);
		var px = dx;
		var py = dy;

		if (dLen2 > 0)
		{
			var dp = ((lcx * dx) + (lcy * dy)) / dLen2;

			px *= dp;
			py *= dp;
		}

		nearest.x = line.x1 + px;
		nearest.y = line.y1 + py;

		//  len2 of p
		var pLen2 = (px * px) + (py * py);

		return (pLen2 <= dLen2 && ((px * dx) +
			(py * dy)) >= 0 && CircleUtil.Contains(circle, nearest.x, nearest.y));
	}

	/**
	 * Checks if two Lines intersect. If the Lines are identical, they will be treated as parallel and thus non-intersecting.
	 *
	 * @since 1.0.0
	 *
	 * @param line1 - The first Line to check.
	 * @param line2 - The second Line to check.
	 * @param out - A Point in which to optionally store the point of intersection.
	 *
	 * @return `true` if the two Lines intersect, and the `out` object will be populated, if given. Otherwise, `false`.
	**/
	public static function LineToLine(line1:Line, line2:Line, ?out:Point):Bool
	{
		var x1 = line1.x1;
		var y1 = line1.y1;
		var x2 = line1.x2;
		var y2 = line1.y2;

		var x3 = line2.x1;
		var y3 = line2.y1;
		var x4 = line2.x2;
		var y4 = line2.y2;

		var numA = (x4 - x3) * (y1 - y3) - (y4 - y3) * (x1 - x3);
		var numB = (x2 - x1) * (y1 - y3) - (y2 - y1) * (x1 - x3);
		var deNom = (y4 - y3) * (x2 - x1) - (x4 - x3) * (y2 - y1);

		//  Make sure there is not a division by zero - this also indicates that the lines are parallel.
		//  If numA and numB were both equal to zero the lines would be on top of each other (coincidental).
		//  This check is not done because it is not necessary for this implementation (the parallel check accounts for this).

		if (deNom == 0)
		{
			return false;
		}

		//  Calculate the intermediate fractional point that the lines potentially intersect.

		var uA = numA / deNom;
		var uB = numB / deNom;

		//  The fractional point will be between 0 and 1 inclusive if the lines intersect.
		//  If the fractional calculation is larger than 1 or smaller than 0 the lines would need to be longer to intersect.

		if (uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1)
		{
			if (out != null)
			{
				out.x = x1 + (uA * (x2 - x1));
				out.y = y1 + (uA * (y2 - y1));
			}

			return true;
		}

		return false;
	}

	/**
	 * Checks for intersection between the Line and a Rectangle shape, or a rectangle-like
	 * object, with public `x`, `y`, `right` and `bottom` properties, such as a Sprite or Body.
	 *
	 * An intersection is considered valid if:
	 *
	 * The line starts within, or ends within, the Rectangle.
	 * The line segment intersects one of the 4 rectangle edges.
	 *
	 * The for the purposes of this function rectangles are considered 'solid'.
	 *
	 * @since 1.0.0
	 *
	 * @param line - The Line to check for intersection.
	 * @param rect - The Rectangle to check for intersection.
	 *
	 * @return `true` if the Line and the Rectangle intersect, `false` otherwise.
	**/
	public static function LineToRectangle(line:Line, rect:Rectangle):Bool
	{
		var x1 = line.x1;
		var y1 = line.y1;

		var x2 = line.x2;
		var y2 = line.y2;

		var bx1 = rect.x;
		var by1 = rect.y;
		var bx2 = rect.right;
		var by2 = rect.bottom;

		var t = 0.0;

		//  If the start or end of the line is inside the rect then we assume
		//  collision, as rects are solid for our use-case.

		if (
			(x1 >= bx1 && x1 <= bx2 && y1 >= by1 && y1 <= by2) || (x2 >= bx1 && x2 <= bx2 && y2 >= by1 && y2 <= by2)
		)
		{
			return true;
		}

		if (x1 < bx1 && x2 >= bx1)
		{
			//  Left edge
			t = y1 + (y2 - y1) * (bx1 - x1) / (x2 - x1);

			if (t > by1 && t <= by2)
			{
				return true;
			}
		}
		else if (x1 > bx2 && x2 <= bx2)
		{
			//  Right edge
			t = y1 + (y2 - y1) * (bx2 - x1) / (x2 - x1);

			if (t >= by1 && t <= by2)
			{
				return true;
			}
		}

		if (y1 < by1 && y2 >= by1)
		{
			//  Top edge
			t = x1 + (x2 - x1) * (by1 - y1) / (y2 - y1);

			if (t >= bx1 && t <= bx2)
			{
				return true;
			}
		}
		else if (y1 > by2 && y2 <= by2)
		{
			//  Bottom edge
			t = x1 + (x2 - x1) * (by2 - y1) / (y2 - y1);

			if (t >= bx1 && t <= bx2)
			{
				return true;
			}
		}

		return false;
	}

	/**
	 * Checks if the a Point falls between the two end-points of a Line, based on the given line thickness.
	 *
	 * Assumes that the line end points are circular, not square.
	 *
	 * @since 1.0.0
	 *
	 * @param point - The point, or point-like object to check.
	 * @param line - The line segment to test for intersection on.
	 * @param lineThickness - The line thickness. Assumes that the line end points are circular.
	 *
	 * @return `true` if the Point falls on the Line, otherwise `false`.
	**/
	public static function PointToLine(point:Point, line:Line, lineThickness:Float = 1):Bool
	{
		var x1 = line.x1;
		var y1 = line.y1;

		var x2 = line.x2;
		var y2 = line.y2;

		var px = point.x;
		var py = point.y;

		var L2 = (((x2 - x1) * (x2 - x1)) + ((y2 - y1) * (y2 - y1)));

		if (L2 == 0)
		{
			return false;
		}

		var r = (((px - x1) * (x2 - x1)) + ((py - y1) * (y2 - y1))) / L2;

		//  Assume line thickness is circular
		if (r < 0)
		{
			//  Outside line1
			return (Math
				.sqrt(((x1 - px) * (x1 - px)) + ((y1 - py) * (y1 - py))) <= lineThickness);
		}
		else if ((r >= 0) && (r <= 1))
		{
			//  On the line segment
			var s = (((y1 - py) * (x2 - x1)) - ((x1 - px) * (y2 - y1))) / L2;

			return (Math.abs(s) * Math.sqrt(L2) <= lineThickness);
		}
		else
		{
			//  Outside line2
			return (Math
				.sqrt(((x2 - px) * (x2 - px)) + ((y2 - py) * (y2 - py))) <= lineThickness);
		}
	}

	/**
	 * Checks if two Rectangles intersect.
	 *
	 * A Rectangle intersects another Rectangle if any part of its bounds is within the other Rectangle's bounds. As such, the two Rectangles are considered "solid". A Rectangle with no width or no height will never intersect another Rectangle.
	 *
	 * @since 1.0.0
	 *
	 * @param rectA - The first Rectangle to check for intersection.
	 * @param rectB - The second Rectangle to check for intersection.
	 *
	 * @return `true` if the two Rectangles intersect, otherwise `false`.
	**/
	public static function RectangleToRectangle(rectA:Rectangle, rectB:Rectangle):Bool
	{
		if (rectA.width <= 0 || rectA.height <= 0 || rectB.width <= 0 || rectB.height <= 0)
		{
			return false;
		}

		return
			!(rectA.right < rectB.x || rectA.bottom < rectB.y || rectA.x > rectB.right || rectA.y > rectB.bottom);
	}

	/**
	 * Checks if a Point is located on the given line segment.
	 *
	 * @since 1.0.0
	 *
	 * @param point - The Point to check for intersection.
	 * @param line - The line segment to check for intersection.
	 *
	 * @return `true` if the Point is on the given line segment, otherwise `false`.
	**/
	public static function PointToLineSegment(point:Point, line:Line):Bool
	{
		if (!PointToLine(point, line))
		{
			return false;
		}

		var xMin = Math.min(line.x1, line.x2);
		var xMax = Math.max(line.x1, line.x2);
		var yMin = Math.min(line.y1, line.y2);
		var yMax = Math.max(line.y1, line.y2);

		return ((point.x >= xMin && point.x <= xMax) && (point.y >= yMin && point.y <= yMax));
	}

	/**
	 * Checks for intersection between Rectangle shape and Triangle shape.
	 *
	 * @since 1.0.0
	 *
	 * @param rect - Rectangle object to test.
	 * @param triangle - Triangle object to test.
	 *
	 * @return A value of `true` if objects intersect; otherwise `false`.
	**/
	public static function RectangleToTriangle(rect:Rectangle, triangle:Triangle):Bool
	{
		//  First the cheapest ones:

		if (triangle.left > rect.right || triangle.right < rect.left || triangle.top > rect.bottom || triangle.bottom < rect.top)
		{
			return false;
		}

		var triA = triangle.getLineA();
		var triB = triangle.getLineB();
		var triC = triangle.getLineC();

		//  Are any of the triangle points within the rectangle?

		if (RectangleUtil.contains(rect, triA.x1, triA
			.y1) || RectangleUtil.contains(rect, triA.x2, triA.y2))
		{
			return true;
		}

		if (RectangleUtil.contains(rect, triB.x1, triB
			.y1) || RectangleUtil.contains(rect, triB.x2, triB.y2))
		{
			return true;
		}

		if (RectangleUtil.contains(rect, triC.x1, triC
			.y1) || RectangleUtil.contains(rect, triC.x2, triC.y2))
		{
			return true;
		}

		//  Cheap tests over, now to see if any of the lines intersect ...

		var rectA = rect.getLineA();
		var rectB = rect.getLineB();
		var rectC = rect.getLineC();
		var rectD = rect.getLineD();

		if (LineToLine(triA, rectA) || LineToLine(triA, rectB) || LineToLine(triA, rectC) || LineToLine(triA, rectD)
		)
		{
			return true;
		}

		if (LineToLine(triB, rectA) || LineToLine(triB, rectB) || LineToLine(triB, rectC) || LineToLine(triB, rectD)
		)
		{
			return true;
		}

		if (LineToLine(triC, rectA) || LineToLine(triC, rectB) || LineToLine(triC, rectC) || LineToLine(triC, rectD)
		)
		{
			return true;
		}

		//  None of the lines intersect, so are any rectangle points within the triangle?

		var points = RectangleUtil.decompose(rect);
		var within = TriangleUtil.ContainsArray(triangle, points, true);

		return (within.length > 0);
	}

	/**
	 * Check if rectangle intersects with values.
	 *
	 * @since 1.0.0
	 *
	 * @param rect - The rectangle object
	 * @param left - The x coordinate of the left of the Rectangle.
	 * @param right - The x coordinate of the right of the Rectangle.
	 * @param top - The y coordinate of the top of the Rectangle.
	 * @param bottom - The y coordinate of the bottom of the Rectangle.
	 * @param tolerance - Tolerance allowed in the calculation, expressed in pixels.
	 *
	 * @return Returns true if there is an intersection.
	**/
	public static function RectangleToValues(rect:Rectangle, left:Float, right:Float, top:Float, bottom:Float, tolerance:Float = 0):Bool
	{
		return !(left > rect.right + tolerance
			|| right < rect.left - tolerance
			|| top > rect.bottom + tolerance || bottom < rect.top - tolerance);
	}

	/**
	 * Checks if a Triangle and a Circle intersect.
	 *
	 * A Circle intersects a Triangle if its center is located within it or if any of the Triangle's sides intersect the Circle. As such, the Triangle and the Circle are considered "solid" for the intersection.
	 *
	 * @since 1.0.0
	 *
	 * @param triangle - The Triangle to check for intersection.
	 * @param circle - The Circle to check for intersection.
	 *
	 * @return `true` if the Triangle and the `Circle` intersect, otherwise `false`.
	**/
	public static function TriangleToCircle(triangle:Triangle, circle:Circle):Bool
	{
		//  First the cheapest ones:

		if (triangle.left > circle.right
			|| triangle.right < circle.left
			|| triangle.top > circle.bottom
			|| triangle.bottom < circle.top)
		{
			return false;
		}

		if (TriangleUtil.Contains(triangle, circle.x, circle.y))
		{
			return true;
		}

		if (LineToCircle(triangle.getLineA(), circle))
		{
			return true;
		}

		if (LineToCircle(triangle.getLineB(), circle))
		{
			return true;
		}

		if (LineToCircle(triangle.getLineC(), circle))
		{
			return true;
		}

		return false;
	}

	/**
	 * Checks if a Triangle and a Line intersect.
	 *
	 * The Line intersects the Triangle if it starts inside of it, ends inside of it, or crosses any of the Triangle's sides. Thus, the Triangle is considered "solid".
	 *
	 * @since 1.0.0
	 *
	 * @param triangle - The Triangle to check with.
	 * @param line - The Line to check with.
	 *
	 * @return `true` if the Triangle and the Line intersect, otherwise `false`.
	**/
	public static function TriangleToLine(triangle:Triangle, line:Line)
	{
		var pointA = inline line.getPointA(inline new Point());
		var pointB = inline line.getPointB(inline new Point());
		//  If the Triangle contains either the start or end point of the line, it intersects
		if (TriangleUtil.Contains(triangle, pointA.x, pointA
			.y) || TriangleUtil.Contains(triangle, pointB.x, pointB.y))
		{
			return true;
		}

		//  Now check the line against each line of the Triangle
		if (LineToLine(triangle.getLineA(), line))
		{
			return true;
		}

		if (LineToLine(triangle.getLineB(), line))
		{
			return true;
		}

		if (LineToLine(triangle.getLineC(), line))
		{
			return true;
		}

		return false;
	}

	/**
	 * Checks if two Triangles intersect.
	 *
	 * A Triangle intersects another Triangle if any pair of their lines intersects or if any point of one Triangle is within the other Triangle. Thus, the Triangles are considered "solid".
	 *
	 * @since 1.0.0
	 *
	 * @param triangleA - The first Triangle to check for intersection.
	 * @param triangleB - The second Triangle to check for intersection.
	 *
	 * @return `true` if the Triangles intersect, otherwise `false`.
	**/
	public static function TriangleToTriangle(triangleA:Triangle, triangleB:Triangle)
	{
		//  First the cheapest ones:

		if (triangleA.left > triangleB.right
			|| triangleA.right < triangleB.left
			|| triangleA.top > triangleB.bottom
			|| triangleA.bottom < triangleB.top)
		{
			return false;
		}

		var lineAA = triangleA.getLineA();
		var lineAB = triangleA.getLineB();
		var lineAC = triangleA.getLineC();

		var lineBA = triangleB.getLineA();
		var lineBB = triangleB.getLineB();
		var lineBC = triangleB.getLineC();

		//  Now check the lines against each line of TriangleB
		if (LineToLine(lineAA, lineBA) || LineToLine(lineAA, lineBB) || LineToLine(lineAA, lineBC)
		)
		{
			return true;
		}

		if (LineToLine(lineAB, lineBA) || LineToLine(lineAB, lineBB) || LineToLine(lineAB, lineBC)
		)
		{
			return true;
		}

		if (LineToLine(lineAC, lineBA) || LineToLine(lineAC, lineBB) || LineToLine(lineAC, lineBC)
		)
		{
			return true;
		}

		//  Nope, so check to see if any of the points of triangleA are within triangleB

		var points = TriangleUtil.Decompose(triangleA);
		var within = TriangleUtil.ContainsArray(triangleB, points, true);

		if (within.length > 0)
		{
			return true;
		}

		//  Finally check to see if any of the points of triangleB are within triangleA

		points = TriangleUtil.Decompose(triangleB);
		within = TriangleUtil.ContainsArray(triangleA, points, true);

		if (within.length > 0)
		{
			return true;
		}

		return false;
	}
}
