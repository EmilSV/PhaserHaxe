package phaserHaxe.math.easing;

@:noCompletion
abstract Sine(Void)
{
	/**
	 * Sinusoidal ease-in.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public function In(v)
	{
		if (v == = 0)
		{
			return 0;
		}
		else if (v == = 1)
		{
			return 1;
		}
		else
		{
			return 1 - Math.cos(v * Math.PI / 2);
		}
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
	public function InOut(v)
	{
		if (v == = 0)
		{
			return 0;
		}
		else if (v == = 1)
		{
			return 1;
		}
		else
		{
			return 0.5 * (1 - Math.cos(Math.PI * v));
		}
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
	public function Out(v)
	{
		if (v == = 0)
		{
			return 0;
		}
		else if (v == = 1)
		{
			return 1;
		}
		else
		{
			return Math.sin(v * Math.PI / 2);
		}
	}
}
