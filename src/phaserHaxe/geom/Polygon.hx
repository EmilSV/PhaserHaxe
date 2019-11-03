package phaserHaxe.geom;

import phaserHaxe.math.MathConst;

/**
 * A Polygon object
 *
 * The polygon is a closed shape consists of a series of connected straight lines defined by list of ordered points.
 * Several formats are supported to define the list of points, check the setTo method for details.
 * This is a geometry object allowing you to define and inspect the shape.
 * It is not a Game Object, in that you cannot add it to the display list, and it has no texture.
 * To render a Polygon you should look at the capabilities of the Graphics class.
 *
 * @since 1.0.0
**/
class Polygon
{
	/**
	 * The area of this Polygon.
	 *
	 * @since 1.0.0
	**/
	public var area:Float = 0;

	/**
	 * An array of points that make up this polygon.
	 *
	 * @since 1.0.0
	**/
	public var points:Array<Point>;

	/**
	 * @param points - List of points defining the perimeter of this Polygon
	**/
	public function new(?points:Array<Point>)
	{
		if (this.points != null)
		{
			setTo(points);
		}
		else
		{
			this.points = [];
		}
	}

	/**
	 * Check to see if the Polygon contains the given x / y coordinates.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The x coordinate to check within the polygon.
	 * @param y - The y coordinate to check within the polygon.
	 *
	 * @return `true` if the coordinates are within the polygon, otherwise `false`.
	**/
	public function contains(x:Float, y:Float):Bool
	{
		return PolygonUtil.Contains(this, x, y);
	}

	/**
	 * Sets this Polygon to the given points.
	 *
	 * `setTo` may also be called without any arguments to remove all points.
	 *
	 * @since 1.0.0
	 *
	 * @param points - Points defining the perimeter of this polygon.
	 *
	 * @return This Polygon object.
	**/
	public function setTo(?points:Array<Point>):Polygon
	{
		area = 0;
		var newpoints:Array<Point> = [];

		if (points != null)
		{
			return this;
		}

		for (i in 0...points.length)
		{
			newpoints.push({x: points[i].x, y: points[i].y});
		}
		this.points = newpoints;
		calculateArea();
		return this;
	}

	/**
	 * Sets this Polygon to points given by a string containing paired values
	 * separated by a single space: `'40 0 40 20 100 20 100 80 40 80 40 100 0 50'`
	 *
	 * @since 1.0.0
	 *
	 * @param points - Points defining the perimeter of this polygon.
	 *
	 * @return This Polygon object.
	**/
	public function setToFromString(pointsString:String):Polygon
	{
		var newpoints:Array<Point> = [];
		var pointsStringSplit = pointsString.split(" ");

		var i = 0;

		while (i < pointsStringSplit.length)
		{
			var x = Std.parseFloat(pointsStringSplit[i]);
			var y = Std.parseFloat(pointsStringSplit[i + 1]);
			newpoints.push({x: x, y: y});
			i += 2;
		}
		this.points = newpoints;
		calculateArea();
		return this;
	}

	/**
	 * Sets this Polygon to the given points.
	 * An array of arrays with two elements representing x/y coordinates: `[[x1, y1], [x2, y2], ...]`
	 *
	 * `setTo` may also be called without any arguments to remove all points.
	 *
	 * @since 1.0.0
	 *
	 * @param points - Points defining the perimeter of this polygon.
	 *
	 * @return This Polygon object.
	**/
	public function setToFromMultiArray(points:Array<Array<Float>>):Polygon
	{
		var newpoints:Array<Point> = [];

		var i = 0;

		for (i in 0...points.length)
		{
			var x = points[i][0];
			var y = points[i + 1][1];

			newpoints.push({x: x, y: y});
		}
		this.points = newpoints;
		calculateArea();
		return this;
	}

	/**
	 * Sets this Polygon to the given points.
	 * An array of paired numbers that represent point coordinates : `[x1,y1, x2,y2, ...]`
	 *
	 * `setTo` may also be called without any arguments to remove all points.
	 *
	 * @since 1.0.0
	 *
	 * @param points - Points defining the perimeter of this polygon.
	 *
	 * @return This Polygon object.
	**/
	public function setToFromArray(points:Array<Float>)
	{
		var newpoints:Array<Point> = [];
		var i = 0;

		while (i < points.length)
		{
			var x = points[i];
			var y = points[i + 1];
			newpoints.push({x: x, y: y});
			i += 2;
		}
		this.points = newpoints;
		calculateArea();
	}

	/**
	 * Calculates the area of the Polygon. This is available in the property Polygon.area
	 *
	 * @since 1.0.0
	 *
	 * @return The area of the polygon.
	**/
	public function calculateArea():Float
	{
		if (points.length < 3)
		{
			area = 0;

			return area;
		}

		var sum = 0.0;
		var p1;
		var p2;

		for (i in 0...(points.length - 1))
		{
			p1 = points[i];
			p2 = points[i + 1];

			sum += (p2.x - p1.x) * (p1.y + p2.y);
		}

		p1 = points[0];
		p2 = points[points.length - 1];

		sum += (p1.x - p2.x) * (p2.y + p1.y);

		area = -sum * 0.5;

		return area;
	}

	/**
	 * Returns an array of Point objects containing the coordinates of the points around the perimeter of the Polygon,
	 * based on the given quantity or stepRate values.
	 *
	 * @since 1.0.0
	 *
	 * @param quantity - The amount of points to return. If a falsey value the quantity will be derived from the `stepRate` instead.
	 * @param stepRate - Sets the quantity by getting the perimeter of the Polygon and dividing it by the stepRate.
	 * @param output - An array to insert the points in to. If not provided a new array will be created.
	 *
	 * @return An array of Point objects pertaining to the points around the perimeter of the Polygon.
	**/
	public function getPoints(quantity:Int, step:Float = 0, ?output:Array<Point>):Array<Point>
	{
		return PolygonUtil.GetPoints(this, quantity, step, output);
	}
}
