package phaserHaxe.gameobjects.components;

import phaserHaxe.textures.CanvasTexture;
import phaserHaxe.textures.Texture;
import phaserHaxe.geom.Rectangle;
import phaserHaxe.gameobjects.components.ICrop;
import phaserHaxe.gameobjects.components.ITransform;
import phaserHaxe.textures.Frame;
import phaserHaxe.utils.types.Union;

@:phaserHaxe.Mixin(phaserHaxe.gameobjects.components.IFrameBasedSize.FrameBasedSizeMixin)
interface IFrameBasedSize extends ISize
{
	/**
	 * A property indicating that a Game Object has this component.
	 *
	 * @default true
	 * @since 1.0.0
	**/
	private var _sizeComponent:Bool;

	/**
	 * The native (un-scaled) width of this Game Object.
	 *
	 * Changing this value will not change the size that the Game Object is rendered in-game.
	 * For that you need to Union set the scale of the Game Object (`setScale`) or use
	 * the `displayWidth` property.
	 *
	 * @since 1.0.0
	**/
	public var width:Float;

	/**
	 * The native (un-scaled) height of this Game Object.
	 *
	 * Changing this value will not change the size that the Game Object is rendered in-game.
	 * For that you need to Union set the scale of the Game Object (`setScale`) or use
	 * the `displayHeight` property.
	 *
	 * @since 1.0.0
	**/
	public var height:Float;

	/**
	 * The displayed width of this Game Object.
	 *
	 * This value takes into account the scale factor.
	 *
	 * Setting this value will adjust the Game Object's scale property.
	 *
	 * @since 1.0.0
	**/
	public var displayWidth(get, set):Float;

	/**
	 * The displayed height of this Game Object.
	 *
	 * This value takes into account the scale factor.
	 *
	 * Setting this value will adjust the Game Object's scale property.
	 *
	 * @since 1.0.0
	**/
	public var displayHeight(get, set):Float;

	/**
	 * Sets the size of this Game Object to be that of the given Frame.
	 *
	 * This will not change the size that the Game Object is rendered in-game.
	 * For that you need to Union set the scale of the Game Object (`setScale`) or call the
	 * `setDisplaySize` method, which is the same thing as changing the scale but allows you
	 * to do so by giving pixel values.
	 *
	 * If you have enabled this Game Object for input, changing the size will _not_ change the
	 * size of the hit area. To do this you should adjust the `input.hitArea` object directly.
	 *
	 * @since 1.0.0
	 *
	 * @param frame - The frame to base the size of this Game Object on.
	 *
	 * @return This Game Object instance.
	**/
	public function setSizeToFrame(?frame:Frame):IFrameBasedSize;

	/**
	 * Sets the internal size of this Game Object, as used for frame or physics body creation.
	 *
	 * This will not change the size that the Game Object is rendered in-game.
	 * For that you need to Union set the scale of the Game Object (`setScale`) or call the
	 * `setDisplaySize` method, which is the same thing as changing the scale but allows you
	 * to do so by giving pixel values.
	 *
	 * If you have enabled this Game Object for input, changing the size will _not_ change the
	 * size of the hit area. To do this you should adjust the `input.hitArea` object directly.
	 *
	 * @since 1.0.0
	 *
	 * @param width - The width of this Game Object.
	 * @param height - The height of this Game Object.
	 *
	 * @return This Game Object instance.
	**/
	public function setSize(width:Float, height:Float):IFrameBasedSize;

	/**
	 * Sets the display size of this Game Object.
	 *
	 * Calling this will adjust the scale.
	 *
	 * @since 1.0.0
	 *
	 * @param width - The width of this Game Object.
	 * @param height - The height of this Game Object.
	 *
	 * @return This Game Object instance.
	**/
	public function setDisplaySize(width:Float, height:Float):IFrameBasedSize;
}

final class FrameBasedSizeImplementation
{
	public static inline function get_displayWidth<T:ISize & ITransform & ICrop>(self:T):Float
	{
		return self.scaleX * self.frame.realWidth;
	}

	public static inline function set_displayWidth<T:ISize & ITransform & ICrop>(self:T,
			value:Float):Float
	{
		return self.scaleX = value / self.frame.realWidth;
	}

	public static inline function get_displayHeight<T:ISize & ITransform & ICrop>(self:T):Float
	{
		return self.scaleY * self.frame.realHeight;
	}

	public static inline function set_displayHeight<T:ISize & ITransform & ICrop>(self:T,
		value:Float):Float
	{
		return self.scaleY = value / self.frame.realHeight;
	}

	public static inline function setSizeToFrame<T:ISize & ICrop>(self:T, ?frame:Frame):T
	{
		if (frame == null)
		{
			frame = self.frame;
		}

		self.width = frame.realWidth;
		self.height = frame.realHeight;

		return self;
	}

	public static inline function setSize<T:ISize>(self:T, width:Float, height:Float):T
	{
		self.width = width;
		self.height = height;
		return self;
	}

	public static inline function setDisplaySize<T:ISize>(self:T, width:Float,
			height:Float):T
	{
		self.displayWidth = width;
		self.displayHeight = height;

		return self;
	}
}

final class FrameBasedSizeMixin implements IFrameBasedSize implements ITransform implements ICrop
{
	/**
	 * The internal crop data object, as used by `setCrop` and passed to the `Frame.setCropUVs` method.
	 *
	 * @since 1.0.0
	**/
	private var _crop:CropDataObject;

	/**
	 * A property indicating that a Game Object has this component.
	 *
	 * @since 1.0.0
	**/
	private var _sizeComponent:Bool = true;

	/**
	 * The native (un-scaled) width of this Game Object.
	 *
	 * Changing this value will not change the size that the Game Object is rendered in-game.
	 * For that you need to Union set the scale of the Game Object (`setScale`) or use
	 * the `displayWidth` property.
	 *
	 * @since 1.0.0
	**/
	public var width:Float = 0;

	/**
	 * The native (un-scaled) height of this Game Object.
	 *
	 * Changing this value will not change the size that the Game Object is rendered in-game.
	 * For that you need to Union set the scale of the Game Object (`setScale`) or use
	 * the `displayHeight` property.
	 *
	 * @since 1.0.0
	**/
	public var height:Float = 0;

	/**
	 * The displayed width of this Game Object.
	 *
	 * This value takes into account the scale factor.
	 *
	 * Setting this value will adjust the Game Object's scale property.
	 *
	 * @since 1.0.0
	**/
	public var displayWidth(get, set):Float;

	/**
	 * The displayed height of this Game Object.
	 *
	 * This value takes into account the scale factor.
	 *
	 * Setting this value will adjust the Game Object's scale property.
	 *
	 * @since 1.0.0
	**/
	public var displayHeight(get, set):Float;

	private function get_displayWidth():Float
	{
		return FrameBasedSizeImplementation.get_displayWidth(this);
	}

	private function set_displayWidth(value:Float):Float
	{
		return FrameBasedSizeImplementation.set_displayWidth(this, value);
	}

	private function get_displayHeight():Float
	{
		return FrameBasedSizeImplementation.get_displayHeight(this);
	}

	private function set_displayHeight(value:Float):Float
	{
		return FrameBasedSizeImplementation.set_displayHeight(this, value);
	}

	/**
	 * Sets the size of this Game Object to be that of the given Frame.
	 *
	 * This will not change the size that the Game Object is rendered in-game.
	 * For that you need to Union set the scale of the Game Object (`setScale`) or call the
	 * `setDisplaySize` method, which is the same thing as changing the scale but allows you
	 * to do so by giving pixel values.
	 *
	 * If you have enabled this Game Object for input, changing the size will _not_ change the
	 * size of the hit area. To do this you should adjust the `input.hitArea` object directly.
	 *
	 * @since 1.0.0
	 *
	 * @param frame - The frame to base the size of this Game Object on.
	 *
	 * @return This Game Object instance.
	**/
	public function setSizeToFrame(?frame:Frame):FrameBasedSizeMixin
	{
		return FrameBasedSizeImplementation.setSizeToFrame(this, frame);
	}

	/**
	 * Sets the internal size of this Game Object, as used for frame or physics body creation.
	 *
	 * This will not change the size that the Game Object is rendered in-game.
	 * For that you need to Union set the scale of the Game Object (`setScale`) or call the
	 * `setDisplaySize` method, which is the same thing as changing the scale but allows you
	 * to do so by giving pixel values.
	 *
	 * If you have enabled this Game Object for input, changing the size will _not_ change the
	 * size of the hit area. To do this you should adjust the `input.hitArea` object directly.
	 *
	 * @since 1.0.0
	 *
	 * @param width - The width of this Game Object.
	 * @param height - The height of this Game Object.
	 *
	 * @return This Game Object instance.
	**/
	public function setSize(width:Float, height:Float):FrameBasedSizeMixin
	{
		return FrameBasedSizeImplementation.setSize(this, width, height);
	}

	/**
	 * Sets the display size of this Game Object.
	 *
	 * Calling this will adjust the scale.
	 *
	 * @since 1.0.0
	 *
	 * @param width - The width of this Game Object.
	 * @param height - The height of this Game Object.
	 *
	 * @return This Game Object instance.
	**/
	public function setDisplaySize(width:Float, height:Float):FrameBasedSizeMixin
	{
		return FrameBasedSizeImplementation.setDisplaySize(this, width, height);
	}

	// ITransform implementation
	@:phaserHaxe.mixinIgnore
	private var _scaleX:Float = 1;

	@:phaserHaxe.mixinIgnore
	private var _scaleY:Float = 1;

	@:phaserHaxe.mixinIgnore
	private var _rotation:Float = 0;

	@:phaserHaxe.mixinIgnore
	public var x:Float = 0;

	@:phaserHaxe.mixinIgnore
	public var y:Float = 0;

	@:phaserHaxe.mixinIgnore
	public var z:Float = 0;

	@:phaserHaxe.mixinIgnore
	public var w:Float = 0;

	@:phaserHaxe.mixinIgnore
	public var scale(get, set):Float;

	@:phaserHaxe.mixinIgnore
	public var scaleX(get, set):Float;

	@:phaserHaxe.mixinIgnore
	public var scaleY(get, set):Float;

	@:phaserHaxe.mixinIgnore
	public var angle(get, set):Float;
	@:phaserHaxe.mixinIgnore
	public var rotation(get, set):Float;

	@:phaserHaxe.mixinIgnore
	private inline function get_scale():Float
	{
		throw "Not Implemented";
	}

	@:phaserHaxe.mixinIgnore
	private inline function set_scale(value:Float):Float
	{
		throw "Not Implemented";
	}

	@:phaserHaxe.mixinIgnore
	private inline function get_scaleX():Float
	{
		throw "Not Implemented";
	}

	@:phaserHaxe.mixinIgnore
	private inline function set_scaleX(value:Float):Float
	{
		throw "Not Implemented";
	}

	@:phaserHaxe.mixinIgnore
	private inline function get_scaleY():Float
	{
		throw "Not Implemented";
	}

	@:phaserHaxe.mixinIgnore
	private inline function set_scaleY(value:Float):Float
	{
		throw "Not Implemented";
	}

	@:phaserHaxe.mixinIgnore
	private inline function get_angle():Float
	{
		throw "Not Implemented";
	}

	@:phaserHaxe.mixinIgnore
	private inline function set_angle(value:Float):Float
	{
		throw "Not Implemented";
	}

	@:phaserHaxe.mixinIgnore
	private inline function get_rotation():Float
	{
		throw "Not Implemented";
	}

	@:phaserHaxe.mixinIgnore
	private inline function set_rotation(value:Float):Float
	{
		throw "Not Implemented";
	}

	@:phaserHaxe.mixinIgnore
	public function setPosition(x:Float = 0, ?y:Float, z:Float = 0,
			w:Float = 0):ITransform
	{
		throw "Not Implemented";
	}

	@:phaserHaxe.mixinIgnore
	public function setRandomPosition(x:Float = 0, y:Float = 0, ?width:Float,
			?height:Float):ITransform
	{
		throw "Not Implemented";
	}

	@:phaserHaxe.mixinIgnore
	public function setRotation(radians:Float = 0):ITransform
	{
		throw "Not Implemented";
	}

	@:phaserHaxe.mixinIgnore
	public function setAngle(degrees:Float = 0):ITransform
	{
		throw "Not Implemented";
	}

	@:phaserHaxe.mixinIgnore
	public function setScale(x:Float = 1, ?y:Float):ITransform
	{
		throw "Not Implemented";
	}

	@:phaserHaxe.mixinIgnore
	public function setX(value:Float = 0):ITransform
	{
		throw "Not Implemented";
	}

	@:phaserHaxe.mixinIgnore
	public function setY(value:Float = 0):ITransform
	{
		throw "Not Implemented";
	}

	@:phaserHaxe.mixinIgnore
	public function setZ(value:Float = 0):ITransform
	{
		throw "Not Implemented";
	}

	@:phaserHaxe.mixinIgnore
	public function setW(value:Float = 0):ITransform
	{
		throw "Not Implemented";
	}

	@:phaserHaxe.mixinIgnore
	public function getLocalTransformMatrix(?tempMatrix:TransformMatrix):TransformMatrix
	{
		throw "Not Implemented";
	}

	@:phaserHaxe.mixinIgnore
	public function getWorldTransformMatrix(?tempMatrix:TransformMatrix,
			?parentMatrix:TransformMatrix):TransformMatrix
	{
		throw "Not Implemented";
	}

	// ICrop implementation
	@:phaserHaxe.mixinIgnore
	public var texture:Texture = null;

	@:phaserHaxe.mixinIgnore
	public var frame:Frame = null;

	@:phaserHaxe.mixinIgnore
	public var isCropped:Bool = false;

	@:phaserHaxe.mixinIgnore
	public function setCrop(?x:Union<Rectangle, Float>, ?y:Float, ?width:Float,
			?height:Float):CropMixin
	{
		throw "Not Implemented";
	}

	@:phaserHaxe.mixinIgnore
	private function resetCropObject():CropDataObject
	{
		throw "Not Implemented";
	}
}
