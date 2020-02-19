package phaserHaxe.loader.typedefs;

import js.html.XMLHttpRequestResponseType;

/**
 * @since 1.0.0
**/
typedef FileConfig =
{
	/**
	 * The file type string (image, json, etc) for sorting within the Loader.
	 *
	 * @since 1.0.0
	**/
	public var type:String;

	/**
	 * Unique cache key (unique within its file type)
	 *
	 * @since 1.0.0
	**/
	public var key:String;

	/**
	 * The URL of the file, not including baseURL.
	 *
	 * @since 1.0.0
	**/
	public var ?url:String;

	/**
	 * The path of the file, not including the baseURL.
	 *
	 * @since 1.0.0
	**/
	public var ?path:String;

	/**
	 * The default extension this file uses.
	 *
	 * @since 1.0.0
	**/
	public var ?extension:String;

	/**
	 * The responseType to be used by the XHR request.
	 *
	 * @since 1.0.0
	**/
	public var ?responseType:XMLHttpRequestResponseType;

	/**
	 * Custom XHR Settings specific to this file and merged with the Loader defaults.
	 *
	 * @since 1.0.0
	**/
	public var ?xhrSettings:XHRSettingsObject;

	public var ?cache:Any;

	public var ?config:Any;
};
