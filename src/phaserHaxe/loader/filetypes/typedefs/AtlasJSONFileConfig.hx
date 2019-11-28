package phaserHaxe.loader.filetypes.typedefs;

/**
 * @since 1.0.0
**/
typedef AtlasJSONFileConfig =
{
	/**
	 * The key of the file. Must be unique within both the Loader and the Texture Manager.
	 *
	 * @since 1.0.0
	**/
	public var key:String;

	/**
	 * The absolute or relative URL to load the texture image file from.
	 *
	 * @since 1.0.0
	**/
	public var textureURL:String;

	/**
	 * The default file extension to use for the image texture if no url is provided.
	 *
	 * @since 1.0.0
	**/
	public var textureExtension:String;

	/**
	 * Extra XHR Settings specifically for the texture image file.
	 *
	 * @since 1.0.0
	**/
	public var textureXhrSettings:XHRSettingsObject;

	/**
	 *  The filename of an associated normal map. It uses the same path and url to load as the texture image.
	 *
	 * @since 1.0.0
	**/
	public var normalMap:String;

	/**
	 *  The absolute or relative URL to load the atlas json file from. Or a well formed JSON object to use instead.
	 *
	 * @since 1.0.0
	**/
	public var atlasURL:String;

	/**
	 * The default file extension to use for the atlas json if no url is provided.
	 *
	 * @since 1.0.0
	**/
	public var ?atlasExtension:String;

	/**
	 * Extra XHR Settings specifically for the atlas json file.
	 *
	 * @since 1.0.0
	**/
	public var atlasXhrSettings:XHRSettingsObject;
};
