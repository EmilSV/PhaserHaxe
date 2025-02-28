package phaserHaxe.math.easing;

@:noCompletion
final class Circular
{
    public function new() {}

	/**
	 * Circular ease-out.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public function Out(v:Float):Float
	{
		return inline EasingCircular.Out(v);
	}

	/**
	 * Circular ease-in/out.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public function InOut(v:Float):Float
	{
		return inline EasingCircular.InOut(v);
	}

	/**
	 * Circular ease-in.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public function In(v:Float):Float
	{
		return inline EasingCircular.In(v);
	}
}
