package phaserHaxe.input.typedefs;

import haxe.Constraints.Function;

/**
 * @since 1.0.0
**/
typedef InputPluginContainer =
{
	/**
	 * The unique name of this plugin in the input plugin cache.
	 *
	 * @since 1.0.0
	**/
	public var key:String;

	/**
	 * The plugin to be stored. Should be the source object, not instantiated.
	 *
	 * @since 1.0.0
	**/
	public var plugin:Function;

	/**
	 * If this plugin is to be injected into the Input Plugin, this is the property key map used.
	 *
	 * @since 1.0.0
	**/
	public var ?mapping:String;

	public var settingsKey:String;

	public var configKey:String;
};
