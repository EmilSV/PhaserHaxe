package phaserHaxe.gameobjects.components;

import phaserHaxe.gameobjects.components.ICrop;
import phaserHaxe.gameobjects.components.ISize;

@:allow(phaserHaxe.gameobjects.components.OriginImplementation)
@:phaserHaxe.Mixin(phaserHaxe.gameobjects.components.IOrigin.OriginMixin)
interface IOrigin
{
	/**
	 * The horizontal origin of this Game Object.
	 * The origin maps the relationship between the size and position of the Game Object.
	 * The default value is 0.5, meaning all Game Objects are positioned based on their center.
	 * Setting the value to 0 means the position now relates to the left of the Game Object.
	 *
	 * @default 0.5
	 * @since 1.0.0
	**/
	public var originX(get, set):Float;

	/**
	 * The vertical origin of this Game Object.
	 * The origin maps the relationship between the size and position of the Game Object.
	 * The default value is 0.5, meaning all Game Objects are positioned based on their center.
	 * Setting the value to 0 means the position now relates to the top of the Game Object.
	 *
	 * @default 0.5
	 * @since 1.0.0
	 */
	public var originY(get, set):Float;

	//  private + read only
	private var _displayOriginX:Float;
	private var _displayOriginY:Float;

	/**
	 * The horizontal display origin of this Game Object.
	 * The origin is a normalized value between 0 and 1.
	 * The displayOrigin is a pixel value, based on the size of the Game Object combined with the origin.
	 *
	 * @since 1.0.0
	**/
	public var displayOriginX(get, set):Float;

	/**
	 * The vertical display origin of this Game Object.
	 * The origin is a normalized value between 0 and 1.
	 * The displayOrigin is a pixel value, based on the size of the Game Object combined with the origin.
	 *
	 * @since 1.0.0
	**/
	public var displayOriginY(get, set):Float;

	/**
	 * Sets the origin of this Game Object.
	 *
	 * The values are given in the range 0 to 1.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The horizontal origin value.
	 * @param y - The vertical origin value. If not defined it will be set to the value of `x`.
	 *
	 * @return This Game Object instance.
	**/
	public function setOrigin(x:Float = 0.5, ?y:Float):IOrigin;

	/**
	 * Sets the origin of this Game Object based on the Pivot values in its Frame.
	 *
	 * @since 1.0.0
	 *
	 * @return This Game Object instance.
	**/
	public function setOriginFromFrame():IOrigin;

	/**
	 * Sets the display origin of this Game Object.
	 * The difference between this and setting the origin is that you can use pixel values for setting the display origin.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The horizontal display origin value.
	 * @param y - The vertical display origin value. If not defined it will be set to the value of `x`.
	 *
	 * @return {this} This Game Object instance.
	 */
	public function setDisplayOrigin(x:Float = 0, ?y:Float):IOrigin;

	/**
	 * Updates the Display Origin cached values internally stored on this Game Object.
	 * You don't usually call this directly, but it is exposed for edge-cases where you may.
	 *
	 * @since 1.0.0
	 *
	 * @return This Game Object instance.
	 */
	public function updateDisplayOrigin():IOrigin;
}

final class OriginImplementation
{
	public static inline function get_displayOriginX<T:IOrigin>(self:T):Float
	{
		return self._displayOriginX;
	}

	public static function set_displayOriginX<T:IOrigin>(self:T,
			value:Float):Float
	{
		self._displayOriginX = value;
		if (Std.is(self, ISize))
		{
			self.originX = value / (cast self : ISize).width;
		}
		return value;
	}

	public static inline function get_displayOriginY<T:IOrigin>(self:T):Float
	{
		return self._displayOriginY;
	}

	public static function set_displayOriginY<T:IOrigin>(self:T,
			value:Float):Float
	{
		self._displayOriginY = value;
		if (Std.is(self, ISize))
		{
			self.originY = value / (cast self : ISize).height;
		}
		return value;
	}

	public static inline function setOrigin<T:IOrigin>(self:T, x:Float = 0.5, ?y:Float):T
	{
		self.originX = x;
		self.originY = y != null ? y : x;
		return (cast self.updateDisplayOrigin() : T);
	}

	public static inline function setOriginFromFrame<T:IOrigin>(self:T):T
	{
		final selfCrop = cast(self, ICrop);

		if (selfCrop.frame != null || !selfCrop.frame.customPivot)
		{
			self.setOrigin();
		}
		else
		{
			self.originX = selfCrop.frame.pivotX;
			self.originY = selfCrop.frame.pivotY;
			self.updateDisplayOrigin();
		}
		return self;
	}

	public static inline function setDisplayOrigin<T:IOrigin>(self:T, x:Float = 0,
			?y:Float):T
	{
		self.displayOriginX = x;
		self.displayOriginY = y != null ? y : x;

		return self;
	}

	public static inline function updateDisplayOrigin<T:IOrigin>(self:T):T
	{
		final selfSize = cast(self, ISize);

		self._displayOriginX = Math.round(self.originX * selfSize.width);
		self._displayOriginY = Math.round(self.originY * selfSize.height);

		return self;
	}
}

@:phaserHaxe.NoMixin
final class OriginMixin implements IOrigin
{
	public var _originX:Float = 0.5;
	public var _originY:Float = 0.5;

	/**
	 * The horizontal origin of this Game Object.
	 * The origin maps the relationship between the size and position of the Game Object.
	 * The default value is 0.5, meaning all Game Objects are positioned based on their center.
	 * Setting the value to 0 means the position now relates to the left of the Game Object.
	 *
	 * @since 1.0.0
	**/
	public var originX(get, set):Float;

	/**
	 * The vertical origin of this Game Object.
	 * The origin maps the relationship between the size and position of the Game Object.
	 * The default value is 0.5, meaning all Game Objects are positioned based on their center.
	 * Setting the value to 0 means the position now relates to the top of the Game Object.
	 *
	 * @since 1.0.0
	 */
	public var originY(get, set):Float;

	//  private + read only
	private var _displayOriginX:Float = 0;
	private var _displayOriginY:Float = 0;

	/**
	 * The horizontal display origin of this Game Object.
	 * The origin is a normalized value between 0 and 1.
	 * The displayOrigin is a pixel value, based on the size of the Game Object combined with the origin.
	 *
	 * @since 1.0.0
	**/
	public var displayOriginX(get, set):Float;

	/**
	 * The vertical display origin of this Game Object.
	 * The origin is a normalized value between 0 and 1.
	 * The displayOrigin is a pixel value, based on the size of the Game Object combined with the origin.
	 *
	 * @since 1.0.0
	**/
	public var displayOriginY(get, set):Float;

	private function get_displayOriginX():Float
	{
		return OriginImplementation.get_displayOriginX(this);
	}

	private inline function set_displayOriginX(value:Float):Float
	{
		return OriginImplementation.set_displayOriginX(this, value);
	}

	private function get_displayOriginY():Float
	{
		return  OriginImplementation.get_displayOriginX(this);
	}

	private inline function set_displayOriginY(value:Float):Float
	{
		return OriginImplementation.set_displayOriginY(this, value);
	}

	private inline function get_originX():Float
	{
		return _originX;
	}

	private inline function set_originX(value:Float):Float
	{
		return _originX = value;
	}

	private inline function get_originY():Float
	{
		return _originY;
	}

	private inline function set_originY(value:Float):Float
	{
		return _originY = value;
	}

	/**
	 * Sets the origin of this Game Object.
	 *
	 * The values are given in the range 0 to 1.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The horizontal origin value.
	 * @param y - The vertical origin value. If not defined it will be set to the value of `x`.
	 *
	 * @return This Game Object instance.
	**/
	public function setOrigin(x:Float = 0.5, ?y:Float):OriginMixin
	{
		return OriginImplementation.setOrigin(this, x, y);
	}

	/**
	 * Sets the origin of this Game Object based on the Pivot values in its Frame.
	 *
	 * @since 1.0.0
	 *
	 * @return This Game Object instance.
	**/
	public function setOriginFromFrame():OriginMixin
	{
		return OriginImplementation.setOriginFromFrame(this);
	}

	/**
	 * Sets the display origin of this Game Object.
	 * The difference between this and setting the origin is that you can use pixel values for setting the display origin.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The horizontal display origin value.
	 * @param y - The vertical display origin value. If not defined it will be set to the value of `x`.
	 *
	 * @return This Game Object instance.
	**/
	public function setDisplayOrigin(x:Float = 0, ?y:Float):OriginMixin
	{
		return OriginImplementation.setDisplayOrigin(this, x, y);
	}

	/**
	 * Updates the Display Origin cached values internally stored on this Game Object.
	 * You don't usually call this directly, but it is exposed for edge-cases where you may.
	 *
	 * @since 1.0.0
	 *
	 * @return This Game Object instance.
	**/
	public function updateDisplayOrigin():OriginMixin
	{
		return OriginImplementation.updateDisplayOrigin(this);
	}
}
