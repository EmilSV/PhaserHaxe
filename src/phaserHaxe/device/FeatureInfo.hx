package phaserHaxe.device;

import js.Browser;
import phaserHaxe.display.canvas.CanvasPool;

final class FeatureInfo
{
	#if js
	private static var _isInitialized:Null<Bool>;
	#else
	private static var _isInitialized:Bool;
	#end

	public static var canvas(get, null):Bool;
	public static var canvasBitBltShift(default, null):Null<Bool>;
	public static var file(default, null):Bool;
	public static var fileSystem(default, null):Bool;
	public static var getUserMedia(default, null):Bool;
	public static var littleEndian(default, null):Null<Bool>;
	public static var localStorage(default, null):Bool;
	public static var pointerLock(default, null):Bool;
	public static var support32bit(default, null):Bool;
	public static var vibration(default, null):Bool;
	public static var webGL(default, null):Bool;
	public static var worker(default, null):Bool;

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

	private static function initialize():Void
	{
		FeatureInfo.canvas = js.Syntax.code("!!window['CanvasRenderingContext2D']");
		try
		{
			FeatureInfo.localStorage = js.Syntax.code("!!localStorage.getItem");
		}
		catch (error:Dynamic)
		{
			FeatureInfo.localStorage = false;
		}

		FeatureInfo.file = js.Syntax.code("!!window['File'] && !!window['FileReader'] && !!window['FileList'] && !!window['Blob']");
		FeatureInfo.fileSystem = js.Syntax.code("!!window['requestFileSystem']");

		var isUint8:Bool;
		function testWebGL()
		{
			if (js.Syntax.code("window['WebGLRenderingContext']"))
			{
				try
				{
					var canvas = CanvasPool.createWebGL(Browser.window);
					var ctx = js.Syntax.code("{0}.getContext('webgl') || {0}.getContext('experimental-webgl')", canvas);
					var canvas2D = CanvasPool.create2D(Browser.window);
					var ctx2D = canvas2D.getContext('2d');
					//  Can't be done on a webgl context
					var image = ctx2D.createImageData(1, 1);
					//  Test to see if ImageData uses CanvasPixelArray or Uint8ClampedArray.
					//  @author Matt DesLauriers (@mattdesl)
					isUint8 = js.Syntax.instanceof(image.data, js.lib.Uint8ClampedArray);
					CanvasPool.remove(canvas);
					CanvasPool.remove(canvas2D);
					return js.Syntax.code("!!{0}", 0);
				}
				catch (e:Dynamic)
				{
					return false;
				}
			}
			return false;
		}

		FeatureInfo.webGL = testWebGL();

		FeatureInfo.worker = js.Syntax.code("!!window['Worker']");

		FeatureInfo.pointerLock = js.Syntax.code("'pointerLockElement' in document || 'mozPointerLockElement' in document || 'webkitPointerLockElement' in document");

		js.Syntax.code("navigator.getUserMedia = navigator.getUserMedia || navigator.webkitGetUserMedia || navigator.mozGetUserMedia || navigator.msGetUserMedia || navigator.oGetUserMedia");
		js.Syntax.code("window.URL = window.URL || window.webkitURL || window.mozURL || window.msURL");
		FeatureInfo.getUserMedia = js.Syntax.code("{0}.getUserMedia && !!navigator.getUserMedia && !!window.URL", Features);
	}
}
