package phaserX.math;

class Vector2
{
	public var x:Float;
	public var y:Float;

	public function new(x:Float, ?y:Float)
	{
		this.x = x;
		this.y = if (y != null) y else x;
	}

	public static function fromObject(obj:{x:Float, y:Float})
	{
		return new Vector2(obj.x, obj.y);
	}

	/**
	 * Make a clone of this Vector2.
	 *
	 * @since 1.0.0
	 *
	 * @return A clone of this Vector2.
	**/
	public function clone():Vector2
	{
		return new Vector2(x, y);
	}

	/**
	 * Copy the components of a given Vector into this Vector.
	 *
	 * @since 1.0.0
	 * @param src The Vector to copy the components from.
	 * @return This Vector2.
	**/
	public function copy(src:Vector2):Vector2
	{
		this.x = src.x;
		this.y = src.y;

		return this;
	}

	/**
	 * Set the component values of this Vector from a given Vector2Like object.
	 *
	 * @since 1.0.0
	 *
	 * @param obj - The object containing the component values to set for this Vector.
	 *
	 * @return This Vector2.
	**/
	public function setFromObject(obj:{x:Float, y:Float})
	{
		this.x = obj.x;
		this.y = obj.y;

		return this;
	}

	/**
	 * Set the `x` and `y` components of the this Vector to the given `x` and `y` values.
	 *
	 * @since 1.0.0
	 *
	 * @param x The x value to set for this Vector.
	 * @param y The y value to set for this Vector.
	 *
	 * @return {Phaser.Math.Vector2} This Vector2.
	**/
	public function set(x:Float, ?y:Float):Vector2
	{
		if (y == null)
		{
			this.x = x;
			this.y = x;
		}
		else
		{
			this.x = x;
			this.y = y;
		}

		return this;
	}

	/**
	 * This method is an alias for `Vector2.set`.
	 *
	 * @since 1.0.0
	 *
	 * @param x The x value to set for this Vector.
	 * @param y The y value to set for this Vector.
	 *
	 * @return This Vector2.
	**/
	public inline function setTo(x:Float, ?y:Float):Vector2
	{
		return this.set(x, y);
	}

	/**
	 * Sets the `x` and `y` values of this object from a given polar coordinate.
	 *
	 * @since 1.0.0
	 *
	 * @param azimuth The angular coordinate, in radians.
	 * @param radius The radial coordinate (length).
	 *
	 * @return This Vector2.
	**/
	public function setToPolar(azimuth:Float, radius:Float = 1):Vector2
	{
		this.x = Math.cos(azimuth) * radius;
		this.y = Math.sin(azimuth) * radius;
		return this;
	}

	/**
	 * Check whether this Vector is equal to a given Vector.
	 *
	 * Performs a strict equality check against each Vector's components.
	 *
	 * @since 1.0.0
	 *
	 * @param v The vector to compare with this Vector.
	 *
	 * @return Whether the given Vector is equal to this Vector.
	**/
	public function equals(v:Vector2):Bool
	{
		return (this.x == v.x) && (this.y == v.y);
	}

	/**
	 * Calculate the angle between this Vector and the positive x-axis, in radians.
	 *
	 * @since 1.0.0
	 *
	 * @return The angle between this Vector, and the positive x-axis, given in radians.
	**/
	public function angle():Float
	{
		// computes the angle in radians with respect to the positive x-axis

		var angle = Math.atan2(this.y, this.x);

		if (angle < 0)
		{
			angle += 2 * Math.PI;
		}

		return angle;
	}

	/**
	 * Add a given Vector to this Vector. Addition is component-wise.
	 *
	 * @since 1.0.0
	 *
	 * @param src The Vector to add to this Vector.
	 *
	 * @return This Vector2.
	**/
	public function add(src:Vector2):Vector2
	{
		this.x += src.x;
		this.y += src.y;
		return this;
	}

	/**
	 * Subtract the given Vector from this Vector. Subtraction is component-wise.
	 *
	 * @since 1.0.0
	 *
	 * @param src The Vector to subtract from this Vector.
	 *
	 * @return This Vector2.
	**/
	public function subtract(src:Vector2):Vector2
	{
		this.x -= src.x;
		this.y -= src.y;
		return this;
	}

	/**
	 * Perform a component-wise multiplication between this Vector and the given Vector.
	 *
	 * Multiplies this Vector by the given Vector.
	 *
	 * @since 1.0.0
	 *
	 * @param src The Vector to multiply this Vector by.
	 *
	 * @return This Vector2.
	**/
	public function multiply(src:Vector2):Vector2
	{
		this.x *= src.x;
		this.y *= src.y;
		return this;
	}

	/**
	 * Scale this Vector by the given value.
	 *
	 * @since 1.0.0
	 *
	 * @param value The value to scale this Vector by.
	 *
	 * @return This Vector2.
	**/
	public function scale(value:Float):Vector2
	{
		if (Math.isFinite(value))
		{
			this.x *= value;
			this.y *= value;
		}
		else
		{
			this.x = 0;
			this.y = 0;
		}

		return this;
	}

	/**
	 * Perform a component-wise division between this Vector and the given Vector.
	 *
	 * Divides this Vector by the given Vector.
	 *
	 * @since 1.0.0
	 *
	 * @param src The Vector to divide this Vector by.
	 *
	 * @return This Vector2.
	**/
	public function divide(src:Vector2):Vector2
	{
		this.x /= src.x;
		this.y /= src.y;

		return this;
	}
}
