package phaserHaxe.loader.filetypes.typedefs;

import phaserHaxe.utils.types.Union;
import phaserHaxe.loader.XHRSettingsObject;

/**
 * @since 1.0.0
**/
typedef PackFileConfig =
{
	/**
	 * The key of the file. Must be unique within both the Loader and the JSON Cache.
	 *
	 * @since 1.0.0
	**/
	public var key:String;

	/**
	 * The absolute or relative URL to load the file from. Or can be a ready formed JSON object, in which case it will be directly processed.
	 *
	 * @since 1.0.0
	**/
	public var ?url:Union<String, {}>;

	/**
	 * The default file extension to use if no url is provided.
	 *
	 * @since 1.0.0
	**/
	public var ?extension:String;

	/**
	 * If specified instead of the whole JSON file being parsed, only the section corresponding to this property key will be added. If the property you want to extract is nested, use periods to divide it.
	 *
	 * @since 1.0.0
	**/
	public var ?dataKey:String;

	/**
	 * Extra XHR Settings specifically for this file.
	 *
	 * @since 1.0.0
	**/
	public var ?xhrSettings:XHRSettingsObject;
};
