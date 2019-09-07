package phaserHaxe.device;

#if js
import js.Browser;
import phaserHaxe.display.canvas.CanvasPool;
import js.html.Image;
import js.Syntax as JsSyntax;

final class CanvasFeatures
{
	public static var supportInverseAlpha(default, null):Bool = false;
	public static var supportNewBlendModes(default, null):Bool = false;

	private static var _ =
		{
			if (Browser.window.document != null)
			{
				CanvasFeatures.supportNewBlendModes = checkBlendMode();
				CanvasFeatures.supportInverseAlpha = checkInverseAlpha();
			}

			null;
		}

	private static function checkBlendMode()
	{
		var pngHead = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAQAAAABAQMAAADD8p2OAAAAA1BMVEX/';
		var pngEnd = 'AAAACklEQVQI12NgAAAAAgAB4iG8MwAAAABJRU5ErkJggg==';

		var magenta = new Image();

		magenta.onload = function()
		{
			var yellow = new Image();

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

				CanvasFeatures.supportNewBlendModes = (data[0] == 255 && data[1] == 0 && data[2] == 0);

				return true;
			};

			yellow.src = pngHead + '/wCKxvRF' + pngEnd;
		};

		magenta.src = pngHead + 'AP804Oa6' + pngEnd;

		return false;
	}

	private static function checkInverseAlpha()
	{
		var canvas = CanvasPool.create(Browser.window, 2, 1);
		var context = canvas.getContext('2d');

		context.fillStyle = 'rgba(10, 20, 30, 0.5)';

		//  Draw a single pixel
		context.fillRect(0, 0, 1, 1);

		//  Get the color values
		var s1 = context.getImageData(0, 0, 1, 1);

		if (JsSyntax.strictEq(s1, null))
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
}
#else
final class CanvasFeatures
{
	public inline static var supportInverseAlpha = false;
	public inline static var supportNewBlendModes = false;
}
#end
