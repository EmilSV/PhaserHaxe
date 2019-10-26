package phaserHaxe.textures;

import haxe.io.Bytes;
import js.lib.ArrayBuffer;
import haxe.io.UInt32Array;
import phaserHaxe.compatibility.UInt8ClampedArray;
import haxe.io.UInt8Array;
import phaserHaxe.display.Color;
import js.html.CanvasRenderingContext2D as HTMLCanvasRenderingContext2D;
import phaserHaxe.utils.types.StringOrInt;
import js.html.CanvasElement as HTMLCanvasElement;
import js.html.ImageElement as HTMLImageElement;
import js.html.ImageData as HTMLImageData;
import phaserHaxe.textures.Texture;
import haxe.io.ArrayBufferView;
import phaserHaxe.utils.types.Union;

/**
 * A Canvas Texture is a special kind of Texture that is backed by an HTML Canvas Element as its source.
 *
 * You can use the properties of this texture to draw to the canvas element directly, using all of the standard
 * canvas operations available in the browser. Any Game Object can be given this texture and will render with it.
 *
 * Note: When running under WebGL the Canvas Texture needs to re-generate its base WebGLTexture and reupload it to
 * the GPU every time you modify it, otherwise the changes you make to this texture will not be visible. To do this
 * you should call `CanvasTexture.refresh()` once you are finished with your changes to the canvas. Try and keep
 * this to a minimum, especially on large canvas sizes, or you may inadvertently thrash the GPU by constantly uploading
 * texture data to it. This restriction does not apply if using the Canvas Renderer.
 *
 * It starts with only one frame that covers the whole of the canvas. You can add further frames, that specify
 * sections of the canvas using the `add` method.
 *
 * Should you need to resize the canvas use the `setSize` method so that it accurately updates all of the underlying
 * texture data as well. Forgetting to do this (i.e. by changing the canvas size directly from your code) could cause
 * graphical errors.
 *
 * @since 1.0.0
 *
**/
class CanvasTexture extends Texture
{
	/**
	 * A reference to the Texture Source of this Canvas.
	 *
	 * @since 1.0.0
	**/
	private var _source:TextureSource;

	/**
	 * The source Canvas Element.
	 *
	 * @since 1.0.0
	**/
	public var canvas(default, null):HTMLCanvasElement;

	/**
	 * The 2D Canvas Rendering Context.
	 *
	 * @since 1.0.0
	**/
	public var context(default, null):HTMLCanvasRenderingContext2D;

	/**
	 * The width of the Canvas.
	 * This property is read-only, if you wish to change it use the `setSize` method.
	 *
	 * @since 1.0.0
	**/
	public var width(default, null):Int;

	/**
	 * The height of the Canvas.
	 * This property is read-only, if you wish to change it use the `setSize` method.
	 *
	 * @since 1.0.0
	**/
	public var height(default, null):Int;

	/**
	 * The context image data.
	 * Use the `update` method to populate this when the canvas changes.
	 *
	 * @since 1.0.0
	**/
	public var imageData:HTMLImageData;

	/**
	 * A Uint8ClampedArray view into the `buffer`.
	 * Use the `update` method to populate this when the canvas changes.
	 * Note that this is unavailable in some browsers, such as Epic Browser, due to their security restrictions.
	 *
	 * @since 1.0.0
	**/
	public var data:UInt8ClampedArray = null;

	/**
	 * An Uint32Array view into the `buffer`.
	 *
	 * @since 1.0.0
	**/
	public var pixels:UInt32Array = null;

	/**
	 * An buffer the same size as the context ImageData.
	 *
	 * @since 1.0.0
	**/
	public var buffer:Bytes = null;

	/**
	 * @param manager - A reference to the Texture Manager this Texture belongs to.
	 * @param key - The unique string-based key of this Texture.
	 * @param source - The canvas element that is used as the base of this texture.
	 * @param width - The width of the canvas.
	 * @param height - The height of the canvas.
	**/
	public function new(manager:TextureManager, key:String, source:HTMLCanvasElement,
			width:Int, height:Int)
	{
		super(manager, key, source, width, height);
		throw new Error("Not Implemented");
	}

	/**
	 * This re-creates the `imageData` from the current context.
	 * It then re-builds the ArrayBuffer, the `data` Uint8ClampedArray reference and the `pixels` Int32Array.
	 *
	 * Warning: This is a very expensive operation, so use it sparingly.
	 *
	 * @since 1.0.0
	 *
	 * @return This CanvasTexture.
	**/
	public function update():CanvasTexture
	{
		throw new Error("Not Implemented");
	}

	/**
	 * Draws the given Image or Canvas element to this CanvasTexture, then updates the internal
	 * ImageData buffer and arrays.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The x coordinate to draw the source at.
	 * @param y - The y coordinate to draw the source at.
	 * @param source - The element to draw to this canvas.
	 *
	 * @return This CanvasTexture.
	**/
	public function draw(x:Int, y:Int,
			source:Union<HTMLImageElement, HTMLCanvasElement>)
	{
		throw new Error("Not Implemented");
	}

	/**
	 * Draws the given texture frame to this CanvasTexture, then updates the internal
	 * ImageData buffer and arrays.
	 *
	 * @since 1.0.0
	 *
	 * @param key - The unique string-based key of the Texture.
	 * @param frame - The string-based name, or integer based index, of the Frame to get from the Texture.
	 * @param x - The x coordinate to draw the source at.
	 * @param y - The y coordinate to draw the source at.
	 *
	 * @return This CanvasTexture.
	**/
	public function drawFrame(key:String, frame:StringOrInt, x:Int = 0, y:Int = 0)
	{
		throw new Error("Not Implemented");
	}

	/**
	 * Sets a pixel in the CanvasTexture to the given color and alpha values.
	 *
	 * This is an expensive operation to run in large quantities, so use sparingly.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The x coordinate of the pixel to get. Must lay within the dimensions of this CanvasTexture and be an integer.
	 * @param y - The y coordinate of the pixel to get. Must lay within the dimensions of this CanvasTexture and be an integer.
	 * @param red - The red color value. A number between 0 and 255.
	 * @param green - The green color value. A number between 0 and 255.
	 * @param blue - The blue color value. A number between 0 and 255.
	 * @param alpha - The alpha value. A number between 0 and 255.
	 *
	 * @return This CanvasTexture.
	**/
	public function setPixel(x:Int, y:Int, red:Int, green:Int, blue:Int,
			alpha:Int = 255):CanvasTexture
	{
		throw new Error("Not Implemented");
	}

	/**
	 * Puts the ImageData into the context of this CanvasTexture at the given coordinates.
	 *
	 * @since 1.0.0
	 *
	 * @param imageData - The ImageData to put at the given location.
	 * @param x - The x coordinate to put the imageData. Must lay within the dimensions of this CanvasTexture and be an integer.
	 * @param y - The y coordinate to put the imageData. Must lay within the dimensions of this CanvasTexture and be an integer.
	 * @param dirtyX - Horizontal position (x coordinate) of the top-left corner from which the image data will be extracted.
	 * @param dirtyY - Vertical position (x coordinate) of the top-left corner from which the image data will be extracted.
	 * @param dirtyWidth - Width of the rectangle to be painted. Defaults to the width of the image data.
	 * @param dirtyHeight - Height of the rectangle to be painted. Defaults to the height of the image data.
	 *
	 * @return This CanvasTexture.
	**/
	public function putData(imageData:HTMLImageData, x:Int, y:Int, dirtyX:Int,
			dirtyY:Int, dirtyWidth:Int, dirtyHeight:Int)
	{
		throw new Error("Not Implemented");
	}

	/**
	 * Gets an ImageData region from this CanvasTexture from the position and size specified.
	 * You can write this back using `CanvasTexture.putData`, or manipulate it.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The x coordinate of the top-left of the area to get the ImageData from. Must lay within the dimensions of this CanvasTexture and be an integer.
	 * @param y - The y coordinate of the top-left of the area to get the ImageData from. Must lay within the dimensions of this CanvasTexture and be an integer.
	 * @param width - The width of the rectangle from which the ImageData will be extracted. Positive values are to the right, and negative to the left.
	 * @param height - The height of the rectangle from which the ImageData will be extracted. Positive values are down, and negative are up.
	 *
	 * @return The ImageData extracted from this CanvasTexture.
	**/
	public function getData(x:Int, y:Int, width:Int, height:Int):HTMLImageData
	{
		throw new Error("Not Implemented");
	}

	/**
	 * Get the color of a specific pixel from this texture and store it in a Color object.
	 *
	 * If you have drawn anything to this CanvasTexture since it was created you must call `CanvasTexture.update` to refresh the array buffer,
	 * otherwise this may return out of date color values, or worse - throw a run-time error as it tries to access an array element that doesn't exist.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The x coordinate of the pixel to get. Must lay within the dimensions of this CanvasTexture and be an integer.
	 * @param y - The y coordinate of the pixel to get. Must lay within the dimensions of this CanvasTexture and be an integer.
	 * @param out - A Color object to store the pixel values in. If not provided a new Color object will be created.
	 *
	 * @return An object with the red, green, blue and alpha values set in the r, g, b and a properties.
	**/
	public function getPixel(x:Int, y:Int, ?out:Color):Color
	{
		throw new Error("Not Implemented");
	}

	/**
	 * Returns an array containing all of the pixels in the given region.
	 *
	 * If the requested region extends outside the bounds of this CanvasTexture,
	 * the region is truncated to fit.
	 *
	 * If you have drawn anything to this CanvasTexture since it was created you must call `CanvasTexture.update` to refresh the array buffer,
	 * otherwise this may return out of date color values, or worse - throw a run-time error as it tries to access an array element that doesn't exist.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The x coordinate of the top-left of the region. Must lay within the dimensions of this CanvasTexture and be an integer.
	 * @param y - The y coordinate of the top-left of the region. Must lay within the dimensions of this CanvasTexture and be an integer.
	 * @param width - The width of the region to get. Must be an integer. Defaults to the canvas width if not given.
	 * @param height - The height of the region to get. Must be an integer. If not given will be set to the `width`.
	 *
	 * @return An array of Pixel objects.
	**/
	public function getPixels(x:Int = 0, y:Int = 0, width:Int = 0,
			height:Int = 0):Array<PixelConfig>
	{
		throw new Error("Not Implemented");
	}

	/**
	 * Returns the Image Data index for the given pixel in this CanvasTexture.
	 *
	 * The index can be used to read directly from the `this.data` array.
	 *
	 * The index points to the red value in the array. The subsequent 3 indexes
	 * point to green, blue and alpha respectively.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The x coordinate of the pixel to get. Must lay within the dimensions of this CanvasTexture and be an integer.
	 * @param y - The y coordinate of the pixel to get. Must lay within the dimensions of this CanvasTexture and be an integer.
	 *
	**/
	public function getIndex(x:Int, y:Int):Int
	{
		throw new Error("Not Implemented");
	}

	/**
	 * This should be called manually if you are running under WebGL.
	 * It will refresh the WebGLTexture from the Canvas source. Only call this if you know that the
	 * canvas has changed, as there is a significant GPU texture allocation cost involved in doing so.
	 *
	 * @since 1.0.0
	 *
	 * @return This CanvasTexture.
	**/
	public function refresh()
	{
		throw new Error("Not Implemented");
	}

	/**
	 * Gets the Canvas Element.
	 *
	 * @since 1.0.0
	 *
	 * @return The Canvas DOM element this texture is using.
	**/
	public function getCanvas():HTMLCanvasElement
	{
		throw new Error("Not Implemented");
	}

	/**
	 * Gets the 2D Canvas Rendering Context.
	 *
	 * @since 1.0.0
	 *
	 * @return The Canvas Rendering Context this texture is using.
	**/
	public function getContext():HTMLCanvasRenderingContext2D
	{
		throw new Error("Not Implemented");
	}

	/**
	 * Clears the given region of this Canvas Texture, resetting it back to transparent.
	 * If no region is given, the whole Canvas Texture is cleared.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The x coordinate of the top-left of the region to clear.
	 * @param y - The y coordinate of the top-left of the region to clear.
	 * @param width - The width of the region.
	 * @param height - The height of the region.
	 *
	 * @return The Canvas Texture.
	**/
	public function clear(x:Int = 0, y:Int = 0, ?width:Int, ?height:Int)
	{
		throw new Error("Not Implemented");
	}

	/**
	 * Changes the size of this Canvas Texture.
	 *
	 * @since 1.0.0
	 *
	 * @param width - The new width of the Canvas.
	 * @param height - The new height of the Canvas. If not given it will use the width as the height.
	 *
	 * @return The Canvas Texture.
	**/
	public function setSize(width:Int, ?height:Int):CanvasTexture
	{
		throw new Error("Not Implemented");
	}

	/**
	 * Destroys this Texture and releases references to its sources and frames.
	 *
	 * @since 1.0.0
	**/
	public override function destroy()
	{
		throw new Error("Not Implemented");
	}
}
