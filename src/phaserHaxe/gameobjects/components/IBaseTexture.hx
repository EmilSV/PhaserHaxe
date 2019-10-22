package phaserHaxe.gameobjects.components;

import phaserHaxe.textures.Frame;
import phaserHaxe.textures.Texture;

interface IBaseTexture
{
	/**
	 * The Texture this Game Object is using to render with.
	 *
	 * @since 1.0.0
	**/
	public var texture:Texture;

	/**
	 * The Texture Frame this Game Object is using to render with.
	 *
	 * @since 1.0.0
	**/
	public var frame:Frame;

	/**
	 * Internal flag. Not to be set by this Game Object.
	 *
	 * @since 1.0.0
	**/
	private var isCropped:Bool;
}
