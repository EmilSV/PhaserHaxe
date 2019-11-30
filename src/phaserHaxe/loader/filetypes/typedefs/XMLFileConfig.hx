/**
 * @since 1.0.0
**/
typedef XMLFileConfig =
{
	/**
	 * The key of the file. Must be unique within both the Loader and the Tilemap Cache.
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

	/**
	 * The default file extension to use if no url is provided.
	 *
	 * @since 1.0.0
	**/
	public var ?extension:String;

	/**
	 *  Extra XHR Settings specifically for this file.
	 *
	 * @since 1.0.0
	**/
	public var ?xhrSettings:XHRSettingsObject;
};
