package phaserHaxe.loader.filetypes;

import js.html.audio.AudioBuffer as WebAudioBuffer;
import js.html.DOMException;
import phaserHaxe.loader.typedefs.FileConfig;
import js.html.audio.AudioContext as WebAudioContext;
import phaserHaxe.loader.filetypes.typedefs.AudioFileConfig;
import phaserHaxe.utils.types.Union;
import EReg class AudioFile extends File
{public function new(loader:LoaderPlugin, key:Union < String, AudioFileConfig >,
	urlConfig:{
	?type: String, ?url: String}, xhrSettings: XHRSettingsObject,
		audioContext: WebAudioContext) {
		if (!Std.is(key, String)) {
			var config = (cast key : AudioFileConfig);

key = config.key;
xhrSettings = config.xhrSettings;
if (config.context != null)
{
	audioContext = config.context;
}
} var fileConfig:FileConfig = {
	type: "audio",
	cache: loader.cacheManager.audio,
	extension: urlConfig.type,
	responseType: ARRAYBUFFER,
	key: (cast key : String),
	url: urlConfig.url,
	xhrSettings: xhrSettings,
	config: {context: audioContext}
};

super(loader, fileConfig);
} /**
 * Called automatically by Loader.nextFile.
 * This method controls what extra work this File does with its loaded data.
 *
 * @since 1.0.0
**/ public override function onProcess()
{
	this.state = FileConst.FILE_PROCESSING;
	var _this = this;

	var config = (cast config : {context: WebAudioContext});
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

public static function create(loader:LoaderPlugin, key:Union<String, AudioFileConfig>,
	urls:Array<Union<String, {url:String}>>, config:Any,
	xhrSettings:XHRSettingsObject) {}

public static function getAudioURL(game:Game, urls:Array<Union<String, {url:String}>>)
{
	if (!Std.is(urls, Array))
	{
		urls = [(cast urls : Union<String, {url:String, type:String}>)];
	}

	for (url in urls)
	{
		final url = if (!Std.is(url, String))
		{
			(cast urls : {url: String}).url;
		}
		else
		{
			(cast url : String);
		}

		if (url.indexOf("blob:") == 0 || url.indexOf("data:") == 0)
		{
			return url;
		}

		var audioTypeRegex = (~/\.([a-zA-Z0-9]+)($|\?)/);
		var audioTypeMatched = audioTypeRegex.match(url);

		audioType = GetFastValue(urls[i], 'type', (audioType) ? audioType[1] : '')
			.toLowerCase();

		if (game.device.audio[audioType])
		{
			return {
				url: url,
				type: audioType
			};
		}
	}

	return null;
}
}
