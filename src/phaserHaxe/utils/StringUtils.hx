package phaserHaxe.utils;

enum abstract PadDirections(Int) from Int to Int
{
	var LEFT = 1;
	var RIGHT = 2;
	var BOTH = 3;
}

final class StringUtils
{
	/**
	 * Takes the given string and pads it out, to the length required, using the character
	 * specified. For example if you need a string to be 6 characters long, you can call:
	 *
	 * `pad('bob', 6, '-', RIGHT)`
	 *
	 * This would return: `bob---` as it has padded it out to 6 characters, using the `-` on the right.
	 *
	 * You can also use it to pad numbers (they are always returned as strings):
	 *
	 * `pad(512, 6, '0', LEFT)`
	 *
	 * Would return: `000512` with the string padded to the left.
	 *
	 * If you don't specify a direction it'll pad to both sides:
	 *
	 * `pad('c64', 7, '*')`
	 *
	 * Would return: `**c64**`
	 *
	 * @since 1.0.0
	 *
	 * @param str - The target string. `toString()` will be called on the string, which means you can also pass in common data types like numbers.
	 * @param len - The number of characters to be added.
	 * @param pad - The string to pad it out with (defaults to a space).
	 * @param dir - The direction dir = LEFT (1), RIGHT (2), BOTH (3).
	 *
	 * @return The padded string.
	**/
	public static function pad(str:Dynamic, len:Int = 0, pad:String = " ",
			dir:PadDirections = BOTH):String
	{
		final buffer = new StringBuf();

		final str = Std.string(str);

		if (len + 1 >= str.length)
		{
			switch (dir)
			{
				case LEFT:
					for (i in 0...(len + 1 - str.length))
					{
						buffer.add(pad);
					}

					buffer.add(str);

				case BOTH:
					final padlen = len - str.length;
					final right = Math.ceil((padlen) / 2);
					final left = padlen - right;

					for (i in 0...(left + 1))
					{
						buffer.add(pad);
					}

					buffer.add(str);

					for (i in 0...(right + 1))
					{
						buffer.add(pad);
					}

				default:
					buffer.add(str);

					for (i in 0...(len + 1 - str.length))
					{
						buffer.add(pad);
					}
			}
		}
		else
		{
			return str.toString();
		}

		return buffer.toString();
	}
}
