package phaserHaxe.math.easing;

@:noCompletion
final class Expo
{
	public function new() {}

	/**
	 * Exponential ease-in.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public function In(v:Float):Float
	{
		return inline EasingExpo.In(v);
	}

	/**
	 * Exponential ease-in/out.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public function InOut(v:Float):Float
	{
		return inline EasingExpo.InOut(v);
	}

	/**
	 * Exponential ease-out.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public function Out(v:Float):Float
	{
		return inline EasingExpo.Out(v);
	}
}
