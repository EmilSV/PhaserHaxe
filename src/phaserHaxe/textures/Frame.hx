package phaserHaxe.textures;

import phaserHaxe.math.MathUtility;
import js.html.webgl.Texture as WebGLTexture;
import phaserHaxe.gameobjects.components.CropDataObject;

@:structInit
final class FrameData
{
	public var cut:FrameDataCut;
	public var trim:Bool;
	public var sourceSize:FrameDataSourceSize;
	public var spriteSourceSize:FrameDataSpriteSourceSize;
	public var radius:Float;
	public var drawImage:FrameDataDrawImage;

	public function deepCopy():FrameData
	{
		return {
			cut: {
				x: this.cut.x,
				y: this.cut.y,
				w: this.cut.w,
				h: this.cut.h,
				r: this.cut.r,
				b: this.cut.b,
			},
			trim: this.trim,
			sourceSize: {
				w: this.sourceSize.w,
				h: this.sourceSize.h,
			},
			spriteSourceSize: {
				x: this.spriteSourceSize.x,
				y: this.spriteSourceSize.y,
				w: this.spriteSourceSize.w,
				h: this.spriteSourceSize.h,
				r: this.spriteSourceSize.r,
				b: this.spriteSourceSize.b,
			},
			radius: this.radius,
			drawImage: {
				x: this.drawImage.x,
				y: this.drawImage.y,
				width: this.drawImage.width,
				height: this.drawImage.height,
			}
		};
	}
}

@:structInit
final class FrameDataCut
{
	public var x:Float;
	public var y:Float;
	public var w:Float;
	public var h:Float;
	public var r:Float;
	public var b:Float;
}

@:structInit
final class FrameDataSourceSize
{
	public var w:Float;
	public var h:Float;
}

@:structInit
final class FrameDataSpriteSourceSize
{
	public var x:Float;
	public var y:Float;
	public var w:Float;
	public var h:Float;
	public var r:Float;
	public var b:Float;
}

@:structInit
final class FrameDataDrawImage
{
	public var x:Float;
	public var y:Float;
	public var width:Float;
	public var height:Float;
}

/**
 * A Frame is a section of a Texture.
 *
 * @since 1.0.0
 *
**/
class Frame
{
	/**
	 * The Texture this Frame is a part of.
	 *
	 * @since 1.0.0
	**/
	public var texture:Texture;

	/**
	 * The name of this Frame.
	 * The name is unique within the Texture.
	 *
	 * @since 1.0.0
	**/
	public var name:String;

	/**
	 * The TextureSource this Frame is part of.
	 *
	 * @since 1.0.0
	**/
	public var source:TextureSource;

	/**
	 * The index of the TextureSource in the Texture sources array.
	 *
	 * @since 1.0.0
	**/
	public var sourceIndex:Int;

	/**
	 * A reference to the Texture Source WebGL Texture that this Frame is using.
	 *
	 * @since 1.0.0
	**/
	public var glTexture:WebGLTexture;

	/**
	 * X position within the source image to cut from.
	 *
	 * @since 1.0.0
	**/
	public var cutX:Int;

	/**
	 * Y position within the source image to cut from.
	 *
	 * @since 1.0.0
	**/
	public var cutY:Int;

	/**
	 * The width of the area in the source image to cut.
	 *
	 * @since 1.0.0
	**/
	public var cutWidth:Int;

	/**
	 * The height of the area in the source image to cut.
	 *
	 * @since 1.0.0
	**/
	public var cutHeight:Int;

	/**
	 * The X rendering offset of this Frame; taking trim into account.
	 *
	 * @since 1.0.0
	**/
	public var x:Int;

	/**
	 * The Y rendering offset of this Frame, taking trim into account.
	 *
	 * @since 1.0.0
	**/
	public var y:Int;

	/**
	 * The rendering width of this Frame, taking trim into account.
	 *
	 * @since 1.0.0
	**/
	public var width:Int;

	/**
	 * The rendering height of this Frame, taking trim into account.
	 *
	 * @since 1.0.0
	**/
	public var height:Int;

	/**
	 * Half the width, floored.
	 * Precalculated for the renderer.
	 *
	 * @since 1.0.0
	**/
	public var halfWidth:Int;

	/**
	 * Half the height, floored.
	 * Precalculated for the renderer.
	 *
	 * @since 1.0.0
	**/
	public var halfHeight:Int;

	/**
	 * The x center of this frame, floored.
	 *
	 * @since 1.0.0
	**/
	public var centerX:Int;

	/**
	 * The y center of this frame, floored.
	 *
	 * @since 1.0.0
	**/
	public var centerY:Int;

	/**
	 * The horizontal pivot point of this Frame.
	 *
	 * @since 1.0.0
	**/
	public var pivotX:Int = 0;

	/**
	 * The vertical pivot point of this Frame.
	 *
	 * @since 1.0.0
	**/
	public var pivotY:Int = 0;

	/**
	 * Does this Frame have a custom pivot point?
	 *
	 * @since 1.0.0
	**/
	public var customPivot:Bool = false;

	/**
	 * **CURRENTLY UNSUPPORTED**
	 *
	 * Is this frame is rotated or not in the Texture?
	 * Rotation allows you to use rotated frames in texture atlas packing.
	 * It has nothing to do with Sprite rotation.
	 *
	 * @since 1.0.0
	**/
	public var rotated:Bool;

	/**
	 * Over-rides the Renderer setting.
	 * -1 = use Renderer Setting
	 * 0 = No rounding
	 * 1 = Round
	 *
	 * @since 1.0.0
	**/
	public var autoRound:Int = -1;

	/**
	 * Any Frame specific custom data can be stored here.
	 *
	 * @since 1.0.0
	**/
	public var customData:{};

	/**
	 * WebGL UV u0 value.
	 *
	 * @since 1.0.0
	 */
	public var u0:Float = 0;

	/**
	 * WebGL UV v0 value.
	 *
	 * @since 1.0.0
	**/
	public var v0:Float = 0;

	/**
	 * WebGL UV u1 value.
	 *
	 * @since 1.0.0
	**/
	public var u1:Float = 0;

	/**
	 * WebGL UV v1 value.
	 *
	 * @since 1.0.0
	**/
	public var v1:Float = 0;

	/**
	 * The un-modified source frame, trim and UV data.
	 *
	 * @since 1.0.0
	**/
	public var data:FrameData;

	/**
	 * The width of the Frame in its un-trimmed, un-padded state, as prepared in the art package,
	 * before being packed.
	 *
	 * @since 1.0.0
	**/
	public var realWidth(get, never):Float;

	/**
	 * The height of the Frame in its un-trimmed, un-padded state, as prepared in the art package,
	 * before being packed.
	 *
	 * @since 1.0.0
	**/
	public var realHeight(get, never):Float;

	/**
	 * The radius of the Frame (derived from sqrt(w * w + h * h) / 2)
	 *
	 * @since 1.0.0
	**/
	public var radius(get, never):Float;

	/**
	 * The Canvas drawImage data object.
	 *
	 * @since 1.0.0
	**/
	public var canvasData(get, never):FrameDataDrawImage;

	private inline function get_realWidth():Float
	{
		return data.sourceSize.w;
	}

	private inline function get_realHeight():Float
	{
		return data.sourceSize.h;
	}

	public inline function get_radius():Float
	{
		return data.radius;
	}

	public inline function get_canvasData():FrameDataDrawImage
	{
		return data.drawImage;
	}

	/**
	 * @param texture - The Texture this Frame is a part of.
	 * @param name - The name of this Frame. The name is unique within the Texture.
	 * @param sourceIndex - The index of the TextureSource that this Frame is a part of.
	 * @param x - The x coordinate of the top-left of this Frame.
	 * @param y - The y coordinate of the top-left of this Frame.
	 * @param width - The width of this Frame.
	 * @param height - The height of this Frame.
	**/
	public function new(texture:Texture, name:String, sourceIndex:Int, x:Int, y:Int,
			width:Int, height:Int)
	{
		this.texture = texture;

		this.name = name;

		this.source = texture.source[sourceIndex];

		this.sourceIndex = sourceIndex;

		this.glTexture = this.source.glTexture;

		this.data = {
			cut: {
				x: 0,
				y: 0,
				w: 0,
				h: 0,
				r: 0,
				b: 0
			},
			trim: false,
			sourceSize: {
				w: 0,
				h: 0
			},
			spriteSourceSize: {
				x: 0,
				y: 0,
				w: 0,
				h: 0,
				r: 0,
				b: 0
			},
			radius: 0,
			drawImage: {
				x: 0,
				y: 0,
				width: 0,
				height: 0
			}
		};

		this.setSize(width, height, x, y);
	}

	/**
	 * Sets the width, height, x and y of this Frame.
	 *
	 * This is called automatically by the constructor
	 * and should rarely be changed on-the-fly.
	 *
	 * @since 1.0.0
	 *
	 * @param width - The width of the frame before being trimmed.
	 * @param height - The height of the frame before being trimmed.
	 * @param x - The x coordinate of the top-left of this Frame.
	 * @param y - The y coordinate of the top-left of this Frame.
	 *
	 * @return This Frame object.
	**/
	public function setSize(width:Int, height:Int, x:Int = 0, y:Int = 0)
	{
		this.cutX = x;
		this.cutY = y;
		this.cutWidth = width;
		this.cutHeight = height;

		this.width = width;
		this.height = height;

		this.halfWidth = Math.floor(width * 0.5);
		this.halfHeight = Math.floor(height * 0.5);

		this.centerX = Math.floor(width / 2);
		this.centerY = Math.floor(height / 2);

		var data = this.data;
		var cut = data.cut;

		cut.x = x;
		cut.y = y;
		cut.w = width;
		cut.h = height;
		cut.r = x + width;
		cut.b = y + height;

		data.sourceSize.w = width;
		data.sourceSize.h = height;

		data.spriteSourceSize.w = width;
		data.spriteSourceSize.h = height;

		data.radius = 0.5 * Math.sqrt(width * width + height * height);

		var drawImage = data.drawImage;

		drawImage.x = x;
		drawImage.y = y;
		drawImage.width = width;
		drawImage.height = height;

		return this.updateUVs();
	}

	/**
	 * If the frame was trimmed when added to the Texture Atlas, this records the trim and source data.
	 *
	 * @since 1.0.0
	 *
	 * @param actualWidth - The width of the frame before being trimmed.
	 * @param actualHeight - The height of the frame before being trimmed.
	 * @param destX - The destination X position of the trimmed frame for display.
	 * @param destY - The destination Y position of the trimmed frame for display.
	 * @param destWidth - The destination width of the trimmed frame for display.
	 * @param destHeight - The destination height of the trimmed frame for display.
	 *
	 * @return This Frame object.
	**/
	public function setTrim(actualWidth:Int, actualHeight:Int, destX:Int, destY:Int,
			destWidth:Int, destHeight:Int):Frame
	{
		var data = this.data;
		var ss = data.spriteSourceSize;
		//  Store actual values
		data.trim = true;
		data.sourceSize.w = actualWidth;
		data.sourceSize.h = actualHeight;
		ss.x = destX;
		ss.y = destY;
		ss.w = destWidth;
		ss.h = destHeight;
		ss.r = destX + destWidth;
		ss.b = destY + destHeight;
		//  Adjust properties
		this.x = destX;
		this.y = destY;
		this.width = destWidth;
		this.height = destHeight;
		this.halfWidth = Std.int(destWidth * 0.5);
		this.halfHeight = Std.int(destHeight * 0.5);
		this.centerX = Math.floor(destWidth / 2);
		this.centerY = Math.floor(destHeight / 2);
		return this.updateUVs();
	}

	/**
	 * Takes a crop data object and, based on the rectangular region given, calculates the
	 * required UV coordinates in order to crop this Frame for WebGL and Canvas rendering.
	 *
	 * This is called directly by the Game Object Texture Components `setCrop` method.
	 * Please use that method to crop a Game Object.
	 *
	 * @since 1.0.0
	 *
	 * @param crop - The crop data object. This is the `GameObject._crop` property.
	 * @param x - The x coordinate to start the crop from. Cannot be negative or exceed the Frame width.
	 * @param y - The y coordinate to start the crop from. Cannot be negative or exceed the Frame height.
	 * @param width - The width of the crop rectangle. Cannot exceed the Frame width.
	 * @param height - The height of the crop rectangle. Cannot exceed the Frame height.
	 * @param flipX - Does the parent Game Object have flipX set?
	 * @param flipY - Does the parent Game Object have flipY set?
	 *
	 * @return The updated crop data object.
	**/
	public function setCropUVs(crop:CropDataObject, x:Float, y:Float, width:Float,
			height:Float, flipX:Bool, flipY:Bool):CropDataObject
	{
		//  Clamp the input values

		var cx = this.cutX;
		var cy = this.cutY;
		var cw = this.cutWidth;
		var ch = this.cutHeight;
		var rw = this.realWidth;
		var rh = this.realHeight;

		x = MathUtility.clamp(x, 0, rw);
		y = MathUtility.clamp(y, 0, rh);

		width = MathUtility.clamp(width, 0, rw - x);
		height = MathUtility.clamp(height, 0, rh - y);

		var ox = cx + x;
		var oy = cy + y;
		var ow = width;
		var oh = height;

		var data = this.data;

		if (data.trim)
		{
			var ss = data.spriteSourceSize;

			//  Need to check for intersection between the cut area and the crop area
			//  If there is none, we set UV to be empty, otherwise set it to be the intersection area

			width = MathUtility.clamp(width, 0, cw - x);
			height = MathUtility.clamp(height, 0, ch - y);

			var cropRight = x + width;
			var cropBottom = y + height;

			var intersects = !(ss.r < x || ss.b < y || ss.x > cropRight || ss.y > cropBottom);

			if (intersects)
			{
				var ix = Math.max(ss.x, x);
				var iy = Math.max(ss.y, y);
				var iw = Math.min(ss.r, cropRight) - ix;
				var ih = Math.min(ss.b, cropBottom) - iy;

				ow = iw;
				oh = ih;

				if (flipX)
				{
					ox = cx + (cw - (ix - ss.x) - iw);
				}
				else
				{
					ox = cx + (ix - ss.x);
				}

				if (flipY)
				{
					oy = cy + (ch - (iy - ss.y) - ih);
				}
				else
				{
					oy = cy + (iy - ss.y);
				}

				x = ix;
				y = iy;

				width = iw;
				height = ih;
			}
			else
			{
				ox = 0;
				oy = 0;
				ow = 0;
				oh = 0;
			}
		}
		else
		{
			if (flipX)
			{
				ox = cx + (cw - x - width);
			}

			if (flipY)
			{
				oy = cy + (ch - y - height);
			}
		}

		var tw = this.source.width;
		var th = this.source.height;

		//  Map the given coordinates into UV space, clamping to the 0-1 range.

		crop.u0 = Math.max(0, ox / tw);
		crop.v0 = Math.max(0, oy / th);
		crop.u1 = Math.min(1, (ox + ow) / tw);
		crop.v1 = Math.min(1, (oy + oh) / th);

		crop.x = x;
		crop.y = y;

		crop.cx = ox;
		crop.cy = oy;
		crop.cw = ow;
		crop.ch = oh;

		crop.width = width;
		crop.height = height;

		crop.flipX = flipX;
		crop.flipY = flipY;

		return crop;
	}

	/**
	 * Takes a crop data object and recalculates the UVs based on the dimensions inside the crop object.
	 * Called automatically by `setFrame`.
	 *
	 * @since 1.0.0
	 *
	 * @param crop - The crop data object. This is the `GameObject._crop` property.
	 * @param flipX - Does the parent Game Object have flipX set?
	 * @param flipY - Does the parent Game Object have flipY set?
	 *
	 * @return The updated crop data object.
	**/
	public function updateCropUVs(crop:CropDataObject, flipX:Bool,
			flipY:Bool):CropDataObject
	{
		return this.setCropUVs(crop, crop.x, crop.y, crop.width, crop.height, flipX,
			flipY);
	}

	/**
	 * Updates the internal WebGL UV cache and the drawImage cache.
	 *
	 * @since 1.0.0
	 *
	 * @return This Frame object.
	**/
	public function updateUVs():Frame
	{
		var cx = this.cutX;
		var cy = this.cutY;
		var cw = this.cutWidth;
		var ch = this.cutHeight;

		//  Canvas data

		var cd = this.data.drawImage;

		cd.width = cw;
		cd.height = ch;

		//  WebGL data

		var tw = this.source.width;
		var th = this.source.height;

		this.u0 = cx / tw;
		this.v0 = cy / th;

		this.u1 = (cx + cw) / tw;
		this.v1 = (cy + ch) / th;

		return this;
	}

	/**
	 * Updates the internal WebGL UV cache.
	 *
	 * @since 1.0.0
	 *
	 * @return This Frame object.
	**/
	public function updateUVsInverted():Frame
	{
		var tw = source.width;
		var th = source.height;
		u0 = (cutX + cutHeight) / tw;
		v0 = cutY / th;
		u1 = cutX / tw;
		v1 = (cutY + cutWidth) / th;
		return this;
	}

	/**
	 * Clones this Frame into a new Frame object.
	 *
	 * @since 1.0.0
	 *
	 * @return A clone of this Frame.
	**/
	public function clone():Frame
	{
		var clone = new Frame(this.texture, this.name, this.sourceIndex, this.x, this.y,
			this.width, this.height);
		clone.cutX = this.cutX;
		clone.cutY = this.cutY;
		clone.cutWidth = this.cutWidth;
		clone.cutHeight = this.cutHeight;
		clone.x = this.x;
		clone.y = this.y;
		clone.width = this.width;
		clone.height = this.height;
		clone.halfWidth = this.halfWidth;
		clone.halfHeight = this.halfHeight;
		clone.centerX = this.centerX;
		clone.centerY = this.centerY;
		clone.rotated = this.rotated;
		clone.data = this.data.deepCopy();
		clone.updateUVs();
		return clone;
	}

	/**
	 * Destroys this Frame by nulling its reference to the parent Texture and and data objects.
	 *
	 * @since 1.0.0
	**/
	public function destroy():Void
	{
		this.source = null;
		this.texture = null;
		this.glTexture = null;
		this.customData = null;
		this.data = null;
	}
}
