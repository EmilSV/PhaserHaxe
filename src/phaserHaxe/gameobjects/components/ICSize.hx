package phaserHaxe.gameobjects.components;

import phaserHaxe.gameobjects.components.ICCrop;
import phaserHaxe.gameobjects.components.ICTransform;

@:autoBuild(phaserHaxe.macro.Mixin.build(SizeMixin))
interface ICSize
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
	 * For that you need to either set the scale of the Game Object (`setScale`) or use
	 * the `displayWidth` property.
	 *
	 * @since 1.0.0
	**/
	public var width:Float;

	/**
	 * The native (un-scaled) height of this Game Object.
	 *
	 * Changing this value will not change the size that the Game Object is rendered in-game.
	 * For that you need to either set the scale of the Game Object (`setScale`) or use
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
	 * For that you need to either set the scale of the Game Object (`setScale`) or call the
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
	public function setSizeToFrame(?frame:Frame):ICSize;

	/**
	 * Sets the internal size of this Game Object, as used for frame or physics body creation.
	 *
	 * This will not change the size that the Game Object is rendered in-game.
	 * For that you need to either set the scale of the Game Object (`setScale`) or call the
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
	public function setSize(width:Float, height:Float):ICSize;

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
	public function setDisplaySize(width:Float, height:Float):ICSize;
}

@:noCompletion
final class SizeImplementation
{
	@:generic
	public static inline function get_displayWidth<T:ICSize>(self:T):Float
	{
		if (Std.is(self, ICTransform) && Std.is(self, ICCrop))
		{
			return (cast self : ICTransform).scaleX * (cast self : ICCrop)
				.frame.realWidth;
		}
		return 0;
	}

	@:generic
	public static inline function set_displayWidth<T:ICSize>(self:T, value:Float):Float
	{
		if (Std.is(self, ICTransform) && Std.is(self, ICCrop))
		{
			return (cast self : ICTransform).scaleX = value / (cast self : ICCrop)
				.frame.realWidth;
		}
		return 0;
	}

	@:generic
	public static inline function get_displayHeight<T:ICSize>(self:T):Float
	{
		if (Std.is(self, ICTransform) && Std.is(self, ICCrop))
		{
			return (cast self : ICTransform).scaleY * (cast self : ICCrop)
				.frame.realHeight;
		}

		return 0;
	}

	@:generic
	public static inline function set_displayHeight<T:ICSize>(self:T, value:Float):Float
	{
		if (Std.is(self, ICTransform) && Std.is(self, ICCrop))
		{
			return (cast self : ICTransform).scaleY = value / (cast self : ICCrop)
				.frame.realHeight;
		}

		return 0;
	}

	@:generic
	public static inline function setSizeToFrame<T:ICSize>(self:T, ?frame:Frame):T
	{
		if (frame == null && Std.is(self, ICCrop))
		{
			frame = (cast self : ICCrop).frame;
		}

		self.width = frame.realWidth;
		self.height = frame.realHeight;

		return self;
	}

	@:generic
	public static inline function setSize<T:ICSize>(self:T, width:Float, height:Float):T
	{
		self.width = width;
		self.height = height;
		return self;
	}

	@:generic
	public static inline function setDisplaySize<T:ICSize>(self:T, width:Float,
			height:Float):T
	{
		self.displayWidth = width;
		self.displayHeight = height;

		return self;
	}
}

@:phaserHaxe.NoMixin
final class SizeMixin implements ICSize
{
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
	 * For that you need to either set the scale of the Game Object (`setScale`) or use
	 * the `displayWidth` property.
	 *
	 * @since 1.0.0
	**/
	public var width:Float = 0;

	/**
	 * The native (un-scaled) height of this Game Object.
	 *
	 * Changing this value will not change the size that the Game Object is rendered in-game.
	 * For that you need to either set the scale of the Game Object (`setScale`) or use
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
		return SizeImplementation.get_displayWidth(this);
	}

	private function set_displayWidth(value:Float):Float
	{
		return SizeImplementation.set_displayWidth(this, value);
	}

	private function get_displayHeight():Float
	{
		return SizeImplementation.get_displayHeight(this);
	}

	private function set_displayHeight(value:Float):Float
	{
		return SizeImplementation.set_displayHeight(this, value);
	}

	/**
	 * Sets the size of this Game Object to be that of the given Frame.
	 *
	 * This will not change the size that the Game Object is rendered in-game.
	 * For that you need to either set the scale of the Game Object (`setScale`) or call the
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
	public function setSizeToFrame(?frame:Frame):SizeMixin
	{
		return SizeImplementation.setSizeToFrame(this, frame);
	}

	/**
	 * Sets the internal size of this Game Object, as used for frame or physics body creation.
	 *
	 * This will not change the size that the Game Object is rendered in-game.
	 * For that you need to either set the scale of the Game Object (`setScale`) or call the
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
	public function setSize(width:Float, height:Float):SizeMixin
	{
		return SizeImplementation.setSize(this, width, height);
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
	public function setDisplaySize(width:Float, height:Float):SizeMixin
	{
		return SizeImplementation.setDisplaySize(this, width, height);
	}
}
