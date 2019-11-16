package phaserHaxe.device;

/**
 * Determines the input support of the browser running this Phaser Game instance.
 * These values are read-only and populated during the boot sequence of the game.
 * They are then referenced by internal game systems and are available for you to access
 * via `this.sys.game.device.input` from within any Scene.
 *
 * @since 1.0.0
**/
final class InputInfo
{
	#if js
	private static var _isInitialized:Null<Bool>;
	#else
	private static var _isInitialized:Bool;
	#end

	/**
	 * Is navigator.getGamepads available?
	 *
	 * @since 1.0.0
	**/
	public static var gamepads(get, null):Bool;

	/**
	 * Is mspointer available?
	 *
	 * @since 1.0.0
	**/
	public static var mspointer(get, null):Bool;

	/**
	 * Is touch available?
	 *
	 * @since 1.0.0
	**/
	public static var touch(get, null):Bool;

	/**
	 * The newest type of Wheel/Scroll event supported: "wheel", "mousewheel", "DOMMouseScroll"
	 *
	 * @since 1.0.0
	**/
	public static var wheelEvent(get, null):Null<String>;

	private static inline function isNotInitialized()
	{
		#if js
		return js.Syntax.strictNeq(_isInitialized, true);
		#else
		return _isInitialized != true;
		#end
	}

	public static function get_gamepads():Bool
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return gamepads;
	}

	public static function get_mspointer():Bool
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return mspointer;
	}

	public static function get_touch():Bool
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return touch;
	}

	public static function get_wheelEvent():Null<String>
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return wheelEvent;
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
        InputInfo.gamepads = false;
        InputInfo.mspointer = false;
        InputInfo.touch = false;
        InputInfo.wheelEvent = null;

		BrowserInfo.initialize();

		if (js.Syntax.code("'ontouchstart' in document.documentElement || (navigator.maxTouchPoints && navigator.maxTouchPoints >= 1"))
		{
			InputInfo.touch = true;
		}

		if (js.Syntax.code("navigator.msPointerEnabled || navigator.pointerEnabled"))
		{
			InputInfo.mspointer = true;
		}

		if (js.Syntax.code("navigator.getGamepads"))
		{
			InputInfo.gamepads = true;
		}

		// See https://developer.mozilla.org/en-US/docs/Web/Events/wheel
		if (js.Syntax.code("'onwheel' in window") || BrowserInfo.ie && js.Syntax.code(("'WheelEvent' in window")))
		{
			// DOM3 Wheel Event: FF 17+, IE 9+, Chrome 31+, Safari 7+
			InputInfo.wheelEvent = 'wheel';
		}
		else if (js.Syntax.code("'onmousewheel' in window"))
		{
			// Non-FF legacy: IE 6-9, Chrome 1-31, Safari 5-7.
			InputInfo.wheelEvent = 'mousewheel';
		}
		else if (BrowserInfo.firefox && js.Syntax.code("'MouseScrollEvent' in window"))
		{
			// FF prior to 17. This should probably be scrubbed.
			InputInfo.wheelEvent = 'DOMMouseScroll';
		}

		_isInitialized = true;
	}
}
