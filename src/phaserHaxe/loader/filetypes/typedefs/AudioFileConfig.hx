package phaserHaxe.loader.filetypes.typedefs;

import js.html.audio.AudioContext as WebAudioContext;

/**
 * @since 1.0.0
**/
typedef AudioFileConfig =
{
	/**
	 * The key of the file. Must be unique within the Loader and Audio Cache.
	 *
	 * @since 1.0.0
	**/
	public var key:String;

	/**
	 * The absolute or relative URL to load the file from.
	 *
	 * @since 1.0.0
	**/
	public var ?url:String;

	public var config:Any;

	/**
	 * Extra XHR Settings specifically for this file.
	 *
	 * @since 1.0.0
	**/
	public var ?xhrSettings:XHRSettingsObject;

	/**
	 * The AudioContext this file will use to process itself.
	 *
	 * @since 1.0.0
	**/
	public var ?context:WebAudioContext;
};
