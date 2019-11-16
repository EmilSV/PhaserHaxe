package phaserHaxe.device;

final class BrowserInfo
{
	#if js
	private static var _isInitialized:Null<Bool>;
	#else
	private static var _isInitialized:Bool;
	#end

	public static var chrome(get, null):Bool;
	public static var chromeVersion(get, null):Int;
	public static var edge(get, null):Bool;
	public static var firefox(get, null):Bool;
	public static var firefoxVersion(get, null):Int;
	public static var ie(get, null):Bool;
	public static var ieVersion(get, null):Int;
	public static var mobileSafari(get, null):Bool;
	public static var opera(get, null):Bool;
	public static var safari(get, null):Bool;
	public static var safariVersion(get, null):Int;
	public static var silk(get, null):Bool;
	public static var trident(get, null):Bool;
	public static var tridentVersion(get, null):Int;

	private static inline function isNotInitialized()
	{
		#if js
		return js.Syntax.strictNeq(_isInitialized, true);
		#else
		return _isInitialized != true;
		#end
	}

	private static function get_chrome()
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return chrome;
	}

	private static function get_chromeVersion()
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return chromeVersion;
	}

	private static function get_edge()
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return edge;
	}

	private static function get_firefox()
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return firefox;
	}

	private static function get_firefoxVersion()
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return firefoxVersion;
	}

	private static function get_ie()
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return ie;
	}

	private static function get_ieVersion()
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return ieVersion;
	}

	private static function get_mobileSafari()
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return mobileSafari;
	}

	private static function get_opera()
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return opera;
	}

	private static function get_safari()
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return safari;
	}

	private static function get_safariVersion()
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return safariVersion;
	}

	private static function get_silk()
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return silk;
	}

	private static function get_trident()
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return trident;
	}

	private static function get_tridentVersion()
	{
		if (isNotInitialized())
		{
			initialize();
		}
		return tridentVersion;
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

		BrowserInfo.chrome = false;
		BrowserInfo.chromeVersion = 0;
		BrowserInfo.edge = false;
		BrowserInfo.firefox = false;
		BrowserInfo.firefoxVersion = 0;
		BrowserInfo.ie = false;
		BrowserInfo.ieVersion = 0;
		BrowserInfo.mobileSafari = false;
		BrowserInfo.opera = false;
		BrowserInfo.safari = false;
		BrowserInfo.safariVersion = 0;
		BrowserInfo.silk = false;
		BrowserInfo.trident = false;
		BrowserInfo.tridentVersion = 0;

		function parseInt(value:String):Int
		{
			var output = Std.parseInt(value);
			return output != null ? output : -1;
		}

		var ua = js.Browser.navigator.userAgent;

		var regex:EReg = null;

		if (~/Edge\/\d+/.match(ua))
		{
			BrowserInfo.edge = true;
		}
		else if ((regex = (~/Chrome\/(\d+)/)).match(ua) && !OSInfo.windowsPhone)
		{
			BrowserInfo.chrome = true;
			BrowserInfo.chromeVersion = parseInt(regex.matched(1));
		}
		else if ((regex = ~/Firefox\D+(\d+)/).match(ua))
		{
			BrowserInfo.firefox = true;
			BrowserInfo.firefoxVersion = parseInt(regex.matched(1));
		}
		else if ((regex = ~/AppleWebKit/).match(ua) && OSInfo.iOS)
		{
			BrowserInfo.mobileSafari = true;
		}
		else if ((regex = ~/MSIE (\d+\.\d+);/).match(ua))
		{
			BrowserInfo.ie = true;
			BrowserInfo.ieVersion = parseInt(regex.matched(1));
		}
		else if ((regex = ~/Opera/).match(ua))
		{
			BrowserInfo.opera = true;
		}
		else if ((regex = ~/Safari/).match(ua))
		{
			BrowserInfo.safari = true;
		}
		else if ((regex = ~/Trident\/(\d+\.\d+)(.*)rv:(\d+\.\d+)/).match(ua))
		{
			BrowserInfo.ie = true;
			BrowserInfo.trident = true;
			BrowserInfo.tridentVersion = parseInt(regex.matched(1));
			BrowserInfo.ieVersion = parseInt(regex.matched(3));
		}

		//  Silk gets its own if clause because its ua also contains 'Safari'
		if ((~/Silk/).match(ua))
		{
			BrowserInfo.silk = true;
		}

		_isInitialized = true;
	}
}
