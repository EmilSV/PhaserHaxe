package phaserHaxe.geom;

final class PolygonUtil
{
	/**
	 * Create a new polygon which is a copy of the specified polygon
	 *
	 * @since 1.0.0
	 *
	 * @param polygon - The polygon to create a clone of
	 *
	 * @return A new separate Polygon cloned from the specified polygon, based on the same points.
	**/
	public static function Clone(polygon:Polygon):Polygon
	{
		return new Polygon(polygon.points);
	}

	/**
	 * Checks if a point is within the bounds of a Polygon.
	 *
	 * @since 1.0.0
	 *
	 * @param polygon - The Polygon to check against.
	 * @param x - The X coordinate of the point to check.
	 * @param y - The Y coordinate of the point to check.
	 *
	 * @return `true` if the point is within the bounds of the Polygon, otherwise `false`.
	**/
	public static function Contains(polygon:Polygon, x:Float, y:Float):Bool
	{
		var inside = false;
		var i = -1, j = polygon.points.length - 1;

		while (++i < polygon.points.length)
		{
			var ix = polygon.points[i].x;
			var iy = polygon.points[i].y;

			var jx = polygon.points[j].x;
			var jy = polygon.points[j].y;

			if (((iy <= y && y < jy) || (jy <= y && y < iy)) && (x < (jx - ix) * (y - iy) / (jy - iy) + ix))
			{
				inside = !inside;
			}
			j = i;
		}

		return inside;
	}

	/**
	 * [description]
	 *
	 * @since 1.0.0
	 *
	 * @param polygon - [description]
	 * @param point - [description]
	 *
	 * @return [description]
	**/
	public static function ContainsPoint(polygon:Polygon, point:Point):Bool
	{
		return Contains(polygon, point.x, point.y);
	}

	/**
	 * Stores all of the points of a Polygon into a flat array of numbers following the sequence [ x,y, x,y, x,y ],
	 * i.e. each point of the Polygon, in the order it's defined, corresponds to two elements of the resultant
	 * array for the point's X and Y coordinate.
	 *
	 * @since 1.0.0
	 *
	 * @param polygon - The Polygon whose points to export.
	 * @param output - An array to which the points' coordinates should be appended.
	 *
	 * @return The modified `output` array, or a new array if none was given.
	**/
	public static function GetNumberArray(polygon:Polygon, ?output:Array<Float>):Array<Float>
	{
		if (output == null)
		{
			output = [];
		}

		for (i in 0...polygon.points.length)
		{
			output.push(polygon.points[i].x);
			output.push(polygon.points[i].y);
		}

		return output;
	}

	/**
	 * Returns an array of Point objects containing the coordinates of the points around the perimeter of the Polygon,
	 * based on the given quantity or stepRate values.
	 *
	 * @since 1.0.0
	 *
	 * @param polygon - The Polygon to get the points from.
	 * @param quantity - The amount of points to return. If a falsey value the quantity will be derived from the `stepRate` instead.
	 * @param stepRate - Sets the quantity by getting the perimeter of the Polygon and dividing it by the stepRate.
	 * @param output - An array to insert the points in to. If not provided a new array will be created.
	 *
	 * @return An array of Point objects pertaining to the points around the perimeter of the Polygon.
	**/
	public static function GetPoints(polygon:Polygon, quantity:Int, stepRate:Float = 0, ?out:Array<Point>):Array<Point>
	{
		if (out == null)
		{
			out = [];
		}

		var points = polygon.points;
		var perimeter = Perimeter(polygon);

		var quantityFloat:Float = quantity;

		if (quantity == 0)
		{
			quantityFloat = perimeter / stepRate;
			quantity = Std.int(quantityFloat);
		}

		for (i in 0...quantity)
		{
			var position = perimeter * (i / quantityFloat);
			var accumulatedPerimeter = 0.0;

			for (j in 0...points.length)
			{
				var pointA = points[j];
				var pointB = points[(j + 1) % points.length];
				var line = new Line(pointA.x, pointA.y, pointB.x, pointB.y);
				var length = LineUtil.Length(line);

				if (position < accumulatedPerimeter || position > accumulatedPerimeter + length)
				{
					accumulatedPerimeter += length;
					continue;
				}

				var point = line.getPoint((position - accumulatedPerimeter) / length);
				out.push(point);

				break;
			}
		}

		return out;
	}

	/**
	 * Calculates the bounding AABB rectangle of a polygon.
	 *
	 * @since 1.0.0
	 *
	 * @param polygon - The polygon that should be calculated.
	 * @param out - The rectangle or object that has x, y, width, and height properties to store the result. Optional.
	 *
	 * @return The resulting rectangle or object that is passed in with position and dimensions of the polygon's AABB.
	**/
	public static function GetAABB(polygon:Polygon, ?out:Rectangle):Rectangle
	{
		if (out == null)
		{
			out = new Rectangle();
		}

		var minX = Math.POSITIVE_INFINITY;
		var minY = Math.POSITIVE_INFINITY;
		var maxX = -minX;
		var maxY = -minY;
		var p;

		for (i in 0...polygon.points.length)
		{
			p = polygon.points[i];

			minX = Math.min(minX, p.x);
			minY = Math.min(minY, p.y);
			maxX = Math.max(maxX, p.x);
			maxY = Math.max(maxY, p.y);
		}

		out.x = minX;
		out.y = minY;
		out.width = maxX - minX;
		out.height = maxY - minY;

		return out;
	}

	/**
	 * Returns the perimeter of the given Polygon.
	 *
	 * @since 1.0.0
	 *
	 * @param polygon - The Polygon to get the perimeter of.
	 *
	 * @return The perimeter of the Polygon.
	**/
	public static function Perimeter(polygon:Polygon):Float
	{
		var points = polygon.points;
		var perimeter = 0.0;

		for (i in 0...points.length)
		{
			var pointA = points[i];
			var pointB = points[(i + 1) % points.length];
			var line = new Line(pointA.x, pointA.y, pointB.x, pointB.y);

			perimeter += LineUtil.Length(line);
		}

		return perimeter;
	}

	/**
	 * Reverses the order of the points of a Polygon.
	 *
	 * @since 1.0.0
	 *
	 * @param polygon - The Polygon to modify.
	 *
	 * @return The modified Polygon.
	**/
	public static function Reverse(polygon:Polygon):Polygon
	{
		polygon.points.reverse();

		return polygon;
	}

	/**
	 * Takes a Polygon object and applies Chaikin's smoothing algorithm on its points.
	 *
	 * @since 1.0.0
	 *
	 * @param polygon - The polygon to be smoothed. The polygon will be modified in-place and returned.
	 *
	 * @return The input polygon.
	**/
	public static function Smooth(polygon:Polygon):Polygon
	{
		inline function copy(out:Array<Float>, a:Array<Float>)
		{
			out[0] = a[0];
			out[1] = a[1];

			return out;
		}

		var i;
		var points = [];
		var data = polygon.points;

		for (i in 0...data.length)
		{
			points.push([data[i].x, data[i].y]);
		}

		var output = [];

		if (points.length > 0)
		{
			output.push(copy([0, 0], points[0]));
		}

		for (i in 0...(points.length - 1))
		{
			var p0 = points[i];
			var p1 = points[i + 1];
			var p0x = p0[0];
			var p0y = p0[1];
			var p1x = p1[0];
			var p1y = p1[1];

			output.push([0.85 * p0x + 0.15 * p1x, 0.85 * p0y + 0.15 * p1y]);
			output.push([0.15 * p0x + 0.85 * p1x, 0.15 * p0y + 0.85 * p1y]);
		}

		if (points.length > 1)
		{
			output.push(copy([0, 0], points[points.length - 1]));
		}

		return polygon.setToFromMultiArray(output);
	}
}
