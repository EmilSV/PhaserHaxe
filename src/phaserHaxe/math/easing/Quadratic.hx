package phaserHaxe.math.easing;

@:noCompletion
final class Quadratic
{
	public function new() {}

	/**
	 * Quadratic ease-in.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public function inward(v:Float):Float
	{
		return inline EasingQuadratic.In(v);
	}

	/**
	 * Quadratic ease-in/out.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public function inOut(v:Float):Float
	{
		return inline EasingQuadratic.InOut(v);
	}

	/**
	 * Quadratic ease-out.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public function out(v:Float):Float
	{
		return inline EasingQuadratic.Out(v);
	}
}
