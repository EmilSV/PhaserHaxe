package phaserHaxe.loader.filetypes.typedefs;

/**
 * @since 1.0.0
**/
typedef MultiScriptFileConfig =
{
	/**
	 * The key of the file. Must be unique within the Loader.
	 *
	 * @since 1.0.0
	**/
	public var key:String;

	/**
	 * An array of absolute or relative URLs to load the script files from.
	 * They are processed in the order given in the array.
	 *
	 * @since 1.0.0
	**/
	public var ?url:Array<String>;

	/**
	 * The default file extension to use if no url is provided.
	 *
	 * @since 1.0.0
	**/
	public var ?extension:String;

	/**
	 * Extra XHR Settings specifically for these files.
	 *
	 * @since 1.0.0
	**/
	public var ?xhrSettings:XHRSettingsObject;
}
