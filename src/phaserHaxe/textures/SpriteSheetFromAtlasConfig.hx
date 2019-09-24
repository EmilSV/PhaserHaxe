package phaserHaxe.textures;

import phaserHaxe.textures.SpriteSheetConfig;

typedef SpriteSheetFromAtlasConfig = SpriteSheetConfig &
{
	/**
	 * The key of the Texture Atlas in which this Sprite Sheet can be found.
	 *
	 * @since 1.0.0
	**/
	var atlas:String;

	/**
	 * The key of the Texture Atlas Frame in which this Sprite Sheet can be found.
	 *
	 * @since 1.0.0
	**/
	var frame:String;
};
