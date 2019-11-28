package phaserHaxe.loader.filetypes.typedefs;

import phaserHaxe.utils.types.MultipleOrOne;

/**
 * @since 1.0.0
**/
typedef AudioSpriteFileConfig =
{
	/**
	 * The key of the file. Must be unique within both the Loader and the Audio Cache.
	 *
	 * @since 1.0.0
	**/
	public var key:String;

	/**
	 * The absolute or relative URL to load the json file from. Or a well formed JSON object to use instead.
	 *
	 * @since 1.0.0
	**/
	public var jsonURL:String;

	/**
	 * Extra XHR Settings specifically for the json file.
	 *
	 * @since 1.0.0
	**/
	public var jsonXhrSettings:XHRSettingsObject;

	/**
	 * The absolute or relative URL to load the audio file from.
	 *
	 * @since 1.0.0
	**/
	public var audioURL:MultipleOrOne<String>;

	/**
	 * The audio configuration options.
	 *
	 * @since 1.0.0
	**/
	public var audioConfig:Any;

	/**
	 *  Extra XHR Settings specifically for the audio file.
	 *
	 * @since 1.0.0
	**/
	public var audioXhrSettings:XHRSettingsObject;
};
