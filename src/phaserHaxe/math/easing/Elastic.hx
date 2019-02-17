package phaserHaxe.math.easing;

@:noCompletion
final class Elastic
{
	public function new() {}

	/**
	 * Elastic ease-in.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 * @param amplitude - The amplitude of the elastic ease.
	 * @param period - Sets how tight the sine-wave is, where smaller values are tighter waves, which result in more cycles.
	 *
	 * @return The tweened value.
	**/
	public function In(v:Float, amplitude:Float = 0.1, period:Float = 0.1):Float
	{
		return inline EasingElastic.In(v, amplitude, period);
	}

	/**
	 * Elastic ease-in/out.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 * @param amplitude - The amplitude of the elastic ease.
	 * @param period - Sets how tight the sine-wave is, where smaller values are tighter waves, which result in more cycles.
	 *
	 * @return The tweened value.
	**/
	public function InOut(v:Float, amplitude:Float = 0.1, period:Float = 0.1):Float
	{
		return inline EasingElastic.InOut(v, amplitude, period);
	}

	/**
	 * Elastic ease-out.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 * @param amplitude - The amplitude of the elastic ease.
	 * @param period - Sets how tight the sine-wave is, where smaller values are tighter waves, which result in more cycles.
	 *
	 * @return The tweened value.
	**/
	public function Out(v:Float, amplitude:Float = 0.1, period:Float = 0.1):Float
	{
		return inline EasingElastic.Out(v, amplitude, period);
	}
}
