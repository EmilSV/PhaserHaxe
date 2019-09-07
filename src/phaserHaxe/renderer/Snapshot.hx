package phaserHaxe.renderer;

import js.Browser;
import phaserHaxe.display.canvas.CanvasPool;
import phaserHaxe.display.Color;
#if js
import js.html.CanvasElement;
import js.html.Image;

typedef SnapShootCallback = (data:Null<Either<Color, Image>>) -> Void;
#else
typedef SnapShootCallback = (data:Dynamic) -> Void;
#end

@:structInit
final class SnapshotState
{
	/**
	 * The function to call after the snapshot is taken.
	 * @since 1.0.0
	**/
	public var callback:SnapShootCallback;

	/**
	 * The format of the image to create, usually `image/png` or `image/jpeg`.
	 * @since 1.0.0
	**/
	public var type:String = "image/png";

	/**
	 * The image quality, between 0 and 1. Used for image formats with lossy compression, such as `image/jpeg`.
	 * @since 1.0.0
	**/
	public var encoder:Float = 0.92;

	/**
	 * The x coordinate to start the snapshot from.
	 * @since 1.0.0
	**/
	public var x:Int = 0;

	/**
	 * The y coordinate to start the snapshot from.
	 * @since 1.0.0
	**/
	public var y:Int = 0;

	/**
	 * The width of the snapshot.
	 * @since 1.0.0
	**/
	public var width:Int = -1;

	/**
	 * The height of the snapshot.
	 * @since 1.0.0
	**/
	public var height:Int = -1;

	/**
	 * Is this a snapshot to get a single pixel, or an area?
	 * @since 1.0.0
	**/
	public var getPixel:Bool = false;

	/**
	 * Is this snapshot grabbing from a frame buffer or a canvas?
	 * @since 1.0.0
	**/
	public var isFramebuffer:Bool = false;

	/**
	 * The width of the frame buffer, if a frame buffer grab.
	 * @since 1.0.0
	**/
	public var bufferWidth:Int = -1;

	/**
	 * The height of the frame buffer, if a frame buffer grab.
	 * @since 1.0.0
	**/
	public var bufferHeight:Int = -1;
}

#if js
final class SnapShoot
{
	public static function canvas(canvas:CanvasElement, config:SnapshotState)
	{
		var callback = config.callback;
		var type = config.type;
		var encoderOptions = config.encoder;

		var x = Std.int(Math.abs(Math.round(config.x)));
		var y = Std.int(Math.abs(Math.round(config.y)));

		var width = config.width >= 0 ? config.width : canvas.width;
		var height = config.height >= 0 ? config.height : canvas.width;
		var getPixel = config.getPixel;

		if (getPixel)
		{
			var context = canvas.getContext('2d');
			var imageData = context.getImageData(x, y, 1, 1);
			var data:Array<Int> = imageData.data;
			callback(new Color(data[0], data[1], data[2], Std.int(data[3] / 255)));
		}
		else if (x != 0 || y != 0 || width != canvas.width || height != canvas.height)
		{
			//  Area Grab
			var copyCanvas = CanvasPool.createWebGL(Browser.window, width, height);
			var ctx = copyCanvas.getContext('2d');

			ctx.drawImage(canvas, x, y, width, height, 0, 0, width, height);

			var image1 = new Image();

			image1.onerror = function()
			{
				callback(null);

				CanvasPool.remove(copyCanvas);
			};

			image1.onload = function()
			{
				callback(image1);

				CanvasPool.remove(copyCanvas);
			};

			image1.src = copyCanvas.toDataURL(type, encoderOptions);
		}
		else
		{
			//  Full Grab
			var image2 = new Image();

			image2.onerror = function()
			{
				callback(null);
			};

			image2.onload = function()
			{
				callback(image2);
			};

			image2.src = canvas.toDataURL(type, encoderOptions);
		}
	}
}
#else
#end
