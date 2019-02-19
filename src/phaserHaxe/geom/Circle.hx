package phaserHaxe.geom;

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
}
