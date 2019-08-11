package phaserHaxe.gameobjects.components;

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
