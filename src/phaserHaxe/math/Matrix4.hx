package phaserHaxe.math;

import haxe.io.Float32Array;

class Matrix4
{
	private static inline final EPSILON = 0.000001;
	private static final _tempMat1 = new Matrix4();
	private static final _tempMat2 = new Matrix4();

	/**
	 * The matrix values.
	 *
	 * @since 1.0.0
	**/
	public var val:Float32Array;

	public function new(?m:Matrix4)
	{
		val = new Float32Array(16);
	}

	/**
	 * Make a clone of this Matrix4.
	 *
	 * @since 1.0.0
	 *
	 * @return A clone of this Matrix4.
	**/
	public function clone()
	{
		return new Matrix4(this);
	}

	/**
	 * This method is an alias for `Matrix4.copy`.
	 *
	 * @since 1.0.0
	 *
	 * @param src - The Matrix to set the values of this Matrix's from.
	 *
	 * @return This Matrix4.
	**/
	public function set(src:Matrix4)
	{
		return this.copy(src);
	}

	/**
	 * Copy the values of a given Matrix into this Matrix.
	 *
	 * @since 1.0.0
	 *
	 * @param src - The Matrix to copy the values from.
	 *
	 * @return This Matrix4.
	**/
	public function copy(src:Matrix4)
	{
		var out = this.val;
		var a = src.val;
		out[0] = a[0];
		out[1] = a[1];
		out[2] = a[2];
		out[3] = a[3];
		out[4] = a[4];
		out[5] = a[5];
		out[6] = a[6];
		out[7] = a[7];
		out[8] = a[8];
		out[9] = a[9];
		out[10] = a[10];
		out[11] = a[11];
		out[12] = a[12];
		out[13] = a[13];
		out[14] = a[14];
		out[15] = a[15];
		return this;
	}

	/**
	 * Set the values of this Matrix from the given array.
	 *
	 * @since 1.0.0
	 *
	 * @param a - The array to copy the values from.
	 *
	 * @return This Matrix4.
	**/
	public function fromArray(a)
	{
		var out = this.val;
		out[0] = a[0];
		out[1] = a[1];
		out[2] = a[2];
		out[3] = a[3];
		out[4] = a[4];
		out[5] = a[5];
		out[6] = a[6];
		out[7] = a[7];
		out[8] = a[8];
		out[9] = a[9];
		out[10] = a[10];
		out[11] = a[11];
		out[12] = a[12];
		out[13] = a[13];
		out[14] = a[14];
		out[15] = a[15];
		return this;
	}

	/**
	 * Reset this Matrix.
	 *
	 * Sets all values to `0`.
	 *
	 * @since 1.0.0
	 *
	 * @return This Matrix4.
	**/
	public function zero()
	{
		var out = this.val;
		out[0] = 0;
		out[1] = 0;
		out[2] = 0;
		out[3] = 0;
		out[4] = 0;
		out[5] = 0;
		out[6] = 0;
		out[7] = 0;
		out[8] = 0;
		out[9] = 0;
		out[10] = 0;
		out[11] = 0;
		out[12] = 0;
		out[13] = 0;
		out[14] = 0;
		out[15] = 0;
		return this;
	}

	/**
	 * Set the `x`, `y` and `z` values of this Matrix.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The x value.
	 * @param y - The y value.
	 * @param z - The z value.
	 *
	 * @return This Matrix4.
	**/
	public function xyz(x, y, z)
	{
		this.identity();
		var out = this.val;
		out[12] = x;
		out[13] = y;
		out[14] = z;
		return this;
	}

	/**
	 * Set the scaling values of this Matrix.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The x scaling value.
	 * @param y - The y scaling value.
	 * @param z - The z scaling value.
	 *
	 * @return This Matrix4.
	**/
	public function scaling(x, y, z)
	{
		this.zero();
		var out = this.val;
		out[0] = x;
		out[5] = y;
		out[10] = z;
		out[15] = 1;
		return this;
	}

	/**
	 * Reset this Matrix to an identity (default) matrix.
	 *
	 * @since 1.0.0
	 *
	 * @return {Phaser.Math.Matrix4} This Matrix4.
	**/
	public function identity()
	{
		var out = this.val;
		out[0] = 1;
		out[1] = 0;
		out[2] = 0;
		out[3] = 0;
		out[4] = 0;
		out[5] = 1;
		out[6] = 0;
		out[7] = 0;
		out[8] = 0;
		out[9] = 0;
		out[10] = 1;
		out[11] = 0;
		out[12] = 0;
		out[13] = 0;
		out[14] = 0;
		out[15] = 1;
		return this;
	}

	/**
	 * Transpose this Matrix.
	 *
	 * @since 1.0.0
	 *
	 * @return {Phaser.Math.Matrix4} This Matrix4.
	**/
	public function transpose()
	{
		var a = this.val;
		var a01 = a[1];
		var a02 = a[2];
		var a03 = a[3];
		var a12 = a[6];
		var a13 = a[7];
		var a23 = a[11];
		a[1] = a[4];
		a[2] = a[8];
		a[3] = a[12];
		a[4] = a01;
		a[6] = a[9];
		a[7] = a[13];
		a[8] = a02;
		a[9] = a12;
		a[11] = a[14];
		a[12] = a03;
		a[13] = a13;
		a[14] = a23;
		return this;
	}

	/**
	 * Invert this Matrix.
	 *
	 * @since 1.0.0
	 *
	 * @return {Phaser.Math.Matrix4} This Matrix4.
	**/
	public function invert()
	{
		var a = this.val;
		var a00 = a[0];
		var a01 = a[1];
		var a02 = a[2];
		var a03 = a[3];
		var a10 = a[4];
		var a11 = a[5];
		var a12 = a[6];
		var a13 = a[7];
		var a20 = a[8];
		var a21 = a[9];
		var a22 = a[10];
		var a23 = a[11];
		var a30 = a[12];
		var a31 = a[13];
		var a32 = a[14];
		var a33 = a[15];
		var b00 = a00 * a11 - a01 * a10;
		var b01 = a00 * a12 - a02 * a10;
		var b02 = a00 * a13 - a03 * a10;
		var b03 = a01 * a12 - a02 * a11;
		var b04 = a01 * a13 - a03 * a11;
		var b05 = a02 * a13 - a03 * a12;
		var b06 = a20 * a31 - a21 * a30;
		var b07 = a20 * a32 - a22 * a30;
		var b08 = a20 * a33 - a23 * a30;
		var b09 = a21 * a32 - a22 * a31;
		var b10 = a21 * a33 - a23 * a31;
		var b11 = a22 * a33 - a23 * a32;
		// Calculate the determinant
		var det = b00 * b11 - b01 * b10 + b02 * b09 + b03 * b08 - b04 * b07 +
			b05 * b06;
		if (det == 0)
		{
			return null;
		}
		det = 1 / det;
		a[0] = (a11 * b11 - a12 * b10 + a13 * b09) * det;
		a[1] = (a02 * b10 - a01 * b11 - a03 * b09) * det;
		a[2] = (a31 * b05 - a32 * b04 + a33 * b03) * det;
		a[3] = (a22 * b04 - a21 * b05 - a23 * b03) * det;
		a[4] = (a12 * b08 - a10 * b11 - a13 * b07) * det;
		a[5] = (a00 * b11 - a02 * b08 + a03 * b07) * det;
		a[6] = (a32 * b02 - a30 * b05 - a33 * b01) * det;
		a[7] = (a20 * b05 - a22 * b02 + a23 * b01) * det;
		a[8] = (a10 * b10 - a11 * b08 + a13 * b06) * det;
		a[9] = (a01 * b08 - a00 * b10 - a03 * b06) * det;
		a[10] = (a30 * b04 - a31 * b02 + a33 * b00) * det;
		a[11] = (a21 * b02 - a20 * b04 - a23 * b00) * det;
		a[12] = (a11 * b07 - a10 * b09 - a12 * b06) * det;
		a[13] = (a00 * b09 - a01 * b07 + a02 * b06) * det;
		a[14] = (a31 * b01 - a30 * b03 - a32 * b00) * det;
		a[15] = (a20 * b03 - a21 * b01 + a22 * b00) * det;
		return this;
	}

	/**
	 * Calculate the adjoint, or adjugate, of this Matrix.
	 *
	 * @since 1.0.0
	 *
	 * @return {Phaser.Math.Matrix4} This Matrix4.
	**/
	public function adjoint()
	{
		var a = this.val;
		var a00 = a[0];
		var a01 = a[1];
		var a02 = a[2];
		var a03 = a[3];
		var a10 = a[4];
		var a11 = a[5];
		var a12 = a[6];
		var a13 = a[7];
		var a20 = a[8];
		var a21 = a[9];
		var a22 = a[10];
		var a23 = a[11];
		var a30 = a[12];
		var a31 = a[13];
		var a32 = a[14];
		var a33 = a[15];
		a[0] = (a11 * (a22 * a33 - a23 * a32) - a21 * (a12 * a33 - a13 * a32) +
			a31 * (a12 * a23 - a13 * a22));
		a[1] = -(a01 * (a22 * a33 - a23 * a32) - a21 * (a02 * a33 - a03 * a32) + a31 * (a02 * a23 - a03 * a22));
		a[2] = (a01 * (a12 * a33 - a13 * a32) - a11 * (a02 * a33 - a03 * a32) +
			a31 * (a02 * a13 - a03 * a12));
		a[3] = -(a01 * (a12 * a23 - a13 * a22) - a11 * (a02 * a23 - a03 * a22) + a21 * (a02 * a13 - a03 * a12));
		a[4] = -(a10 * (a22 * a33 - a23 * a32) - a20 * (a12 * a33 - a13 * a32) + a30 * (a12 * a23 - a13 * a22));
		a[5] = (a00 * (a22 * a33 - a23 * a32) - a20 * (a02 * a33 - a03 * a32) +
			a30 * (a02 * a23 - a03 * a22));
		a[6] = -(a00 * (a12 * a33 - a13 * a32) - a10 * (a02 * a33 - a03 * a32) + a30 * (a02 * a13 - a03 * a12));
		a[7] = (a00 * (a12 * a23 - a13 * a22) - a10 * (a02 * a23 - a03 * a22) +
			a20 * (a02 * a13 - a03 * a12));
		a[8] = (a10 * (a21 * a33 - a23 * a31) - a20 * (a11 * a33 - a13 * a31) +
			a30 * (a11 * a23 - a13 * a21));
		a[9] = -(a00 * (a21 * a33 - a23 * a31) - a20 * (a01 * a33 - a03 * a31) + a30 * (a01 * a23 - a03 * a21));
		a[10] = (a00 * (a11 * a33 - a13 * a31) - a10 * (a01 * a33 - a03 * a31) + a30 * (a01 * a13 - a03 * a11));
		a[11] = -(a00 * (a11 * a23 - a13 * a21) - a10 * (a01 * a23 - a03 * a21) +
			a20 * (a01 * a13 - a03 * a11));
		a[12] = -(a10 * (a21 * a32 - a22 * a31) - a20 * (a11 * a32 - a12 * a31) +
			a30 * (a11 * a22 - a12 * a21));
		a[13] = (a00 * (a21 * a32 - a22 * a31) - a20 * (a01 * a32 - a02 * a31) + a30 * (a01 * a22 - a02 * a21));
		a[14] = -(a00 * (a11 * a32 - a12 * a31) - a10 * (a01 * a32 - a02 * a31) +
			a30 * (a01 * a12 - a02 * a11));
		a[15] = (a00 * (a11 * a22 - a12 * a21) - a10 * (a01 * a22 - a02 * a21) + a20 * (a01 * a12 - a02 * a11));
		return this;
	}

	/**
	 * Calculate the determinant of this Matrix.
	 *
	 * @since 1.0.0
	 *
	 * @return The determinant of this Matrix.
	**/
	public function determinant():Float
	{
		var a = this.val;
		var a00 = a[0];
		var a01 = a[1];
		var a02 = a[2];
		var a03 = a[3];
		var a10 = a[4];
		var a11 = a[5];
		var a12 = a[6];
		var a13 = a[7];
		var a20 = a[8];
		var a21 = a[9];
		var a22 = a[10];
		var a23 = a[11];
		var a30 = a[12];
		var a31 = a[13];
		var a32 = a[14];
		var a33 = a[15];
		var b00 = a00 * a11 - a01 * a10;
		var b01 = a00 * a12 - a02 * a10;
		var b02 = a00 * a13 - a03 * a10;
		var b03 = a01 * a12 - a02 * a11;
		var b04 = a01 * a13 - a03 * a11;
		var b05 = a02 * a13 - a03 * a12;
		var b06 = a20 * a31 - a21 * a30;
		var b07 = a20 * a32 - a22 * a30;
		var b08 = a20 * a33 - a23 * a30;
		var b09 = a21 * a32 - a22 * a31;
		var b10 = a21 * a33 - a23 * a31;
		var b11 = a22 * a33 - a23 * a32;
		// Calculate the determinant
		return b00 * b11 - b01 * b10 + b02 * b09 + b03 * b08 - b04 * b07 +
			b05 * b06;
	}

	/**
	 * Multiply this Matrix by the given Matrix.
	 *
	 * @since 1.0.0
	 *
	 * @param {Phaser.Math.Matrix4} src - The Matrix to multiply this Matrix by.
	 *
	 * @return {Phaser.Math.Matrix4} This Matrix4.
	**/
	public function multiply(src)
	{
		var a = this.val;
		var a00 = a[0];
		var a01 = a[1];
		var a02 = a[2];
		var a03 = a[3];
		var a10 = a[4];
		var a11 = a[5];
		var a12 = a[6];
		var a13 = a[7];
		var a20 = a[8];
		var a21 = a[9];
		var a22 = a[10];
		var a23 = a[11];
		var a30 = a[12];
		var a31 = a[13];
		var a32 = a[14];
		var a33 = a[15];
		var b = src.val;
		// Cache only the current line of the second matrix
		var b0 = b[0];
		var b1 = b[1];
		var b2 = b[2];
		var b3 = b[3];
		a[0] = b0 * a00 + b1 * a10 + b2 * a20 + b3 * a30;
		a[1] = b0 * a01 + b1 * a11 + b2 * a21 + b3 * a31;
		a[2] = b0 * a02 + b1 * a12 + b2 * a22 + b3 * a32;
		a[3] = b0 * a03 + b1 * a13 + b2 * a23 + b3 * a33;
		b0 = b[4];
		b1 = b[5];
		b2 = b[6];
		b3 = b[7];
		a[4] = b0 * a00 + b1 * a10 + b2 * a20 + b3 * a30;
		a[5] = b0 * a01 + b1 * a11 + b2 * a21 + b3 * a31;
		a[6] = b0 * a02 + b1 * a12 + b2 * a22 + b3 * a32;
		a[7] = b0 * a03 + b1 * a13 + b2 * a23 + b3 * a33;
		b0 = b[8];
		b1 = b[9];
		b2 = b[10];
		b3 = b[11];
		a[8] = b0 * a00 + b1 * a10 + b2 * a20 + b3 * a30;
		a[9] = b0 * a01 + b1 * a11 + b2 * a21 + b3 * a31;
		a[10] = b0 * a02 + b1 * a12 + b2 * a22 + b3 * a32;
		a[11] = b0 * a03 + b1 * a13 + b2 * a23 + b3 * a33;
		b0 = b[12];
		b1 = b[13];
		b2 = b[14];
		b3 = b[15];
		a[12] = b0 * a00 + b1 * a10 + b2 * a20 + b3 * a30;
		a[13] = b0 * a01 + b1 * a11 + b2 * a21 + b3 * a31;
		a[14] = b0 * a02 + b1 * a12 + b2 * a22 + b3 * a32;
		a[15] = b0 * a03 + b1 * a13 + b2 * a23 + b3 * a33;
		return this;
	}

	/**
	 * [description]
	 *
	 * @since 1.0.0
	 *
	 * @param src [description]
	 *
	 * @return This Matrix4.
	**/
	public function multiplyLocal(src:Matrix4):Matrix4
	{
		var a = [];
		var m1 = this.val;
		var m2 = src.val;
		a[0] = m1[0] * m2[0] + m1[1] * m2[4] + m1[2] * m2[8] + m1[3] * m2[12];
		a[1] = m1[0] * m2[1] + m1[1] * m2[5] + m1[2] * m2[9] + m1[3] * m2[13];
		a[2] = m1[0] * m2[2] + m1[1] * m2[6] + m1[2] * m2[10] + m1[3] * m2[14];
		a[3] = m1[0] * m2[3] + m1[1] * m2[7] + m1[2] * m2[11] + m1[3] * m2[15];
		a[4] = m1[4] * m2[0] + m1[5] * m2[4] + m1[6] * m2[8] + m1[7] * m2[12];
		a[5] = m1[4] * m2[1] + m1[5] * m2[5] + m1[6] * m2[9] + m1[7] * m2[13];
		a[6] = m1[4] * m2[2] + m1[5] * m2[6] + m1[6] * m2[10] + m1[7] * m2[14];
		a[7] = m1[4] * m2[3] + m1[5] * m2[7] + m1[6] * m2[11] + m1[7] * m2[15];
		a[8] = m1[8] * m2[0] + m1[9] * m2[4] + m1[10] * m2[8] + m1[11] * m2[12];
		a[9] = m1[8] * m2[1] + m1[9] * m2[5] + m1[10] * m2[9] + m1[11] * m2[13];
		a[10] = m1[8] * m2[2] + m1[9] * m2[6] + m1[10] * m2[10] +
			m1[11] * m2[14];
		a[11] = m1[8] * m2[3] + m1[9] * m2[7] + m1[10] * m2[11] +
			m1[11] * m2[15];
		a[12] = m1[12] * m2[0] + m1[13] * m2[4] + m1[14] * m2[8] +
			m1[15] * m2[12];
		a[13] = m1[12] * m2[1] + m1[13] * m2[5] + m1[14] * m2[9] +
			m1[15] * m2[13];
		a[14] = m1[12] * m2[2] + m1[13] * m2[6] + m1[14] * m2[10] +
			m1[15] * m2[14];
		a[15] = m1[12] * m2[3] + m1[13] * m2[7] + m1[14] * m2[11] +
			m1[15] * m2[15];
		return this.fromArray(a);
	}

	/**
	 * Translate this Matrix using the given Vector.
	 *
	 * @since 1.0.0
	 *
	 * @param v The Vector to translate this Matrix with.
	 *
	 * @return This Matrix4.
	**/
	public function translate(v:Vector3)
	{
		var x = v.x;
		var y = v.y;
		var z = v.z;
		var a = this.val;
		a[12] = a[0] * x + a[4] * y + a[8] * z + a[12];
		a[13] = a[1] * x + a[5] * y + a[9] * z + a[13];
		a[14] = a[2] * x + a[6] * y + a[10] * z + a[14];
		a[15] = a[3] * x + a[7] * y + a[11] * z + a[15];
		return this;
	}

	/**
	 * Translate this Matrix using the given values.
	 *
	 * @since 1.0.0
	 *
	 * @param x The x component.
	 * @param y The y component.
	 * @param z The z component.
	 *
	 * @return {Phaser.Math.Matrix4} This Matrix4.
	**/
	public function translateXYZ(x:Float, y:Float, z:Float)
	{
		var a = this.val;
		a[12] = a[0] * x + a[4] * y + a[8] * z + a[12];
		a[13] = a[1] * x + a[5] * y + a[9] * z + a[13];
		a[14] = a[2] * x + a[6] * y + a[10] * z + a[14];
		a[15] = a[3] * x + a[7] * y + a[11] * z + a[15];
		return this;
	}

	/**
	 * Apply a scale transformation to this Matrix.
	 *
	 * Uses the `x`, `y` and `z` components of the given Vector to scale the Matrix.
	 *
	 * @since 1.0.0
	 *
	 * @param v The Vector to scale this Matrix with.
	 *
	 * @return This Matrix4.
	**/
	public function scale(v:Vector3)
	{
		var x = v.x;
		var y = v.y;
		var z = v.z;
		var a = this.val;
		a[0] = a[0] * x;
		a[1] = a[1] * x;
		a[2] = a[2] * x;
		a[3] = a[3] * x;
		a[4] = a[4] * y;
		a[5] = a[5] * y;
		a[6] = a[6] * y;
		a[7] = a[7] * y;
		a[8] = a[8] * z;
		a[9] = a[9] * z;
		a[10] = a[10] * z;
		a[11] = a[11] * z;
		return this;
	}

	/**
	 * Apply a scale transformation to this Matrix.
	 *
	 * @since 1.0.0
	 *
	 * @param x The x component.
	 * @param y The y component.
	 * @param z The z component.
	 *
	 * @return This Matrix4.
	**/
	public function scaleXYZ(x:Float, y:Float, z:Float)
	{
		var a = this.val;
		a[0] = a[0] * x;
		a[1] = a[1] * x;
		a[2] = a[2] * x;
		a[3] = a[3] * x;
		a[4] = a[4] * y;
		a[5] = a[5] * y;
		a[6] = a[6] * y;
		a[7] = a[7] * y;
		a[8] = a[8] * z;
		a[9] = a[9] * z;
		a[10] = a[10] * z;
		a[11] = a[11] * z;
		return this;
	}

	/**
	 * Derive a rotation matrix around the given axis.
	 *
	 * @since 1.0.0
	 *
	 * @param axis - The rotation axis.
	 * @param angle - The rotation angle in radians.
	 *
	 * @return This Matrix4.
	**/
	public function makeRotationAxis(axis:Vector3, angle:Float)
	{
		// Based on http://www.gamedev.net/reference/articles/article1199.asp
		var c = Math.cos(angle);
		var s = Math.sin(angle);
		var t = 1 - c;
		var x = axis.x;
		var y = axis.y;
		var z = axis.z;
		var tx = t * x;
		var ty = t * y;
		this.fromArray([
			tx * x + c, tx * y - s * z, tx * z + s * y, 0, tx * y + s * z,
			ty * y + c, ty * z - s * x, 0, tx * z - s * y, ty * z + s * x,
			t * z * z + c, 0, 0, 0, 0, 1
		]);
		return this;
	}

	/**
	 * Apply a rotation transformation to this Matrix.
	 *
	 * @since 1.0.0
	 *
	 * @param rad - The angle in radians to rotate by.
	 * @param axis - The axis to rotate upon.
	 *
	 * @return This Matrix4.
	**/
	public function rotate(rad:Float, axis:Vector3):Null<Matrix4>
	{
		var a = val;
		var x = axis.x;
		var y = axis.y;
		var z = axis.z;
		var len = Math.sqrt(x * x + y * y + z * z);
		if (Math.abs(len) < EPSILON)
		{
			return null;
		}
		len = 1 / len;
		x *= len;
		y *= len;
		z *= len;
		var s = Math.sin(rad);
		var c = Math.cos(rad);
		var t = 1 - c;
		var a00 = a[0];
		var a01 = a[1];
		var a02 = a[2];
		var a03 = a[3];
		var a10 = a[4];
		var a11 = a[5];
		var a12 = a[6];
		var a13 = a[7];
		var a20 = a[8];
		var a21 = a[9];
		var a22 = a[10];
		var a23 = a[11];
		// Construct the elements of the rotation matrix
		var b00 = x * x * t + c;
		var b01 = y * x * t + z * s;
		var b02 = z * x * t - y * s;
		var b10 = x * y * t - z * s;
		var b11 = y * y * t + c;
		var b12 = z * y * t + x * s;
		var b20 = x * z * t + y * s;
		var b21 = y * z * t - x * s;
		var b22 = z * z * t + c;
		// Perform rotation-specific matrix multiplication
		a[0] = a00 * b00 + a10 * b01 + a20 * b02;
		a[1] = a01 * b00 + a11 * b01 + a21 * b02;
		a[2] = a02 * b00 + a12 * b01 + a22 * b02;
		a[3] = a03 * b00 + a13 * b01 + a23 * b02;
		a[4] = a00 * b10 + a10 * b11 + a20 * b12;
		a[5] = a01 * b10 + a11 * b11 + a21 * b12;
		a[6] = a02 * b10 + a12 * b11 + a22 * b12;
		a[7] = a03 * b10 + a13 * b11 + a23 * b12;
		a[8] = a00 * b20 + a10 * b21 + a20 * b22;
		a[9] = a01 * b20 + a11 * b21 + a21 * b22;
		a[10] = a02 * b20 + a12 * b21 + a22 * b22;
		a[11] = a03 * b20 + a13 * b21 + a23 * b22;
		return this;
	}

	/**
	 * Rotate this matrix on its X axis.
	 *
	 * @since 1.0.0
	 *
	 * @param rad - The angle in radians to rotate by.
	 *
	 * @return This Matrix4.
	**/
	public function rotateX(rad:Float)
	{
		var a = val;
		var s = Math.sin(rad);
		var c = Math.cos(rad);
		var a10 = a[4];
		var a11 = a[5];
		var a12 = a[6];
		var a13 = a[7];
		var a20 = a[8];
		var a21 = a[9];
		var a22 = a[10];
		var a23 = a[11];
		// Perform axis-specific matrix multiplication
		a[4] = a10 * c + a20 * s;
		a[5] = a11 * c + a21 * s;
		a[6] = a12 * c + a22 * s;
		a[7] = a13 * c + a23 * s;
		a[8] = a20 * c - a10 * s;
		a[9] = a21 * c - a11 * s;
		a[10] = a22 * c - a12 * s;
		a[11] = a23 * c - a13 * s;
		return this;
	}

	/**
	 * Rotate this matrix on its Y axis.
	 *
	 * @since 1.0.0
	 *
	 * @param rad - The angle to rotate by, in radians.
	 *
	 * @return This Matrix4.
	**/
	public function rotateY(rad:Float)
	{
		var a = val;
		var s = Math.sin(rad);
		var c = Math.cos(rad);
		var a00 = a[0];
		var a01 = a[1];
		var a02 = a[2];
		var a03 = a[3];
		var a20 = a[8];
		var a21 = a[9];
		var a22 = a[10];
		var a23 = a[11];
		// Perform axis-specific matrix multiplication
		a[0] = a00 * c - a20 * s;
		a[1] = a01 * c - a21 * s;
		a[2] = a02 * c - a22 * s;
		a[3] = a03 * c - a23 * s;
		a[8] = a00 * s + a20 * c;
		a[9] = a01 * s + a21 * c;
		a[10] = a02 * s + a22 * c;
		a[11] = a03 * s + a23 * c;
		return this;
	}

	/**
	 * Rotate this matrix on its Z axis.
	 *
	 * @since 1.0.0
	 *
	 * @param rad - The angle to rotate by, in radians.
	 *
	 * @return This Matrix4.
	**/
	public function rotateZ(rad:Float)
	{
		var a = val;
		var s = Math.sin(rad);
		var c = Math.cos(rad);
		var a00 = a[0];
		var a01 = a[1];
		var a02 = a[2];
		var a03 = a[3];
		var a10 = a[4];
		var a11 = a[5];
		var a12 = a[6];
		var a13 = a[7];
		// Perform axis-specific matrix multiplication
		a[0] = a00 * c + a10 * s;
		a[1] = a01 * c + a11 * s;
		a[2] = a02 * c + a12 * s;
		a[3] = a03 * c + a13 * s;
		a[4] = a10 * c - a00 * s;
		a[5] = a11 * c - a01 * s;
		a[6] = a12 * c - a02 * s;
		a[7] = a13 * c - a03 * s;
		return this;
	}

	/**
	 * Set the values of this Matrix from the given rotation Quaternion and translation Vector.
	 *
	 * @since 1.0.0
	 *
	 * @param q - The Quaternion to set rotation from.
	 * @param v - The Vector to set translation from.
	 *
	 * @return This Matrix4.
	**/
	public function fromRotationTranslation(q:Quaternion, v:Vector3)
	{
		// Quaternion math
		var out = val;
		var x = q.x;
		var y = q.y;
		var z = q.z;
		var w = q.w;
		var x2 = x + x;
		var y2 = y + y;
		var z2 = z + z;
		var xx = x * x2;
		var xy = x * y2;
		var xz = x * z2;
		var yy = y * y2;
		var yz = y * z2;
		var zz = z * z2;
		var wx = w * x2;
		var wy = w * y2;
		var wz = w * z2;
		out[0] = 1 - (yy + zz);
		out[1] = xy + wz;
		out[2] = xz - wy;
		out[3] = 0;
		out[4] = xy - wz;
		out[5] = 1 - (xx + zz);
		out[6] = yz + wx;
		out[7] = 0;
		out[8] = xz + wy;
		out[9] = yz - wx;
		out[10] = 1 - (xx + yy);
		out[11] = 0;
		out[12] = v.x;
		out[13] = v.y;
		out[14] = v.z;
		out[15] = 1;
		return this;
	}

	/**
	 * Set the values of this Matrix from the given Quaternion.
	 *
	 * @since 1.0.0
	 *
	 * @param q The Quaternion to set the values of this Matrix from.
	 *
	 * @return This Matrix4.
	**/
	public function fromQuat(q)
	{
		var out = val;
		var x = q.x;
		var y = q.y;
		var z = q.z;
		var w = q.w;
		var x2 = x + x;
		var y2 = y + y;
		var z2 = z + z;
		var xx = x * x2;
		var xy = x * y2;
		var xz = x * z2;
		var yy = y * y2;
		var yz = y * z2;
		var zz = z * z2;
		var wx = w * x2;
		var wy = w * y2;
		var wz = w * z2;
		out[0] = 1 - (yy + zz);
		out[1] = xy + wz;
		out[2] = xz - wy;
		out[3] = 0;
		out[4] = xy - wz;
		out[5] = 1 - (xx + zz);
		out[6] = yz + wx;
		out[7] = 0;
		out[8] = xz + wy;
		out[9] = yz - wx;
		out[10] = 1 - (xx + yy);
		out[11] = 0;
		out[12] = 0;
		out[13] = 0;
		out[14] = 0;
		out[15] = 1;
		return this;
	}

	/**
	 * Generate a frustum matrix with the given bounds.
	 *
	 * @since 1.0.0
	 *
	 * @param left - The left bound of the frustum.
	 * @param right - The right bound of the frustum.
	 * @param bottom - The bottom bound of the frustum.
	 * @param top - The top bound of the frustum.
	 * @param near - The near bound of the frustum.
	 * @param far - The far bound of the frustum.
	 *
	 * @return This Matrix4.
	**/
	public function frustum(left:Float, right:Float, bottom:Float, top:Float, near:Float, far:Float)
	{
		var out = val;
		var rl = 1 / (right - left);
		var tb = 1 / (top - bottom);
		var nf = 1 / (near - far);
		out[0] = (near * 2) * rl;
		out[1] = 0;
		out[2] = 0;
		out[3] = 0;
		out[4] = 0;
		out[5] = (near * 2) * tb;
		out[6] = 0;
		out[7] = 0;
		out[8] = (right + left) * rl;
		out[9] = (top + bottom) * tb;
		out[10] = (far + near) * nf;
		out[11] = -1;
		out[12] = 0;
		out[13] = 0;
		out[14] = (far * near * 2) * nf;
		out[15] = 0;
		return this;
	}

	/**
	 * Generate a perspective projection matrix with the given bounds.
	 *
	 * @since 1.0.0
	 *
	 * @param fovy - Vertical field of view in radians
	 * @param aspect - Aspect ratio. Typically viewport width  /height.
	 * @param near - Near bound of the frustum.
	 * @param far - Far bound of the frustum.
	 *
	 * @return This Matrix4.
	**/
	public function perspective(fovy:Float, aspect:Float, near:Float, far:Float):Matrix4
	{
		var out = val;
		var f = 1.0 / Math.tan(fovy / 2);
		var nf = 1 / (near - far);
		out[0] = f / aspect;
		out[1] = 0;
		out[2] = 0;
		out[3] = 0;
		out[4] = 0;
		out[5] = f;
		out[6] = 0;
		out[7] = 0;
		out[8] = 0;
		out[9] = 0;
		out[10] = (far + near) * nf;
		out[11] = -1;
		out[12] = 0;
		out[13] = 0;
		out[14] = (2 * far * near) * nf;
		out[15] = 0;
		return this;
	}

	/**
	 * Generate a perspective projection matrix with the given bounds.
	 *
	 * @since 1.0.0
	 *
	 * @param width - The width of the frustum.
	 * @param height - The height of the frustum.
	 * @param near - Near bound of the frustum.
	 * @param far - Far bound of the frustum.
	 *
	 * @return This Matrix4.
	**/
	public function perspectiveLH(width:Float, height:Float, near:Float, far:Float):Matrix4
	{
		var out = val;
		out[0] = (2 * near) / width;
		out[1] = 0;
		out[2] = 0;
		out[3] = 0;
		out[4] = 0;
		out[5] = (2 * near) / height;
		out[6] = 0;
		out[7] = 0;
		out[8] = 0;
		out[9] = 0;
		out[10] = -far / (near - far);
		out[11] = 1;
		out[12] = 0;
		out[13] = 0;
		out[14] = (near * far) / (near - far);
		out[15] = 0;
		return this;
	}

	/**
	 * Generate an orthogonal projection matrix with the given bounds.
	 *
	 * @since 1.0.0
	 *
	 * @param left - The left bound of the frustum.
	 * @param right - The right bound of the frustum.
	 * @param bottom - The bottom bound of the frustum.
	 * @param top - The top bound of the frustum.
	 * @param near - The near bound of the frustum.
	 * @param far - The far bound of the frustum.
	 *
	 * @return This Matrix4.
	**/
	public function ortho(left:Float, right:Float, bottom:Float, top:Float, near:Float, far:Float)
	{
		var out = val;
		var lr = left - right;
		var bt = bottom - top;
		var nf = near - far;
		//  Avoid division by zero
		lr = (lr == 0) ? lr : 1.0 / lr;
		bt = (bt == 0) ? bt : 1.0 / bt;
		nf = (nf == 0) ? nf : 1.0 / nf;
		out[0] = -2 * lr;
		out[1] = 0;
		out[2] = 0;
		out[3] = 0;
		out[4] = 0;
		out[5] = -2 * bt;
		out[6] = 0;
		out[7] = 0;
		out[8] = 0;
		out[9] = 0;
		out[10] = 2 * nf;
		out[11] = 0;
		out[12] = (left + right) * lr;
		out[13] = (top + bottom) * bt;
		out[14] = (far + near) * nf;
		out[15] = 1;
		return this;
	}

	/**
	 * Generate a look-at matrix with the given eye position, focal point, and up axis.
	 *
	 * @since 1.0.0
	 *
	 * @return This Matrix4.
	**/
	public function lookAt(eye:Vector3, center:Vector3, up:Vector3):Matrix4
	{
		var out = val;
		var eyex = eye.x;
		var eyey = eye.y;
		var eyez = eye.z;
		var upx = up.x;
		var upy = up.y;
		var upz = up.z;
		var centerx = center.x;
		var centery = center.y;
		var centerz = center.z;
		if (Math.abs(eyex - centerx) < EPSILON && Math.abs(eyey - centery) < EPSILON && Math.abs(eyez - centerz) < EPSILON)
		{
			return identity();
		}
		var z0 = eyex - centerx;
		var z1 = eyey - centery;
		var z2 = eyez - centerz;
		var len = 1 / Math.sqrt(z0 * z0 + z1 * z1 + z2 * z2);
		z0 *= len;
		z1 *= len;
		z2 *= len;
		var x0 = upy * z2 - upz * z1;
		var x1 = upz * z0 - upx * z2;
		var x2 = upx * z1 - upy * z0;
		len = Math.sqrt(x0 * x0 + x1 * x1 + x2 * x2);
		if (len == 0)
		{
			x0 = 0;
			x1 = 0;
			x2 = 0;
		}
		else
		{
			len = 1 / len;
			x0 *= len;
			x1 *= len;
			x2 *= len;
		}
		var y0 = z1 * x2 - z2 * x1;
		var y1 = z2 * x0 - z0 * x2;
		var y2 = z0 * x1 - z1 * x0;
		len = Math.sqrt(y0 * y0 + y1 * y1 + y2 * y2);
		if (len == 0)
		{
			y0 = 0;
			y1 = 0;
			y2 = 0;
		}
		else
		{
			len = 1 / len;
			y0 *= len;
			y1 *= len;
			y2 *= len;
		}
		out[0] = x0;
		out[1] = y0;
		out[2] = z0;
		out[3] = 0;
		out[4] = x1;
		out[5] = y1;
		out[6] = z1;
		out[7] = 0;
		out[8] = x2;
		out[9] = y2;
		out[10] = z2;
		out[11] = 0;
		out[12] = -(x0 * eyex + x1 * eyey + x2 * eyez);
		out[13] = -(y0 * eyex + y1 * eyey + y2 * eyez);
		out[14] = -(z0 * eyex + z1 * eyey + z2 * eyez);
		out[15] = 1;
		return this;
	}

	/**
	 * Set the values of this matrix from the given `yaw`, `pitch` and `roll` values.
	 *
	 * @since 1.0.0
	 *
	 * @param yaw - [description]
	 * @param pitch - [description]
	 * @param roll - [description]
	 *
	 * @return This Matrix4.
	**/
	public function yawPitchRoll(yaw:Float, pitch:Float, roll:Float)
	{
		zero();
		_tempMat1.zero();
		_tempMat2.zero();
		var m0 = val;
		var m1 = _tempMat1.val;
		var m2 = _tempMat2.val;
		//  Rotate Z
		var s = Math.sin(roll);
		var c = Math.cos(roll);
		m0[10] = 1;
		m0[15] = 1;
		m0[0] = c;
		m0[1] = s;
		m0[4] = -s;
		m0[5] = c;
		//  Rotate X
		s = Math.sin(pitch);
		c = Math.cos(pitch);
		m1[0] = 1;
		m1[15] = 1;
		m1[5] = c;
		m1[10] = c;
		m1[9] = -s;
		m1[6] = s;
		//  Rotate Y
		s = Math.sin(yaw);
		c = Math.cos(yaw);
		m2[5] = 1;
		m2[15] = 1;
		m2[0] = c;
		m2[2] = -s;
		m2[8] = s;
		m2[10] = c;
		multiplyLocal(_tempMat1);
		multiplyLocal(_tempMat2);
		return this;
	}

	/**
	 * Generate a world matrix from the given rotation, position, scale, view matrix and projection matrix.
	 *
	 * @since 1.0.0
	 *
	 * @param rotation - The rotation of the world matrix.
	 * @param position - The position of the world matrix.
	 * @param scale - The scale of the world matrix.
	 * @param viewMatrix - The view matrix.
	 * @param projectionMatrix - The projection matrix.
	 *
	 * @return this Matrix4.
	**/
	public function setWorldMatrix(rotation:Vector3, position:Vector3, scale:Vector3, ?viewMatrix:Matrix4, ?projectionMatrix:Matrix4):Matrix4
	{
		yawPitchRoll(rotation.y, rotation.x, rotation.z);

		_tempMat1.scaling(scale.x, scale.y, scale.z);
		_tempMat2.xyz(position.x, position.y, position.z);

		multiplyLocal(_tempMat1);
		multiplyLocal(_tempMat2);

		if (viewMatrix != null)
		{
			multiplyLocal(viewMatrix);
		}
		if (projectionMatrix != null)
		{
			multiplyLocal(projectionMatrix);
		}

		return this;
	}
}
