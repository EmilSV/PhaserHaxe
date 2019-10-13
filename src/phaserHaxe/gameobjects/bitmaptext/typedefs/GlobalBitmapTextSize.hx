package phaserHaxe.gameobjects.bitmaptext.typedefs;

/**
 * The position and size of the Bitmap Text in global space, taking into account the Game Object's scale and world position.
 *
 * @since 1.0.0
**/
typedef GlobalBitmapTextSize =
{
	/**
	 * The x position of the BitmapText, taking into account the x position and scale of the Game Object.
	 *
	 * @since 1.0.0
	**/
	public var x:Float;

	/**
	 * The y position of the BitmapText, taking into account the y position and scale of the Game Object.
	 *
	 * @since 1.0.0
	**/
	public var y:Float;

	/**
	 *  The width of the BitmapText, taking into account the x scale of the Game Object.
	 *
	 * @since 1.0.0
	**/
	public var width:Float;

	/**
	 * The height of the BitmapText, taking into account the y scale of the Game Object.
	 *
	 * @since 1.0.0
	**/
	public var height:Float;
};
