package phaserHaxe.gameobjects.components;

import phaserHaxe.utils.StringOrInt;
import phaserHaxe.gameobjects.components.ICrop.CropImplementation;
import phaserHaxe.geom.Rectangle;
import phaserHaxe.gameobjects.components.IFlip;
import phaserHaxe.textures.Texture;
import phaserHaxe.textures.Frame;

/**
 * Provides methods used for getting and setting the texture of a Game Object.
 *
 * @since 1.0.0
**/
@:allow(phaserHaxe.gameobjects.components.TextureCropImplementation)
@:phaserHaxe.Mixin(phaserHaxe.gameobjects.components.ITextureCrop.TextureCropMixin)
interface ITextureCrop extends ICrop extends ITexture
{
	/**
	 * The internal crop data object, as used by `setCrop` and passed to the `Frame.setCropUVs` method.
	 *
	 * @since 1.0.0
	**/
	private var _crop:CropDataObject;

	/**
	 * The Texture this Game Object is using to render with.
	 *
	 * @since 1.0.0
	**/
	public var texture:Texture;

	/**
	 * The Texture Frame this Game Object is using to render with.
	 *
	 * @since 1.0.0
	**/
	public var frame:Frame;

	/**
	 * A boolean flag indicating if this Game Object is being cropped or not.
	 * You can toggle this at any time after `setCrop` has been called, to turn cropping on or off.
	 * Equally, calling `setCrop` with no arguments will reset the crop and disable it.
	 *
	 * @since 1.0.0
	**/
	public var isCropped:Bool;

	/**
	 * Applies a crop to a texture based Game Object, such as a Sprite or Image.
	 *
	 * The crop is a rectangle that limits the area of the texture frame that is visible during rendering.
	 *
	 * Cropping a Game Object does not change its size, dimensions, physics body or hit area, it just
	 * changes what is shown when rendered.
	 *
	 * The crop coordinates are relative to the texture frame, not the Game Object, meaning 0 x 0 is the top-left.
	 *
	 * Therefore, if you had a Game Object that had an 800x600 sized texture, and you wanted to show only the left
	 * half of it, you could call `setCrop(0, 0, 400, 600)`.
	 *
	 * It is also scaled to match the Game Object scale automatically. Therefore a crop rect of 100x50 would crop
	 * an area of 200x100 when applied to a Game Object that had a scale factor of 2.
	 *
	 * You can either pass in numeric values directly, or you can provide a single Rectangle object as the first argument.
	 *
	 * Call this method with no arguments at all to reset the crop, or toggle the property `isCropped` to `false`.
	 *
	 * You should do this if the crop rectangle becomes the same size as the frame itself, as it will allow
	 * the renderer to skip several internal calculations.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The x coordinate to start the crop from. Or a Phaser.Geom.Rectangle object, in which case the rest of the arguments are ignored.
	 * @param y - The y coordinate to start the crop from.
	 * @param width - The width of the crop rectangle in pixels.
	 * @param height - The height of the crop rectangle in pixels.
	 *
	 * @return This Game Object instance.
	**/
	public function setCrop(?x:Either<Rectangle, Float>, ?y:Float, ?width:Float,
		?height:Float):ICrop;

	/**
	 * Sets the texture and frame this Game Object will use to render with.
	 *
	 * Textures are referenced by their string-based keys, as stored in the Texture Manager.
	 *
	 * @method Phaser.GameObjects.Components.TextureCrop#setTexture
	 * @since 3.0.0
	 *
	 * @param key - The key of the texture to be used, as stored in the Texture Manager.
	 * @param frame - The name or index of the frame within the Texture.
	 *
	 * @return This Game Object instance.
	**/
	public function setTexture(key:String, ?frame:StringOrInt):ITextureCrop;

	/**
	 * Sets the frame this Game Object will use to render with.
	 *
	 * The Frame has to belong to the current Texture being used.
	 *
	 * It can be either a string or an index.
	 *
	 * Calling `setFrame` will modify the `width` and `height` properties of your Game Object.
	 * It will also change the `origin` if the Frame has a custom pivot point, as exported from packages like Texture Packer.
	 *
	 * @since 1.0.0
	 *
	 * @param frame - The name or index of the frame within the Texture.
	 * @param updateSize - Should this call adjust the size of the Game Object?
	 * @param updateOrigin - Should this call adjust the origin of the Game Object?
	 *
	 * @return This Game Object instance.
	**/
	public function setFrame(frame:StringOrInt, updateSize:Bool = true,
		updateOrigin:Bool = true):ITextureCrop;

	/**
	 * Internal method that returns a blank, well-formed crop object for use by a Game Object.
	 *
	 * @since 1.0.0
	 *
	 * @return The crop object.
	**/
	private function resetCropObject():CropDataObject;
}

final class TextureCropImplementation
{
	private static inline var _FLAG = 8;

	public inline static function setCrop<T:ICrop & IFlip>(self:T,
			?x:Either<Rectangle, Float>, ?y:Float, ?width:Float, ?height:Float):T
	{
		return CropImplementation.setCrop(self, x, y, width, height);
	}

	public inline static function resetCropObject():CropDataObject
	{
		return CropImplementation.resetCropObject();
	}

	public inline static function setTexture<T:ITextureCrop & GameObject>(self:T,
			key:String, ?frame:StringOrInt):T
	{
		self.texture = self.scene.sys.textures.get(key);

		return cast self.setFrame(frame);
	}

	public static function setFrame<T:ITextureCrop & GameObject & IFlip>(self:T,
			frame:StringOrInt, updateSize:Bool = true,
			updateOrigin:Bool = true):T
	{
		self.frame = (cast self.texture).get(frame);

		if (self.frame.cutWidth != 0 || self.frame.cutHeight != 0)
		{
			self.renderFlags &= ~_FLAG;
		}
		else
		{
			self.renderFlags |= _FLAG;
		}

		final selfSizeComp = Std.is(self, ISize) ? (cast self : ISize) : null;

		if (selfSizeComp != null && updateSize)
		{
			selfSizeComp.setSizeToFrame();
		}

		final selfOriginComp = Std.is(self, IOrigin) ? (cast self : IOrigin) : null;

		if (selfOriginComp != null && updateOrigin)
		{
			if (self.frame.customPivot)
			{
				selfOriginComp.setOrigin(self.frame.pivotX, self.frame.pivotY);
			}
			else
			{
				selfOriginComp.updateDisplayOrigin();
			}
		}

		if (self.isCropped)
		{
			self.frame.updateCropUVs(self._crop, self.flipX, self.flipY);
		}

		return self;
	}
}

final class TextureCropMixin extends GameObject implements ITextureCrop implements IFlip
{
	/**
	 * The internal crop data object, as used by `setCrop` and passed to the `Frame.setCropUVs` method.
	 *
	 * @since 1.0.0
	**/
	private var _crop:CropDataObject = new CropDataObject();

	/**
	 * The Texture this Game Object is using to render with.
	 *
	 * @since 1.0.0
	**/
	public var texture:Texture = null;

	/**
	 * The Texture Frame this Game Object is using to render with.
	 *
	 * @since 1.0.0
	**/
	public var frame:Frame = null;

	/**
	 * A boolean flag indicating if this Game Object is being cropped or not.
	 * You can toggle this at any time after `setCrop` has been called, to turn cropping on or off.
	 * Equally, calling `setCrop` with no arguments will reset the crop and disable it.
	 *
	 * @since 1.0.0
	**/
	public var isCropped:Bool = false;

	/**
	 * Applies a crop to a texture based Game Object, such as a Sprite or Image.
	 *
	 * The crop is a rectangle that limits the area of the texture frame that is visible during rendering.
	 *
	 * Cropping a Game Object does not change its size, dimensions, physics body or hit area, it just
	 * changes what is shown when rendered.
	 *
	 * The crop coordinates are relative to the texture frame, not the Game Object, meaning 0 x 0 is the top-left.
	 *
	 * Therefore, if you had a Game Object that had an 800x600 sized texture, and you wanted to show only the left
	 * half of it, you could call `setCrop(0, 0, 400, 600)`.
	 *
	 * It is also scaled to match the Game Object scale automatically. Therefore a crop rect of 100x50 would crop
	 * an area of 200x100 when applied to a Game Object that had a scale factor of 2.
	 *
	 * You can either pass in numeric values directly, or you can provide a single Rectangle object as the first argument.
	 *
	 * Call this method with no arguments at all to reset the crop, or toggle the property `isCropped` to `false`.
	 *
	 * You should do this if the crop rectangle becomes the same size as the frame itself, as it will allow
	 * the renderer to skip several internal calculations.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The x coordinate to start the crop from. Or a Phaser.Geom.Rectangle object, in which case the rest of the arguments are ignored.
	 * @param y - The y coordinate to start the crop from.
	 * @param width - The width of the crop rectangle in pixels.
	 * @param height - The height of the crop rectangle in pixels.
	 *
	 * @return This Game Object instance.
	**/
	public function setCrop(?x:Either<Rectangle, Float>, ?y:Float, ?width:Float,
			?height:Float):TextureCropMixin
	{
		return TextureCropImplementation.setCrop(this, x, y, width, height);
	}

	/**
	 * Sets the texture and frame this Game Object will use to render with.
	 *
	 * Textures are referenced by their string-based keys, as stored in the Texture Manager.
	 *
	 * @method Phaser.GameObjects.Components.TextureCrop#setTexture
	 * @since 3.0.0
	 *
	 * @param key - The key of the texture to be used, as stored in the Texture Manager.
	 * @param frame - The name or index of the frame within the Texture.
	 *
	 * @return This Game Object instance.
	**/
	public function setTexture(key:String, ?frame:StringOrInt):TextureCropMixin
	{
		return TextureCropImplementation.setTexture(this, key, frame);
	}

	/**
	 * Sets the frame this Game Object will use to render with.
	 *
	 * The Frame has to belong to the current Texture being used.
	 *
	 * It can be either a string or an index.
	 *
	 * Calling `setFrame` will modify the `width` and `height` properties of your Game Object.
	 * It will also change the `origin` if the Frame has a custom pivot point, as exported from packages like Texture Packer.
	 *
	 * @since 1.0.0
	 *
	 * @param frame - The name or index of the frame within the Texture.
	 * @param updateSize - Should this call adjust the size of the Game Object?
	 * @param updateOrigin - Should this call adjust the origin of the Game Object?
	 *
	 * @return This Game Object instance.
	**/
	public function setFrame(frame:StringOrInt, updateSize:Bool = true,
			updateOrigin:Bool = true):TextureCropMixin
	{
		return TextureCropImplementation.setFrame(this, frame, updateSize, updateOrigin);
	}

	/**
	 * Internal method that returns a blank, well-formed crop object for use by a Game Object.
	 *
	 * @since 1.0.0
	 *
	 * @return The crop object.
	**/
	private function resetCropObject():CropDataObject
	{
		return TextureCropImplementation.resetCropObject();
	}

	// IFlip implementation
	@:phaserHaxe.mixinIgnore
	public var flipX:Bool = false;

	@:phaserHaxe.mixinIgnore
	public var flipY:Bool = false;

	@:phaserHaxe.mixinIgnore
	public function toggleFlipX():IFlip
	{
		throw "Not Implemented";
	}

	@:phaserHaxe.mixinIgnore
	public function toggleFlipY():IFlip
	{
		throw "Not Implemented";
	}

	@:phaserHaxe.mixinIgnore
	public function setFlipX(value:Bool):IFlip
	{
		throw "Not Implemented";
	}

	@:phaserHaxe.mixinIgnore
	public function setFlipY(value:Bool):IFlip
	{
		throw "Not Implemented";
	}

	@:phaserHaxe.mixinIgnore
	public function setFlip(x:Bool, y:Bool):IFlip
	{
		throw "Not Implemented";
	}

	@:phaserHaxe.mixinIgnore
	public function resetFlip():IFlip
	{
		throw "Not Implemented";
	}
}
