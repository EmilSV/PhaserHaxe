package phaserHaxe.math;

/**
 * A representation of a vector in 4D space.
 *
 * A four-component vector.
 *
 * @since 1.0.0
 *
**/
@:structInit
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
	 * @return A clone of this Vector4.
	**/
	public function clone():Vector4
	{
		return new Vector4(this.x, this.y, this.z, this.w);
	}

	/**
	 * Copy the components of a given Vector into this Vector.
	 *
	 * @since 1.0.0
	 *
	 * @param src - The Vector to copy the components from.
	 *
	 * @return This Vector4.
	**/
	public function copy(src:Vector4):Vector4
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
	 * @param v - The vector to check equality with.
	 *
	 * @return A boolean indicating whether the two Vectors are equal or not.
	**/
	public function equals(v:Vector4):Bool
	{
		return ((this.x == v.x) && (this.y == v.y) && (this.z == v.z) && (this
			.w == v.w));
	}

	/**
	 * Set the `x`, `y`, `z` and `w` components of the this Vector to the given `x`, `y`, `z` and `w` values.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The x value to set for this Vector, or an object containing x, y, z and w components.
	 * @param y - The y value to set for this Vector.
	 * @param z - The z value to set for this Vector.
	 * @param w - The z value to set for this Vector.
	 *
	 * @return This Vector4.
	**/
	public function set(x:Float, y:Float, z:Float, w:Float):Vector4
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
	 * @param v - The Vector to add to this Vector.
	 *
	 * @return This Vector4.
	**/
	public function add(v:Vector4):Vector4
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
	 * @param v - The Vector to subtract from this Vector.
	 *
	 * @return This Vector4.
	**/
	public function subtract(v:Vector4):Vector4
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
	 * @param scale - The value to scale this Vector by.
	 *
	 * @return This Vector4.
	**/
	public function scale(scale:Float):Vector4
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
	 * @return The length of this Vector.
	**/
	public function length():Float
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
	 * @return The length of this Vector, squared.
	**/
	public function lengthSq():Float
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
	 * @return This Vector4.
	**/
	public function normalize():Vector4
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
	 * @param v - The Vector4 to dot product with this Vector4.
	 *
	 * @return The dot product of this Vector and the given Vector.
	**/
	public function dot(v:Vector4):Float
	{
		return x * v.x + y * v.y + z * v.z + w * v.w;
	}

	/**
	 * Linearly interpolate between this Vector and the given Vector.
	 *
	 * Interpolates this Vector towards the given Vector.
	 *
	 *
	 * @param v - The Vector4 to interpolate towards.
	 * @param t - The interpolation percentage, between 0 and 1.
	 *
	 * @return This Vector4.
	**/
	public function lerp(v:Vector4, t:Float = 0):Vector4
	{
		var ax = x;
		var ay = y;
		var az = z;
		var aw = w;
		x = ax + t * (v.x - ax);
		y = ay + t * (v.y - ay);
		z = az + t * (v.z - az);
		w = aw + t * (v.w - aw);
		return this;
	}

	/**
	 * Perform a component-wise multiplication between this Vector and the given Vector.
	 *
	 * Multiplies this Vector by the given Vector.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The Vector to multiply this Vector by.
	 *
	 * @return This Vector4.
	**/
	public function multiply(v:Vector4):Vector4
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
	 * @param v - The Vector to divide this Vector by.
	 *
	 * @return This Vector4.
	**/
	public function divide(v:Vector4):Vector4
	{
		x /= v.x;
		y /= v.y;
		z /= v.z;
		w /= v.w;
		return this;
	}

	/**
	 * Calculate the distance between this Vector and the given Vector.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The Vector to calculate the distance to.
	 *
	 * @return The distance from this Vector to the given Vector.
	**/
	public function distance(v:Vector4):Float
	{
		var dx = v.x - x;
		var dy = v.y - y;
		var dz = v.z - z;
		var dw = v.w - w;
		return Math.sqrt(dx * dx + dy * dy + dz * dz + dw * dw);
	}

	/**
	 * Calculate the distance between this Vector and the given Vector, squared.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The Vector to calculate the distance to.
	 *
	 * @return The distance from this Vector to the given Vector, squared.
	**/
	public function distanceSq(v:Vector4):Float
	{
		var dx = v.x - x;
		var dy = v.y - y;
		var dz = v.z - z;
		var dw = v.w - w;
		return dx * dx + dy * dy + dz * dz + dw * dw;
	}

	/**
	 * Negate the `x`, `y`, `z` and `w` components of this Vector.
	 *
	 * @since 1.0.0
	 *
	 * @return This Vector4.
	**/
	public function negate():Vector4
	{
		x = -x;
		y = -y;
		z = -z;
		w = -w;
		return this;
	}

	/**
	 * Transform this Vector with the given Matrix.
	 *
	 * @since 1.0.0
	 *
	 * @param mat - The Matrix4 to transform this Vector4 with.
	 *
	 * @return This Vector4.
	**/
	public function transformMat4(mat:Matrix4):Vector4
	{
		var localX = x;
		var localY = y;
		var localZ = z;
		var localW = w;
		var m = mat.val;
		x = m[0] * localX + m[4] * localY + m[8] * localZ + m[12] * localW;
		y = m[1] * localX + m[5] * localY + m[9] * localZ + m[13] * localW;
		z = m[2] * localX + m[6] * localY + m[10] * localZ + m[14] * localW;
		w = m[3] * localX + m[7] * localY + m[11] * localZ + m[15] * localW;
		return this;
	}

	/**
	 * Transform this Vector with the given Quaternion.
	 *
	 * @since 1.0.0
	 *
	 * @param q - The Quaternion to transform this Vector with.
	 *
	 * @return This Vector4.
	**/
	public function transformQuat(q):Vector4
	{
		// TODO: is this really the same as Vector3?
		// Also, what about this: http://molecularmusings.wordpress.com/2013/05/24/a-faster-quaternion-vector-multiplication/
		// benchmarks: http://jsperf.com/quaternion-transform-vec3-implementations
		var localX = x;
		var localY = y;
		var localZ = z;
		var qx = q.x;
		var qy = q.y;
		var qz = q.z;
		var qw = q.w;
		// calculate quat * vec
		var ix = qw * localX + qy * localZ - qz * localY;
		var iy = qw * localY + qz * localX - qx * localZ;
		var iz = qw * localZ + qx * localY - qy * localX;
		var iw = -qx * localX - qy * localY - qz * localZ;
		// calculate result * inverse quat
		x = ix * qw + iw * -qx + iy * -qz - iz * -qy;
		y = iy * qw + iw * -qy + iz * -qx - ix * -qz;
		z = iz * qw + iw * -qz + ix * -qy - iy * -qx;
		return this;
	}

	/**
	 * Make this Vector the zero vector (0, 0, 0, 0).
	 *
	 * @since 1.0.0
	 *
	 * @return This Vector4.
	**/
	public function reset():Vector4
	{
		x = 0;
		y = 0;
		z = 0;
		w = 0;
		return this;
	}
}
