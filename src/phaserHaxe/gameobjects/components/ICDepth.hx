package phaserHaxe.gameobjects.components;

@:allow(phaserHaxe.gameobjects.components.DepthImplementation)
@:autoBuild(phaserHaxe.macro.Mixin.build(DepthMixin))
interface ICDepth
{
	/**
	 * Private internal value. Holds the depth of the Game Object.
	 *
	 * @default 0
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
	public function setDepth(value:Int = 0):ICDepth;
}

@:noCompletion
final class DepthImplementation
{
	@:generic
	public static inline function get_depth<T:ICDepth>(self:T):Int
	{
		return self._depth;
	}

	@:generic
	public static inline function set_depth<T:ICDepth>(self:T, value:Int):Int
	{
		if (Std.is(self, GameObject))
		{
			(cast self : GameObject).scene.sys.queueDepthSort();
		}
		return self._depth = value;
	}

	@:generic
	public static inline function setDepth<T:ICDepth>(self:T, value:Int):T
	{
		self.depth = value;
		return self;
	}
}

final class DepthMixin
{
	/**
	 * Private internal value. Holds the depth of the Game Object.
	 *
	 * @since 1.0.0
	**/
	private var _depth:Int = 0;

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

	private inline function get_depth():Int
	{
		return DepthImplementation.get_depth(cast this);
	}

	private inline function set_depth(value:Int):Int
	{
		return DepthImplementation.set_depth(cast this, value);
	}

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
	public inline function setDepth(value:Int = 0):DepthMixin
	{
		return cast DepthImplementation.setDepth(cast this, value);
	}
}
