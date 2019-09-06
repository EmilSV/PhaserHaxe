package phaserHaxe.renderer;

/**
 * Phaser Scale Modes.
 *
 * @since 1.0.0
**/
enum abstract ScaleModes(Int) to Int
{
	/**
	 * Default Scale Mode (Linear).
	 *
	 * @since 1.0.0
	**/
	var DEFAULT = 0;

	/**
	 * Linear Scale Mode.
	 *
	 * @since 1.0.0
	**/
	var LINEAR = 0;

	/**
	 * Nearest Scale Mode.
	 *
	 * @since 1.0.0
	**/
	var NEAREST = 1;
}
