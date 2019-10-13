package phaserHaxe.gameobjects.bitmaptext.typedefs;

/**
 *
 * @since 1.0.0
**/
typedef RetroFontConfig =
{
	/**
	 * The key of the image containing the font.
	 *
	 * @since 1.0.0
	**/
	public var image:String;

	/**
	 * If the font set doesn't start at the top left of the given image, specify offset here.
	 *
	 * @since 1.0.0
	**/
	public var offset:{x:Float, y:Float};

	/**
	 * The width of each character in the font set.
	 *
	 * @since 1.0.0
	**/
	public var width:Float;

	/**
	 * The height of each character in the font set.
	 *
	 * @since 1.0.0
	**/
	public var height:Float;

	/**
	 * The characters used in the font set, in display order. You can use the TEXT_SET consts for common font set arrangements.
	 *
	 * @since 1.0.0
	**/
	public var chars:String;

	/**
	 * The number of characters per row in the font set. If not given charsPerRow will be the image width / characterWidth.
	 *
	 * @since 1.0.0
	**/
	public var charsPerRow:Int;

	/**
	 * If the characters in the font set have spacing between them set the required amount here.
	 *
	 * @since 1.0.0
	**/
	public var spacing:{x:Float, y:Float};

	/**
	 * The amount of vertical space to add to the line height of the font.
	 *
	 * @since 1.0.0
	**/
	public var lineSpacing:Float;
};
