package phaserHaxe.math.easing;

@:noCompletion
final class Stepped
{
	public function new() {}

	/**
	 * Stepped easing.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 * @param steps - The number of steps in the ease.
	 *
	 * @return The tweened value.
	**/
	public function Stepped(v:Float, steps:Float = 1):Float
	{
		return inline EasingStepped.Stepped(v, steps);
	}
}
