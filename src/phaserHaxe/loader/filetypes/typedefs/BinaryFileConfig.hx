
/**
* @since 1.0.0
**/
typedef BinaryFileConfig =
{
	/**
	 * The key of the file. Must be unique within both the Loader and the Binary Cache.
	 *
	 * @since 1.0.0
	**/
	public var key:String;

	/**
	 * The absolute or relative URL to load the file from.
	 *
	 * @since 1.0.0
	**/
	public var url:String;

	/**
	 * The default file extension to use if no url is provided.
	 *
	 * @since 1.0.0
	**/
	public var ?extension:String;

	/**
	 * Extra XHR Settings specifically for this file.
	 *
	 * @since 1.0.0
	**/
	public var xhrSettings:XHRSettingsObject;

	/**
	 * Optional type to cast the binary file to once loaded. For example, `Uint8Array`.
	 *
	 * @since 1.0.0
	**/
	public var dataType:Class<Dynamic>;
}
