package phaserHaxe.math.easing;

@:noCompletion
final class Linear
{
	public function new() {}

	/**
	 * Linear easing (no variation).
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public function Linear(v:Float):Float
	{
		return v;
	}
}
