package phaserHaxe.gameobjects.components;

#if eval
import haxe.macro.Context;
import haxe.macro.Expr;
#end
import phaserHaxe.gameobjects.components.Crop;
import phaserHaxe.gameobjects.components.Transform;

using Lambda;

interface ISize
{
	/**
	 * A property indicating that a Game Object has this component.
	 *
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
	public function setSizeToFrame(?frame:Frame):ISize;

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
	public function setSize(width:Float, height:Float):ISize;

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
	public function setDisplaySize(width:Float, height:Float):ISize;
}

@:noCompletion
final class SizeImplementation
{
	@:generic
	public static inline function get_displayWidth<T:ISize>(self:T):Float
	{
		if (Std.is(self, ITransform) && Std.is(self, ICrop))
		{
			return (cast self : ITransform).scaleX * (cast self : ICrop).frame.realWidth;
		}
		return 0;
	}

	@:generic
	public static inline function set_displayWidth<T:ISize>(self:T, value:Float):Float
	{
		if (Std.is(self, ITransform) && Std.is(self, ICrop))
		{
			return (cast self : ITransform)
				.scaleX = value / (cast self : ICrop).frame.realWidth;
		}
		return 0;
	}

	@:generic
	public static inline function get_displayHeight<T:ISize>(self:T):Float
	{
		if (Std.is(self, ITransform) && Std.is(self, ICrop))
		{
			return (cast self : ITransform).scaleY * (cast self : ICrop).frame.realHeight;
		}

		return 0;
	}

	@:generic
	public static inline function set_displayHeight<T:ISize>(self:T, value:Float):Float
	{
		if (Std.is(self, ITransform) && Std.is(self, ICrop))
		{
			return (cast self : ITransform)
				.scaleY = value / (cast self : ICrop).frame.realHeight;
		}

		return 0;
	}

	@:generic
	public static inline function setSizeToFrame<T:ISize>(self:T, ?frame:Frame):T
	{
		if (frame == null && Std.is(self, ICrop))
		{
			frame = (cast self : ICrop).frame;
		}

		self.width = frame.realWidth;
		self.height = frame.realHeight;

		return self;
	}

	@:generic
	public static inline function setSize<T:ISize>(self:T, width:Float, height:Float):T
	{
		self.width = width;
		self.height = height;
		return self;
	}

	@:generic
	public static inline function setDisplaySize<T:ISize>(self:T, width:Float,
			height:Float):T
	{
		self.displayWidth = width;
		self.displayHeight = height;

		return self;
	}
}

final class SizeBuilder
{
	#if eval
	public static function build():Array<Field>
	{
		final fields = Context.getBuildFields();
		final pos = Context.currentPos();
		final buildType = Context.toComplexType(Context.getLocalType());
		final newFelids:Array<Field> = [];

		function addField(field:Field)
		{
			newFelids.push(field);
		}

		addField({
			name: "_sizeComponent",
			doc: "A property indicating that a Game Object has this component.",
			access: [APrivate],
			kind: FVar(macro:Bool),
			pos: pos
		});

		addField({
			name: "width",

			doc: "The native (un-scaled) width of this Game Object.

			Changing this value will not change the size that the Game Object is rendered in-game.
			For that you need to either set the scale of the Game Object (`setScale`) or use
			the `displayWidth` property.",

			access: [APublic],
			kind: FVar(macro:Float),
			pos: pos
		});

		addField({
			name: "height",

			doc: "The native (un-scaled) height of this Game Object.
			
			Changing this value will not change the size that the Game Object is rendered in-game. 
			For that you need to either set the scale of the Game Object (`setScale`) or use 
			the `displayHeight` property.",

			access: [APublic],
			kind: FVar(macro:Float),
			pos: pos
		});

		addField({
			name: "displayWidth",
			doc: "",
			access: [APublic],
			kind: FProp("get", "set", macro:Float),
			pos: pos
		});

		addField({
			name: "get_displayWidth",
			doc: "",
			access: [APrivate],
			kind: FFun({
				args: [],
				ret: macro:Float,
				expr: macro return get_displayWidth(self)
			}),
			pos: pos
		});

		addField({
			name: "set_displayWidth",
			doc: "",
			access: [APrivate],
			kind: FFun({
				args: [
					{
						name: "value",
						type: macro:Float
					}
				],
				ret: macro:Float,
				expr: macro return set_displayWidth(this, value)
			}),
			pos: pos
		});

		addField({
			name: "displayHeight",
			doc: "",
			access: [APublic],
			kind: FProp("get", "set", macro:Float),
			pos: pos
		});

		addField({
			name: "get_displayHeight",
			doc: "",
			access: [APrivate],
			kind: FFun({
				args: [],
				ret: macro:Float,
				expr: macro return get_displayHeight(self)
			}),
			pos: pos
		});

		addField({
			name: "set_displayHeight",
			doc: "",
			access: [APrivate],
			kind: FFun({
				args: [
					{
						name: "value",
						type: macro:Float
					}
				],
				ret: macro:Float,
				expr: macro return set_displayHeight(this, value)
			}),
			pos: pos
		});

		addField({
			name: "setSizeToFrame",
			doc: "",
			access: [APublic],
			kind: FFun({
				args: [{name: "frame", opt: true, type: macro:Dynamic}],
				expr: macro return
					phaserHaxe.gameobjects.components.Size.SizeImplementation.setSizeToFrame(this, frame),
				ret: buildType,
			}),
			pos: pos
		});

		addField({
			name: "setSize",
			doc: "",
			access: [APublic],
			kind: FFun({
				args: [
					{
						name: "width",
						type: macro:Float
					},
					{
						name: "height",
						type: macro:Float
					}
				],
				expr: macro return
					phaserHaxe.gameobjects.components.Size.SizeImplementation.setSize(this, width, height),
				ret: buildType,
			}),
			pos: pos
		});

		addField({
			name: "setDisplaySize",
			doc: "",
			access: [APublic],
			kind: FFun({
				args: [
					{
						name: "width",
						type: macro:Float
					},
					{
						name: "height",
						type: macro:Float
					}
				],
				expr: macro return
					phaserHaxe.gameobjects.components.Size.SizeImplementation.setDisplaySize(this, width, height),
				ret: buildType,
			}),
			pos: pos
		});

		return newFelids.filter((f1) -> !fields.exists((f2) -> f1.name == f2.name))
			.concat(fields);
	}
	#end
}
