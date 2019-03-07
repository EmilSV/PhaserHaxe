package phaserHaxe.math;

import phaserHaxe.math.Vector4;
import haxe.io.UInt8Array;
import haxe.io.Float32Array;

/**
 * A quaternion.
**/
@:forward(x, y, z, w)
@:structInit
abstract Quaternion(Vector4) from Vector4 to Vector4
{
	private static inline final EPSILON = 0.000001;
	//  Some static 'private' arrays
	private static var siNext = UInt8Array.fromArray([1, 2, 0]);
	private static var tmp = Float32Array.fromArray([0, 0, 0]);
	private static var xUnitVec3 = new Vector3(1, 0, 0);
	private static var yUnitVec3 = new Vector3(0, 1, 0);
	private static var tmpvec = new Vector3();
	private static var tmpMat3 = new Matrix3();

	public inline function new(x:Float = 0, y:Float = 0, z:Float = 0, w:Float = 0)
	{
		this = new Vector4(x, y, z, w);
	}

	/**
	 * Copy the components of a given Quaternion or Vector into this Quaternion.
	 *
	 * @since 1.0.0
	 *
	 * @param src - The Quaternion to copy the components from.
	 *
	 * @return This Quaternion.
	**/
	public function copy(src:Quaternion):Quaternion
	{
		this.x = src.x;
		this.y = src.y;
		this.z = src.z;
		this.w = src.w;
		return this;
	}

	/**
	 * Set the components of this Quaternion.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The x component.
	 * @param y - The y component.
	 * @param z - The z component.
	 * @param w - The w component.
	 *
	 * @return This Quaternion.
	**/
	public function set(x:Float = 0, y:Float = 0, z:Float = 0, w:Float = 0):Quaternion
	{
		this.x = x;
		this.y = y;
		this.z = z;
		this.w = w;
		return this;
	}

	/**
	 * Add a given Quaternion or Vector to this Quaternion. Addition is component-wise.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The Quaternion or Vector to add to this Quaternion.
	 *
	 * @return This Quaternion.
	**/
	public function add(v:Quaternion):Quaternion
	{
		this.x += v.x;
		this.y += v.y;
		this.z += v.z;
		this.w += v.w;
		return this;
	}

	/**
	 * Subtract a given Quaternion or Vector from this Quaternion. Subtraction is component-wise.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The Quaternion or Vector to subtract from this Quaternion.
	 *
	 * @return This Quaternion.
	**/
	public function subtract(v:Quaternion):Quaternion
	{
		this.x -= v.x;
		this.y -= v.y;
		this.z -= v.z;
		this.w -= v.w;
		return this;
	}

	/**
	 * Scale this Quaternion by the given value.
	 *
	 * @since 1.0.0
	 *
	 * @param scale - The value to scale this Quaternion by.
	 *
	 * @return This Quaternion.
	**/
	public function scale(scale:Float):Quaternion
	{
		this.x *= scale;
		this.y *= scale;
		this.z *= scale;
		this.w *= scale;
		return this;
	}

	/**
	 * Calculate the length of this Quaternion.
	 *
	 * @since 1.0.0
	 *
	 * @return The length of this Quaternion.
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
	 * Calculate the length of this Quaternion squared.
	 *
	 * @since 1.0.0
	 *
	 * @return The length of this Quaternion, squared.
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
	 * Normalize this Quaternion.
	 *
	 * @since 1.0.0
	 *
	 * @return This Quaternion.
	**/
	public function normalize():Quaternion
	{
		var localX = this.x;
		var localY = this.y;
		var localZ = this.z;
		var localW = this.w;
		var len = localX * localX + localY * localY + localZ * localZ + localW * localW;
		if (len > 0)
		{
			len = 1 / Math.sqrt(len);
			this.x = localX * len;
			this.y = localY * len;
			this.z = localZ * len;
			this.w = localW * len;
		}
		return this;
	}

	/**
	 * Calculate the dot product of this Quaternion and the given Quaternion or Vector.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The Quaternion or Vector to dot product with this Quaternion.
	 *
	 * @return The dot product of this Quaternion and the given Quaternion or Vector.
	**/
	public function dot(v:Quaternion):Float
	{
		var x = this.x;
		var y = this.y;
		var z = this.z;
		var w = this.w;
		return x * v.x + y * v.y + z * v.z + w * v.w;
	}

	/**
	 * Linearly interpolate this Quaternion towards the given Quaternion or Vector.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The Quaternion or Vector to interpolate towards.
	 * @param t - The percentage of interpolation.
	 *
	 * @return This Quaternion.
	**/
	public function lerp(v:Quaternion, t:Float = 0):Quaternion
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
	 * [description]
	 *
	 * @since 1.0.0
	 *
	 * @param a - [description]
	 * @param b - [description]
	 *
	 * @return This Quaternion.
	**/
	public function rotationTo(a:Vector3, b:Vector3):Quaternion
	{
		var dot = a.x * b.x + a.y * b.y + a.z * b.z;
		if (dot < -0.999999)
		{
			if (tmpvec.copy(xUnitVec3).cross(a).length() < EPSILON)
			{
				tmpvec.copy(yUnitVec3).cross(a);
			}
			tmpvec.normalize();
			return setAxisAngle(tmpvec, Math.PI);
		}
		else if (dot > 0.999999)
		{
			this.x = 0;
			this.y = 0;
			this.z = 0;
			this.w = 1;
			return this;
		}
		else
		{
			tmpvec.copy(a).cross(b);
			this.x = tmpvec.x;
			this.y = tmpvec.y;
			this.z = tmpvec.z;
			this.w = 1 + dot;
			return normalize();
		}
	}

	/**
	 * Set the axes of this Quaternion.
	 *
	 * @since 1.0.0
	 *
	 * @param view - The view axis.
	 * @param right - The right axis.
	 * @param up - The upwards axis.
	 *
	 * @return This Quaternion.
	**/
	public function setAxes(view:Vector3, right:Vector3, up:Vector3):Quaternion
	{
		var m = tmpMat3.val;
		m[0] = right.x;
		m[3] = right.y;
		m[6] = right.z;
		m[1] = up.x;
		m[4] = up.y;
		m[7] = up.z;
		m[2] = -view.x;
		m[5] = -view.y;
		m[8] = -view.z;
		return fromMat3(tmpMat3).normalize();
	}

	/**
	 * Reset this Matrix to an identity (default) Quaternion.
	 *
	 * @since 1.0.0
	 *
	 * @return This Quaternion.
	**/
	public function identity():Quaternion
	{
		this.x = 0;
		this.y = 0;
		this.z = 0;
		this.w = 1;
		return this;
	}

	/**
	 * Set the axis angle of this Quaternion.
	 *
	 * @since 1.0.0
	 *
	 * @param axis - The axis.
	 * @param rad - The angle in radians.
	 *
	 * @return This Quaternion.
	**/
	public function setAxisAngle(axis:Vector3, rad:Float):Quaternion
	{
		rad = rad * 0.5;
		var s = Math.sin(rad);
		this.x = s * axis.x;
		this.y = s * axis.y;
		this.z = s * axis.z;
		this.w = Math.cos(rad);
		return this;
	}

	/**
	 * Multiply this Quaternion by the given Quaternion or Vector.
	 *
	 * @since 1.0.0
	 *
	 * @param b - The Quaternion or Vector to multiply this Quaternion by.
	 *
	 * @return This Quaternion.
	**/
	public function multiply(b:Quaternion):Quaternion
	{
		var ax = this.x;
		var ay = this.y;
		var az = this.z;
		var aw = this.w;
		var bx = b.x;
		var by = b.y;
		var bz = b.z;
		var bw = b.w;
		this.x = ax * bw + aw * bx + ay * bz - az * by;
		this.y = ay * bw + aw * by + az * bx - ax * bz;
		this.z = az * bw + aw * bz + ax * by - ay * bx;
		this.w = aw * bw - ax * bx - ay * by - az * bz;
		return this;
	}

	/**
	 * Smoothly linearly interpolate this Quaternion towards the given Quaternion or Vector.
	 *
	 * @since 1.0.0
	 *
	 * @param b - The Quaternion or Vector to interpolate towards.
	 * @param t - The percentage of interpolation.
	 *
	 * @return This Quaternion.
	**/
	public function slerp(b:Quaternion, t:Float):Quaternion
	{
		// benchmarks: http://jsperf.com/quaternion-slerp-implementations
		var ax = this.x;
		var ay = this.y;
		var az = this.z;
		var aw = this.w;
		var bx = b.x;
		var by = b.y;
		var bz = b.z;
		var bw = b.w;
		// calc cosine
		var cosom = ax * bx + ay * by + az * bz + aw * bw;
		// adjust signs (if necessary)
		if (cosom < 0)
		{
			cosom = -cosom;
			bx = -bx;
			by = -by;
			bz = -bz;
			bw = -bw;
		}
		// "from" and "to" quaternions are very close
		//  ... so we can do a linear interpolation
		var scale0 = 1 - t;
		var scale1 = t;
		// calculate coefficients
		if ((1 - cosom) > EPSILON)
		{
			// standard case (slerp)
			var omega = Math.acos(cosom);
			var sinom = Math.sin(omega);
			scale0 = Math.sin((1.0 - t) * omega) / sinom;
			scale1 = Math.sin(t * omega) / sinom;
		}
		// calculate final values
		this.x = scale0 * ax + scale1 * bx;
		this.y = scale0 * ay + scale1 * by;
		this.z = scale0 * az + scale1 * bz;
		this.w = scale0 * aw + scale1 * bw;
		return this;
	}

	/**
	 * Invert this Quaternion.
	 *
	 * @since 1.0.0
	 *
	 * @return This Quaternion.
	**/
	public function invert():Quaternion
	{
		var a0 = this.x;
		var a1 = this.y;
		var a2 = this.z;
		var a3 = this.w;
		var dot = a0 * a0 + a1 * a1 + a2 * a2 + a3 * a3;
		var invDot = (dot != 0) ? 1 / dot : 0;
		// TODO: Would be faster to return [0,0,0,0] immediately if dot == 0
		this.x = -a0 * invDot;
		this.y = -a1 * invDot;
		this.z = -a2 * invDot;
		this.w = a3 * invDot;
		return this;
	}

	/**
	 * Compatibility this Quaternion into its conjugate.
	 *
	 * Sets the x, y and z components.
	 *
	 * @since 1.0.0
	 *
	 * @return This Quaternion.
	**/
	public function conjugate():Quaternion
	{
		this.x = -this.x;
		this.y = -this.y;
		this.z = -this.z;
		return this;
	}

	/**
	 * Rotate this Quaternion on the X axis.
	 *
	 * @since 1.0.0
	 *
	 * @param rad - The rotation angle in radians.
	 *
	 * @return This Quaternion.
	**/
	public function rotateX(rad:Float):Quaternion
	{
		rad *= 0.5;
		var ax = this.x;
		var ay = this.y;
		var az = this.z;
		var aw = this.w;
		var bx = Math.sin(rad);
		var bw = Math.cos(rad);
		this.x = ax * bw + aw * bx;
		this.y = ay * bw + az * bx;
		this.z = az * bw - ay * bx;
		this.w = aw * bw - ax * bx;
		return this;
	}

	/**
	 * Rotate this Quaternion on the Y axis.
	 *
	 * @since 1.0.0
	 *
	 * @param rad - The rotation angle in radians.
	 *
	 * @return This Quaternion.
	**/
	public function rotateY(rad:Float):Quaternion
	{
		rad *= 0.5;
		var ax = this.x;
		var ay = this.y;
		var az = this.z;
		var aw = this.w;
		var by = Math.sin(rad);
		var bw = Math.cos(rad);
		this.x = ax * bw - az * by;
		this.y = ay * bw + aw * by;
		this.z = az * bw + ax * by;
		this.w = aw * bw - ay * by;
		return this;
	}

	/**
	 * Rotate this Quaternion on the Z axis.
	 *
	 * @since 1.0.0
	 *
	 * @param rad - The rotation angle in radians.
	 *
	 * @return This Quaternion.
	**/
	public function rotateZ(rad:Float):Quaternion
	{
		rad *= 0.5;
		var ax = this.x;
		var ay = this.y;
		var az = this.z;
		var aw = this.w;
		var bz = Math.sin(rad);
		var bw = Math.cos(rad);
		this.x = ax * bw + ay * bz;
		this.y = ay * bw - ax * bz;
		this.z = az * bw + aw * bz;
		this.w = aw * bw - az * bz;
		return this;
	}

	/**
	 * Create a unit (or rotation) Quaternion from its x, y, and z components.
	 *
	 * Sets the w component.
	 *
	 * @since 1.0.0
	 *
	 * @return This Quaternion.
	**/
	public function calculateW():Quaternion
	{
		var x = this.x;
		var y = this.y;
		var z = this.z;
		this.w = -Math.sqrt(1.0 - x * x - y * y - z * z);
		return this;
	}

	/**
	 * Compatibility the given Matrix into this Quaternion.
	 *
	 * @since 1.0.0
	 *
	 * @param mat - The Matrix to Compatibility from.
	 *
	 * @return This Quaternion.
	**/
	public function fromMat3(mat:Matrix3):Quaternion
	{
		// benchmarks:
		//    http://jsperf.com/typed-array-access-speed
		//    http://jsperf.com/conversion-of-3x3-matrix-to-quaternion
		// Algorithm in Ken Shoemake's article in 1987 SIGGRAPH course notes
		// article "Quaternion Calculus and Fast Animation".
		var m = mat.val;
		var fTrace = m[0] + m[4] + m[8];
		var fRoot;
		if (fTrace > 0)
		{
			// |w| > 1/2, may as well choose w > 1/2
			fRoot = Math.sqrt(fTrace + 1.0); // 2w
			this.w = 0.5 * fRoot;
			fRoot = 0.5 / fRoot; // 1/(4w)
			this.x = (m[7] - m[5]) * fRoot;
			this.y = (m[2] - m[6]) * fRoot;
			this.z = (m[3] - m[1]) * fRoot;
		}
		else
		{
			// |w| <= 1/2
			var i = 0;
			if (m[4] > m[0])
			{
				i = 1;
			}
			if (m[8] > m[i * 3 + i])
			{
				i = 2;
			}
			var j = siNext[i];
			var k = siNext[j];
			//  This isn't quite as clean without array access
			fRoot = Math.sqrt(m[i * 3 + i] - m[j * 3 + j] - m[k * 3 + k] + 1);
			tmp[i] = 0.5 * fRoot;
			fRoot = 0.5 / fRoot;
			tmp[j] = (m[j * 3 + i] + m[i * 3 + j]) * fRoot;
			tmp[k] = (m[k * 3 + i] + m[i * 3 + k]) * fRoot;
			this.x = tmp[0];
			this.y = tmp[1];
			this.z = tmp[2];
			this.w = (m[k * 3 + j] - m[j * 3 + k]) * fRoot;
		}
		return this;
	}
}
