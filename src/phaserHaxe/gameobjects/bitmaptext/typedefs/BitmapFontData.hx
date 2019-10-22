package phaserHaxe.gameobjects.bitmaptext.typedefs;

import phaserHaxe.gameobjects.bitmaptext.typedefs.BitmapFontCharacterData;

/**
 * Bitmap Font data that can be used by a BitmapText Game Object.
 *
 * @since 1.0.0
 *
**/
typedef BitmapFontData =
{
	/**
	 * The name of the font.
	 *
	 * @since 1.0.0
	**/
	public var font:String;

	/**
	 * The size of the font.
	 *
	 * @since 1.0.0
	**/
	public var size:Float;

	/**
	 * The line height of the font.
	 *
	 * @since 1.0.0
	**/
	public var lineHeight:Float;

	/**
	 * Whether this font is a retro font (monospace).
	 *
	 * @since 1.0.0
	**/
	public var ?retroFont:Bool;

	/**
	 * The character data of the font, keyed by character code.
	 * Each character datum includes a position, size, offset and more.
	 *
	 * @since 1.0.0
	**/
	public var chars:Map<Int, BitmapFontCharacterData>;
};
