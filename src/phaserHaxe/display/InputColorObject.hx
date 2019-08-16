package phaserHaxe.display;

/**
 * @since 1.0.0
**/
typedef InputColorObject =
{
	/**
	 * The red color value in the range 0 to 255.
	 *
	 * @since 1.0.0
	**/
	var r(default, null):Int;

	/**
	 * The green color value in the range 0 to 255.
	 *
	 * @since 1.0.0
	**/
	var g(default, null):Int;

	/**
	 * The blue color value in the range 0 to 255.
	 *
	 * @since 1.0.0
	**/
	var b(default, null):Int;

	/**
	 * The alpha color value in the range 0 to 255.
	 *
	 * @since 1.0.0
	**/
	var ?a(default, null):Int;
}
