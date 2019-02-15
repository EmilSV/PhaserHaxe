package phaserHaxe.math.easing;

@:noCompletion
abstract Bounce(Void)
{
	/**
	 * Bounce ease-in.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public function In(v:Float):Float
	{
		v = 1 - v;
		if (v < 1 / 2.75)
		{
			return 1 - (7.5625 * v * v);
		}
		else if (v < 2 / 2.75)
		{
			return 1 - (7.5625 * (v -= 1.5 / 2.75) * v + 0.75);
		}
		else if (v < 2.5 / 2.75)
		{
			return 1 - (7.5625 * (v -= 2.25 / 2.75) * v + 0.9375);
		}
		else
		{
			return 1 - (7.5625 * (v -= 2.625 / 2.75) * v + 0.984375);
		}
	}

	/**
	 * Bounce ease-in/out.
	 *
	 * @since 1.0.0
	 *
	 * @param  v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public function InOut(v:Float):Float
	{
		var reverse = false;
		if (v < 0.5)
		{
			v = 1 - (v * 2);
			reverse = true;
		}
		else
		{
			v = (v * 2) - 1;
		}
		if (v < 1 / 2.75)
		{
			v = 7.5625 * v * v;
		}
		else if (v < 2 / 2.75)
		{
			v = 7.5625 * (v -= 1.5 / 2.75) * v + 0.75;
		}
		else if (v < 2.5 / 2.75)
		{
			v = 7.5625 * (v -= 2.25 / 2.75) * v + 0.9375;
		}
		else
		{
			v = 7.5625 * (v -= 2.625 / 2.75) * v + 0.984375;
		}
		if (reverse)
		{
			return (1 - v) * 0.5;
		}
		else
		{
			return v * 0.5 + 0.5;
		}
	}

	/**
	 * Bounce ease-out.
	 *
	 * @since 1.0.0
	 *
	 * @param v - The value to be tweened.
	 *
	 * @return The tweened value.
	**/
	public function Out(v:Float):Float
	{
		if (v < 1 / 2.75)
		{
			return 7.5625 * v * v;
		}
		else if (v < 2 / 2.75)
		{
			return 7.5625 * (v -= 1.5 / 2.75) * v + 0.75;
		}
		else if (v < 2.5 / 2.75)
		{
			return 7.5625 * (v -= 2.25 / 2.75) * v + 0.9375;
		}
		else
		{
			return 7.5625 * (v -= 2.625 / 2.75) * v + 0.984375;
		}
	}
}
