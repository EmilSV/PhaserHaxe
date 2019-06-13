package phaserHaxe.gameobjects.components;

#if eval
import haxe.macro.Context;
import haxe.macro.Expr;
#end

using Lambda;

@:allow(phaserHaxe.gameobjects.components.DepthImplementation)
@:autoBuild(phaserHaxe.gameobjects.components.DepthBuilder.build())
interface IDepth
{
	/**
	 * Private internal value. Holds the depth of the Game Object.
	 *
	 * @since 1.0.0
	**/
	private var _depth:Int;

	/**
	 * The depth of this Game Object within the Scene.
	 *
	 * The depth is also known as the 'z-index' in some environments, and allows you to change the rendering order
	 * of Game Objects, without actually moving their position in the display list.
	 *
	 * The depth starts from zero (the default value) and increases from that point. A Game Object with a higher depth
	 * value will always render in front of one with a lower value.
	 *
	 * Setting the depth will queue a depth sort event within the Scene.
	 *
	 * @since 1.0.0
	**/
	public var depth(get, set):Int;

	/**
	 * The depth of this Game Object within the Scene.
	 *
	 * The depth is also known as the 'z-index' in some environments, and allows you to change the rendering order
	 * of Game Objects, without actually moving their position in the display list.
	 *
	 * The depth starts from zero (the default value) and increases from that point. A Game Object with a higher depth
	 * value will always render in front of one with a lower value.
	 *
	 * Setting the depth will queue a depth sort event within the Scene.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The depth of this Game Object.
	 *
	 * @return This Game Object instance.
	**/
	public function setDepth(value:Int = 0):IDepth;
}

@:noCompletion
final class DepthImplementation
{
	@:generic
	public static inline function get_depth<T:IDepth>(self:T):Int
	{
		return self._depth;
	}

	@:generic
	public static inline function set_depth<T:IDepth>(self:T, value:Int):Int
	{
		if (Std.is(self, GameObject))
		{
			(cast self : GameObject).scene.sys.queueDepthSort();
		}
		return self._depth = value;
	}

	@:generic
	public static inline function setDepth<T:IDepth>(self:T, value:Int = 0):T
	{
		self.depth = value;
		return self;
	}
}

final class DepthBuilder
{
	#if eval
	public static function build():Array<Field>
	{
		// get existing fields from the context from where build() is called
		final fields = Context.getBuildFields();
		final pos = Context.currentPos();
		final buildType = Context.toComplexType(Context.getLocalType());
		final newFelids:Array<Field> = [];

		function addField(field:Field)
		{
			newFelids.push(field);
		}

		addField({
			name: "_depth",
			doc: "Private internal value. Holds the depth of the Game Object.",
			access: [APrivate],
			kind: FVar(macro:Int, macro 0),
			pos: pos
		});

		addField({
			name: "depth",

			doc: "The depth of this Game Object within the Scene.
            The depth is also known as the 'z-index' in some environments, and allows you to change the rendering order 
            of Game Objects, without actually moving their position in the display list.
            
            The depth starts from zero (the default value) and increases from that point. A Game Object with a higher depth 
            value will always render in front of one with a lower value.
            
            Setting the depth will queue a depth sort event within the Scene.",

			access: [APublic],
			kind: FProp("get", "set", macro:Int),
			pos: pos
		});

		addField({
			name: "get_depth",
			access: [APrivate, AInline],
			kind: FFun({
				args: [],
				ret: macro:Int,
				expr: macro return
					phaserHaxe.gameobjects.components.DepthImplementation.get_depth(this)
			}),
			pos: pos
		});

		addField({
			name: "set_depth",
			access: [APrivate, AInline],
			kind: FFun({
				args: [
					{
						name: "value",
						type: macro:Int
					}
				],
				ret: macro:Int,
				expr: macro return
					phaserHaxe.gameobjects.components.DepthImplementation.set_depth(this, value)
			}),
			pos: pos
		});

		addField({
			name: "setDepth",
			doc: "The depth of this Game Object within the Scene.
            
            The depth is also known as the 'z-index' in some environments, and allows you to change the rendering order
            of Game Objects, without actually moving their position in the display list.
            The depth starts from zero (the default value) and increases from that point. A Game Object with a higher depth 
            value will always render in front of one with a lower value. 
            Setting the depth will queue a depth sort event within the Scene.
            
            @param value - The depth of this Game Object.
            @return This Game Object instance.",

			access: [APublic, AInline],
			kind: FFun({
				args: [
					{
						name: "value",
						value: macro 0,
						type: macro:Int
					}
				],
				ret: buildType,
				expr: macro return
					phaserHaxe.gameobjects.components.DepthImplementation.setDepth(this, value)
			}),
			pos: pos
		});

		return newFelids.filter((f1) -> !fields.exists((f2) -> f1.name == f2.name))
			.concat(fields);
	}
	#end
}
