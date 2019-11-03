package phaserHaxe.gameobjects.bitmaptext.typedefs;

import phaserHaxe.utils.types.Union;
import phaserHaxe.gameobjects.typedefs.GameObjectConfig;

/**
 *
 * @since 1.0.0
**/
typedef BitmapTextConfig = GameObjectConfig &
{
	/**
	 * The key of the font to use from the BitmapFont cache.
	 *
	 * @since 1.0.0
	**/
	public var ?font:String;

	/**
	 * The string, or array of strings, to be set as the content of this Bitmap Text.
	 *
	 * @since 1.0.0
	**/
	public var ?text:String;

	/**
	 * The font size to set.
	 *
	 * @since 1.0.0
	**/
	public var ?size:Union<Float, Bool>;
};
