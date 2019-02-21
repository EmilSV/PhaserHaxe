package phaserHaxe.geom;

/**
 * Encapsulates a 2D rectangle defined by its corner point
 * in the top-left and its extends in x (width) and y (height)
 *
 * @since 1.0.0
 *
**/
class Rectangle
{
	/**
	 * The X coordinate of the top left corner of the Rectangle.
	 *
	 * @name Phaser.Geom.Rectangle#x
	 * @type {number}
	 * @default 0
	 * @since 3.0.0
	**/
	public var x:Float;

	/**
	 * The Y coordinate of the top left corner of the Rectangle.
	 *
	 * @name Phaser.Geom.Rectangle#y
	 * @type {number}
	 * @default 0
	 * @since 3.0.0
	 */
	public var y:Float;

	/**
	 * The width of the Rectangle, i.e. the distance between its left side (defined by `x`) and its right side.
	 *
	 * @name Phaser.Geom.Rectangle#width
	 * @type {number}
	 * @default 0
	 * @since 3.0.0
	 */
	public var width:Float;

	/**
	 * The height of the Rectangle, i.e. the distance between its top side (defined by `y`) and its bottom side.
	 *
	 * @name Phaser.Geom.Rectangle#height
	 * @type {number}
	 * @default 0
	 * @since 3.0.0
	**/
	public var height:Float;

	/**
	 * The x coordinate of the left of the Rectangle.
	 * Changing the left property of a Rectangle object has no effect on the y and height properties. However it does affect the width property, whereas changing the x value does not affect the width property.
	 *
	 * @name Phaser.Geom.Rectangle#left
	 * @type {number}
	 * @since 3.0.0
	**/
	public var left(get, set):Float;

	/**
	 * The sum of the x and width properties.
	 * Changing the right property of a Rectangle object has no effect on the x, y and height properties, however it does affect the width property.
	 *
	 * @since 1.0.0
	**/
	public var right(get, set):Float;

	/**
	 * The y coordinate of the top of the Rectangle. Changing the top property of a Rectangle object has no effect on the x and width properties.
	 * However it does affect the height property, whereas changing the y value does not affect the height property.
	 *
	 * @name Phaser.Geom.Rectangle#top
	 * @type {number}
	 * @since 3.0.0
	**/
	public var top(get, set):Float;

	/**
	 * The sum of the y and height properties.
	 * Changing the bottom property of a Rectangle object has no effect on the x, y and width properties, but does change the height property.
	 *
	 * @name Phaser.Geom.Rectangle#bottom
	 * @type {number}
	 * @since 3.0.0
	**/
	public var bottom(get, set):Float;

	/**
	 * The x coordinate of the center of the Rectangle.
	 *
	 * @since 1.0.0
	**/
	public var centerX(get, set):Float;

	/**
	 * The y coordinate of the center of the Rectangle.
	 *
	 * @since 1.0.0
	**/
	public var centerY(get, set):Float;

	/**
	 * @param x - The X coordinate of the top left corner of the Rectangle.
	 * @param y - The Y coordinate of the top left corner of the Rectangle.
	 * @param width - The width of the Rectangle.
	 * @param height - The height of the Rectangle.
	**/
	public function new(x:Float = 0, y:Float = 0, width:Float = 0, height:Float = 0)
	{
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;
	}

	private inline function get_left()
	{
		return this.x;
	}

	private function set_left(value)
	{
		if (value >= this.right)
		{
			this.width = 0;
		}
		else
		{
			this.width = this.right - value;
		}
		return value;
	}

	private inline function get_right()
	{
		return this.x + this.width;
	}

	private function set_right(value)
	{
		if (value <= this.x)
		{
			this.width = 0;
		}
		else
		{
			this.width = value - this.x;
		}
		return value;
	}

	private inline function get_top()
	{
		return this.y;
	}

	private function set_top(value)
	{
		if (value >= this.bottom)
		{
			this.height = 0;
		}
		else
		{
			this.height = (this.bottom - value);
		}

		this.y = value;
		return value;
	}

	private inline function get_bottom()
	{
		return this.y + this.height;
	}

	private function set_bottom(value)
	{
		if (value <= this.y)
		{
			this.height = 0;
		}
		else
		{
			this.height = value - this.y;
		}
		return value;
	}

	private inline function get_centerX()
	{
		return this.x + (this.width / 2);
	}

	private inline function set_centerX(value)
	{
		this.x = value - (this.width / 2);
		return value;
	}

	private inline function get_centerY()
	{
		return this.y + (this.height / 2);
	}

	private inline function set_centerY(value)
	{
		this.y = value - (this.height / 2);
		return value;
	}
}
