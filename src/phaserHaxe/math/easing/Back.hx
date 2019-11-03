package phaserHaxe.math.easing;

@:noCompletion
final class Back
{
	public function new() {}

	/**
	 * Back ease-in.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 * @param overshoot - The overshoot amount.
	 *
	 * @return The tweened value.
	**/
	public inline function In(v:Float, overshoot:Float = 1.70158):Float
	{
		return EasingBack.In(v, overshoot);
	}

	/**
	 * Back ease-in/out.
	 *
	 * @since 1.0.0
	 *
	 * @param number v - The value to be tweened.
	 * @param number overshoot - The overshoot amount.
	 *
	 * @return number The tweened value.
	**/
	public function InOut(v:Float, overshoot:Float = 1.70158):Float
	{
		return inline EasingBack.InOut(v, overshoot);
	}

	/**
	 * Back ease-out.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 * @param overshoot - The overshoot amount.
	 *
	 * @return The tweened value.
	**/
	public function Out(v:Float, overshoot:Float = 1.70158):Float
	{
		return inline EasingBack.Out(v, overshoot);
	}
}
