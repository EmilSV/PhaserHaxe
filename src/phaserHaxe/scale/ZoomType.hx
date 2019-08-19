package phaserHaxe.scale;

/**
 * Phaser Scale Manager constants for zoom modes.
 *
 * To find out what each mode does please see [phaserHaxe.scale.Zoom]{@link phaserHaxe.scale.Zoom}.
 *
 * @since 1.0.0
**/
enum abstract ZoomType(Int) from Int to Int
{
	/**
	 * The game canvas will not be zoomed by Phaser.
	 *
	 * @since 1.0.0
	**/
	var NO_ZOOM = 1;

	/**
	 * The game canvas will be 2x zoomed by Phaser.
	 *
	 * @since 1.0.0
	**/
	var ZOOM_2X = 2;

	/**
	 * The game canvas will be 4x zoomed by Phaser.
	 *
	 * @since 1.0.0
	**/
	var ZOOM_4X = 4;

	/**
	 * Calculate the zoom value based on the maximum multiplied game size that will
	 * fit into the parent, or browser window if no parent is set.
	 *
	 * @since 1.0.0
	**/
	var MAX_ZOOM = -1;
}
