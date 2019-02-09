package phaserX.math;

/**
 * A representation of a vector in 3D space.
 *
 * A three-component vector.
 *
 * @since 1.0.0
**/
class Vector3
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

	public function new(x:Float, y:Float, z:Float)
	{
		this.x = x;
		this.y = y;
		this.z = z;
	}

	/**
	 * Set this Vector to point up.
	 *
	 * Sets the y component of the vector to 1, and the others to 0.
	 *
	 * @since 1.0.0
	 *
	 * @return This Vector3.
	**/
	public function up():Vector3
	{
		x = 0;
		y = 1;
		z = 0;
		return this;
	}

	/**
	 * Make a clone of this Vector3.
	 *
	 * @since 1.0.0
	 *
	 * @return A new Vector3 object containing this Vectors values.
	**/
	public function clone():Vector3
	{
		return new Vector3(x, y, z);
	}

	/**
	 * Calculate the cross (vector) product of two given Vectors.
	 *
	 * @since 1.0.0
	 *
	 * @param a The first Vector to multiply.
	 * @param b The second Vector to multiply.
	 *
	 * @return This Vector3.
	**/
	public function crossVectors(a:Vector3, b:Vector3):Vector3
	{
		var ax = a.x;
		var ay = a.y;
		var az = a.z;
		var bx = b.x;
		var by = b.y;
		var bz = b.z;
		x = ay * bz - az * by;
		y = az * bx - ax * bz;
		z = ax * by - ay * bx;
		return this;
	}

	/**
	 * Check whether this Vector is equal to a given Vector.
	 *
	 * Performs a strict equality check against each Vector's components.
	 *
	 * @since 1.0.0
	 *
	 * @param v The Vector3 to compare against.
	 *
	 * @return True if the two vectors strictly match, otherwise false.
	**/
	public function equals(v:Vector3):Bool
	{
		return ((x == v.x) && (y == v.y) && (z == v.z));
	}

	/**
	 * Copy the components of a given Vector into this Vector.
	 *
	 * @since 1.0.0
	 *
	 * @param src The Vector to copy the components from.
	 *
	 * @return This Vector3.
	**/
	public function copy(src:Vector3):Vector3
	{
		x = src.x;
		y = src.y;
		z = src.z;
		return this;
	}

	/**
	 * Set the `x`, `y`, and `z` components of this Vector to the given `x`, `y`, and `z` values.
	 *
	 * @since 1.0.0
	 *
	 * @param x The x value to set for this Vector, or an object containing x, y and z components.
	 * @param y The y value to set for this Vector.
	 * @param z The z value to set for this Vector.
	 *
	 * @return This Vector3.
	**/
	public function set(x:Float, y:Float, z:Float):Vector3
	{
		this.x = x;
		this.y = y;
		this.z = z;

		return this;
	}

	/**
	 * Add a given Vector to this Vector. Addition is component-wise.
	 *
	 * @since 1.0.0
	 *
	 * @param v The Vector to add to this Vector.
	 *
	 * @return This Vector3.
	**/
	public function add(v):Vector3
	{
		x += v.x;
		y += v.y;
		z += v.z;
		return this;
	}

	/**
	 * Subtract the given Vector from this Vector. Subtraction is component-wise.
	 *
	 * @since 1.0.0
	 *
	 * @param v The Vector to subtract from this Vector.
	 *
	 * @return This Vector3.
	**/
	public function subtract(v:Vector3):Vector3
	{
		this.x -= v.x;
		this.y -= v.y;
		this.z -= v.z;
		return this;
	}

	/**
	 * Perform a component-wise multiplication between this Vector and the given Vector.
	 *
	 * Multiplies this Vector by the given Vector.
	 *
	 * @since 1.0.0
	 *
	 * @param v The Vector to multiply this Vector by.
	 *
	 * @return This Vector3.
	**/
	function multiply(v:Vector3):Vector3
	{
		x *= v.x;
		y *= v.y;
		z *= v.z;
		return this;
	}

	/**
	 * Scale this Vector by the given value.
	 *
	 * @since 1.0.0
	 *
	 * @param scale The value to scale this Vector by.
	 *
	 * @return This Vector3.
	**/
	function scale(scale:Float):Vector3
	{
		if (Math.isFinite(scale))
		{
			this.x *= scale;
			this.y *= scale;
			this.z *= scale;
		}
		else
		{
			this.x = 0;
			this.y = 0;
			this.z = 0;
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
	 * @param v The Vector to divide this Vector by.
	 *
	 * @return This Vector3.
	**/
	public function divide(v:Vector3):Vector3
	{
		x /= v.x;
		y /= v.y;
		z /= v.z;
		return this;
	}

	/**
	 * Negate the `x`, `y` and `z` components of this Vector.
	 *
	 * @since 1.0.0
	 *
	 * @return This Vector3.
	**/
	public function negate():Vector3
	{
		x = -x;
		y = -y;
		z = -z;
		return this;
	}

	/**
	 * Calculate the distance between this Vector and the given Vector.
	 *
	 * @since 1.0.0
	 *
	 * @param v The Vector to calculate the distance to.
	 *
	 * @return The distance from this Vector to the given Vector.
	**/
	public function distance(v:Vector3):Float
	{
		var dx = v.x - x;
		var dy = v.y - y;
		var dz = v.z - z;
		return Math.sqrt(dx * dx + dy * dy + dz * dz);
	}

	/**
	 * Calculate the distance between this Vector and the given Vector, squared.
	 *
	 * @since 1.0.0
	 *
	 * @param v The Vector to calculate the distance to.
	 *
	 * @return The distance from this Vector to the given Vector, squared.
	**/
	public function distanceSq(v:Vector3):Float
	{
		var dx = v.x - x;
		var dy = v.y - y;
		var dz = v.z - z;
		return dx * dx + dy * dy + dz * dz;
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
		return Math.sqrt(x * x + y * y + z * z);
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
		return x * x + y * y + z * z;
	}

	/**
	 * Normalize this Vector.
	 *
	 * Makes the vector a unit length vector (magnitude of 1) in the same direction.
	 *
	 * @since 1.0.0
	 *
	 * @return This Vector3.
	**/
	public function normalize():Vector3
	{
		var x = this.x;
		var y = this.y;
		var z = this.z;
		var len = x * x + y * y + z * z;
		if (len > 0)
		{
			len = 1 / Math.sqrt(len);
			this.x = x * len;
			this.y = y * len;
			this.z = z * len;
		}
		return this;
	}

	/**
	 * Calculate the dot product of this Vector and the given Vector.
	 *
	 * @since 1.0.0
	 *
	 * @param v The Vector3 to dot product with this Vector3.
	 *
	 * @return The dot product of this Vector and `v`.
	**/
	public function dot(v:Vector3):Float
	{
		return x * v.x + y * v.y + z * v.z;
	}

	/**
	 * Calculate the cross (vector) product of this Vector (which will be modified) and the given Vector.
	 *
	 * @since 1.0.0
	 *
	 * @param v The Vector to cross product with.
	 *
	 * @return This Vector3.
	**/
	public function cross(v:Vector3):Vector3
	{
		var ax = this.x;
		var ay = this.y;
		var az = this.z;
		var bx = v.x;
		var by = v.y;
		var bz = v.z;
		this.x = ay * bz - az * by;
		this.y = az * bx - ax * bz;
		this.z = ax * by - ay * bx;
		return this;
	}

	/**
	 * Linearly interpolate between this Vector and the given Vector.
	 *
	 * Interpolates this Vector towards the given Vector.
	 *
	 * @since 1.0.0
	 *
	 * @param v The Vector3 to interpolate towards.
	 * @param t The interpolation percentage, between 0 and 1.
	 *
	 * @return This Vector3.
	**/
	public function lerp(v:Vector3, t:Float = 0)
	{
		var ax = this.x;
		var ay = this.y;
		var az = this.z;
		this.x = ax + t * (v.x - ax);
		this.y = ay + t * (v.y - ay);
		this.z = az + t * (v.z - az);
		return this;
	}

	/**
	 * Transform this Vector with the given Matrix.
	 *
	 * @since 1.0.0
	 *
	 * @param mat The Matrix3 to transform this Vector3 with.
	 *
	 * @return This Vector3.
	**/
	public function transformMat3(mat)
	{
		var x = this.x;
		var y = this.y;
		var z = this.z;
		var m = mat.val;
		this.x = x * m[0] + y * m[3] + z * m[6];
		this.y = x * m[1] + y * m[4] + z * m[7];
		this.z = x * m[2] + y * m[5] + z * m[8];
		return this;
	}

	/**
	 * Transform this Vector with the given Matrix.
	 *
	 * @since 1.0.0
	 *
	 * @param mat The Matrix4 to transform this Vector3 with.
	 *
	 * @return This Vector3.
	**/
	public function transformMat4(mat)
	{
		var x = this.x;
		var y = this.y;
		var z = this.z;
		var m = mat.val;
		this.x = m[0] * x + m[4] * y + m[8] * z + m[12];
		this.y = m[1] * x + m[5] * y + m[9] * z + m[13];
		this.z = m[2] * x + m[6] * y + m[10] * z + m[14];
		return this;
	}

	/**
	 * Transforms the coordinates of this Vector3 with the given Matrix4.
	 *
	 * @since 1.0.0
	 *
	 * @param mat The Matrix4 to transform this Vector3 with.
	 *
	 * @return This Vector3.
	**/
	public function transformCoordinates(mat)
	{
		var x = this.x;
		var y = this.y;
		var z = this.z;
		var m = mat.val;
		var tx = (x * m[0]) + (y * m[4]) + (z * m[8]) + m[12];
		var ty = (x * m[1]) + (y * m[5]) + (z * m[9]) + m[13];
		var tz = (x * m[2]) + (y * m[6]) + (z * m[10]) + m[14];
		var tw = (x * m[3]) + (y * m[7]) + (z * m[11]) + m[15];
		this.x = tx / tw;
		this.y = ty / tw;
		this.z = tz / tw;
		return this;
	}

	/**
	 * Transform this Vector with the given Quaternion.
	 *
	 * @since 1.0.0
	 *
	 * @param  q The Quaternion to transform this Vector with.
	 *
	 * @return This Vector3.
	**/
	public function transformQuat(q)
	{
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
	 * Multiplies this Vector3 by the specified matrix, applying a W divide. This is useful for projection,
	 * e.g. unprojecting a 2D point into 3D space.
	 *
	 * @since 1.0.0
	 *
	 * @param mat The Matrix4 to multiply this Vector3 with.
	 *
	 * @return This Vector3.
	**/
	public function project(mat)
	{
		var x = this.x;
		var y = this.y;
		var z = this.z;
		var m = mat.val;
		var a00 = m[0];
		var a01 = m[1];
		var a02 = m[2];
		var a03 = m[3];
		var a10 = m[4];
		var a11 = m[5];
		var a12 = m[6];
		var a13 = m[7];
		var a20 = m[8];
		var a21 = m[9];
		var a22 = m[10];
		var a23 = m[11];
		var a30 = m[12];
		var a31 = m[13];
		var a32 = m[14];
		var a33 = m[15];
		var lw = 1 / (x * a03 + y * a13 + z * a23 + a33);
		this.x = (x * a00 + y * a10 + z * a20 + a30) * lw;
		this.y = (x * a01 + y * a11 + z * a21 + a31) * lw;
		this.z = (x * a02 + y * a12 + z * a22 + a32) * lw;
		return this;
	}

	/**
	 * Unproject this point from 2D space to 3D space.
	 * The point should have its x and y properties set to
	 * 2D screen space, and the z either at 0 (near plane)
	 * or 1 (far plane). The provided matrix is assumed to already
	 * be combined, i.e. projection * view * model.
	 *
	 * After this operation, this vector's (x, y, z) components will
	 * represent the unprojected 3D coordinate.
	 *
	 * @since 3.0.0
	 *
	 * @param viewport - Screen x, y, width and height in pixels.
	 * @param invProjectionView - Combined projection and view matrix.
	 *
	 * @return This Vector3.
	**/
	public function unproject(viewport, invProjectionView)
	{
		var viewX = viewport.x;
		var viewY = viewport.y;
		var viewWidth = viewport.z;
		var viewHeight = viewport.w;
		var x = this.x - viewX;
		var y = (viewHeight - this.y - 1) - viewY;
		var z = this.z;
		this.x = (2 * x) / viewWidth - 1;
		this.y = (2 * y) / viewHeight - 1;
		this.z = 2 * z - 1;
		return this.project(invProjectionView);
	}

	/**
	 * Make this Vector the zero vector (0, 0, 0).
	 *
	 * @since 1.0.0
	 *
	 * @return This Vector3.
	**/
	public function reset():Vector3
	{
		x = 0;
		y = 0;
		z = 0;
		return this;
	}

	/**
	 * A static right Vector3 for use by reference.
	 *
	 * This constant is meant for comparison operations and should not be modified directly.
	 *
	 * @since 1.0.0
	**/
	public static final RIGHT:Vector3 = new Vector3(1, 0, 0);

	/**
	 * A static left Vector3 for use by reference.
	 *
	 * This constant is meant for comparison operations and should not be modified directly.
	 *
	 * @since 1.0.0
	**/
	public static final LEFT:Vector3 = new Vector3(-1, 0, 0);

	/**
	 * A static up Vector3 for use by reference.
	 *
	 * This constant is meant for comparison operations and should not be modified directly.
	 *
	 * @since 1.0.0
	**/
	public static final UP:Vector3 = new Vector3(0, -1, 0);

	/**
	 * A static down Vector3 for use by reference.
	 *
	 * This constant is meant for comparison operations and should not be modified directly.
	 *
	 * @since 1.0.0
	**/
	public static final DOWN:Vector3 = new Vector3(0, 1, 0);

	/**
	 * A static forward Vector3 for use by reference.
	 *
	 * This constant is meant for comparison operations and should not be modified directly.
	 *
	 * @since 1.0.0
	 */
	public static final FORWARD:Vector3 = new Vector3(0, 0, 1);

	/**
	 * A static back Vector3 for use by reference.
	 *
	 * This constant is meant for comparison operations and should not be modified directly.
	 *
	 * @since 1.0.0
	**/
	public static final BACK:Vector3 = new Vector3(0, 0, -1);

	/**
	 * A static one Vector3 for use by reference.
	 *
	 * This constant is meant for comparison operations and should not be modified directly.
	 *
	 * @since 1.0.0
	**/
	public static final ONE:Vector3 = new Vector3(1, 1, 1);
}
