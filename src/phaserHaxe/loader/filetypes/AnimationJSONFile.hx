package phaserHaxe.loader.filetypes;

import phaserHaxe.loader.filetypes.typedefs.JSONFileConfig;
import phaserHaxe.utils.types.Union;

/**
 * A single Animation JSON File suitable for loading by the Loader.
 *
 * These are created when you use the Phaser.Loader.LoaderPlugin#animation method and are not typically created directly.
 *
 * For documentation about what all the arguments and configuration options mean please see Phaser.Loader.LoaderPlugin#animation.
 *
 * @since 1.0.0
**/
class AnimationJSONFile extends JSONFile
{
	/**
	 * @param loader - A reference to the Loader that is responsible for this file.
	 * @param key - The key to use for this file, or a file configuration object.
	 * @param url - The absolute or relative URL to load this file from. If undefined or `null` it will be set to `<key>.json`, i.e. if `key` was "alien" then the URL will be "alien.json".
	 * @param xhrSettings - Extra XHR Settings specifically for this file.
	 * @param dataKey - When the JSON file loads only this property will be stored in the Cache.
	**/
	public function new(loader:LoaderPlugin, key:Union<String, JSONFileConfig>,
			?url:String, ?xhrSettings:XHRSettingsObject, ?dataKey:String)
	{
		super(loader, key, url, xhrSettings, dataKey);

		this.type = "animationJSON";
	}

	/**
	 * Called automatically by Loader.nextFile.
	 * This method controls what extra work this File does with its loaded data.
	 *
	 * @since 1.0.0
	**/
	public override function onProcess()
	{
		//  We need to hook into this event:
		this.loader.once(LoaderEvents.POST_PROCESS, this.onLoadComplete, this);

		//  But the rest is the same as a norm'al JSON file
		super.onProcess();
	}

	/**
	 * Called at the end of the load process, after the Loader has finished all files in its queue.
	 *
	 * @since 1.0.0
	**/
	public function onLoadComplete(loader:LoaderPlugin)
	{
		this.loader.systems.anims.fromJSON(this.data);
		this.pendingDestroy();
	}
}
