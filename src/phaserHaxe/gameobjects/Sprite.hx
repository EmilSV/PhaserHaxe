package phaserHaxe.gameobjects;

import phaserHaxe.gameobjects.components.ICTransform;

class Sprite implements ICTransform
{
	/**
	 * Private internal value. Holds the horizontal scale value.
	 *
	 * @since 1.0.0
	**/
	private var _scaleX:Float;

	/**
	 * Private internal value. Holds the vertical scale value.
	 *
	 * @since 1.0.0
	**/
	private var _scaleY:Float;

	/**
	 * Private internal value. Holds the rotation value in radians.
	 *
	 * @since 1.0.0
	**/
	private var _rotation:Float;

	/**
	 * The x position of this Game Object.
	 *
	 * @since 1.0.0
	**/
	public var x:Float;

	/**
	 * The y position of this Game Object.
	 *
	 * @since 1.0.0
	**/
	public var y:Float;

	/**
	 * The z position of this Game Object.
	 * Note: Do not use this value to set the z-index, instead see the `depth` property.
	 *
	 * @since 1.0.0
	**/
	public var z:Float;

	/**
	 * The w position of this Game Object.
	 *
	 * @since 1.0.0
	**/
	public var w:Float;
}
