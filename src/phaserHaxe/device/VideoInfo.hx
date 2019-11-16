package phaserHaxe.device;

/**
 * Determines the video support of the browser running this Phaser Game instance.
 * These values are read-only and populated during the boot sequence of the game.
 * They are then referenced by internal game systems and are available for you to access
 * via `this.sys.game.device.video` from within any Scene.
 *
 * @since 1.0.0
**/
final class VideoInfo
{
	#if js
	private static var _isInitialized:Null<Bool>;
	#else
	private static var _isInitialized:Bool;
	#end

	/**
	 * Can this device play h264 mp4 video files?
	 *
	 * @since 1.0.0
	**/
	public static var h264(get, null):Bool;

	/**
	 * Can this device play hls video files?
	 *
	 * @since 1.0.0
	**/
	public static var hls(get, null):Bool;

	/**
	 * Can this device play h264 mp4 video files?
	 *
	 * @since 1.0.0
	**/
	public static var mp4(get, null):Bool;

	/**
	 * Can this device play ogg video files?
	 *
	 * @since 1.0.0
	**/
	public static var ogg(get, null):Bool;

	/**
	 * Can this device play vp9 video files?
	 *
	 * @since 1.0.0
	**/
	public static var vp9(get, null):Bool;

	/**
	 * Can this device play webm video files?
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

	public static function get_h264():Bool
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return h264;
	}

	public static function get_hls():Bool
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return hls;
	}

	public static function get_mp4():Bool
	{
		if (isNotInitialized())
		{
			initialize();
		}
		return mp4;
	}

	public static function get_ogg():Bool
	{
		if (isNotInitialized())
		{
			initialize();
		}
		return ogg;
	}

	public static function get_vp9():Bool
	{
		if (isNotInitialized())
		{
			initialize();
		}
		return vp9;
	}

	public static function get_webm():Bool
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

		// Default values
		VideoInfo.h264 = false;
		VideoInfo.hls = false;
		VideoInfo.mp4 = false;
		VideoInfo.ogg = false;
		VideoInfo.vp9 = false;
		VideoInfo.webm = false;

		function hasContent(value:String):Bool
		{
			return value != null && value.length != 0;
		}

		var videoElement:js.html.VideoElement = cast js.Browser.document.createElement('video');
		var result = js.Syntax.code("!!{0}.canPlayType", videoElement);

		try
		{
			if (result)
			{
				final reg = ~/^no$/;

				var canPlayOggStr = reg.replace(videoElement.canPlayType('video/ogg; codecs="theora"'), '');

				if (hasContent(canPlayOggStr))
				{
					VideoInfo.ogg = true;
				}

				var canPlayMp4Str = reg.replace(videoElement.canPlayType('video/mp4; codecs="avc1.42E01E"'), '');

				if (hasContent(canPlayMp4Str))
				{
					// Without QuickTime, this value will be `undefined`. github.com/Modernizr/Modernizr/issues/546
					VideoInfo.h264 = true;
					VideoInfo.mp4 = true;
				}

				var canPlayWebmStr = reg.replace(videoElement.canPlayType('video/webm; codecs="vp8, vorbis"'), '');

				if (hasContent(canPlayWebmStr))
				{
					VideoInfo.webm = true;
				}

				var canPlayVP9Str = reg.replace(videoElement.canPlayType('video/webm; codecs="vp9"'), '');

				if (hasContent(canPlayVP9Str))
				{
					VideoInfo.vp9 = true;
				}

				var canPlayHLSStr = reg.replace(videoElement.canPlayType('application/x-mpegURL; codecs="avc1.42E01E"'), '');

				if (hasContent(canPlayHLSStr))
				{
					VideoInfo.hls = true;
				}
			}
		}
		catch (e:Dynamic)
		{
			//  Nothing to do
		}

		_isInitialized = true;
	}
}
