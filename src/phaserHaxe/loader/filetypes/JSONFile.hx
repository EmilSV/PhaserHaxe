package phaserHaxe.loader.filetypes;

import phaserHaxe.loader.typedefs.FileConfig;
import phaserHaxe.loader.filetypes.typedefs.JSONFileConfig;
import phaserHaxe.utils.types.Union;
import haxe.Json;

/**
 * A single JSON File suitable for loading by the Loader.
 *
 * These are created when you use the Phaser.Loader.LoaderPlugin#json method and are not typically created directly.
 *
 * For documentation about what all the arguments and configuration options mean please see Phaser.Loader.LoaderPlugin#json.
 *
 * @since 1.0.0
**/
class JSONFile extends File
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
		var extension = "json";

		if (!Std.is(key, String))
		{
			var config = (cast key : JSONFileConfig);

			key = config.key;
			url = config.key;
			xhrSettings = config.xhrSettings;
			if (config.extension != null)
			{
				extension = config.extension;
			}

			if (config.dataKey != null)
			{
				extension = config.dataKey;
			}
		}

		var fileConfig:FileConfig = {
			type: "json",
			cache: loader.cacheManager.json,
			extension: extension,
			responseType: TEXT,
			key: cast key,
			url: url,
			xhrSettings: xhrSettings,
			config: dataKey
		};

		super(loader, fileConfig);

		if (!Std.is(url, String))
		{
			//  Object provided instead of a URL, so no need to actually load it (populate data with value)
			if (dataKey != null && url != null)
			{
				this.data = Reflect.getProperty(url, dataKey);
			}
			else
			{
				this.data = url;
			}

			this.state = FileConst.FILE_POPULATED;
		}
	}

	/**
	 * Called automatically by Loader.nextFile.
	 * This method controls what extra work this File does with its loaded data.
	 *
	 * @since 1.0.0
	**/
	public override function onProcess()
	{
		if (state != FileConst.FILE_POPULATED)
		{
			state = FileConst.FILE_PROCESSING;

			var json:Any = Json.parse(xhrLoader.responseText);

			var key = config;

			if (Std.is(key, String))
			{
				if (Reflect.hasField(json, key))
				{
					data = Reflect.field(json, key);
				}
				else
				{
					data = json;
				}
			}
			else
			{
				data = json;
			}
		}

		onProcessComplete();
	}
}
