package phaserHaxe.device;

/**
 * Determines the audio playback capabilities of the device running this Phaser Game instance.
 * These values are read-only and populated during the boot sequence of the game.
 * They are then referenced by internal game systems and are available for you to access
 * via `this.sys.game.device.audio` from within any Scene.
 *
 * @since 1.0.0
**/
final class AudioInfo
{
	#if js
	private static var _isInitialized:Null<Bool>;
	#else
	private static var _isInitialized:Bool;
	#end

	/**
	 * Can this device play HTML Audio tags?
	 *
	 * @since 1.0.0
	**/
	public static var audioData(get, null):Bool;

	/**
	 * Can this device play EC-3 Dolby Digital Plus files?
	 *
	 * @since 1.0.0
	**/
	public static var dolby(get, null):Bool;

	/**
	 * Can this device can play m4a files.
	 *
	 * @since 1.0.0
	**/
	public static var m4a(get, null):Bool;

	/**
	 * Can this device play mp3 files?
	 *
	 * @since 1.0.0
	**/
	public static var mp3(get, null):Bool;

	/**
	 * Can this device play ogg files?
	 *
	 * @since 1.0.0
	**/
	public static var ogg(get, null):Bool;

	/**
	 * Can this device play opus files?
	 *
	 * @since 1.0.0
	**/
	public static var opus(get, null):Bool;

	/**
	 * Can this device play wav files?
	 *
	 * @since 1.0.0
	**/
	public static var wav(get, null):Bool;

	/**
	 * Does this device have the Web Audio API?
	 *
	 * @since 1.0.0
	**/
	public static var webAudio(get, null):Bool;

	/**
	 * Can this device play webm files?
	 *
	 * @since 1.0.0
	**/
	public static var webm(get, null):Bool;

	private static inline function isNotInitialized()
	{
		#if js
		return js.Syntax.strictNeq(_isInitialized, true);
		#else
		return _isInitialized != true;
		#end
	}

	private static function get_audioData():Bool
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return audioData;
	}

	private static function get_dolby():Bool
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return dolby;
	}

	private static function get_m4a():Bool
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return m4a;
	}

	private static function get_mp3():Bool
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return mp3;
	}

	private static function get_ogg():Bool
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return ogg;
	}

	private static function get_opus():Bool
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return opus;
	}

	private static function get_wav():Bool
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return wav;
	}

	private static function get_webAudio():Bool
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return webAudio;
	}

	private static function get_webm():Bool
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return webm;
	}

	@:allow(phaserHaxe)
	private static function initialize()
	{
		#if js
		if (js.Syntax.strictEq(_isInitialized, true))
		{
			return;
		}
		#else
		if (_isInitialized)
		{
			return;
		}
		#end

		AudioInfo.audioData = false;
		AudioInfo.dolby = false;
		AudioInfo.m4a = false;
		AudioInfo.mp3 = false;
		AudioInfo.ogg = false;
		AudioInfo.opus = false;
		AudioInfo.wav = false;
		AudioInfo.webAudio = false;
		AudioInfo.webm = false;

		BrowserInfo.initialize();

		function hasContent(value:String):Bool
		{
			return value != null && value.length != 0;
		}

		AudioInfo.audioData = js.Syntax.code("!!(window['Audio'])");

		AudioInfo.webAudio = js.Syntax.code("!!(window['AudioContext'] || window['webkitAudioContext'])");

		var audioElement:js.html.AudioElement = cast js.Browser.document.createElement("audio");

		var result = js.Syntax.code("!!{0}.canPlayType", audioElement);

		try
		{
			if (result)
			{
				final reg = (~/^no$/);

				var canPlayOggStr = reg.replace(audioElement.canPlayType('audio/ogg; codecs="vorbis"'), '');

				if (hasContent(canPlayOggStr))
				{
					AudioInfo.ogg = true;
				}

				var canPlayOpusStr1 = reg.replace(audioElement.canPlayType('audio/ogg; codecs="opus"'), '');
				var canPlayOpusStr2 = reg.replace(audioElement.canPlayType('audio/opus;'), '');

				if (hasContent(canPlayOpusStr1) || hasContent(canPlayOpusStr2))
				{
					AudioInfo.opus = true;
				}

				var canPlayMp3Str = reg.replace(audioElement.canPlayType('audio/wav; codecs="1"'), '');

				if (hasContent(canPlayMp3Str))
				{
					AudioInfo.mp3 = true;
				}
				//  Mimetypes accepted:
				//  developer.mozilla.org/En/Media_formats_supported_by_the_audio_and_video_elements
				//  bit.ly/iphoneoscodecs
				var canPlayWavStr = reg.replace(audioElement.canPlayType('audio/wav; codecs="1"'), '');

				if (hasContent(canPlayWavStr))
				{
					AudioInfo.wav = true;
				}

				var canPlayM4aStr1 = audioElement.canPlayType('audio/x-m4a;');
				var canPlayM4aStr2 = reg.replace(audioElement.canPlayType('audio/aac;'), '');
				if (hasContent(canPlayM4aStr1) || hasContent(canPlayM4aStr2))
				{
					AudioInfo.m4a = true;
				}

				var canPlayWebmStr = reg.replace(audioElement.canPlayType('audio/webm; codecs="vorbis"'), '');
				if (hasContent(canPlayWebmStr))
				{
					AudioInfo.webm = true;
				}

				if (js.Syntax.strictNeq(audioElement.canPlayType('audio/mp4;codecs="ec-3"'), ''))
				{
					if (BrowserInfo.edge)
					{
						AudioInfo.dolby = true;
					}
					else if (BrowserInfo.safari && BrowserInfo.safariVersion >= 9)
					{
						final reg = (~/Mac OS X (\d+)_(\d+)/);

						if (reg.match(js.Browser.navigator.userAgent))
						{
							var major = Std.parseInt(reg.matched(1));
							var minor = Std.parseInt(reg.matched(2));

							if ((major == 10 && minor >= 11) || major > 10)
							{
								AudioInfo.dolby = true;
							}
						}
					}
				}
			}
		}
		catch (e:Dynamic)
		{
			//  Nothing to do here
		}

		_isInitialized = true;
	}
}
