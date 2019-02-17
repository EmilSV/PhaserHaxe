package phaserHaxe.math.easing;

@:noCompletion
final class Sine
{
	public function new() {}

	/**
	 * Sinusoidal ease-in.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public function In(v:Float):Float
	{
		return inline EasingSine.In(v);
	}

	/**
	 * Sinusoidal ease-in/out.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public function InOut(v:Float):Float
	{
		return inline EasingSine.InOut(v);
	}

	/**
	 * Sinusoidal ease-out.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public function Out(v:Float):Float
	{
		return inline EasingSine.Out(v);
	}
}
