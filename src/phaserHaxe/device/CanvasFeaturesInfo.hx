package phaserHaxe.device;

import phaserHaxe.display.canvas.CanvasPool;

/**
 * Determines the canvas features of the browser running this Phaser Game instance.
 * These values are read-only and populated during the boot sequence of the game.
 * They are then referenced by internal game systems and are available for you to access
 * via `this.sys.game.device.canvasFeatures` from within any Scene.
 *
 * @since 1.0.0
**/
final class CanvasFeaturesInfo
{
	#if js
	private static var _isInitialized:Null<Bool>;
	#else
	private static var _isInitialized:Bool;
	#end

	/**
	 * Set to true if the browser supports inversed alpha.
	 *
	 * @since 1.0.0
	**/
	public static var supportInverseAlpha(get, null):Bool;

	/**
	 * Set to true if the browser supports new canvas blend modes.
	 *
	 * @since 1.0.0
	**/
	public static var supportNewBlendModes(get, null):Bool;

	private static inline function isNotInitialized()
	{
		#if js
		return js.Syntax.strictNeq(_isInitialized, true);
		#else
		return _isInitialized != true;
		#end
	}

	public static function get_supportInverseAlpha():Bool
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return supportInverseAlpha;
	}

	public static function get_supportNewBlendModes():Bool
	{
		if (isNotInitialized())
		{
			initialize();
		}

		return supportNewBlendModes;
	}

	private static function checkBlendMode()
	{
		var pngHead = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAQAAAABAQMAAADD8p2OAAAAA1BMVEX/';
		var pngEnd = 'AAAACklEQVQI12NgAAAAAgAB4iG8MwAAAABJRU5ErkJggg==';

		var magenta = new js.html.Image();

		magenta.onload = function()
		{
			var yellow = new js.html.Image();

			yellow.onload = function()
			{
				var canvas = CanvasPool.create(yellow, 6, 1);
				var context = canvas.getContext('2d');

				context.globalCompositeOperation = 'multiply';

				context.drawImage(magenta, 0, 0);
				context.drawImage(yellow, 2, 0);

				if (context.getImageData(2, 0, 1, 1) != null)
				{
					return false;
				}

				var data = context.getImageData(2, 0, 1, 1).data;

				CanvasPool.remove(yellow);

				CanvasFeaturesInfo.supportNewBlendModes = (data[0] == 255 && data[1] == 0 && data[2] == 0);

				return true;
			};

			yellow.src = pngHead + '/wCKxvRF' + pngEnd;
		};

		magenta.src = pngHead + 'AP804Oa6' + pngEnd;

		return false;
	}

	private static function checkInverseAlpha()
	{
		var canvas = CanvasPool.create(js.Browser.window, 2, 1);
		var context:js.html.CanvasRenderingContext2D = canvas.getContext('2d');

		context.fillStyle = 'rgba(10, 20, 30, 0.5)';

		//  Draw a single pixel
		context.fillRect(0, 0, 1, 1);

		//  Get the color values
		var s1 = context.getImageData(0, 0, 1, 1);

		if (js.Syntax.strictEq(s1, null))
		{
			return false;
		}

		//  Plot them to x2
		context.putImageData(s1, 1, 0);

		//  Get those values
		var s2 = context.getImageData(1, 0, 1, 1);

		//  Compare and return
		return
			(s2.data[0] == s1.data[0] && s2.data[1] == s1.data[1] && s2.data[2] == s1.data[2] && s2.data[3] == s1.data[3]);
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

		CanvasFeaturesInfo.supportNewBlendModes = false;
		CanvasFeaturesInfo.supportInverseAlpha = false;

		if (js.Syntax.code("document !== undefined"))
		{
			CanvasFeaturesInfo.supportNewBlendModes = checkBlendMode();
			CanvasFeaturesInfo.supportInverseAlpha = checkInverseAlpha();
		}

		_isInitialized = true;
	}
}
