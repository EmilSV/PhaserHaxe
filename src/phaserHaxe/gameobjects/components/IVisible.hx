package phaserHaxe.gameobjects.components;

@:allow(phaserHaxe.gameobjects.components.VisibleImplementation)
@:phaserHaxe.Mixin(phaserHaxe.gameobjects.components.IVisible.VisibleMixin)
interface IVisible
{
	/**
	 * Private internal value. Holds the visible value.
	 *
	 * @default true
	 * @since 1.0.0
	**/
	private var _visible:Bool;

	/**
	 * The visible state of the Game Object.
	 *
	 * An invisible Game Object will skip rendering, but will still process update logic.
	 *
	 * @since 1.0.0
	**/
	public var visible(get, set):Bool;

	/**
	 * Sets the visibility of this Game Object.
	 *
	 * An invisible Game Object will skip rendering, but will still process update logic.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The visible state of the Game Object.
	 *
	 * @return This Game Object instance.
	**/
	public function setVisible(value:Bool):IVisible;
}

final class VisibleImplementation
{
	private static inline var _FLAG = 1;

	public static inline function get_visible<T:IVisible>(self:T):Bool
	{
		return self._visible;
	}

	public static inline function set_visible<T:IVisible & IHaveRenderFlags>(self:T,
			value:Bool):Bool
	{
		if (value)
		{
			self._visible = true;
			self.renderFlags |= _FLAG;
		}
		else
		{
			self._visible = false;
			self.renderFlags &= ~_FLAG;
		}
		return value;
	}

	public static inline function setVisible<T:IVisible & IHaveRenderFlags>(self:T,
			value:Bool):T
	{
		self.visible = value;
		return self;
	}
}

final class VisibleMixin implements IHaveRenderFlags implements IVisible
{
	@:phaserHaxe.mixinIgnore
	public var renderFlags:RenderFlags;

	/**
	 * Private internal value. Holds the visible value.
	 *
	 * @since 1.0.0
	**/
	private var _visible:Bool = true;

	/**
	 * The visible state of the Game Object.
	 *
	 * An invisible Game Object will skip rendering, but will still process update logic.
	 *
	 * @since 1.0.0
	**/
	public var visible(get, set):Bool;

	private inline function get_visible():Bool
	{
		return VisibleImplementation.get_visible(this);
	}

	private function set_visible(value:Bool):Bool
	{
		return VisibleImplementation.set_visible(this, value);
	}

	/**
	 * Sets the visibility of this Game Object.
	 *
	 * An invisible Game Object will skip rendering, but will still process update logic.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The visible state of the Game Object.
	 *
	 * @return This Game Object instance.
	**/
	public function setVisible(value:Bool):VisibleMixin
	{
		return VisibleImplementation.setVisible(this, value);
	}
}
