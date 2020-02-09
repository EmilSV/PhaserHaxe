package phaserHaxe.loader.filetypes;

import phaserHaxe.utils.types.MultipleOrOne;
import phaserHaxe.loader.filetypes.typedefs.AudioSpriteFileConfig;
import phaserHaxe.utils.types.Union;
import phaserHaxe.loader.filetypes.configs.AudioSpriteConfig;

/**
 * An Audio Sprite File suitable for loading by the Loader.
 *
 * These are created when you use the Phaser.Loader.LoaderPlugin#audioSprite method and are not typically created directly.
 *
 * For documentation about what all the arguments and configuration options mean please see Phaser.Loader.LoaderPlugin#audioSprite.
 *
 * @since 1.0.0
**/
class AudioSpriteFile extends MultiFile
{
	public var config:AudioSpriteConfig;

	/**
	 * @param loader - A reference to the Loader that is responsible for this file.
	 * @param key - The key to use for this file, or a file configuration object.
	 * @param jsonURL - The absolute or relative URL to load the json file from. Or a well formed JSON object to use instead.
	 * @param audioURL - The absolute or relative URL to load the audio file from. If empty it will be obtained by parsing the JSON file.
	 * @param audioConfig - The audio configuration options.
	 * @param audioXhrSettings - An XHR Settings configuration object for the audio file. Used in replacement of the Loaders default XHR Settings.
	 * @param jsonXhrSettings - An XHR Settings configuration object for the json file. Used in replacement of the Loaders default XHR Settings.
	**/
	public function new(loader:LoaderPlugin, key:Union<String, AudioSpriteFileConfig>,
			?jsonURL:String, ?audioURL:MultipleOrOne<String>, ?audioConfig:Any,
			?audioXhrSettings:XHRSettingsObject, ?jsonXhrSettings:XHRSettingsObject)
	{
		if (!Std.is(key, String))
		{
			var config = (cast key : AudioSpriteFileConfig);

			key = config.key;
			jsonURL = config.jsonURL;
			audioURL = config.audioURL;
			audioConfig = config.audioConfig;
			audioXhrSettings = config.audioXhrSettings;
			jsonXhrSettings = config.jsonXhrSettings;
		}

		//  No url? then we're going to do a json load and parse it from that
		if (audioURL == null)
		{
			final data = new JSONFile(loader, (cast key : String), jsonURL, jsonXhrSettings);

			super(loader, "audiosprite", (cast key : String), cast [data]);

			this.config = {
				resourceLoad: true,
				audioConfig: audioConfig,
				audioXhrSettings: audioXhrSettings
			};
		}
		else
		{
			final audio = AudioFile.create(loader, cast key, audioURL, audioConfig, audioXhrSettings);

			if (audio != null)
			{
				final data = new JSONFile(loader, cast key, jsonURL, jsonXhrSettings);

				super(loader, "audiosprite", cast key, [audio, data]);

				this.config = {resourceLoad: false};
			}
		}
	}

	/**
	 * Called by each File when it finishes loading.
	 *
	 * @since 1.0.0
	 *
	 * @param file - The File that has completed processing.
	**/
	public override function onFileComplete(file:File)
	{
		var index = files.indexOf(file);
		if (index != -1)
		{
			pending--;
			var urls = Reflect.getProperty(file.data, "resources");
			if (config.resourceLoad && file.type == "json" && urls != null)
			{
				//  Inspect the data for the files to now load
				var audioConfig = this.config.audioConfig;
				var audioXhrSettings = this.config.audioXhrSettings;
				
				var audio = AudioFile.create(this.loader, file.key, urls, audioConfig, audioXhrSettings);
				
				if (audio != null)
				{
					this.addToMultiFile(audio);
					
					this.loader.addFile(audio);
				}
			}
		}
	}

	/**
	 * Adds this file to its target cache upon successful loading and processing.
	 *
	 * @since 1.0.0
	**/
	public override function addToCache()
	{
		if (this.isReadyToProcess())
		{
			var fileA = this.files[0];
			var fileB = this.files[1];
			fileA.addToCache();
			fileB.addToCache();
			this.complete = true;
		}
	}
}
