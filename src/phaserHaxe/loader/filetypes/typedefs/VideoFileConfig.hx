package phaserHaxe.loader.filetypes.typedefs;

import phaserHaxe.utils.types.Union;

/**
 * @since 1.0.0
**/
typedef VideoFileConfig =
{
	/**
	 * The key to use for this file, or a file configuration object.
	 *
	 * @since 1.0.0
	**/
	public var key:Union<String, VideoFileConfig>;

	/**
	 * The absolute or relative URL to load this file from in a config object.
	 *
	 * @since 1.0.0
	**/
	public var urlConfig:Any;

	/**
	 * The load event to listen for when _not_ loading as a blob. Either "loadeddata", "canplay" or "canplaythrough".
	 *
	 * @since 1.0.0
	**/
	public var ?loadEvent:String;

	/**
	 * Load the video as a data blob, or via the Video element?
	 *
	 * @since 1.0.0
	**/
	public var ?asBlob:Bool;

	/**
	 * Does the video have an audio track? If not you can enable auto-playing on it.
	 *
	 * @since 1.0.0
	**/
	public var ?noAudio:Bool;

	/**
	 * Extra XHR Settings specifically for this file.
	 *
	 * @since 1.0.0
	**/
	public var ?xhrSettings:XHRSettingsObject;
};
