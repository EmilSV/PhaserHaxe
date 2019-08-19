package phaserHaxe.scale;

// TODO: link doc


/**
 * Phaser Scale Manager constants for centering the game canvas.
 *
 * To find out what each mode does please see [Phaser.Scale.Center]{@link Phaser.Scale.Center}.
 *
 * @since 1.0.0
**/
enum abstract CenterType(Int) to Int from Int
{
	/**
	 * The game canvas is not centered within the parent by Phaser.
	 * You can still center it yourself via CSS.
	 *
	 * @since 1.0.0
	**/
	var NO_CENTER = 0;

	/**
	 * The game canvas is centered both horizontally and vertically within the parent.
	 * To do this, the parent has to have a bounds that can be calculated and not be empty.
	 *
	 * Centering is achieved by setting the margin left and top properties of the
	 * game canvas, and does not factor in any other CSS styles you may have applied.
	 *
	 * @since 1.0.0
	**/
	var CENTER_BOTH = 1;

	/**
	 * The game canvas is centered horizontally within the parent.
	 * To do this, the parent has to have a bounds that can be calculated and not be empty.
	 *
	 * Centering is achieved by setting the margin left and top properties of the
	 * game canvas, and does not factor in any other CSS styles you may have applied.
	 *
	 * @since 1.0.0
	**/
	var CENTER_HORIZONTALLY = 2;

	/**
	 * The game canvas is centered both vertically within the parent.
	 * To do this, the parent has to have a bounds that can be calculated and not be empty.
	 *
	 * Centering is achieved by setting the margin left and top properties of the
	 * game canvas, and does not factor in any other CSS styles you may have applied.
	 *
	 * @since 1.0.0
	**/
	var CENTER_VERTICALLY = 3;
}
