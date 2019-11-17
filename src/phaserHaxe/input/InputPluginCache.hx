package phaserHaxe.input;

import haxe.Constraints.Function;
import phaserHaxe.input.typedefs.InputPluginContainer;
import haxe.ds.StringMap;

final class InputPluginCache
{
	private static var inputPlugins:Null<StringMap<InputPluginContainer>>;

	/**
	 * Static method called directly by the Core internal Plugins.
	 * Key is a reference used to get the plugin from the plugins object (i.e. InputPlugin)
	 * Plugin is the object to instantiate to create the plugin
	 * Mapping is what the plugin is injected into the Scene.Systems as (i.e. input)
	 *
	 * @since 1.0.0
	 *
	 * @param key - A reference used to get this plugin from the plugin cache.
	 * @param plugin - The plugin to be stored. Should be the core object, not instantiated.
	 * @param mapping - If this plugin is to be injected into the Input Plugin, this is the property key used.
	 * @param settingsKey - The key in the Scene Settings to check to see if this plugin should install or not.
	 * @param configKey - The key in the Game Config to check to see if this plugin should install or not.
	**/
	public static function register(key:String, plugin:Function, mapping:String,
			settingsKey:String, configKey:String)
	{
		if (inputPlugins == null)
		{
			inputPlugins = new StringMap();
		}

		inputPlugins.set(key, {
			key: key,
			plugin: plugin,
			mapping: mapping,
			settingsKey: settingsKey,
			configKey: configKey
		});
	}

	public static function getPlugin(key:String):InputPluginContainer
	{
		return if (inputPlugins != null)
		{
			inputPlugins.get(key);
		}
		else
		{
			null;
		}
	}

    public static function install() {
        
    }
}
