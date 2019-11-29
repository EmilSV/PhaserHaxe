/**
 * @since 1.0.0
**/
typedef MultiAtlasFileConfig =
{
	/**
	 * The key of the file. Must be unique within both the Loader and the Texture Manager.
	 *
	 * @since 1.0.0
	**/
	public var key:String;

	/**
	 * The absolute or relative URL to load the multi atlas json file from. Or, a well formed JSON object.
	 *
	 * @since 1.0.0
	**/
	public var ?atlasURL:String;

	/**
	 * The default file extension to use for the atlas json if no url is provided.
	 *
	 * @since 1.0.0
	**/
	public var ?atlasExtension:String;

	/**
	 *  Extra XHR Settings specifically for the atlas json file.
	 *
	 * @since 1.0.0
	**/
	public var ?atlasXhrSettings:XHRSettingsObject;

	/**
	 * Optional path to use when loading the textures defined in the atlas data.
	 *
	 * @since 1.0.0
	**/
	public var ?path:String;

	/**
	 * Optional Base URL to use when loading the textures defined in the atlas data.
	 *
	 * @since 1.0.0
	**/
	public var ?baseURL:String;

	/**
	 * Extra XHR Settings specifically for the texture files.
	 *
	 * @since 1.0.0
	**/
	public var ?textureXhrSettings:XHRSettingsObject;
};
