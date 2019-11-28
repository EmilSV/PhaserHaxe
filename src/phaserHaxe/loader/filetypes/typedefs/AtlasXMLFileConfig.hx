package phaserHaxe.loader.filetypes.typedefs;

/**
 * @since 1.0.0
**/
typedef AtlasXMLFileConfig =
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
	public var ?textureExtension:String;

	/**
	 * Extra XHR Settings specifically for the texture image file.
	 *
	 * @since 1.0.0
	**/
	public var ?textureXhrSettings:XHRSettingsObject;

	/**
	 *  The filename of an associated normal map. It uses the same path and url to load as the texture image.
	 *
	 * @since 1.0.0
	**/
	public var normalMap:String;

	/**
	 * The absolute or relative URL to load the atlas xml file from.
	 *
	 * @since 1.0.0
	**/
	public var atlasURL:String;

	/**
	 * The default file extension to use for the atlas xml if no url is provided.
	 *
	 * @since 1.0.0
	**/
	public var ?atlasExtension:String;

	/**
	 * Extra XHR Settings specifically for the atlas xml file.
	 *
	 * @since 1.0.0
	**/
	public var atlasXhrSettings:XHRSettingsObject;
};
