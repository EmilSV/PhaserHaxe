package phaserHaxe.scale;


// TODO: Finish link doc 

/**
 * Phaser Scale Manager constants for the different scale modes available.
 *
 * To find out what each mode does please see [Phaser.Scale.ScaleModes]{@link Phaser.Scale.ScaleModes}.
 *
 * @since 1.0.0
**/
enum abstract ScaleModeType(Int) to Int from Int
{
	/**
	 * No scaling happens at all. The canvas is set to the size given in the game config and Phaser doesn't change it
	 * again from that point on. If you change the canvas size, either via CSS, or directly via code, then you need
	 * to call the Scale Managers `resize` method to give the new dimensions, or input events will stop working.
	 *
	 * @since 1.0.0
	**/
	var NONE = 0;

	/**
	 * The height is automatically adjusted based on the width.
	 *
	 * @since 1.0.0
	**/
	var WIDTH_CONTROLS_HEIGHT = 1;

	/**
	 * The width is automatically adjusted based on the height.
	 *
	 * @since 1.0.0
	**/
	var HEIGHT_CONTROLS_WIDTH = 2;

	/**
	 * The width and height are automatically adjusted to fit inside the given target area,
	 * while keeping the aspect ratio. Depending on the aspect ratio there may be some space
	 * inside the area which is not covered.
	 *
	 * @since 1.0.0
	**/
	var FIT = 3;

	/**
	 * The width and height are automatically adjusted to make the size cover the entire target
	 * area while keeping the aspect ratio. This may extend further out than the target size.
	 *
	 * @since 1.0.0
	**/
	var ENVELOP = 4;

	/**
	 * The Canvas is resized to fit all available _parent_ space, regardless of aspect ratio.
	 *
	 * @since 1.0.0
	**/
	var RESIZE = 5;
}
