package phaserHaxe.gameobjects.components;

interface ISize
{
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
