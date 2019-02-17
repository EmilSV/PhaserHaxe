package phaserHaxe.math;

import haxe.ds.ReadOnlyArray;

typedef SinCosTable =
{
	final sin:ReadOnlyArray<Float>;
	final cos:ReadOnlyArray<Float>;
	final length:Int;
}

class MathUtility
{
	private static final tmpMat4 = new Matrix4();
	private static final tmpQuat = new Quaternion();
	private static final tmpVec3 = new Vector3();

	/**
	 * Wrap the given `value` between `min` and `max.
	 *
	 * @since 1.0.0
	 *
	 * @param value The value to wrap.
	 * @param min The minimum value.
	 * @param max The maximum value.
	 *
	 * @return The wrapped value.
	**/
	public static function Wrap(value:Float, min:Float, max:Float):Float
	{
		var range = max - min;
		return (min + ((((value - min) % range) + range) % range));
	}

	/**
	 * Calculate the mean average of the given values.
	 *
	 * @since 1.0.0
	 *
	 * @param values - The values to average.
	 *
	 * @return The average value.
	**/
	public static function Average(values:Array<Float>):Float
	{
		var sum = 0.0;

		for (value in values)
		{
			sum += value;
		}

		return sum / values.length;
	}

	/**
	 * Compute a random integer between the `min` and `max` values, inclusive.
	 *
	 * @since 1.0.0
	 *
	 * @param  min - The minimum value.
	 * @param  max - The maximum value.
	 *
	 * @return The random integer.
	**/
	public static function Between(min:Int, max:Int):Int
	{
		return Math.floor(Math.random() * (max - min + 1) + min);
	}

	/**
	 * Ceils to some place comparative to a `base`, default is 10 for decimal place.
	 *
	 * The `place` is represented by the power applied to `base` to get that place.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The value to round.
	 * @param place - The place to round to.
	 * @param base - The base to round in. Default is 10 for decimal.
	 *
	 * @return The rounded value.
	**/
	public static function CeilTo(value:Float, place:Float = 0, base:Int = 10)
	{
		var p = Math.pow(base, -place);
		return Math.ceil(value * p) / p;
	}

	/**
	 * Compatibility the given angle from degrees, to the equivalent angle in radians.
	 *
	 * @since 1.0.0
	 *
	 * @param degrees - The angle (in degrees) to Compatibility to radians.
	 *
	 * @return The given angle Compatibilityed to radians.
	**/
	public static function DegToRad(degrees:Int)
	{
		return degrees * MathConst.DEG_TO_RAD;
	}

	public static inline function boolToInt(v:Bool):Int
	{
		#if js
		return js.Syntax.code("(({0}) | 0 )", v);
		#else
		return v ? 1 : 0;
		#end
	}

	/**
	 * Force a value within the boundaries by clamping it to the range `min`, `max`.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The value to be clamped.
	 * @param min - The minimum bounds.
	 * @param max - The maximum bounds.
	 *
	 * @return The clamped value.
	**/
	public static function Clamp(value:Float, min:Float, max:Float):Float
	{
		return Math.max(min, Math.min(max, value));
	}

	/**
	 * Calculate the speed required to cover a distance in the time given.
	 *
	 * @since 1.0.0
	 *
	 * @param distance - The distance to travel in pixels.
	 * @param time - The time, in ms, to cover the distance in.
	 *
	 * @return The amount you will need to increment the position by each step in order to cover the distance in the time given.
	**/
	public static function GetSpeed(distance:Float, time:Int):Float
	{
		return (distance / time) / 1000;
	}

	/**
	 * Return a value based on the range between `min` and `max` and the percentage given.
	 *
	 * @since 1.0.0
	 *
	 * @param percent - A value between 0 and 1 representing the percentage.
	 * @param min - The minimum value.
	 * @param max - The maximum value.
	 *
	 * @return The value that is `percent` percent between `min` and `max`.
	**/
	public static function FromPercent(percent:Float, min:Float, max:Float):Float
	{
		percent = Clamp(percent, 0, 1);

		return (max - min) * percent;
	}

	/**
	 * Floors to some place comparative to a `base`, default is 10 for decimal place.
	 *
	 * The `place` is represented by the power applied to `base` to get that place.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The value to round.
	 * @param place - The place to round to.
	 * @param base - The base to round in. Default is 10 for decimal.
	 *
	 * @return The rounded value.
	**/
	public static function FloorTo(value:Float, place:Int = 0, base:Int = 10):Float
	{
		var p = Math.pow(base, -place);

		return Math.floor(value * p) / p;
	}

	/**
	 * Generate a random floating point number between the two given bounds, minimum inclusive, maximum exclusive.
	 *
	 * @since 1.0.0
	 *
	 * @param min - The lower bound for the float, inclusive.
	 * @param max - The upper bound for the float exclusive.
	 *
	 * @return A random float within the given range.
	**/
	public static function FloatBetween(min:Float, max:Float):Float
	{
		return Math.random() * (max - min) + min;
	}

	/**
	 * Calculates the factorial of a given number for integer values greater than 0.
	 *
	 * @since 1.0.0
	 *
	 * @param value - A positive integer to calculate the factorial of.
	 *
	 * @return The factorial of the given number.
	**/
	public static function Factorial(value:Float):Float
	{
		if (value == 0)
		{
			return 1;
		}

		var res = value;

		while ((--value) != 0)
		{
			res *= value;
		}

		return res;
	}

	/**
	 * Calculates the positive difference of two given numbers.
	 *
	 * @since 1.0.0
	 *
	 * @param a - The first number in the calculation.
	 * @param b - The second number in the calculation.
	 *
	 * @return The positive difference of the two given numbers.
	**/
	public static function Difference(a:Float, b:Float)
	{
		return Math.abs(a - b);
	}

	/**
	 * Check if a given value is an even number.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The number to perform the check with.
	 *
	 * @return Whether the number is even or not.
	**/
	public static function IsEvenFloat(value:Float):Bool
	{
		return (value % 2) == 0;
	}

	/**
	 * Check if a given value is an even number.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The number to perform the check with.
	 *
	 * @return Whether the number is even or not.
	**/
	public static function IsEven(value:Int):Bool
	{
		return (value % 2) == 0;
	}

	/**
	 * Calculates a linear (interpolation) value over t.
	 *
	 * @since 1.0.0
	 *
	 * @param p0 - The first point.
	 * @param p1 - The second point.
	 * @param t - The percentage between p0 and p1 to return, represented as a number between 0 and 1.
	 *
	 * @return The step t% of the way between p0 and p1.
	**/
	public static function Linear(p0:Float, p1:Float, t:Float):Float
	{
		return (p1 - p0) * t + p0;
	}

	/**
	 * Checks if the two values are within the given `tolerance` of each other.
	 *
	 * @since 1.0.0
	 *
	 * @param a - The first value to use in the calculation.
	 * @param b - The second value to use in the calculation.
	 * @param tolerance - The tolerance. Anything equal to or less than this value is considered as being within range.
	 *
	 * @return Returns `true` if `a` is less than or equal to the tolerance of `b`.
	**/
	public static function Within(a:Float, b:Float, tolerance:Float):Bool
	{
		return (Math.abs(a - b) <= tolerance);
	}

	/**
	 * Takes the `x` and `y` coordinates and transforms them into the same space as
	 * defined by the position, rotation and scale values.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The x coordinate to be transformed.
	 * @param y - The y coordinate to be transformed.
	 * @param positionX - Horizontal position of the transform point.
	 * @param positionY - Vertical position of the transform point.
	 * @param rotation - Rotation of the transform point, in radians.
	 * @param scaleX - Horizontal scale of the transform point.
	 * @param scaleY - Vertical scale of the transform point.
	 * @param output - The output vector, point or object for the translated coordinates.
	 *
	 * @return The translated point.
	**/
	public static function TransformXY(x:Float, y:Float, positionX:Float, positionY:Float, rotation:Float,
			scaleX:Float, scaleY:Float, output:Vector2):Vector2
	{
		if (output == null)
		{
			output = new Vector2();
		}

		var radianSin = Math.sin(rotation);
		var radianCos = Math.cos(rotation);

		// Rotate and Scale
		var a = radianCos * scaleX;
		var b = radianSin * scaleX;
		var c = -radianSin * scaleY;
		var d = radianCos * scaleY;

		//  Invert
		var id = 1 / ((a * d) + (c * -b));

		output.x = (d * id * x) + (-c * id * y) + (((positionY * c) - (positionX * d)) * id);
		output.y = (a * id * y) + (-b * id * x) + (((-positionY * a) + (positionX * b)) * id);

		return output;
	}

	/**
	 * Calculate a smooth interpolation percentage of `x` between `min` and `max`.
	 *
	 * The function receives the number `x` as an argument and returns 0 if `x` is less than or equal to the left edge,
	 * 1 if `x` is greater than or equal to the right edge, and smoothly interpolates, using a Hermite polynomial,
	 * between 0 and 1 otherwise.
	 *
	 * @since 3.0.0
	 * @see https://en.wikipedia.org/wiki/Smoothstep
	 *
	 * @param x - The input value.
	 * @param min - The minimum value, also known as the 'left edge', assumed smaller than the 'right edge'.
	 * @param max - The maximum value, also known as the 'right edge', assumed greater than the 'left edge'.
	 *
	 * @return The percentage of interpolation, between 0 and 1.
	**/
	public static function SmoothStep(x:Float, min:Float, max:Float):Float
	{
		if (x <= min)
		{
			return 0;
		}

		if (x >= max)
		{
			return 1;
		}

		x = (x - min) / (max - min);

		return x * x * (3 - 2 * x);
	}

	/**
	 * Calculate a smoother interpolation percentage of `x` between `min` and `max`.
	 *
	 * The function receives the number `x` as an argument and returns 0 if `x` is less than or equal to the left edge,
	 * 1 if `x` is greater than or equal to the right edge, and smoothly interpolates, using a Hermite polynomial,
	 * between 0 and 1 otherwise.
	 *
	 * Produces an even smoother interpolation than SmoothStep.
	 *
	 * @since 1.0.0
	 * @see https://en.wikipedia.org/wiki/Smoothstep#Variations
	 *
	 * @param x - The input value.
	 * @param min - The minimum value, also known as the 'left edge', assumed smaller than the 'right edge'.
	 * @param max - The maximum value, also known as the 'right edge', assumed greater than the 'left edge'.
	 *
	 * @return The percentage of interpolation, between 0 and 1.
	**/
	public static function SmootherStep(x:Float, min:Float, max:Float):Float
	{
		x = Math.max(0, Math.min(1, (x - min) / (max - min)));

		return x * x * x * (x * (x * 6 - 15) + 10);
	}

	/**
	 * Generate a series of sine and cosine values.
	 *
	 * @since 1.0.0
	 *
	 * @param length - The number of values to generate.
	 * @param sinAmp - The sine value amplitude.
	 * @param cosAmp - The cosine value amplitude.
	 * @param frequency - The frequency of the values.
	 *
	 * @return The generated values.
	**/
	public static function SinCosTableGenerator(length:Int, sinAmp:Float = 1, cosAmp:Float = 1, frequency:Float = 1):SinCosTable
	{
		frequency *= Math.PI / length;

		var cos:Array<Float> = [];
		var sin:Array<Float> = [];

		for (c in 0...length)
		{
			cosAmp -= sinAmp * frequency;
			sinAmp += cosAmp * frequency;

			cos[c] = cosAmp;
			sin[c] = sinAmp;
		}

		return {
			sin: sin,
			cos: cos,
			length: length
		};
	}

	/**
	 * Round a value to a given decimal place.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The value to round.
	 * @param place - The place to round to.
	 * @param base - The base to round in. Default is 10 for decimal.
	 *
	 * @return The rounded value.
	**/
	public static function RoundTo(value:Float, place:Int = 0, base:Int = 10):Float
	{
		var p = Math.pow(base, -place);

		return Math.round(value * p) / p;
	}

	/**
	 * Round a given number so it is further away from zero. That is, positive numbers are rounded up, and negative numbers are rounded down.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The number to round.
	 *
	 * @return The rounded number, rounded away from zero.
	**/
	public static function RoundAwayFromZero(value:Float):Float
	{
		// "Opposite" of truncate.
		return (value > 0) ? Math.ceil(value) : Math.floor(value);
	}

	/**
	 * Rotates a vector in place by axis angle.
	 *
	 * This is the same as transforming a point by an
	 * axis-angle quaternion, but it has higher precision.
	 *
	 * @since 1.0.0
	 *
	 * @param vec - The vector to be rotated.
	 * @param axis - The axis to rotate around.
	 * @param radians - The angle of rotation in radians.
	 *
	 * @return The given vector.
	**/
	public static function RotateVec3(vec:Vector3, axis:Vector3, radians:Float):Vector3
	{
		//  Set the quaternion to our axis angle
		tmpQuat.setAxisAngle(axis, radians);
		//  Create a rotation matrix from the axis angle
		tmpMat4.fromRotationTranslation(tmpQuat, tmpVec3.set(0, 0, 0));
		//  Multiply our vector by the rotation matrix
		return vec.transformMat4(tmpMat4);
	}

	/**
	 * Rotate a `point` around `x` and `y` by the given `angle` and `distance`.
	 *
	 * @since 1.0.0
	 *
	 * @param point - The point to be rotated.
	 * @param x - The horizontal coordinate to rotate around.
	 * @param y - The vertical coordinate to rotate around.
	 * @param angle - The angle of rotation in radians.
	 * @param distance - The distance from (x, y) to place the point at.
	 *
	 * @return The given point.
	**/
	public static function RotateAroundDistance(point:Vector2, x:Float, y:Float, angle:Float, distance:Float):Vector2
	{
		var t = angle + Math.atan2(point.y - y, point.x - x);
		point.x = x + (distance * Math.cos(t));
		point.y = y + (distance * Math.sin(t));
		return point;
	}

	/**
	 * Rotate a `point` around `x` and `y` by the given `angle`.
	 *
	 * @function Phaser.Math.RotateAround
	 * @since 3.0.0
	 *
	 * @param point - The point to be rotated.
	 * @param x - The horizontal coordinate to rotate around.
	 * @param y - The vertical coordinate to rotate around.
	 * @param angle - The angle of rotation in radians.
	 *
	 * @return The given point, rotated by the given angle around the given coordinates.
	**/
	public static function RotateAround(point:Vector2, x:Float, y:Float, angle:Float):Vector2
	{
		var c = Math.cos(angle);
		var s = Math.sin(angle);
		var tx = point.x - x;
		var ty = point.y - y;
		point.x = tx * c - ty * s + x;
		point.y = tx * s + ty * c + y;
		return point;
	}

	/**
	 * Rotate a given point by a given angle around the origin (0, 0), in an anti-clockwise direction.
	 *
	 * @since 3.0.0
	 *
	 * @param point - The point to be rotated.
	 * @param angle - The angle to be rotated by in an anticlockwise direction.
	 *
	 * @return The given point, rotated by the given angle in an anticlockwise direction.
	**/
	public static function Rotate(point:Vector2, angle:Float):Vector2
	{
		var x = point.x;
		var y = point.y;

		point.x = (x * Math.cos(angle)) - (y * Math.sin(angle));
		point.y = (x * Math.sin(angle)) + (y * Math.cos(angle));

		return point;
	}

	/**
	 * Compute a random four-dimensional vector.
	 *
	 * @since 1.0.0
	 *
	 * @param vec4 - The Vector to compute random values for.
	 * @param scale - The scale of the random values.
	 *
	 * @return The given Vector.
	**/
	public static function RandomXYZW(vec4:Vector4, scale:Float = 1):Vector4
	{
		// TODO: Not spherical; should fix this for more uniform distribution
		vec4.x = (Math.random() * 2 - 1) * scale;
		vec4.y = (Math.random() * 2 - 1) * scale;
		vec4.z = (Math.random() * 2 - 1) * scale;
		vec4.w = (Math.random() * 2 - 1) * scale;
		return vec4;
	}

	/**
	 * Compute a random position vector in a spherical area, optionally defined by the given radius.
	 *
	 * @since 1.0.0
	 *
	 * @param vec3 - The Vector to compute random values for.
	 * @param radius - The radius.
	 *
	 * @return The given Vector.
	**/
	public static function RandomXYZ(vec3:Vector3, radius:Float = 1):Vector3
	{
		var r = Math.random() * 2 * Math.PI;
		var z = (Math.random() * 2) - 1;
		var zScale = Math.sqrt(1 - z * z) * radius;
		vec3.x = Math.cos(r) * zScale;
		vec3.y = Math.sin(r) * zScale;
		vec3.z = z * radius;
		return vec3;
	}

	/**
	 * Compute a random unit vector.
	 *
	 * Computes random values for the given vector between -1 and 1 that can be used to represent a direction.
	 *
	 * Optionally accepts a scale value to scale the resulting vector by.
	 *
	 * @since 1.0.0
	 *
	 * @param vector - The Vector to compute random values for.
	 * @param scale - The scale of the random values.
	 *
	 * @return The given Vector.
	**/
	public static function RandomXY(vector:Vector2, scale:Float = 1):Vector2
	{
		var r = Math.random() * 2 * Math.PI;
		vector.x = Math.cos(r) * scale;
		vector.y = Math.sin(r) * scale;
		return vector;
	}

	/**
	 * Compatibility the given angle in radians, to the equivalent angle in degrees.
	 *
	 * @since 1.0.0
	 *
	 * @param radians - The angle in radians to Compatibility ot degrees.
	 *
	 * @return The given angle Compatibilityed to degrees.
	**/
	public static function RadToDeg(radians:Float):Float
	{
		return radians * MathConst.RAD_TO_DEG;
	}

	/**
	 * Work out what percentage `value` is of the range between `min` and `max`.
	 * If `max` isn't given then it will return the percentage of `value` to `min`.
	 *
	 * You can optionally specify an `upperMax` value, which is a mid-way point in the range that represents 100%, after which the % starts to go down to zero again.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The value to determine the percentage of.
	 * @param min - The minimum value.
	 * @param max - The maximum value.
	 * @param upperMax - The mid-way point in the range that represents 100%.
	 *
	 * @return A value between 0 and 1 representing the percentage.
	**/
	public static function Percent(value:Float, min:Float, ?max:Float, ?upperMax:Float):Float
	{
		var max:Float = max != null ? max : min + 1;

		var percentage = (value - min) / (max - min);
		if (percentage > 1)
		{
			if (upperMax != null)
			{
				var upperMax:Float = upperMax;
				percentage = ((upperMax - value)) / (upperMax - max);
				if (percentage < 0)
				{
					percentage = 0;
				}
			}
			else
			{
				percentage = 1;
			}
		}
		else if (percentage < 0)
		{
			percentage = 0;
		}
		return percentage;
	}

	/**
	 * Subtract an `amount` from `value`, limiting the minimum result to `min`.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The value to subtract from.
	 * @param amount - The amount to subtract.
	 * @param min - The minimum value to return.
	 *
	 * @return The resulting value.
	**/
	public static function MinSub(value:Float, amount:Float, min:Float):Float
	{
		return Math.max(value - amount, min);
	}

	/**
	 * Add an `amount` to a `value`, limiting the maximum result to `max`.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The value to add to.
	 * @param amount - The amount to add.
	 * @param max - The maximum value to return.
	 *
	 * @return The resulting value.
	**/
	public static function MaxAdd(value:Float, amount:Float, max:Float):Float
	{
		return Math.min(value + amount, max);
	}

	/**
	 * Calculates a Catmull-Rom value.
	 *
	 * @since 1.0.0
	 *
	 * @param t - [description]
	 * @param p0 - [description]
	 * @param p1 - [description]
	 * @param p2 - [description]
	 * @param p3 - [description]
	 *
	 * @return The Catmull-Rom value.
	**/
	public static function CatmullRom(t:Float, p0:Float, p1:Float, p2:Float, p3:Float):Float
	{
		var v0 = (p2 - p0) * 0.5;
		var v1 = (p3 - p1) * 0.5;
		var t2 = t * t;
		var t3 = t * t2;
		return (2 * p1 - 2 * p2 + v0 + v1) * t3 + (-3 * p1 + 3 * p2 - 2 * v0 - v1) * t2 + v0 * t + p1;
	}

	/**
	 * [description]
	 *
	 * @since 1.0.0
	 *
	 * @param n - [description]
	 * @param i - [description]
	 *
	 * @return [description]
	**/
	public static function Bernstein(n:Float, i:Float):Float
	{
		return Factorial(n) / Factorial(i) / Factorial(n - i);
	}
}
