package phaserHaxe.gameobjects.components;

import phaserHaxe.utils.StringOrInt;
import phaserHaxe.textures.Frame;
import phaserHaxe.textures.Texture;

/**
 * Provides methods used for getting and setting the texture of a Game Object.
 *
 * @since 1.0.0
**/
@:phaserHaxe.Mixin(phaserHaxe.gameobjects.components.ITexture.TextureMixin)
interface ITexture
{
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
	 * Internal flag. Not to be set by this Game Object.
	 *
	 * @since 1.0.0
	**/
	private var isCropped:Bool;

	/**
	 * Sets the texture and frame this Game Object will use to render with.
	 *
	 * Textures are referenced by their string-based keys, as stored in the Texture Manager.
	 *
	 * @since 1.0.0
	 *
	 * @param key - The key of the texture to be used, as stored in the Texture Manager.
	 * @param frame - The name or index of the frame within the Texture.
	 *
	 * @return This Game Object instance.
	**/
	public function setTexture(key:String, ?frame:StringOrInt):ITexture;

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
		updateOrigin:Bool = true):ITexture;
}

final class TextureImplementation
{
	public static inline var _FLAG = 8;

	public static function setTexture<T:GameObject & ITexture>(self:T, key:String,
			frame:StringOrInt):T
	{
		self.texture = self.scene.sys.textures.get(key);

		self.setFrame(frame);

		return self;
	}

	public static function setFrame<T:GameObject & ITexture>(self:T, frame:StringOrInt,
			updateSize:Bool = true, updateOrigin:Bool = true):T
	{
		self.frame = self.texture.get(frame);

		if (self.frame.cutWidth == 0 || self.frame.cutHeight == 0)
		{
			self.renderFlags &= ~_FLAG;
		}
		else
		{
			self.renderFlags |= _FLAG;
		}

		if (Std.is(self, ISize) && updateSize)
		{
			(cast self : ISize).setSizeToFrame();
		}

		if (Std.is(self, IOrigin) && updateOrigin)
		{
			if (self.frame.customPivot)
			{
				(cast self : IOrigin).setOrigin(self.frame.pivotX, self.frame.pivotY);
			}
			else
			{
				(cast self : IOrigin).updateDisplayOrigin();
			}
		}

		return self;
	}
}

final class TextureMixin extends GameObject implements ITexture
{
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
	 * Internal flag. Not to be set by this Game Object.
	 *
	 * @since 1.0.0
	**/
	private var isCropped:Bool = false;

	/**
	 * Sets the texture and frame this Game Object will use to render with.
	 *
	 * Textures are referenced by their string-based keys, as stored in the Texture Manager.
	 *
	 * @since 1.0.0
	 *
	 * @param key - The key of the texture to be used, as stored in the Texture Manager.
	 * @param frame - The name or index of the frame within the Texture.
	 *
	 * @return This Game Object instance.
	**/
	public function setTexture(key:String, ?frame:StringOrInt):TextureMixin
	{
		return TextureImplementation.setTexture(this, key, frame);
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
			updateOrigin:Bool = true):TextureMixin
	{
		return TextureImplementation.setFrame(this, frame, updateSize, updateOrigin);
	}
}
