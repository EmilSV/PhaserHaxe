package phaserHaxe.math;

final class Angle
{
	/**
	 * Find the angle of a segment from (x1, y1) -> (x2, y2).
	 *
	 * @since 1.0.0
	 *
	 * @param x1 - The x coordinate of the first point.
	 * @param y1 - The y coordinate of the first point.
	 * @param x2 - The x coordinate of the second point.
	 * @param y2 - The y coordinate of the second point.
	 *
	 * @return The angle in radians.
	**/
	public static function Between(x1:Float, y1:Float, x2:Float, y2:Float):Float
	{
		return Math.atan2(y2 - y1, x2 - x1);
	}

	/**
	 * Find the angle of a segment from (point1.x, point1.y) -> (point2.x, point2.y).
	 *
	 * Calculates the angle of the vector from the first point to the second point.
	 *
	 * @since 1.0.0
	 *
	 * @param point1 - The first point.
	 * @param point2 - The second point.
	 *
	 * @return The angle in radians.
	**/
	public static function BetweenPoints(point1:Vector2, point2:Vector2):Float
	{
		return Math.atan2(point2.y - point1.y, point2.x - point1.x);
	}

	/**
	 * Find the angle of a segment from (x1, y1) -> (x2, y2).
	 *
	 * The difference between this method and {@link Phaser.Math.Angle.Between} is that this assumes the y coordinate
	 * travels down the screen.
	 *
	 * @since 1.0.0
	 *
	 * @param x1 - The x coordinate of the first point.
	 * @param y1 - The y coordinate of the first point.
	 * @param x2 - The x coordinate of the second point.
	 * @param y2 - The y coordinate of the second point.
	 *
	 * @return The angle in radians.
	**/
	public static function BetweenY(x1:Float, y1:Float, x2:Float, y2:Float):Float
	{
		return Math.atan2(x2 - x1, y2 - y1);
	}

	/**
	 * Find the angle of a segment from (point1.x, point1.y) -> (point2.x, point2.y).
	 *
	 * The difference between this method and {@link Phaser.Math.Angle.BetweenPoints} is that this assumes the y coordinate
	 * travels down the screen.
	 *
	 * @since 1.0.0
	 *
	 * @param point1 - The first point.
	 * @param point2 - The second point.
	 *
	 * @return The angle in radians.
	**/
	public static function BetweenPointsY(point1:Vector2, point2:Vector2):Float
	{
		return Math.atan2(point2.x - point1.x, point2.y - point1.y);
	}

	/**
	 * Takes an angle in Phasers default clockwise format and Compatibilitys it so that
	 * 0 is North, 90 is West, 180 is South and 270 is East,
	 * therefore running counter-clockwise instead of clockwise.
	 *
	 * You can pass in the angle from a Game Object using:
	 *
	 * ```haxe
	 * var Compatibilityed = CounterClockwise(gameobject.rotation);
	 * ```
	 *
	 * All values for this function are in radians.
	 *
	 * @since 1.0.0
	 *
	 * @param angle - The angle to Compatibility, in radians.
	 *
	 * @return The Compatibilityed angle, in radians.
	**/
	public static function CounterClockwise(angle:Float):Float
	{
		return Math.abs((((angle + MathConst.TAU) % MathConst.PI2) - MathConst
			.PI2) % MathConst.PI2);
	}

	/**
	 * Normalize an angle to the [0, 2pi] range.
	 *
	 * @since 1.0.0
	 *
	 * @param  angle - The angle to normalize, in radians.
	 *
	 * @return The normalized angle, in radians.
	**/
	public static function Normalize(angle:Float):Float
	{
		angle = angle % (2 * Math.PI);
		if (angle >= 0)
		{
			return angle;
		}
		else
		{
			return angle + 2 * Math.PI;
		}
	}

	/**
	 * Reverse the given angle.
	 *
	 * @since 1.0.0
	 *
	 * @param angle - The angle to reverse, in radians.
	 *
	 * @return The reversed angle, in radians.
	**/
	public static function Reverse(angle:Float):Float
	{
		return Normalize(angle + Math.PI);
	}

	/**
	 * Rotates `currentAngle` towards `targetAngle`, taking the shortest rotation distance. The `lerp` argument is the amount to rotate by in this call.
	 *
	 * @since 1.0.0
	 *
	 * @param currentAngle - The current angle, in radians.
	 * @param targetAngle - The target angle to rotate to, in radians.
	 * @param lerp - The lerp value to add to the current angle.
	 *
	 * @return The adjusted angle.
	**/
	public static function RotateTo(currentAngle:Float, targetAngle:Float, lerp:Float = 0.05):Float
	{
		if (currentAngle == targetAngle)
		{
			return currentAngle;
		}
		if (Math.abs(targetAngle - currentAngle) <= lerp || Math
			.abs(targetAngle - currentAngle) >= (MathConst.PI2 - lerp))
		{
			currentAngle = targetAngle;
		}
		else
		{
			if (Math.abs(targetAngle - currentAngle) > Math.PI)
			{
				if (targetAngle < currentAngle)
				{
					targetAngle += MathConst.PI2;
				}
				else
				{
					targetAngle -= MathConst.PI2;
				}
			}
			if (targetAngle > currentAngle)
			{
				currentAngle += lerp;
			}
			else if (targetAngle < currentAngle)
			{
				currentAngle -= lerp;
			}
		}
		return currentAngle;
	}

	/**
	 * Gets the shortest angle between `angle1` and `angle2`.
	 *
	 * Both angles must be in the range -180 to 180, which is the same clamped
	 * range that `sprite.angle` uses, so you can pass in two sprite angles to
	 * this method and get the shortest angle back between the two of them.
	 *
	 * The angle returned will be in the same range. If the returned angle is
	 * greater than 0 then it's a counter-clockwise rotation, if < 0 then it's
	 * a clockwise rotation.
	 *
	 * TODO: Wrap the angles in this function?
	 *
	 * @since 1.0.0
	 *
	 * @param angle1 - The first angle in the range -180 to 180.
	 * @param angle2 - The second angle in the range -180 to 180.
	 *
	 * @return The shortest angle, in degrees. If greater than zero it's a counter-clockwise rotation.
	**/
	public static function ShortestBetween(angle1:Float, angle2:Float):Float
	{
		var difference = angle2 - angle1;
		if (difference == 0)
		{
			return 0;
		}
		var times = Math.floor((difference - (-180)) / 360);
		return difference - (times * 360);
	}

	/**
	 * Wrap an angle.
	 *
	 * Wraps the angle to a value in the range of -PI to PI.
	 *
	 * @since 1.0.0
	 *
	 * @param angle - The angle to wrap, in radians.
	 *
	 * @return The wrapped angle, in radians.
	**/
	public static function Wrap(angle:Float):Float
	{
		return MathUtility.Wrap(angle, -Math.PI, Math.PI);
	}

	/**
	 * Wrap an angle in degrees.
	 *
	 * Wraps the angle to a value in the range of -180 to 180.
	 *
	 * @since 1.0.0
	 *
	 * @param angle - The angle to wrap, in degrees.
	 *
	 * @return The wrapped angle, in degrees.
	**/
	public static function WrapDegrees(angle:Float):Float
	{
		return MathUtility.Wrap(angle, -180, 180);
	}
}
