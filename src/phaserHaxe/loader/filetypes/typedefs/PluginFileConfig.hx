package phaserHaxe.loader.filetypes.typedefs;

/**
 * @since 1.0.0
**/
typedef PluginFileConfig =
{
	/**
	 * The key of the file. Must be unique within the Loader.
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
	 * Automatically start the plugin after loading?
	 *
	 * @since 1.0.0
	**/
	public var ?start:Bool;

	/**
	 * If this plugin is to be injected into the Scene, this is the property key used.
	 *
	 * @since 1.0.0
	**/
	public var ?mapping:String;

	/**
	 * Extra XHR Settings specifically for this file.
	 *
	 * @since 1.0.0
	**/
	public var ?xhrSettings:XHRSettingsObject;
};
