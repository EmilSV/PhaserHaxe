package phaserHaxe.display;

/**
 * @since 1.0.0
**/
typedef ColorObject =
{
	/**
	 * The red color value in the range 0 to 255.
	 *
	 * @since 1.0.0
	**/
	var r:Int;

	/**
	 * The green color value in the range 0 to 255.
	 *
	 * @since 1.0.0
	**/
	var g:Int;

	/**
	 * The blue color value in the range 0 to 255.
	 *
	 * @since 1.0.0
	**/
	var b:Int;

	/**
	 * The alpha color value in the range 0 to 255.
	 *
	 * @since 1.0.0
	**/
	var ?a:Int;

	/**
	 * The color of this Color component, not including the alpha channel.
	 *
	 * @since 1.0.0
	**/
	var ?color:Int;
}
