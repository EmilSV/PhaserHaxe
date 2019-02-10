package phaserHaxe.math;

import phaserHaxe.math.Vector2Like;

/**
 * A representation of a vector in 2D space.
 *
 * A two-component vector.
 *
 * @since 1.0.0
**/
class Vector2
{
	/**
	 * The x component of this Vector.
	 *
	 * @since 1.0.0
	**/
	public var x:Float;

	/**
	 * The y component of this Vector.
	 *
	 * @since 1.0.0
	**/
	public var y:Float;

	/**
	 * @param x The x component.
	 * @param y The y component.
	**/
	public function new(x:Float, ?y:Float)
	{
		this.x = x;
		this.y = if (y != null) y else x;
	}

	/**
	 * create a vector from a vector like object.
	 *
	 * @since 1.0.0
	 *
	 * @param obj The object containing the component values to create Vector from.
	 *
	 * @return The new Vector2.
	**/
	public static inline function fromObject(obj:Vector2Like):Vector2
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
		x = src.x;
		y = src.y;

		return this;
	}

	/**
	 * Set the component values of this Vector from a given Vector2Like object.
	 *
	 * @since 1.0.0
	 *
	 * @param obj The object containing the component values to set for this Vector.
	 *
	 * @return This Vector2.
	**/
	public function setFromObject(obj:Vector2Like)
	{
		x = obj.x;
		y = obj.y;

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
	 * @return This Vector2.
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
		x = Math.cos(azimuth) * radius;
		y = Math.sin(azimuth) * radius;
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
		return (x == v.x) && (y == v.y);
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

		var angle = Math.atan2(y, x);

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
		x += src.x;
		y += src.y;
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
		x *= src.x;
		y *= src.y;
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
			x *= value;
			y *= value;
		}
		else
		{
			x = 0;
			y = 0;
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
		x /= src.x;
		y /= src.y;

		return this;
	}

	/**
	 * Negate the `x` and `y` components of this Vector.
	 *
	 * @since 1.0.0
	 *
	 * @return This Vector2.
	**/
	public function negate():Vector2
	{
		x = -x;
		y = -y;
		return this;
	}

	/**
	 * Calculate the distance between this Vector and the given Vector.
	 *
	 * @since 1.0.0
	 *
	 * @param src The Vector to calculate the distance to.
	 *
	 * @return The distance from this Vector to the given Vector.
	**/
	public function distance(src:Vector2):Float
	{
		var dx = src.x - x;
		var dy = src.y - y;
		return Math.sqrt(dx * dx + dy * dy);
	}

	/**
	 * Calculate the distance between this Vector and the given Vector, squared.
	 *
	 * @since 1.0.0
	 *
	 * @param src The Vector to calculate the distance to.
	 *
	 * @return The distance from this Vector to the given Vector, squared.
	**/
	public function distanceSq(src:Vector2):Float
	{
		var dx = src.x - x;
		var dy = src.y - y;
		return dx * dx + dy * dy;
	}

	/**
	 * Calculate the length (or magnitude) of this Vector.
	 *
	 * @since 1.0.0
	 *
	 * @return The length of this Vector.
	**/
	public function length():Float
	{
		return Math.sqrt(x * x + y * y);
	}

	/**
	 * Calculate the length of this Vector squared.
	 *
	 * @since 1.0.0
	 *
	 * @return The length of this Vector, squared.
	**/
	public function lengthSq():Float
	{
		return x * x + y * y;
	}

	/**
	 * Normalize this Vector.
	 *
	 * Makes the vector a unit length vector (magnitude of 1) in the same direction.
	 *
	 * @since 1.0.0
	 *
	 * @return This Vector2.
	**/
	public function normalize():Vector2
	{
		var len = x * x + y * y;
		if (len > 0)
		{
			len = 1 / Math.sqrt(len);
			x = x * len;
			y = y * len;
		}
		return this;
	}

	/**
	 * Right-hand normalize (make unit length) this Vector.
	 *
	 * @since 1.0.0
	 *
	 * @return This Vector2.
	**/
	public function normalizeRightHand():Vector2
	{
		var localX = x;
		x = y * -1;
		y = localX;
		return this;
	}

	/**
	 * Calculate the dot product of this Vector and the given Vector.
	 *
	 * @since 1.0.0
	 *
	 * @param src The Vector2 to dot product with this Vector2.
	 *
	 * @return The dot product of this Vector and the given Vector.
	**/
	public function dot(src:Vector2):Float
	{
		return x * src.x + y * src.y;
	}

	/**
	 * Calculate the cross product of this Vector and the given Vector.
	 *
	 * @since 1.0.0
	 *
	 * @param src The Vector2 to cross with this Vector2.
	 *
	 * @return The cross product of this Vector and the given Vector.
	**/
	public function cross(src:Vector2):Float
	{
		return x * src.y - y * src.x;
	}

	/**
	 * Linearly interpolate between this Vector and the given Vector.
	 *
	 * Interpolates this Vector towards the given Vector.
	 *
	 * @since 1.0.0
	 *
	 * @param src The Vector2 to interpolate towards.
	 * @param t The interpolation percentage, between 0 and 1.
	 *
	 * @return This Vector2.
	**/
	public function lerp(src:Vector2, t:Float = 0):Vector2
	{
		var ax = x;
		var ay = y;

		x = ax + t * (src.x - ax);
		y = ay + t * (src.y - ay);
		return this;
	}

	/**
	 * Transform this Vector with the given Matrix.
	 *
	 * @method Phaser.Math.Vector2#transformMat3
	 * @since 1.0.0
	 *
	 * @param mat The Matrix3 to transform this Vector2 with.
	 *
	 * @return This Vector2.
	**/
	public function transformMat3(mat):Vector2
	{
		var localX = x;
		var localY = y;
		var m = mat.val;
		x = m[0] * localX + m[3] * localY + m[6];
		y = m[1] * localX + m[4] * localY + m[7];
		return this;
	}

	/**
	 * Transform this Vector with the given Matrix.
	 *
	 * @since 1.0.0
	 *
	 * @param mat The Matrix4 to transform this Vector2 with.
	 *
	 * @return This Vector2.
	**/
	public function transformMat4(mat):Vector2
	{
		var localX = x;
		var localY = y;
		var m = mat.val;
		x = m[0] * localX + m[4] * localY + m[12];
		y = m[1] * localX + m[5] * localY + m[13];
		return this;
	}

	/**
	 * Make this Vector the zero vector (0, 0).
	 *
	 * @since 1.0.0
	 *
	 * @return This Vector2.
	**/
	public function reset()
	{
		x = 0;
		y = 0;
		return this;
	}

	/**
	 * A static zero Vector2 for use by reference.
	 *
	 * This constant is meant for comparison operations and should not be modified directly.
	 *
	 * @since 1.0.0
	**/
	public static final ZERO:Vector2 = new Vector2(0, 0);

	/**
	 * A static right Vector2 for use by reference.
	 *
	 * This constant is meant for comparison operations and should not be modified directly.
	 *
	 * @since 1.0.0
	**/
	public static final RIGHT:Vector2 = new Vector2(1, 0);

	/**
	 * A static left Vector2 for use by reference.
	 *
	 * This constant is meant for comparison operations and should not be modified directly.
	 *
	 * @since 1.0.0
	 */
	public static final LEFT:Vector2 = new Vector2(-1, 0);

	/**
	 * A static up Vector2 for use by reference.
	 *
	 * This constant is meant for comparison operations and should not be modified directly.
	 *
	 * @since 1.0.0
	**/
	public static final UP:Vector2 = new Vector2(0, -1);

	/**
	 * A static down Vector2 for use by reference.
	 *
	 * This constant is meant for comparison operations and should not be modified directly.
	 *
	 * @since 1.0.0
	**/
	public static final DOWN:Vector2 = new Vector2(0, 1);

	/**
	 * A static one Vector2 for use by reference.
	 *
	 * This constant is meant for comparison operations and should not be modified directly.
	 *
	 * @since 1.0.0
	**/
	public static final ONE:Vector2 = new Vector2(1, 1);
}
