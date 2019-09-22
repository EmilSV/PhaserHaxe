package phaserHaxe;

import js.Browser;
import phaserHaxe.display.canvas.CanvasPool;
import js.html.CanvasRenderingContext2D;
import phaserHaxe.create.GenerateTextureConfig;
import phaserHaxe.create.Palettes;
import js.html.CanvasElement as HTMLCanvasElement;

final class Create
{
	private function new() {}

	public static final instance:Create = new Create();

	public static function generateTexture(?config:GenerateTextureConfig):HTMLCanvasElement
	{
		inline function getValue<T>(value:Null<T>, defaultValue:T):T
		{
			return value != null ? value : defaultValue;
		}

		if (config == null)
		{
			config = {};
		}

		var data = getValue(config.data, []);
		var canvas = getValue(config.canvas, null);
		var palette = getValue(config.palette, Palettes.arne16);
		var pixelWidth = getValue(config.pixelWidth, 1);
		var pixelHeight = getValue(config.pixelHeight, pixelWidth);
		var resizeCanvas = getValue(config.resizeCanvas, true);
		var clearCanvas = getValue(config.clearCanvas, true);
		var preRender = getValue(config.preRender, null);
		var postRender = getValue(config.postRender, null);

		var width = Math.floor(Math.abs(data[0].length * pixelWidth));
		var height = Math.floor(Math.abs(data.length * pixelHeight));

		if (canvas == null)
		{
			canvas = CanvasPool.create2D(instance, width, height);
			resizeCanvas = false;
			clearCanvas = false;
		}

		if (resizeCanvas)
		{
			canvas.width = width;
			canvas.height = height;
		}

		var ctx:CanvasRenderingContext2D = canvas.getContext('2d');

		if (clearCanvas)
		{
			ctx.clearRect(0, 0, width, height);
		}

		//  preRender Callback?
		if (preRender != null)
		{
			preRender(canvas, ctx);
		}

		//  Draw it
		for (y in 0...data.length)
		{
			var row:Array<Dynamic> = data[y];

			for (x in 0...row.length)
			{
				var d = row[x];

				if (d != '.' && d != ' ')
				{
					ctx.fillStyle = palette[d];
					ctx.fillRect(x * pixelWidth, y * pixelHeight, pixelWidth, pixelHeight);
				}
			}
		}

		//  postRender Callback?
		if (postRender != null)
		{
			postRender(canvas, ctx);
		}

		return canvas;
	}
}
