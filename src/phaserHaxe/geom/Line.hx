package phaserHaxe.geom;

final class Line
{
	/**
	 * The x coordinate of the lines starting point.
	 *
	 * @since 1.0.0
	**/
	public var x1:Float;

	/**
	 * The y coordinate of the lines starting point.
	 *
	 * @since 1.0.0
	**/
	public var y1:Float;

	/**
	 * The x coordinate of the lines ending point.
	 *
	 * @since 1.0.0
	**/
	public var x2:Float;

	/**
	 * The y coordinate of the lines ending point.
	 *
	 * @since 1.0.0
	**/
	public var y2:Float;

	/**
	 * The left position of the Line.
	 *
	 * @since 1.0.0
	**/
	public var left(get, set):Float;

	/**
	 * The right position of the Line.
	 *
	 * @since 1.0.0
	**/
	public var right(get, set):Float;

	/**
	 * The top position of the Line.
	 *
	 * @since 1.0.0
	**/
	public var top(get, set):Float;

	/**
	 * The bottom position of the Line.
	 *
	 * @since 1.0.0
	**/
	public var bottom(get, set):Float;

	public function new(x1:Float = 0, y1:Float = 0, x2:Float = 0, y2:Float = 0)
	{
		this.x1 = x1;
		this.y1 = y1;
		this.x2 = x2;
		this.y2 = y2;
	}

	private function get_left():Float
	{
		return Math.min(this.x1, this.x2);
	}

	private function set_left(value:Float):Float
	{
		if (this.x1 <= this.x2)
		{
			this.x1 = value;
		}
		else
		{
			this.x2 = value;
		}
		return value;
	}

	private function get_right():Float
	{
		return Math.max(this.x1, this.x2);
	}

	private function set_right(value:Float):Float
	{
		if (this.x1 > this.x2)
		{
			this.x1 = value;
		}
		else
		{
			this.x2 = value;
		}
		return value;
	}

	private function get_top():Float
	{
		return Math.min(this.y1, this.y2);
	}

	private function set_top(value:Float):Float
	{
		if (this.y1 <= this.y2)
		{
			this.y1 = value;
		}
		else
		{
			this.y2 = value;
		}
		return value;
	}

	private function get_bottom():Float
	{
		return Math.max(this.y1, this.y2);
	}

	private function set_bottom(value:Float):Float
	{
		if (this.y1 > this.y2)
		{
			this.y1 = value;
		}
		else
		{
			this.y2 = value;
		}
		return value;
	}

	/**
	 * Set new coordinates for the line endpoints.
	 *
	 * @method Phaser.Geom.Line#setTo
	 * @since 3.0.0
	 *
	 * @param {number} [x1=0] - The x coordinate of the lines starting point.
	 * @param {number} [y1=0] - The y coordinate of the lines starting point.
	 * @param {number} [x2=0] - The x coordinate of the lines ending point.
	 * @param {number} [y2=0] - The y coordinate of the lines ending point.
	 *
	 * @return {Phaser.Geom.Line} This Line object.
	**/
	public function setTo(x1:Float = 0, y1:Float = 0, x2:Float = 0, y2:Float = 0)
	{
		this.x1 = x1;
		this.y1 = y1;
		this.x2 = x2;
		this.y2 = y2;
		return this;
	}
}
