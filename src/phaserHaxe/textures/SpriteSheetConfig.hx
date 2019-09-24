package phaserHaxe.textures;

/**
 * @since 1.0.0
**/
typedef SpriteSheetConfig =
{
	/**
	 * The fixed width of each frame.
	 *
	 * @since 1.0.0
	**/
	var frameWidth:Int;

	/**
	 * The fixed height of each frame. If not set it will use the frameWidth as the height.
	 *
	 * @since 1.0.0
	**/
	var ?frameHeight:Int;

	/**
	 * Skip a number of frames. Useful when there are multiple sprite sheets in one Texture.
	 *
	 * @since 1.0.0
	**/
	var ?startFrame:Int;

	/**
	 * Skip a number of frames. Useful when there are multiple sprite sheets in one Texture.
	 *
	 * @since 1.0.0
	**/
	var ?endFrame:Int;

	/**
	 *  If the frames have been drawn with a margin, specify the amount here.
	 *
	 * @since 1.0.0
	**/
	var ?margin:Int;

	/**
	 * If the frames have been drawn with spacing between them, specify the amount here.
	 *
	 * @since 1.0.0
	**/
	var ?spacing:Int;
}
