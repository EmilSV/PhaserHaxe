/**
	* @typedef {object} Phaser.Types.Loader.FileTypes.BitmapFontFileConfig
	*
	public var {string} key - The key of the file. Must be unique within both the Loader and the Texture Manager.
	public var {string} [textureURL] - The absolute or relative URL to load the texture image file from.
	public var {string} [textureExtension='png'] - The default file extension to use for the image texture if no url is provided.
	public var {Phaser.Types.Loader.XHRSettingsObject} [textureXhrSettings] - Extra XHR Settings specifically for the texture image file.
	public var {string} [normalMap] - The filename of an associated normal map. It uses the same path and url to load as the texture image.
	public var {string} [fontDataURL] - The absolute or relative URL to load the font data xml file from.
	public var {string} [fontDataExtension='xml'] - The default file extension to use for the font data xml if no url is provided.
	public var {Phaser.Types.Loader.XHRSettingsObject} [fontDataXhrSettings] - Extra XHR Settings specifically for the font data xml file.
 */
typedef BitmapFontFileConfig =
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
	 *  Extra XHR Settings specifically for the texture image file.
	 *
	 * @since 1.0.0
	**/
	public var textureXhrSettings:XHRSettingsObject;

	/**
	 * The filename of an associated normal map. It uses the same path and url to load as the texture image.
	 *
	 * @since 1.0.0
	**/
	public var normalMap:String;

	/**
	 * The absolute or relative URL to load the font data xml file from.
	 *
	 * @since 1.0.0
	**/
	public var fontDataURL:String;

	/**
	 * The default file extension to use for the font data xml if no url is provided.
	 *
	 * @since 1.0.0
	**/
	public var ?fontDataExtension:String;

	/**
	 * Extra XHR Settings specifically for the font data xml file.
	 *
	 * @since 1.0.0
	**/
	public var fontDataXhrSettings:XHRSettingsObject;
};
