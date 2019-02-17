package phaserHaxe.math.easing;

@:noCompletion
final class Bounce
{
	public function new() {}

	/**
	 * Bounce ease-in.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public function In(v:Float):Float
	{
		return inline EasingBounce.In(v);
	}

	/**
	 * Bounce ease-in/out.
	 *
	 * @since 1.0.0
	 *
	 * @param  v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public function InOut(v:Float):Float
	{
		return inline EasingBounce.InOut(v);
	}

	/**
	 * Bounce ease-out.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public function Out(v:Float):Float
	{
		return inline EasingBounce.Out(v);
	}
}
