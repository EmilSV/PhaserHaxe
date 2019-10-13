package phaserHaxe.gameobjects.bitmaptext.typedefs;

/**
 *
 * @since 1.0.0
**/
typedef JSONBitmapText =
{
	/**
	 * The name of the font.
	 *
	 * @since 1.0.0
	**/
	public var font:String;

	/**
	 * The text that this Bitmap Text displays.
	 *
	 * @since 1.0.0
	**/
	public var text:String;

	/**
	 * The size of the font.
	 *
	 * @since 1.0.0
	**/
	public var fontSize:Float;

	/**
	 * Adds / Removes spacing between characters.
	 *
	 * @since 1.0.0
	**/
	public var letterSpacing:Float;

	/**
	 * The alignment of the text in a multi-line BitmapText object.
	 *
	 * @since 1.0.0
	**/
	public var align:Int;
};
