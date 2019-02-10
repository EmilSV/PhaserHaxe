package phaserHaxe.math;

/**
 * A representation of a vector in 4D space.
 *
 * A four-component vector.
 *
 * @since 1.0.0
 *
**/
class Vector4
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
	 * The z component of this Vector.
	 *
	 * @since 1.0.0
	**/
	public var z:Float;

	/**
	 * The w component of this Vector.
	 *
	 * @since 1.0.0
	**/
	public var w:Float;

	public function new(x:Float = 0, y:Float = 0, z:Float = 0, w:Float = 0)
	{
		this.x = x;
		this.y = y;
		this.z = z;
		this.w = w;
	}

	/**
	 * Make a clone of this Vector4.
	 *
	 * @since 1.0.0
	 *
	 * @return {Phaser.Math.Vector4} A clone of this Vector4.
	**/
	public function clone()
	{
		return new Vector4(this.x, this.y, this.z, this.w);
	}

	/**
	 * Copy the components of a given Vector into this Vector.
	 *
	 * @since 1.0.0
	 *
	 * @param {Phaser.Math.Vector4} src - The Vector to copy the components from.
	 *
	 * @return {Phaser.Math.Vector4} This Vector4.
	**/
	public function copy(src)
	{
		this.x = src.x;
		this.y = src.y;
		this.z = src.z;
		this.w = src.w;
		return this;
	}

	/**
	 * Check whether this Vector is equal to a given Vector.
	 *
	 * Performs a strict quality check against each Vector's components.
	 *
	 * @since 1.0.0
	 *
	 * @param {Phaser.Math.Vector4} v - The vector to check equality with.
	 *
	 * @return {boolean} A boolean indicating whether the two Vectors are equal or not.
	**/
	public function equals(v)
	{
		return ((this.x == v.x) && (this.y == v.y) && (this.z == v.z) && (this.w == v.w));
	}

	/**
	 * Set the `x`, `y`, `z` and `w` components of the this Vector to the given `x`, `y`, `z` and `w` values.
	 *
	 * @since 1.0.0
	 *
	 * @param {(number|object)} x - The x value to set for this Vector, or an object containing x, y, z and w components.
	 * @param {number} y - The y value to set for this Vector.
	 * @param {number} z - The z value to set for this Vector.
	 * @param {number} w - The z value to set for this Vector.
	 *
	 * @return {Phaser.Math.Vector4} This Vector4.
	**/
	public function set(x, y, z, w)
	{
		this.x = x;
		this.y = y;
		this.z = z;
		this.w = w;
		return this;
	}

	/**
	 * Add a given Vector to this Vector. Addition is component-wise.
	 *
	 * @since 1.0.0
	 *
	 * @param {(Phaser.Math.Vector2|Phaser.Math.Vector3|Phaser.Math.Vector4)} v - The Vector to add to this Vector.
	 *
	 * @return {Phaser.Math.Vector4} This Vector4.
	**/
	public function add(v)
	{
		this.x += v.x;
		this.y += v.y;
		this.z += v.z;
		this.w += v.w;
		return this;
	}

	/**
	 * Subtract the given Vector from this Vector. Subtraction is component-wise.
	 *
	 * @since 1.0.0
	 *
	 * @param {(Phaser.Math.Vector2|Phaser.Math.Vector3|Phaser.Math.Vector4)} v - The Vector to subtract from this Vector.
	 *
	 * @return {Phaser.Math.Vector4} This Vector4.
	**/
	public function subtract(v)
	{
		this.x -= v.x;
		this.y -= v.y;
		this.z -= v.z;
		this.w -= v.w;
		return this;
	}

	/**
	 * Scale this Vector by the given value.
	 *
	 * @since 1.0.0
	 *
	 * @param {number} scale - The value to scale this Vector by.
	 *
	 * @return {Phaser.Math.Vector4} This Vector4.
	**/
	public function scale(scale)
	{
		this.x *= scale;
		this.y *= scale;
		this.z *= scale;
		this.w *= scale;
		return this;
	}

	/**
	 * Calculate the length (or magnitude) of this Vector.
	 *
	 * @since 1.0.0
	 *
	 * @return {number} The length of this Vector.
	**/
	public function length()
	{
		var x = this.x;
		var y = this.y;
		var z = this.z;
		var w = this.w;
		return Math.sqrt(x * x + y * y + z * z + w * w);
	}

	/**
	 * Calculate the length of this Vector squared.
	 *
	 * @since 1.0.0
	 *
	 * @return {number} The length of this Vector, squared.
	**/
	public function lengthSq()
	{
		var x = this.x;
		var y = this.y;
		var z = this.z;
		var w = this.w;
		return x * x + y * y + z * z + w * w;
	}

	/**
	 * Normalize this Vector.
	 *
	 * Makes the vector a unit length vector (magnitude of 1) in the same direction.
	 *
	 * @since 1.0.0
	 *
	 * @return {Phaser.Math.Vector4} This Vector4.
	**/
	public function normalize()
	{
		var x = this.x;
		var y = this.y;
		var z = this.z;
		var w = this.w;
		var len = x * x + y * y + z * z + w * w;
		if (len > 0)
		{
			len = 1 / Math.sqrt(len);
			this.x = x * len;
			this.y = y * len;
			this.z = z * len;
			this.w = w * len;
		}
		return this;
	}

	/**
	 * Calculate the dot product of this Vector and the given Vector.
	 *
	 * @since 1.0.0
	 *
	 * @param {Phaser.Math.Vector4} v - The Vector4 to dot product with this Vector4.
	 *
	 * @return {number} The dot product of this Vector and the given Vector.
	**/
	public function dot(v)
	{
		return this.x * v.x + this.y * v.y + this.z * v.z + this.w * v.w;
	}

	/**
	 * Linearly interpolate between this Vector and the given Vector.
	 *
	 * Interpolates this Vector towards the given Vector.
	 *
	 *
	 * @param {Phaser.Math.Vector4} v - The Vector4 to interpolate towards.
	 * @param {number} [t=0] - The interpolation percentage, between 0 and 1.
	 *
	 * @return {Phaser.Math.Vector4} This Vector4.
	**/
	public function lerp(v, t = 0)
	{
		var ax = this.x;
		var ay = this.y;
		var az = this.z;
		var aw = this.w;
		this.x = ax + t * (v.x - ax);
		this.y = ay + t * (v.y - ay);
		this.z = az + t * (v.z - az);
		this.w = aw + t * (v.w - aw);
		return this;
	}

	/**
	 * Perform a component-wise multiplication between this Vector and the given Vector.
	 *
	 * Multiplies this Vector by the given Vector.
	 *
	 * @since 1.0.0
	 *
	 * @param {(Phaser.Math.Vector2|Phaser.Math.Vector3|Phaser.Math.Vector4)} v - The Vector to multiply this Vector by.
	 *
	 * @return {Phaser.Math.Vector4} This Vector4.
	**/
	public function multiply(v)
	{
		this.x *= v.x;
		this.y *= v.y;
		this.z *= v.z;
		this.w *= v.w;
		return this;
	}

	/**
	 * Perform a component-wise division between this Vector and the given Vector.
	 *
	 * Divides this Vector by the given Vector.
	 *
	 * @since 1.0.0
	 *
	 * @param {(Phaser.Math.Vector2|Phaser.Math.Vector3|Phaser.Math.Vector4)} v - The Vector to divide this Vector by.
	 *
	 * @return {Phaser.Math.Vector4} This Vector4.
	**/
	public function divide(v)
	{
		this.x /= v.x;
		this.y /= v.y;
		this.z /= v.z;
		this.w /= v.w;
		return this;
	}

	/**
	 * Calculate the distance between this Vector and the given Vector.
	 *
	 * @since 1.0.0
	 *
	 * @param {(Phaser.Math.Vector2|Phaser.Math.Vector3|Phaser.Math.Vector4)} v - The Vector to calculate the distance to.
	 *
	 * @return {number} The distance from this Vector to the given Vector.
	**/
	public function distance(v)
	{
		var dx = v.x - this.x;
		var dy = v.y - this.y;
		var dz = v.z - this.z;
		var dw = v.w - this.w;
		return Math.sqrt(dx * dx + dy * dy + dz * dz + dw * dw);
	}

	/**
	 * Calculate the distance between this Vector and the given Vector, squared.
	 *
	 * @since 1.0.0
	 *
	 * @param {(Phaser.Math.Vector2|Phaser.Math.Vector3|Phaser.Math.Vector4)} v - The Vector to calculate the distance to.
	 *
	 * @return {number} The distance from this Vector to the given Vector, squared.
	**/
	public function distanceSq(v)
	{
		var dx = v.x - this.x;
		var dy = v.y - this.y;
		var dz = v.z - this.z;
		var dw = v.w - this.w;
		return dx * dx + dy * dy + dz * dz + dw * dw;
	}

	/**
	 * Negate the `x`, `y`, `z` and `w` components of this Vector.
	 *
	 * @since 1.0.0
	 *
	 * @return {Phaser.Math.Vector4} This Vector4.
	**/
	public function negate()
	{
		this.x = -this.x;
		this.y = -this.y;
		this.z = -this.z;
		this.w = -this.w;
		return this;
	}

	/**
	 * Transform this Vector with the given Matrix.
	 *
	 * @since 1.0.0
	 *
	 * @param {Phaser.Math.Matrix4} mat - The Matrix4 to transform this Vector4 with.
	 *
	 * @return {Phaser.Math.Vector4} This Vector4.
	**/
	public function transformMat4(mat)
	{
		var x = this.x;
		var y = this.y;
		var z = this.z;
		var w = this.w;
		var m = mat.val;
		this.x = m[0] * x + m[4] * y + m[8] * z + m[12] * w;
		this.y = m[1] * x + m[5] * y + m[9] * z + m[13] * w;
		this.z = m[2] * x + m[6] * y + m[10] * z + m[14] * w;
		this.w = m[3] * x + m[7] * y + m[11] * z + m[15] * w;
		return this;
	}

	/**
	 * Transform this Vector with the given Quaternion.
	 *
	 * @since 1.0.0
	 *
	 * @param {Phaser.Math.Quaternion} q - The Quaternion to transform this Vector with.
	 *
	 * @return {Phaser.Math.Vector4} This Vector4.
	**/
	public function transformQuat(q)
	{
		// TODO: is this really the same as Vector3?
		// Also, what about this: http://molecularmusings.wordpress.com/2013/05/24/a-faster-quaternion-vector-multiplication/
		// benchmarks: http://jsperf.com/quaternion-transform-vec3-implementations
		var x = this.x;
		var y = this.y;
		var z = this.z;
		var qx = q.x;
		var qy = q.y;
		var qz = q.z;
		var qw = q.w;
		// calculate quat * vec
		var ix = qw * x + qy * z - qz * y;
		var iy = qw * y + qz * x - qx * z;
		var iz = qw * z + qx * y - qy * x;
		var iw = -qx * x - qy * y - qz * z;
		// calculate result * inverse quat
		this.x = ix * qw + iw * -qx + iy * -qz - iz * -qy;
		this.y = iy * qw + iw * -qy + iz * -qx - ix * -qz;
		this.z = iz * qw + iw * -qz + ix * -qy - iy * -qx;
		return this;
	}

	/**
	 * Make this Vector the zero vector (0, 0, 0, 0).
	 *
	 * @since 1.0.0
	 *
	 * @return {Phaser.Math.Vector4} This Vector4.
	**/
	public function reset()
	{
		this.x = 0;
		this.y = 0;
		this.z = 0;
		this.w = 0;
		return this;
	}
}
