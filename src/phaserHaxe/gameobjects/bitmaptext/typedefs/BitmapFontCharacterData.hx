/**
 * The font data for an individual character of a Bitmap Font.
 *
 * Describes the character's position, size, offset and kerning.
 *
 * @since 1.0.0
**/
typedef BitmapFontCharacterData =
{
	/**
	 * The x position of the character.
	 *
	 * @since 1.0.0
	**/
	public var x:Float;

	/**
	 * The y position of the character.
	 *
	 * @since 1.0.0
	**/
	public var y:Float;

	/**
	 * The width of the character.
	 *
	 * @since 1.0.0
	**/
	public var width:Float;

	/**
	 * The height of the character.
	 *
	 * @since 1.0.0
	**/
	public var height:Float;

	/**
	 * The center x position of the character.
	 *
	 * @since 1.0.0
	**/
	public var centerX:Float;

	/**
	 * The center y position of the character.
	 *
	 * @since 1.0.0
	**/
	public var centerY:Float;

	/**
	 * The x offset of the character.
	 *
	 * @since 1.0.0
	**/
	public var xOffset:Float;

	/**
	 * The y offset of the character.
	 *
	 * @since 1.0.0
	**/
	public var yOffset:Float;

	/**
	 * Extra data for the character.
	 *
	 * @since 1.0.0
	**/
	public var data:Dynamic;

	/**
	 * Kerning values, keyed by character code.
	 *
	 * @since 1.0.0
	**/
	public var kerning:Dynamic;
};
