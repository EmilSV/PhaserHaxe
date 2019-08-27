package phaserHaxe.gameobjects.components;

@:allow(phaserHaxe.gameobjects.components.DepthImplementation)
@:phaserHaxe.Mixin(phaserHaxe.gameobjects.components.IDepth.DepthMixin)
interface IDepth
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
	public function setDepth(value:Int = 0):IDepth;
}

final class DepthImplementation
{
	public static inline function get_depth<T:IDepth>(self:T):Int
	{
		return self._depth;
	}

	public static inline function set_depth<T:IDepth & GameObject>(self:T, value:Int):Int
	{
		self.scene.sys.queueDepthSort();
		return self._depth = value;
	}

	public static inline function setDepth<T:IDepth>(self:T, value:Int):T
	{
		self.depth = value;
		return self;
	}
}

final class DepthMixin extends GameObject implements IDepth
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
		return DepthImplementation.get_depth(this);
	}

	private inline function set_depth(value:Int):Int
	{
		return DepthImplementation.set_depth(this, value);
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
		return cast DepthImplementation.setDepth(this, value);
	}
}
