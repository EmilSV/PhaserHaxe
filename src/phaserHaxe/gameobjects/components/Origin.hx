package phaserHaxe.gameobjects.components;

import phaserHaxe.gameobjects.components.Crop.ICrop;
import phaserHaxe.gameobjects.components.Size.ISize;
import phaserHaxe.gameobjects.components.Depth.IDepth;
#if eval
import haxe.macro.Context;
import haxe.macro.Expr;
import phaserHaxe.macro.ComponentBuilder;
#end

@:allow(phaserHaxe.gameobjects.components.OriginImplementation)
@:autoBuild(phaserHaxe.gameobjects.components.OriginBuilder.build())
interface IOrigin
{
	/**
	 * A property indicating that a Game Object has this component.
	 *
	 * @since 1.0.0
	**/
	private var _originComponent:Bool;

	/**
	 * The horizontal origin of this Game Object.
	 * The origin maps the relationship between the size and position of the Game Object.
	 * The default value is 0.5, meaning all Game Objects are positioned based on their center.
	 * Setting the value to 0 means the position now relates to the left of the Game Object.
	 *
	 * @since 1.0.0
	**/
	public var originX:Float;

	/**
	 * The vertical origin of this Game Object.
	 * The origin maps the relationship between the size and position of the Game Object.
	 * The default value is 0.5, meaning all Game Objects are positioned based on their center.
	 * Setting the value to 0 means the position now relates to the top of the Game Object.
	 *
	 * @since 1.0.0
	 */
	public var originY:Float;

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

@:noCompletion
final class OriginImplementation
{
	@:generic
	public static inline function get_displayOriginX<T:IOrigin>(self:T):Float
	{
		return self._displayOriginX;
	}

	@:generic
	public static inline function set_displayOriginX<T:IOrigin>(self:T,
			value:Float):Float
	{
		final selfSize = cast(self, ISize);

		self._displayOriginX = value;
		self.originX = value / selfSize.width;

		return value;
	}

	@:generic
	public static inline function get_displayOriginY<T:IOrigin>(self:T):Float
	{
		return self._displayOriginY;
	}

	@:generic
	public static inline function set_displayOriginY<T:IOrigin>(self:T,
			value:Float):Float
	{
		final selfSize = cast(self, ISize);

		self._displayOriginY = value;
		self.originY = value / selfSize.height;

		return value;
	}

	@:generic
	public static inline function setOrigin<T:IOrigin>(self:T, x:Float = 0.5, ?y:Float):T
	{
		self.originX = x;
		self.originY = y != null ? y : x;
		return (cast self.updateDisplayOrigin() : T);
	}

	@:generic
	public static inline function setOriginFromFrame<T:IOrigin>(self:T):T
	{
		final selfCrop = cast(self, ICrop);

		if (!selfCrop.frame || !selfCrop.frame.customPivot)
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

	@:generic
	public static inline function setDisplayOrigin<T:IOrigin>(self:T, x:Float = 0,
			?y:Float):T
	{
		self.displayOriginX = x;
		self.displayOriginY = y != null ? y : x;

		return self;
	}

	@:generic
	public static inline function updateDisplayOrigin<T:IOrigin>(self:T):T
	{
		final selfSize = cast(self, ISize);

		self._displayOriginX = Math.round(self.originX * selfSize.width);
		self._displayOriginY = Math.round(self.originY * selfSize.height);

		return self;
	}
}

final class OriginBuilder
{
	#if eval
	public static function build():Array<Field>
	{
		final builder = new ComponentBuilder();

		builder.addVar({
			name: "_originComponent",
			doc: "A property indicating that a Game Object has a origin component.",
			access: [APrivate],
			type: macro:Bool,
			expr: macro true,
		})
			.addVar({
				name: "originX",

				doc: "The horizontal origin of this Game Object.
			The origin maps the relationship between the size and position of the Game Object.
			The default value is 0.5, meaning all Game Objects are positioned based on their center.
			Setting the value to 0 means the position now relates to the left of the Game Object.",

				type: macro:Float,
				expr: macro 0.5
			})
			.addVar({
				name: "originY",

				doc: "The vertical origin of this Game Object.
			The origin maps the relationship between the size and position of the Game Object.
			The default value is 0.5, meaning all Game Objects are positioned based on their center.
			Setting the value to 0 means the position now relates to the top of the Game Object.",

				type: macro:Float,
				expr: macro 0.5
			})
			.addVar({
				name: "_displayOriginX",
				doc: "internal private value use displayOriginX instead",
				type: macro:Float,
				expr: macro 0
			})
			.addVar({
				name: "_displayOriginY",
				doc: "internal private value use displayOriginY instead",
				type: macro:Float,
				expr: macro 0
			})
			.addPropriety({
				name: "displayOriginX",

				doc: "The horizontal display origin of this Game Object.
				The origin is a normalized value between 0 and 1. 
				The displayOrigin is a pixel value, based on the size of the Game Object combined with the origin.",

				type: macro:Float,
				get: macro return
					phaserHaxe.gameobjects.components.OriginImplementation.get_displayOriginX(this),
				set: macro return
					phaserHaxe.gameobjects.components.OriginImplementation.set_displayOriginX(this, value)
			})
			.addPropriety({
				name: "displayOriginY",

				doc: "The vertical display origin of this Game Object.
				The origin is a normalized value between 0 and 1. 
				The displayOrigin is a pixel value, based on the size of the Game Object combined with the origin.",

				type: macro:Float,
				get: macro return
					phaserHaxe.gameobjects.components.OriginImplementation.get_displayOriginY(this),
				set: macro return
					phaserHaxe.gameobjects.components.OriginImplementation.set_displayOriginY(this, value)
			})
			.addFunction({
				name: "setOrigin",

				doc: "Sets the origin of this Game Object.
				The values are given in the range 0 to 1.
				
				h@param x - The horizontal origin value.
				@param y - The vertical origin value. If not defined it will be set to the value of `x`.
				
				@return This Game Object instance.",

				args: [
					{
						name: "x",
						type: macro:Float,
						value: macro 0.5
					},
					{
						name: "y",
						type: macro:Float,
						opt: true
					}
				],
				expr: macro return phaserHaxe.gameobjects.components.OriginImplementation.setOrigin(this, x, y),
				ret: builder.buildType,
			})
			.addFunction({
				name: "setOriginFromFrame",

				doc: "Sets the origin of this Game Object based on the Pivot values in its Frame.
				@return This Game Object instance.",

				expr: macro return phaserHaxe.gameobjects.components.OriginImplementation.setOriginFromFrame(this),
				ret: builder.buildType,
			})
			.addFunction({
				name: "setDisplayOrigin",

				doc: "Sets the display origin of this Game Object.
				The difference between this and setting the origin is that you can use pixel values for setting the display origin.
				
				@param x - The horizontal display origin value.
				@param y - The vertical display origin value. If not defined it will be set to the value of `x`.
				
				@return This Game Object instance.",

				args: [
					{
						name: "x",
						type: macro:Float,
						value: macro 0
					},
					{
						name: "y",
						type: macro:Float,
						opt: true
					}
				],
				expr: macro return phaserHaxe.gameobjects.components.OriginImplementation.setDisplayOrigin(this, x, y),
				ret: builder.buildType,
			})
			.addFunction({
				name: "updateDisplayOrigin",

				doc: "Updates the Display Origin cached values internally stored on this Game Object.
				You don't usually call this directly, but it is exposed for edge-cases where you may.
				
				@return This Game Object instance.",

				expr: macro return phaserHaxe.gameobjects.components.OriginImplementation.updateDisplayOrigin(this),
				ret: builder.buildType,
			});

		return builder.createFelids();
	}
	#end
}
