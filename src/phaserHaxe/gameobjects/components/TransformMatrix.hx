package phaserHaxe.gameobjects.components;

import js.html.CanvasRenderingContext2D;
import phaserHaxe.math.Vector2;
import phaserHaxe.geom.Point;
import haxe.io.Float32Array;

@:structInit
class DecomposedMatrix
{
	public var translateX:Float;
	public var translateY:Float;
	public var scaleX:Float;
	public var scaleY:Float;
	public var rotation:Float;
}

/**
 * A Matrix used for display transformations for rendering.
 *
 * It is represented like so:
 *
 * ```
 * | a | c | tx |
 * | b | d | ty |
 * | 0 | 0 | 1  |
 * ```
 * @since 1.0.0
 *
**/
class TransformMatrix
{
	/**
	 * The matrix values.
	 *
	 * @since 1.0.0
	**/
	public var matrix:Float32Array;

	/**
	 * The decomposed matrix.
	 *
	 * @since 1.0.0
	**/
	public var decomposedMatrix:DecomposedMatrix;

	/**
	 * The Scale X value.
	 *
	 * @since 1.0.0
	**/
	public var a(get, set):Float;

	/**
	 * The Shear Y value..
	 *
	 * @since 1.0.0
	**/
	public var b(get, set):Float;

	/**
	 * The Shear X value.
	 *
	 * @since 1.0.0
	**/
	public var c(get, set):Float;

	/**
	 * The Scale Y value.
	 *
	 * @since 1.0.0
	**/
	public var d(get, set):Float;

	/**
	 * The Translate X value.
	 *
	 * @since 1.0.0
	**/
	public var e(get, set):Float;

	/**
	 * The Translate Y value.
	 *
	 * @since 1.0.0
	**/
	public var f(get, set):Float;

	/**
	 * The Translate X value.
	 *
	 * @since 1.0.0
	**/
	public var tx(get, set):Float;

	/**
	 * The Translate X value.
	 *
	 * @since 1.0.0
	**/
	public var ty(get, set):Float;

	/**
	 * The rotation of the Matrix.
	 *
	 * @since 1.0.0
	**/
	public var rotation(get, null):Float;

	/**
	 * The horizontal scale of the Matrix
	 *
	 * @since 1.0.0
	**/
	public var scaleX(get, null):Float;

	/**
	 * The vertical scale of the Matrix.
	 *
	 * @since 1.0.0
	**/
	public var scaleY(get, null):Float;

	/**
	 * @param a - The Scale X value.
	 * @param b - The Shear Y value.
	 * @param c - The Shear X value.
	 * @param d - The Scale Y value.
	 * @param tx - The Translate X value.
	 * @param ty - The Translate Y value.
	**/
	public function new(a:Float = 1, b:Float = 0, c:Float = 0, d:Float = 1,
			tx:Float = 0, ty:Float = 0)
	{
		matrix = Float32Array.fromArray([a, b, c, d, tx, ty, 0, 0, 1]);
		decomposedMatrix = {
			translateX: 0,
			translateY: 0,
			scaleX: 1,
			scaleY: 1,
			rotation: 0
		};
	}

	private inline function get_a():Float
	{
		return matrix[0];
	}

	private inline function set_a(value:Float):Float
	{
		matrix[0] = value;
		return value;
	}

	private inline function get_b():Float
	{
		return matrix[1];
	}

	private inline function set_b(value:Float):Float
	{
		matrix[1] = value;
		return value;
	}

	private inline function get_c():Float
	{
		return matrix[2];
	}

	private inline function set_c(value:Float):Float
	{
		matrix[2] = value;
		return value;
	}

	private inline function get_d():Float
	{
		return matrix[3];
	}

	private inline function set_d(value:Float):Float
	{
		matrix[3] = value;
		return value;
	}

	private inline function get_e():Float
	{
		return matrix[4];
	}

	private inline function set_e(value:Float):Float
	{
		matrix[4] = value;
		return value;
	}

	private inline function get_f():Float
	{
		return matrix[5];
	}

	private inline function set_f(value:Float):Float
	{
		matrix[5] = value;
		return value;
	}

	private inline function get_tx():Float
	{
		return matrix[4];
	}

	private inline function set_tx(value:Float):Float
	{
		matrix[4] = value;
		return value;
	}

	private inline function get_ty():Float
	{
		return matrix[5];
	}

	private inline function set_ty(value:Float):Float
	{
		matrix[5] = value;
		return value;
	}

	private inline function get_rotation():Float
	{
		return Math.acos(a / scaleX) * (Math.atan(-c / this.a) < 0 ? -1 : 1);
	}

	private inline function get_scaleX():Float
	{
		return Math.sqrt((a * a) + (c * c));
	}

	private inline function get_scaleY():Float
	{
		return Math.sqrt((b * b) + (d * d));
	}

	/**
	 * Reset the Matrix to an identity matrix.
	 *
	 * @since 1.0.0
	 *
	 * @return This TransformMatrix.
	**/
	public function loadIdentity():TransformMatrix
	{
		matrix[0] = 1;
		matrix[1] = 0;
		matrix[2] = 0;
		matrix[3] = 1;
		matrix[4] = 0;
		matrix[5] = 0;

		return this;
	}

	/**
	 * Translate the Matrix.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The horizontal translation value.
	 * @param y - The vertical translation value.
	 *
	 * @return {this} This TransformMatrix.
	**/
	public function translate(x:Float, y:Float):TransformMatrix
	{
		var matrix = this.matrix;

		matrix[4] = matrix[0] * x + matrix[2] * y + matrix[4];
		matrix[5] = matrix[1] * x + matrix[3] * y + matrix[5];

		return this;
	}

	/**
	 * Scale the Matrix.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The horizontal scale value.
	 * @param y - The vertical scale value.
	 *
	 * @return This TransformMatrix.
	**/
	public function scale(x:Float, y:Float):TransformMatrix
	{
		var matrix = this.matrix;

		matrix[0] *= x;
		matrix[1] *= x;
		matrix[2] *= y;
		matrix[3] *= y;

		return this;
	}

	/**
	 * Rotate the Matrix.
	 *
	 * @since 1.0.0
	 *
	 * @param angle - The angle of rotation in radians.
	 *
	 * @return This TransformMatrix.
	**/
	public function rotate(angle:Float):TransformMatrix
	{
		var sin = Math.sin(angle);
		var cos = Math.cos(angle);

		var matrix = this.matrix;

		var a = matrix[0];
		var b = matrix[1];
		var c = matrix[2];
		var d = matrix[3];

		matrix[0] = a * cos + c * sin;
		matrix[1] = b * cos + d * sin;
		matrix[2] = a * -sin + c * cos;
		matrix[3] = b * -sin + d * cos;

		return this;
	}

	/**
	 * Multiply this Matrix by the given Matrix.
	 *
	 * If an `out` Matrix is given then the results will be stored in it.
	 * If it is not given, this matrix will be updated in place instead.
	 * Use an `out` Matrix if you do not wish to mutate this matrix.
	 *
	 * @since 1.0.0
	 *
	 * @param rhs - The Matrix to multiply by.
	 * @param out - An optional Matrix to store the results in.
	 *
	 * @return Either this TransformMatrix, or the `out` Matrix, if given in the arguments.
	**/
	public function multiply(rhs:TransformMatrix, ?out:TransformMatrix)
	{
		var matrix = this.matrix;
		var source = rhs.matrix;

		var localA = matrix[0];
		var localB = matrix[1];
		var localC = matrix[2];
		var localD = matrix[3];
		var localE = matrix[4];
		var localF = matrix[5];

		var sourceA = source[0];
		var sourceB = source[1];
		var sourceC = source[2];
		var sourceD = source[3];
		var sourceE = source[4];
		var sourceF = source[5];

		var destinationMatrix = (out == null) ? this : out;

		destinationMatrix.a = (sourceA * localA) + (sourceB * localC);
		destinationMatrix.b = (sourceA * localB) + (sourceB * localD);
		destinationMatrix.c = (sourceC * localA) + (sourceD * localC);
		destinationMatrix.d = (sourceC * localB) + (sourceD * localD);
		destinationMatrix.e = (sourceE * localA) + (sourceF * localC) + localE;
		destinationMatrix.f = (sourceE * localB) + (sourceF * localD) + localF;

		return destinationMatrix;
	}

	/**
	 * Multiply this Matrix by the matrix given, including the offset.
	 *
	 * The offsetX is added to the tx value: `offsetX * a + offsetY * c + tx`.
	 * The offsetY is added to the ty value: `offsetY * b + offsetY * d + ty`.
	 *
	 * @since 1.0.0
	 *
	 * @param src - The source Matrix to copy from.
	 * @param offsetX - Horizontal offset to factor in to the multiplication.
	 * @param offsetY - Vertical offset to factor in to the multiplication.
	 *
	 * @return This TransformMatrix.
	**/
	public function multiplyWithOffset(src:TransformMatrix, offsetX:Float, offsetY:Float)
	{
		var matrix = this.matrix;
		var otherMatrix = src.matrix;

		var a0 = matrix[0];
		var b0 = matrix[1];
		var c0 = matrix[2];
		var d0 = matrix[3];
		var tx0 = matrix[4];
		var ty0 = matrix[5];

		var pse = offsetX * a0 + offsetY * c0 + tx0;
		var psf = offsetX * b0 + offsetY * d0 + ty0;

		var a1 = otherMatrix[0];
		var b1 = otherMatrix[1];
		var c1 = otherMatrix[2];
		var d1 = otherMatrix[3];
		var tx1 = otherMatrix[4];
		var ty1 = otherMatrix[5];

		matrix[0] = a1 * a0 + b1 * c0;
		matrix[1] = a1 * b0 + b1 * d0;
		matrix[2] = c1 * a0 + d1 * c0;
		matrix[3] = c1 * b0 + d1 * d0;
		matrix[4] = tx1 * a0 + ty1 * c0 + pse;
		matrix[5] = tx1 * b0 + ty1 * d0 + psf;

		return this;
	}

	/**
	 * Transform the Matrix.
	 *
	 * @since 3.0.0
	 *
	 * @param a - The Scale X value.
	 * @param b - The Shear Y value.
	 * @param c - The Shear X value.
	 * @param d - The Scale Y value.
	 * @param tx - The Translate X value.
	 * @param ty - The Translate Y value.
	 *
	 * @return This TransformMatrix.
	**/
	public function transform(a:Float, b:Float, c:Float, d:Float, tx:Float,
			ty:Float):TransformMatrix
	{
		var matrix = this.matrix;

		var a0 = matrix[0];
		var b0 = matrix[1];
		var c0 = matrix[2];
		var d0 = matrix[3];
		var tx0 = matrix[4];
		var ty0 = matrix[5];

		matrix[0] = a * a0 + b * c0;
		matrix[1] = a * b0 + b * d0;
		matrix[2] = c * a0 + d * c0;
		matrix[3] = c * b0 + d * d0;
		matrix[4] = tx * a0 + ty * c0 + tx0;
		matrix[5] = tx * b0 + ty * d0 + ty0;

		return this;
	}

	/**
	 * Transform a point using this Matrix.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The x coordinate of the point to transform.
	 * @param y - The y coordinate of the point to transform.
	 * @param point - The Point object to store the transformed coordinates.
	 *
	 * @return The Point containing the transformed coordinates.
	**/
	public function transformPoint(x:Float, y:Float, ?point:Point):Point
	{
		if (point == null)
		{
			point = {x: 0, y: 0};
		}

		var matrix = this.matrix;

		var a = matrix[0];
		var b = matrix[1];
		var c = matrix[2];
		var d = matrix[3];
		var tx = matrix[4];
		var ty = matrix[5];

		point.x = x * a + y * c + tx;
		point.y = x * b + y * d + ty;

		return point;
	}

	/**
	 * Invert the Matrix.
	 *
	 * @since 1.0.0
	 *
	 * @return This TransformMatrix.
	**/
	public function invert():TransformMatrix
	{
		var matrix = this.matrix;

		var a = matrix[0];
		var b = matrix[1];
		var c = matrix[2];
		var d = matrix[3];
		var tx = matrix[4];
		var ty = matrix[5];

		var n = a * d - b * c;

		matrix[0] = d / n;
		matrix[1] = -b / n;
		matrix[2] = -c / n;
		matrix[3] = a / n;
		matrix[4] = (c * ty - d * tx) / n;
		matrix[5] = -(a * ty - b * tx) / n;

		return this;
	}

	/**
	 * Set the values of this Matrix to copy those of the matrix given.
	 *
	 * @since 1.0.0
	 *
	 * @param src - The source Matrix to copy from.
	 *
	 * @return This TransformMatrix.
	**/
	public function copyFrom(src:TransformMatrix):TransformMatrix
	{
		var matrix = matrix;

		matrix[0] = src.a;
		matrix[1] = src.b;
		matrix[2] = src.c;
		matrix[3] = src.d;
		matrix[4] = src.e;
		matrix[5] = src.f;

		return this;
	}

	/**
	 * Set the values of this Matrix to copy those of the array given.
	 * Where array indexes 0, 1, 2, 3, 4 and 5 are mapped to a, b, c, d, e and f.
	 *
	 * @since 1.0.0
	 *
	 * @param src - The array of values to set into this matrix.
	 *
	 * @return This TransformMatrix.
	**/
	public function copyFromArray(src:Array<Float>):TransformMatrix
	{
		var matrix = this.matrix;

		matrix[0] = src[0];
		matrix[1] = src[1];
		matrix[2] = src[2];
		matrix[3] = src[3];
		matrix[4] = src[4];
		matrix[5] = src[5];

		return this;
	}

	/**
	 * Copy the values from this Matrix to the given Canvas Rendering Context.
	 * This will use the Context.transform method.
	 *
	 * @since 1.0.0
	 *
	 * @param ctx - The Canvas Rendering Context to copy the matrix values to.
	 *
	 * @return The Canvas Rendering Context.
	**/
	public function copyToContext(ctx:CanvasRenderingContext2D):CanvasRenderingContext2D
	{
		var matrix = matrix;

		ctx.transform(matrix[0], matrix[1], matrix[2], matrix[3], matrix[4], matrix[5]);

		return ctx;
	}

	/**
	 * Copy the values from this Matrix to the given Canvas Rendering Context.
	 * This will use the Context.setTransform method.
	 *
	 * @since 1.0.0
	 *
	 * @param ctx - The Canvas Rendering Context to copy the matrix values to.
	 *
	 * @return The Canvas Rendering Context.
	**/
	public function setToContext(ctx:CanvasRenderingContext2D)
	{
		var matrix = matrix;

		ctx.setTransform(matrix[0], matrix[1], matrix[2], matrix[3], matrix[4], matrix[5]);

		return ctx;
	}

	/**
	 * Copy the values in this Matrix to the array given.
	 *
	 * Where array indexes 0, 1, 2, 3, 4 and 5 are mapped to a, b, c, d, e and f.
	 *
	 * @since 1.0.0
	 *
	 * @param out - The array to copy the matrix values in to.
	 *
	 * @return An array where elements 0 to 5 contain the values from this matrix.
	**/
	public function copyToArray(out:Array<Float>):Array<Float>
	{
		var matrix = matrix;

		if (out == null)
		{
			out = [matrix[0], matrix[1], matrix[2], matrix[3], matrix[4], matrix[5]];
		}
		else
		{
			out[0] = matrix[0];
			out[1] = matrix[1];
			out[2] = matrix[2];
			out[3] = matrix[3];
			out[4] = matrix[4];
			out[5] = matrix[5];
		}

		return out;
	}

	/**
	 * Set the values of this Matrix.
	 *
	 * @since 1.0.0
	 *
	 * @param a - The Scale X value.
	 * @param b - The Shear Y value.
	 * @param c - The Shear X value.
	 * @param d - The Scale Y value.
	 * @param tx - The Translate X value.
	 * @param ty - The Translate Y value.
	 *
	 * @return {this} This TransformMatrix.
	**/
	public function setTransform(a:Float, b:Float, c:Float, d:Float, tx:Float,
			ty:Float):TransformMatrix
	{
		var matrix = matrix;

		matrix[0] = a;
		matrix[1] = b;
		matrix[2] = c;
		matrix[3] = d;
		matrix[4] = tx;
		matrix[5] = ty;

		return this;
	}

	/**
	 * Decompose this Matrix into its translation, scale and rotation values using QR decomposition.
	 *
	 * The result must be applied in the following order to reproduce the current matrix:
	 *
	 * translate -> rotate -> scale
	 *
	 * @since 1.0.0
	 *
	 * @return The decomposed Matrix.
	**/
	public function decomposeMatrix()
	{
		var decomposedMatrix = decomposedMatrix;

		var matrix = matrix;

		//  a = scale X (1)
		//  b = shear Y (0)
		//  c = shear X (0)
		//  d = scale Y (1)

		var a = matrix[0];
		var b = matrix[1];
		var c = matrix[2];
		var d = matrix[3];

		var determ = a * d - b * c;

		decomposedMatrix.translateX = matrix[4];
		decomposedMatrix.translateY = matrix[5];

		if (a != 0 || b != 0)
		{
			var r = Math.sqrt(a * a + b * b);

			decomposedMatrix.rotation = (b > 0) ? Math.acos(a / r) : -Math.acos(a / r);
			decomposedMatrix.scaleX = r;
			decomposedMatrix.scaleY = determ / r;
		}
		else if (c != 0 || d != 0)
		{
			var s = Math.sqrt(c * c + d * d);

			decomposedMatrix.rotation = Math.PI * 0.5 - (d > 0 ? Math.acos(-c / s) : -Math.acos(c / s));
			decomposedMatrix.scaleX = determ / s;
			decomposedMatrix.scaleY = s;
		}
		else
		{
			decomposedMatrix.rotation = 0;
			decomposedMatrix.scaleX = 0;
			decomposedMatrix.scaleY = 0;
		}

		return decomposedMatrix;
	}

	/**
	 * Apply the identity, translate, rotate and scale operations on the Matrix.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The horizontal translation.
	 * @param y - The vertical translation.
	 * @param rotation - The angle of rotation in radians.
	 * @param scaleX - The horizontal scale.
	 * @param scaleY - The vertical scale.
	 *
	 * @return This TransformMatrix.
	**/
	public function applyITRS(x:Float, y:Float, rotation:Float, scaleX:Float,
			scaleY:Float):TransformMatrix
	{
		var matrix = matrix;

		var radianSin = Math.sin(rotation);
		var radianCos = Math.cos(rotation);

		// Translate
		matrix[4] = x;
		matrix[5] = y;

		// Rotate and Scale
		matrix[0] = radianCos * scaleX;
		matrix[1] = radianSin * scaleX;
		matrix[2] = -radianSin * scaleY;
		matrix[3] = radianCos * scaleY;

		return this;
	}

	/**
	 * Takes the `x` and `y` values and returns a new position in the `output` vector that is the inverse of
	 * the current matrix with its transformation applied.
	 *
	 * Can be used to translate points from world to local space.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The x position to translate.
	 * @param y - The y position to translate.
	 * @param output - A Vector2 to store the results in.
	 *
	 * @return The coordinates, inverse-transformed through this matrix.
	**/
	public function applyInverse(x:Float, y:Float, output:Vector2):Vector2
	{
		if (output == null)
		{
			output = new Vector2();
		}

		var matrix = matrix;

		var a = matrix[0];
		var b = matrix[1];
		var c = matrix[2];
		var d = matrix[3];
		var tx = matrix[4];
		var ty = matrix[5];

		var id = 1 / ((a * d) + (c * -b));

		output.x = (d * id * x) + (-c * id * y) + (((ty * c) - (tx * d)) * id);
		output.y = (a * id * y) + (-b * id * x) + (((-ty * a) + (tx * b)) * id);

		return output;
	}

	/**
	 * Returns the X component of this matrix multiplied by the given values.
	 * This is the same as `x * a + y * c + e`.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The x value.
	 * @param y - The y value.
	 *
	 * @return The calculated x value.
	**/
	public function getX(x:Float, y:Float):Float
	{
		return x * a + y * c + e;
	}

	/**
	 * Returns the Y component of this matrix multiplied by the given values.
	 * This is the same as `x * b + y * d + f`.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The x value.
	 * @param y - The y value.
	 *
	 * @return The calculated y value.
	**/
	public function getY(x:Float, y:Float):Float
	{
		return x * b + y * d + f;
	}

	/**
	 * Returns a string that can be used in a CSS Transform call as a `matrix` property.
	 *
	 * @since 1.0.0
	 *
	 * @return A string containing the CSS Transform matrix values.
	**/
	public function getCSSMatrix():String
	{
		var m = matrix;

		return 'matrix(' + m[0] + ',' + m[1] + ',' + m[2] + ',' + m[3] + ',' + m[4] +
			',' + m[5] + ')';
	}

	/**
	 * Destroys this Transform Matrix.
	 *
	 * @since 1.0.0
	**/
	public function destroy():Void
	{
		matrix = null;
		decomposedMatrix = null;
	}
}
