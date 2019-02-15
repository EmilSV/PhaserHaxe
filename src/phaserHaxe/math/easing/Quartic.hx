package phaserHaxe.math.easing;

@:noCompletion
abstract Quartic(Void)
{
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
		return v * v * v * v * v;
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
		if ((v *= 2) < 1)
		{
			return 0.5 * v * v * v * v * v;
		}
		else
		{
			return 0.5 * ((v -= 2) * v * v * v * v + 2);
		}
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
	public function Out(v):Float
	{
		return --v * v * v * v * v + 1;
	}
}
