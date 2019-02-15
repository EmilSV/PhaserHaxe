package phaserHaxe.math.easing;

abstract Stepped(Void)
{
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
		if (v <= 0)
		{
			return 0;
		}
		else if (v >= 1)
		{
			return 1;
		}
		else
		{
			return ((steps * v) + 1) * (1 / steps);
		}
	}
}
