package phaserHaxe.device;

/**
 * Determines the full screen support of the browser running this Phaser Game instance.
 * These values are read-only and populated during the boot sequence of the game.
 * They are then referenced by internal game systems and are available for you to access
 * via `this.sys.game.device.fullscreen` from within any Scene.
 *
 * @since 1.0.0
**/
final class FullscreenInfo
{
	#if js
	private static var _isInitialized:Null<Bool>;
	#else
	private static var _isInitialized:Bool;
	#end

	/**
	 * Does the browser support the Full Screen API?
	 *
	 * @since 1.0.0
	**/
	public static var available(get, null):Bool;

	/**
	 * Does the browser support access to the Keyboard during Full Screen mode?
	 *
	 * @since 1.0.0
	**/
	public static var keyboard(get, null):Bool;

	/** If the browser supports the Full Screen API this holds the call you need to use to cancel it.
	 *
	 * @since 1.0.0
	**/
	public static var cancel(get, null):String;

	/**
	 * If the browser supports the Full Screen API this holds the call you need to use to activate it.
	 *
	 * @since 1.0.0
	**/
	public static var request(get, null):String;

	private static inline function isNotInitialized()
	{
		#if js
		return js.Syntax.strictNeq(_isInitialized, true);
		#else
		return _isInitialized != true;
		#end
	}

	private static function get_available():Bool
	{
		if (isNotInitialized())
		{
			initialize();
		}
		return available;
	}

	public static function get_cancel():String
	{
		if (isNotInitialized())
		{
			initialize();
		}
		return cancel;
	}

	public static function get_keyboard():Bool
	{
		if (isNotInitialized())
		{
			initialize();
		}
		return keyboard;
	}

	public static function get_request():String
	{
		if (isNotInitialized())
		{
			initialize();
		}
		return request;
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

		FullscreenInfo.available = false;
		FullscreenInfo.cancel = '';
		FullscreenInfo.keyboard = false;
		FullscreenInfo.request = '';

		var suffix1 = 'Fullscreen';
		var suffix2 = 'FullScreen';

		var fs = [
			'request' + suffix1,
			'request' + suffix2,
			'webkitRequest' + suffix1,
			'webkitRequest' + suffix2,
			'msRequest' + suffix1,
			'msRequest' + suffix2,
			'mozRequest' + suffix2,
			'mozRequest' + suffix1
		];

		for (i in 0...fs.length)
		{
			if (js.Syntax.field(js.Browser.document.documentElement, fs[i]))
			{
				FullscreenInfo.available = true;
				FullscreenInfo.request = fs[i];
				break;
			}
		}

		var cfs = [
			'cancel' + suffix2,
			'exit' + suffix1,
			'webkitCancel' + suffix2,
			'webkitExit' + suffix1,
			'msCancel' + suffix2,
			'msExit' + suffix1,
			'mozCancel' + suffix2,
			'mozExit' + suffix1
		];

		if (FullscreenInfo.available)
		{
			for (i in 0...cfs.length)
			{
				if (js.Syntax.field(js.Browser.document, cfs[i]))
				{
					FullscreenInfo.cancel = cfs[i];
					break;
				}
			}
		}

		//  Keyboard Input?
		//  Safari 5.1 says it supports fullscreen keyboard, but is lying.
		if (js.Syntax.field(js.Browser.window, "Element")
			&& js.Syntax.field(js.Browser.window, "ALLOW_KEYBOARD_INPUT")
			&& !((~/ Version\/5\.1(?:\.\d+)? Safari\//)
				.match(js.Browser.navigator.userAgent)))
		{
			FullscreenInfo.keyboard = true;
		}

        _isInitialized = true;
	}
}
