package phaserHaxe.math.easing;

@:noCompletion
final class Quartic
{
	public function new() {}

	/**
	 * Quintic ease-in.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public function In(v:Float):Float
	{
		return inline EasingQuartic.In(v);
	}

	/**
	 * Quintic ease-in/out.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public function InOut(v:Float):Float
	{
		return inline EasingQuartic.InOut(v);
	}

	/**
	 * Quintic ease-out.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public function Out(v:Float):Float
	{
		return inline EasingQuartic.Out(v);
	}
}
