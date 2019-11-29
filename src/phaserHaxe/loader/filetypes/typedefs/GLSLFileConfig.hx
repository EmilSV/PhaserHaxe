package phaserHaxe.loader.filetypes.typedefs;

/**
 * @since 1.0.0
**/
typedef GLSLFileConfig =
{
	/**
	 * The key of the file. Must be unique within both the Loader and the Text Cache.
	 *
	 * @since 1.0.0
	**/
	public var key:String;

	/**
	 *  The absolute or relative URL to load the file from.
	 *
	 * @since 1.0.0
	**/
	public var ?url:String;

	/**
	 * The type of shader. Either `fragment` for a fragment shader, or `vertex` for a vertex shader. This is ignored if you load a shader bundle
	 *
	 * @since 1.0.0
	**/
	public var ?shaderType:String;

	/**
	 *  The default file extension to use if no url is provided.
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
}
