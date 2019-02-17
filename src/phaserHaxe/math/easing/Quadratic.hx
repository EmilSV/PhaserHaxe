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
	public function In(v:Float):Float
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
	public function InOut(v:Float):Float
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
	public function Out(v:Float):Float
	{
		return inline EasingQuadratic.Out(v);
	}
}
