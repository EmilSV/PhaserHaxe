package phaserHaxe.loader.filetypes;

import phaserHaxe.loader.typedefs.UrlConfig;
import phaserHaxe.utils.types.MultipleOrOne;
import EReg;
import js.html.DOMException;
import js.html.audio.AudioBuffer as WebAudioBuffer;
import js.html.audio.AudioContext as WebAudioContext;
import phaserHaxe.loader.filetypes.typedefs.AudioFileConfig;
import phaserHaxe.loader.typedefs.FileConfig;
import phaserHaxe.utils.types.Union;
import phaserHaxe.loader.filetypes.configs.AudioFileData;

/**
 * A single Audio File suitable for loading by the Loader.
 *
 * These are created when you use the Phaser.Loader.LoaderPlugin#audio method and are not typically created directly.
 *
 * For documentation about what all the arguments and configuration options mean please see Phaser.Loader.LoaderPlugin#audio.
 *
 * @since 1.0.0
**/
class AudioFile extends BaseAudioFile
{
	public var config:AudioFileData;

	/**
	 * @param loader - A reference to the Loader that is responsible for this file.
	 * @param key - The key to use for this file, or a file configuration object.
	 * @param urlConfig - The absolute or relative URL to load this file from in a config object.
	 * @param xhrSettings - Extra XHR Settings specifically for this file.
	 * @param audioContext - The AudioContext this file will use to process itself.
	**/
	public function new(loader:LoaderPlugin, key:Union<String, AudioFileConfig>,
			?urlConfig:UrlConfig, ?xhrSettings:XHRSettingsObject,
			?audioContext:WebAudioContext)
	{
		if (!Std.is(key, String))
		{
			var config = (cast key : AudioFileConfig);

			key = config.key;
			xhrSettings = config.xhrSettings;
			if (config.context != null)
			{
				audioContext = config.context;
			}
		}
		var fileConfig:FileConfig = {
			type: "audio",
			cache: loader.cacheManager.audio,
			extension: urlConfig.type,
			responseType: ARRAYBUFFER,
			key: (cast key : String),
			url: urlConfig.url,
			xhrSettings: xhrSettings
		};

		this.config = {context: audioContext};

		super(loader, fileConfig);
	}

	/**
	 * Called automatically by Loader.nextFile.
	 * This method controls what extra work this File does with its loaded data.
	 *
	 * @since 1.0.0
	**/
	public override function onProcess()
	{
		this.state = FileConst.FILE_PROCESSING;
		var _this = this;

		// interesting read https://github.com/WebAudio/web-audio-api/issues/1305
		config.context.decodeAudioData(this.xhrLoader.response, function(audioBuffer:WebAudioBuffer)
		{
			_this.data = audioBuffer;

			_this.onProcessComplete();
		}, function(e:DOMException)
		{
			// eslint-disable-next-line no-console
			Console.error('Error decoding audio: $key - , ${e != null ? e.message : null}');

			_this.onProcessError();
		});

		config.context = null;
	}

	public static function create(loader:LoaderPlugin,
			key:Union<String, AudioFileConfig>, ?urls:MultipleOrOne<String>,
			?config:Any, ?xhrSettings:XHRSettingsObject):BaseAudioFile
	{
		var game:Game = loader.systems.game;
		var audioConfig = game.config.audio;
		var deviceAudio = game.device.audio;

		//  url may be inside key, which may be an object
		if (!Std.is(key, String))
		{
			final key = (cast key : AudioFileConfig);
			urls = key.url;
			if (urls == null)
			{
				urls = [];
			}

			config = key.config;
			if (config == null)
			{
				config = {};
			}
		}

		var urlConfig = AudioFile.getAudioURL(game, urls);

		if (urlConfig == null)
		{
			return null;
		}

		// https://developers.google.com/web/updates/2012/02/HTML5-audio-and-the-Web-Audio-API-are-BFFs
		// var stream = GetFastValue(config, 'stream', false);

		if (deviceAudio.webAudio && !(audioConfig != null && audioConfig.disableWebAudio))
		{
			return new AudioFile(loader, key, urlConfig, xhrSettings, game.sound.context);
		}
		else
		{
			return new HTML5AudioFile(loader, key, urlConfig, config);
		}
	}

	public static function getAudioURL(game:Game, urls:MultipleOrOne<String>):
		{
			url:String,
			type:String
		}
	{
		throw new Error("Not implemented");
		// if (!Std.is(urls, Array))
		// {
		// 	urls = [(cast urls : Union<String, {url:String, type:String}>)];
		// }
		// for (i in 0...urls.length)
		// {
		// 	var url:String = null;
		// 	if (!Std.is(url, String))
		// 	{
		// 		url = (cast urls[i] : {url: String}).url;
		// 		url = urls[i]
		// 	}
		// 	else
		// 	{
		// 		url = (cast urls[i] : String);
		// 	}
		// 	if (url.indexOf("blob:") == 0 || url.indexOf("data:") == 0)
		// 	{
		// 		return url;
		// 	}
		// 	var audioTypeRegex = (~/\.([a-zA-Z0-9]+)($|\?)/);
		// 	var audioTypeMatched = audioTypeRegex.match(url);
		// 	var audioType = null;
		// 	audioType urls[i].type;
		// 	audioType = GetFastValue(urls[i], 'type', (audioTypeMatched) ? audioTypeRegex.matched(1) : '')
		// 		.toLowerCase();
		// 	if (game.device.audio[audioType])
		// 	{
		// 		return {
		// 			url: url,
		// 			type: audioType
		// 		};
		// 	}
		// }
		// return null;
	}
}
