package phaserHaxe.loader.filetypes.typedefs;

import haxe.Constraints.Function;
import phaserHaxe.utils.types.Union;

/**
 * @since 1.0.0
**/
typedef ScenePluginFileConfig =
{
	/**
	 * The key of the file. Must be unique within the Loader.
	 *
	 * @since 1.0.0
	**/
	public var key:String;

	/**
	 * The absolute or relative URL to load the file from. Or, a Scene Plugin.
	 *
	 * @since 1.0.0
	**/
	public var ?url:Union<String, Function>;

	/**
	 * The default file extension to use if no url is provided.
	 *
	 * @since 1.0.0
	**/
	public var ?extension:String;

	/**
	 * If this plugin is to be added to Scene.Systems, this is the property key for it.
	 *
	 * @since 1.0.0
	**/
	public var ?systemKey:String;

	/**
	 *  If this plugin is to be added to the Scene, this is the property key for it.
	 *
	 * @since 1.0.0
	**/
	public var ?sceneKey:String;

	/**
	 * Extra XHR Settings specifically for this file.
	 *
	 * @since 1.0.0
	**/
	public var ?xhrSettings:XHRSettingsObject;
};
