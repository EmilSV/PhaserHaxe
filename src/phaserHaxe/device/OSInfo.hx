package phaserHaxe.device;

/**
 * Determines the operating system of the device running this Phaser Game instance.
 * These values are read-only and populated during the boot sequence of the game.
 * They are then referenced by internal game systems and are available for you to access
 * via `this.sys.game.device.os` from within any Scene.
 *
 * @since 1.0.0
**/
final class OSInfo
{
	#if js
	private static var _isInitialized:Null<Bool>;
	#else
	private static var _isInitialized:Bool;
	#end

	/**
	 * Is running on android?
	 *
	 * @since 1.0.0
	**/
	public static var android(get, null):Bool;

	/**
	 * Is running on chromeOS?
	 *
	 * @since 1.0.0
	**/
	public static var chromeOS(get, null):Bool;

	/**
	 * Is the game running under Apache Cordova?
	 *
	 * @since 1.0.0
	**/
	public static var cordova(get, null):Bool;

	/**
	 * Is the game running under the Intel Crosswalk XDK?
	 *
	 * @since 1.0.0
	**/
	public static var crosswalk(get, null):Bool;

	/**
	 * Is running on a desktop?
	 *
	 * @since 1.0.0
	**/
	public static var desktop(get, null):Bool;

	/**
	 * Is the game running under Ejecta?
	 *
	 * @since 1.0.0
	**/
	public static var ejecta(get, null):Bool;

	/**
	 * Is the game running under GitHub Electron?
	 *
	 * @since 1.0.0
	**/
	public static var electron(get, null):Bool;

	/**
	 * Is running on iOS?
	 *
	 * @since 1.0.0
	**/
	public static var iOS(get, null):Bool;

	/**
	 * If running in iOS this will contain the major version number.
	 *
	 * @since 1.0.0
	**/
	public static var iOSVersion(get, null):Int;

	/**
	 * Is running on iPad?
	 *
	 * @since 1.0.0
	**/
	public static var iPad(get, null):Bool;

	/**
	 * Is running on iPhone?
	 *
	 * @since 1.0.0
	**/
	public static var iPhone(get, null):Bool;

	/**
	 * Is running on an Amazon Kindle?
	 *
	 * @since 1.0.0
	**/
	public static var kindle(get, null):Bool;

	/**
	 * Is running on linux?
	 *
	 * @since 1.0.0
	**/
	public static var linux(get, null):Bool;

	/**
	 * Is running on macOS?
	 *
	 * @since 1.0.0
	**/
	public static var macOS(get, null):Bool;

	/**
	 * Is the game running under Node.js?
	 *
	 * @since 1.0.0
	**/
	public static var node(get, null):Bool;

	/**
	 * Is the game running under Node-Webkit?
	 *
	 * @since 1.0.0
	**/
	public static var nodeWebkit(get, null):Bool;

	/**
	 * PixelRatio of the host device?
	 *
	 * @since 1.0.0
	**/
	public static var pixelRatio(get, null):Int;

	/**
	 * Set to true if running as a WebApp, i.e. within a WebView
	 *
	 * @since 1.0.0
	**/
	public static var webApp(get, null):Bool;

	/**
	 * Is running on windows?
	 *
	 * @since 1.0.0
	**/
	public static var windows(get, null):Bool;

	/**
	 * Is running on a Windows Phone?
	 *
	 * @since 1.0.0
	**/
	public static var windowsPhone(get, null):Bool;

	private static inline function isNotInitialized()
	{
		#if js
		return js.Syntax.strictNeq(_isInitialized, true);
		#else
		return _isInitialized != true;
		#end
	}

	private static function get_android()
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return android;
	}

	private static function get_chromeOS()
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return chromeOS;
	}

	private static function get_cordova()
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return cordova;
	}

	private static function get_crosswalk()
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return crosswalk;
	}

	private static function get_desktop()
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return desktop;
	}

	private static function get_ejecta()
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return ejecta;
	}

	private static function get_electron()
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return electron;
	}

	private static function get_iOS()
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return iOS;
	}

	private static function get_iOSVersion()
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return iOSVersion;
	}

	private static function get_iPad()
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return iPad;
	}

	private static function get_iPhone()
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return iPhone;
	}

	private static function get_kindle()
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return kindle;
	}

	private static function get_linux()
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return linux;
	}

	private static function get_macOS()
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return macOS;
	}

	private static function get_node()
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return node;
	}

	private static function get_nodeWebkit()
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return nodeWebkit;
	}

	private static function get_pixelRatio()
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return pixelRatio;
	}

	private static function get_webApp()
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return webApp;
	}

	private static function get_windows()
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return windows;
	}

	private static function get_windowsPhone()
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return windowsPhone;
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
		OSInfo.android = false;
		OSInfo.chromeOS = false;
		OSInfo.cordova = false;
		OSInfo.crosswalk = false;
		OSInfo.desktop = false;
		OSInfo.ejecta = false;
		OSInfo.electron = false;
		OSInfo.iOS = false;
		OSInfo.iOSVersion = 0;
		OSInfo.iPad = false;
		OSInfo.iPhone = false;
		OSInfo.kindle = false;
		OSInfo.linux = false;
		OSInfo.macOS = false;
		OSInfo.node = false;
		OSInfo.nodeWebkit = false;
		OSInfo.pixelRatio = 1;
		OSInfo.webApp = false;
		OSInfo.windows = false;
		OSInfo.windowsPhone = false;

		function parseInt(value:String):Int
		{
			var output = Std.parseInt(value);
			return output != null ? output : -1;
		}

		var ua = js.Browser.navigator.userAgent;

		if ((~/Windows/).match(ua))
		{
			OSInfo.windows = true;
		}
		else if ((~/Mac OS/).match(ua) && !(~/like Mac OS/).match(ua))
		{
			OSInfo.macOS = true;
		}
		else if ((~/Android/).match(ua))
		{
			OSInfo.android = true;
		}
		else if ((~/Linux/).match(ua))
		{
			OSInfo.linux = true;
		}
		else if ((~/iP[ao]d|iPhone/i).match(ua))
		{
			OSInfo.iOS = true;

			var regex = (~/OS (\d+)/);

			regex.match(js.Browser.navigator.appVersion);

			OSInfo.iOSVersion = parseInt(regex.matched(1));

			OSInfo.iPhone = ua.toLowerCase().indexOf('iphone') != -1;
			OSInfo.iPad = ua.toLowerCase().indexOf('ipad') != -1;
		}
		else
			if ((~/Kindle/).match(ua) || (~/\bKF[A-Z][A-Z]+/).match(ua) || (~/Silk.*Mobile Safari/).match(ua))
		{
			OSInfo.kindle = true;

			// This will NOT detect early generations of Kindle Fire, I think there is no reliable way...
			// E.g. "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_6_3; en-us; Silk/1.1.0-80) AppleWebKit/533.16 (KHTML, like Gecko) Version/5.0 Safari/533.16 Silk-Accelerated=true"
		}
		else if ((~/CrOS/).match(ua))
		{
			OSInfo.chromeOS = true;
		}

		if ((~/Windows Phone/i).match(ua) || (~/IEMobile/i).match(ua))
		{
			OSInfo.android = false;
			OSInfo.iOS = false;
			OSInfo.macOS = false;
			OSInfo.windows = true;
			OSInfo.windowsPhone = true;
		}

		var silk = (~/Silk/).match(ua);

		if (OSInfo.windows || OSInfo.macOS || (OSInfo.linux && !silk) || OSInfo.chromeOS)
		{
			OSInfo.desktop = true;
		}

		//  Windows Phone / Table reset
		if (OSInfo.windowsPhone || (~/Windows NT/i).match(ua) && (~/Touch/i).match(ua))
		{
			OSInfo.desktop = false;
		}

		//  WebApp mode in iOS
		if (js.Syntax.code("navigator.standalone"))
		{
			OSInfo.webApp = true;
		}

		if (js.Syntax.code("window.cordova !== undefined"))
		{
			OSInfo.cordova = true;
		}

		if (js.Syntax.code("typeof process !== 'undefined' && process.versions && process.versions.node"))
		{
			OSInfo.node = true;
		}

		if (OSInfo.node && js.Syntax.code("typeof process.versions === 'object'"))
		{
			OSInfo.nodeWebkit = js.Syntax.code("!!process.versions['node-webkit']");

			OSInfo.electron = js.Syntax.code("!!process.versions.electron");
		}

		if (js.Syntax.code("window.ejecta !== undefined"))
		{
			OSInfo.ejecta = true;
		}

		if ((~/Crosswalk/).match(ua))
		{
			OSInfo.crosswalk = true;
		}

		OSInfo.pixelRatio = js.Syntax.code("window['devicePixelRatio'] || 1");

		_isInitialized = true;
	}
}
