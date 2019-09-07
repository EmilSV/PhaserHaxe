package phaserHaxe.textures;


/**
 * Filter Types.
 *
 * @since 1.0.0
**/
enum abstract FilterMode(Int) from Int to Int
{
	/**
	 * Linear filter type.
	 *
	 * @since 1.0.0
	**/
	public var LINEAR = 0;

	/**
	 * Nearest neighbor filter type.
	 *
	 * @since 1.0.0
	**/
	public var NEAREST = 1;
}
