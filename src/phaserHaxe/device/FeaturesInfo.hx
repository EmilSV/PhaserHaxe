package phaserHaxe.device;

import phaserHaxe.display.canvas.CanvasPool;

/**
 * Determines the features of the browser running this Phaser Game instance.
 * These values are read-only and populated during the boot sequence of the game.
 * They are then referenced by internal game systems and are available for you to access
 * via `this.sys.game.device.features` from within any Scene.
 *
 * @since 1.0.0
**/
final class FeaturesInfo
{
	#if js
	private static var _isInitialized:Null<Bool>;
	#else
	private static var _isInitialized:Bool;
	#end

	/**
	 * True if canvas supports a 'copy' bitblt onto itself when the source and destination regions overlap.
	 *
	 * @since 1.0.0
	**/
	public static var canvasBitBltShift(get, null):Null<Bool>;

	/**
	 * Is canvas available?
	 *
	 * @since 1.0.0
	**/
	public static var canvas(get, null):Bool;

	/**
	 * Is file available?
	 *
	 * @since 1.0.0
	**/
	public static var file(get, null):Bool;

	/**
	 * Is fileSystem available?
	 *
	 * @since 1.0.0
	**/
	public static var fileSystem(get, null):Bool;

	/**
	 * Does the device support the getUserMedia API?
	 *
	 * @since 1.0.0
	**/
	public static var getUserMedia(get, null):Bool;

	/**
	 * Is the device big or little endian? (only detected if the browser supports TypedArrays)
	 *
	 * @since 1.0.0
	**/
	public static var littleEndian(get, null):Null<Bool>;

	/**
	 * Is localStorage available?
	 *
	 * @since 1.0.0
	**/
	public static var localStorage(get, null):Bool;

	/**
	 * Is Pointer Lock available?
	 *
	 * @since 1.0.0
	**/
	public static var pointerLock(get, null):Bool;

	/**
	 * Does the device context support 32bit pixel manipulation using array buffer views?
	 *
	 * @since 1.0.0
	**/
	public static var support32bit(get, null):Bool;

	/**
	 * Does the device support the Vibration API?
	 *
	 * @since 1.0.0
	**/
	public static var vibration(get, null):Bool;

	/**
	 * Is webGL available?
	 *
	 * @since 1.0.0
	**/
	public static var webGL(get, null):Bool;

	/**
	 * Is worker available?
	 *
	 * @since 1.0.0
	**/
	public static var worker(get, null):Bool;

	private static inline function isNotInitialized()
	{
		#if js
		return js.Syntax.strictNeq(_isInitialized, true);
		#else
		return _isInitialized != true;
		#end
	}

	private static function get_canvas()
	{
		if (isNotInitialized())
		{
			initialize();
		}
		return canvas;
	}

	private static function get_canvasBitBltShift()
	{
		if (isNotInitialized())
		{
			initialize();
		}
		return canvasBitBltShift;
	}

	private static function get_file()
	{
		if (isNotInitialized())
		{
			initialize();
		}
		return file;
	}

	private static function get_fileSystem()
	{
		if (isNotInitialized())
		{
			initialize();
		}
		return fileSystem;
	}

	private static function get_getUserMedia()
	{
		if (isNotInitialized())
		{
			initialize();
		}
		return getUserMedia;
	}

	private static function get_littleEndian()
	{
		if (isNotInitialized())
		{
			initialize();
		}
		return littleEndian;
	}

	private static function get_localStorage()
	{
		if (isNotInitialized())
		{
			initialize();
		}
		return localStorage;
	}

	private static function get_pointerLock()
	{
		if (isNotInitialized())
		{
			initialize();
		}
		return pointerLock;
	}

	private static function get_support32bit()
	{
		if (isNotInitialized())
		{
			initialize();
		}
		return support32bit;
	}

	private static function get_vibration()
	{
		if (isNotInitialized())
		{
			initialize();
		}
		return vibration;
	}

	private static function get_webGL()
	{
		if (isNotInitialized())
		{
			initialize();
		}
		return webGL;
	}

	private static function get_worker()
	{
		if (isNotInitialized())
		{
			initialize();
		}
		return worker;
	}

	@:allow(phaserHaxe)
	private static function initialize():Void
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

		// default values
		FeaturesInfo.canvas = false;
		FeaturesInfo.canvasBitBltShift = null;
		FeaturesInfo.file = false;
		FeaturesInfo.fileSystem = false;
		FeaturesInfo.getUserMedia = true;
		FeaturesInfo.littleEndian = false;
		FeaturesInfo.localStorage = false;
		FeaturesInfo.pointerLock = false;
		FeaturesInfo.support32bit = false;
		FeaturesInfo.vibration = false;
		FeaturesInfo.webGL = false;
		FeaturesInfo.worker = false;

		// Check Little or Big Endian system.
		// @author Matt DesLauriers (@mattdesl)
		function checkIsLittleEndian()
		{
			var a = new js.lib.ArrayBuffer(4);
			var b = new js.lib.Uint8Array(a);
			var c = new js.lib.Uint32Array(a);

			b[0] = 0xa1;
			b[1] = 0xb2;
			b[2] = 0xc3;
			b[3] = 0xd4;

			if (c[0] == 0xd4c3b2a1)
			{
				return true;
			}

			if (c[0] == 0xa1b2c3d4)
			{
				return false;
			}
			else
			{
				//  Could not determine endianness
				return null;
			}
		}

		inline function isDefined(classType:Class<Dynamic>):Bool
		{
			return js.Syntax.strictNeq(js.Syntax.typeof(classType), "undefined");
		}

		BrowserInfo.initialize();

		FeaturesInfo.canvas = js.Syntax.code("!!window['CanvasRenderingContext2D']");
		try
		{
			FeaturesInfo.localStorage = js.Syntax.code("!!localStorage.getItem");
		}
		catch (error:Dynamic)
		{
			FeaturesInfo.localStorage = false;
		}

		FeaturesInfo.file = js.Syntax.code("!!window['File'] && !!window['FileReader'] && !!window['FileList'] && !!window['Blob']");
		FeaturesInfo.fileSystem = js.Syntax.code("!!window['requestFileSystem']");

		var isUint8:Bool;
		function testWebGL()
		{
			if (js.Syntax.code("window['WebGLRenderingContext']"))
			{
				try
				{
					var canvas = CanvasPool.createWebGL(js.Browser.window);
					var ctx = js.Syntax.code("{0}.getContext('webgl') || {0}.getContext('experimental-webgl')", canvas);
					var canvas2D = CanvasPool.create2D(js.Browser.window);
					var ctx2D:js.html.CanvasRenderingContext2D = canvas2D.getContext('2d');
					//  Can't be done on a webgl context
					var image = ctx2D.createImageData(1, 1);
					//  Test to see if ImageData uses CanvasPixelArray or Uint8ClampedArray.
					//  @author Matt DesLauriers (@mattdesl)
					isUint8 = js.Syntax.instanceof(image.data, js.lib.Uint8ClampedArray);
					CanvasPool.remove(canvas);
					CanvasPool.remove(canvas2D);
					return js.Syntax.code("!!{0}", ctx);
				}
				catch (e:Dynamic)
				{
					return false;
				}
			}
			return false;
		}

		FeaturesInfo.webGL = testWebGL();

		FeaturesInfo.worker = js.Syntax.code("!!window['Worker']");

		FeaturesInfo.pointerLock = js.Syntax.code("'pointerLockElement' in document || 'mozPointerLockElement' in document || 'webkitPointerLockElement' in document");

		(cast js.Browser.window.navigator)
			.getUserMedia = js.Syntax.code("navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia || navigator.oGetUserMedia");

		(cast js.Browser.window)
			.URL = js.Syntax.code("window.URL = window.URL || window.webkitURL || window.mozURL || window.msURL");

		FeaturesInfo.getUserMedia = js.Syntax.code("{0}.getUserMedia && !!navigator.getUserMedia && !!window.URL", FeaturesInfo);

		// Older versions of firefox (< 21) apparently claim support but user media does not actually work
		if (BrowserInfo.firefox && BrowserInfo.firefoxVersion < 21)
		{
			FeaturesInfo.getUserMedia = false;
		}

		// Excludes iOS versions as they generally wrap UIWebView (eg. Safari WebKit) and it
		// is safer to not try and use the fast copy-over method.
		if (!OSInfo.iOS && (BrowserInfo.ie || BrowserInfo.firefox || BrowserInfo.chrome))
		{
			FeaturesInfo.canvasBitBltShift = true;
		}

		// Known not to work
		if (BrowserInfo.safari || BrowserInfo.mobileSafari)
		{
			FeaturesInfo.canvasBitBltShift = false;
		}

			(cast js.Browser.window.navigator)
				.vibrate = js.Syntax.code("navigator.vibrate || navigator.webkitVibrate || navigator.mozVibrate || navigator.msVibrate");

		if ((cast js.Browser.window.navigator).vibrate)
		{
			FeaturesInfo.vibration = true;
		}

		if (isDefined(js.lib.ArrayBuffer) && isDefined(js.lib.Uint8Array) && isDefined(js.lib.Uint32Array))
		{
			FeaturesInfo.littleEndian = checkIsLittleEndian();
		}

		FeaturesInfo.support32bit = (isDefined(js.lib.ArrayBuffer)
			&& isDefined(js.lib.Uint8ClampedArray)
			&& isDefined(js.lib.Int32Array)
			&& js.Syntax.strictNeq(FeaturesInfo.littleEndian, null)
			&& isUint8);

		_isInitialized = true;
	}
}
