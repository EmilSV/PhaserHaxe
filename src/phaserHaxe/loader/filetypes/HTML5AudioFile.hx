package phaserHaxe.loader.filetypes;

import phaserHaxe.loader.typedefs.UrlConfig;
import js.Browser;
import js.html.Audio as WebAudio;
import js.html.AudioElement as HTMLAudioElements;
import phaserHaxe.loader.typedefs.FileConfig;
import phaserHaxe.loader.filetypes.typedefs.AudioFileConfig;
import phaserHaxe.utils.types.Union;
import js.Syntax as JsSyntax;
import js.html.ProgressEvent as WebProgressEvent;

/**
 * A single Audio File suitable for loading by the Loader.
 *
 * These are created when you use the Phaser.Loader.LoaderPlugin#audio method and are not typically created directly.
 *
 * For documentation about what all the arguments and configuration options mean please see Phaser.Loader.LoaderPlugin#audio.
 *
 * @since 1.0.0
**/
class HTML5AudioFile extends BaseAudioFile
{
	public var locked:Bool;
	public var loaded:Bool;
	public var filesLoaded:Int;
	public var filesTotal:Int;

	/**
	 * @param loader - A reference to the Loader that is responsible for this file.
	 * @param key - The key to use for this file, or a file configuration object.
	 * @param urlConfig - The absolute or relative URL to load this file from.
	 * @param xhrSettings - Extra XHR Settings specifically for this file.
	**/
	public function new(loader:LoaderPlugin, key:Union<String, AudioFileConfig>,
			?urlConfig:UrlConfig, ?audioConfig:Any)
	{
		if (!Std.is(key, String))
		{
			var config = (cast key : AudioFileConfig);

			key = config.key;
			if (config.config != null)
			{
				audioConfig = config.config;
			}
		}

		final key = (cast key : String);

		var fileConfig:FileConfig = {
			type: "audio",
			cache: loader.cacheManager.audio,
			extension: urlConfig.type,
			key: key,
			url: urlConfig.url,
			config: audioConfig
		};

		super(loader, fileConfig);

		this.locked = JsSyntax.code("'ontouchstart' in window");
		this.loaded = false;
		this.filesLoaded = 0;
		this.filesTotal = 0;
	}

	/**
	 * Called when the file finishes loading.
	 *
	 * @since 1.0.0
	**/
	public override function onLoad(_, _)
	{
		if (this.loaded)
		{
			return;
		}

		this.loaded = true;

		this.loader.nextFile(this, true);
	}

	/**
	 * Called if the file errors while loading.
	 *
	 * @since 1.0.0
	**/
	public override function onError(_, _)
	{
		final data = (cast this.data : Array<HTMLAudioElements>);

		for (i in 0...data.length)
		{
			var audio = data[i];
			audio.oncanplaythrough = null;
			audio.onerror = null;
		}

		this.loader.nextFile(this, false);
	}

	/**
	 * Called during the file load progress. Is sent a DOM ProgressEvent.
	 *
	 * @fires Phaser.Loader.Events#FILE_PROGRESS
	 * @since 1.0.0
	**/
	public override function onProgress(event:WebProgressEvent)
	{
		var audio = (cast event.target : HTMLAudioElements);

		audio.oncanplaythrough = null;
		audio.onerror = null;

		filesLoaded++;

		percentComplete = Math.min((filesLoaded / filesTotal), 1);

		loader.emit(LoaderEvents.FILE_PROGRESS, [this, percentComplete]);

		if (filesLoaded == filesTotal)
		{
			onLoad(null, null);
		}
	}

	/**
	 * Called by the Loader, starts the actual file downloading.
	 * During the load the methods onLoad, onError and onProgress are called, based on the XHR events.
	 * You shouldn't normally call this method directly, it's meant to be invoked by the Loader.
	 *
	 * @since 1.0.0
	**/
	public override function load()
	{
		var data:Array<WebAudio> = this.data = [];

		var config = (cast this.config : {instances: Null<Int>});
		var instances = 1;

		if (config == null && config.instances != null)
		{
			instances = config.instances;
		}

		this.filesTotal = instances;
		this.filesLoaded = 0;
		this.percentComplete = 0;

		for (i in 0...instances)
		{
			var audio = new WebAudio();
			(cast audio : Dynamic).dataset = {};
			audio.dataset.name = this.key + ('0' + i).substring(-2);
			audio.dataset.used = "false";

			if (locked)
			{
				audio.dataset.locked = 'true';
			}
			else
			{
				audio.dataset.locked = 'false';

				audio.preload = 'auto';
				audio.oncanplaythrough = this.onProgress;
				audio.onerror = this.onError;
			}

			data.push(audio);
		}

		for (i in 0...data.length)
		{
			var audio = data[i];
			audio.src = LoaderUtils.getUrl(this, this.loader.baseURL);

			if (!this.locked)
			{
				audio.load();
			}
		}

		if (this.locked)
		{
			//  This is super-dangerous but works. Race condition potential high.
			//  Is there another way?
			Browser.window.setTimeout(this.onLoad);
		}
	}
}
