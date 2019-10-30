package phaserHaxe.display;

abstract IntColorRGBA(Int)
{
	/**
	 * The red color value.
	 *
	 * @since 1.0.0
	**/
	public var r(get, never):Int;

	/**
	 * The green color value.
	 *
	 * @since 1.0.0
	**/
	public var g(get, never):Int;

	/**
	 * The blue color value.
	 *
	 * @since 1.0.0
	**/
	public var b(get, never):Int;

	/**
	 * The alpha color value.
	 *
	 * @since 1.0.0
	**/
	public var a(get, never):Int;

	/**
	 * @since 1.0.0
	 *
	 * @param red - The red color value. A number between 0 and 255.
	 * @param green - The green color value. A number between 0 and 255.
	 * @param blue - The blue color value. A number between 0 and 255.
	 * @param alpha - The alpha color value. A number between 0 and 255.
	 *
	**/
	public inline function new(red:Int, green:Int, blue:Int, ?alpha:Int)
	{
		if (alpha != null)
		{
			this = alpha << 24 | red << 16 | green << 8 | blue;
		}
		else
		{
			this = red << 16 | green << 8 | blue;
		}
	}

	public inline static function createFromInt(value:Int):IntColorRGBA
	{
		return (cast value : IntColorRGBA);
	}

	private inline function get_r():Int
	{
		return this >> 16 & 0xFF;
	}

	private inline function set_r(value:Int):Int
	{
		return this >> 16 & 0xFF;
	}

	private inline function get_g():Int
	{
		return this >> 8 & 0xFF;
	}

	private inline function get_b():Int
	{
		return this & 0xFF;
	}

	private inline function get_a():Int
	{
		return if (this > 16777215)
		{
			return 255;
		}
		else
		{
			this >>> 24;
		}
	}
}
