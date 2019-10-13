package phaserHaxe.gameobjects.typedefs;

import haxe.ds.Either;
import phaserHaxe.renderer.ScaleModes;
import phaserHaxe.renderer.BlendModes;

/**
 *
 * @since 1.0.0
**/
typedef GameObjectConfig =
{
	/**
	 * The x position of the Game Object.
	 *
	 * @since 1.0.0
	**/
	public var ?x:Float;

	/**
	 * The y position of the Game Object.
	 *
	 * @since 1.0.0
	**/
	public var ?y:Float;

	/**
	 * The depth of the GameObject
	 *
	 * @since 1.0.0
	**/
	public var ?depth:Float;

	/**
	 * The horizontally flipped state of the Game Object.
	 *
	 * @since 1.0.0
	**/
	public var ?flipX:Bool;

	/**
	 * The vertically flipped state of the Game Object.
	 *
	 * @since 1.0.0
	**/
	public var ?flipY:Bool;

	/**
	 * The scale of the GameObject.
	 *
	 * @since 1.0.0
	**/
	public var ?scale:Either<Float, Dynamic>;

	/**
	 * The scroll factor of the GameObject.
	 *
	 * @since 1.0.0
	**/
	public var ?scrollFactor:Either<Float, Dynamic>;

	/**
	 * The rotation angle of the Game Object, in radians.
	 *
	 * @since 1.0.0
	**/
	public var ?rotation:Float;

	/**
	 * The rotation angle of the Game Object, in degrees.
	 *
	 * @since 1.0.0
	**/
	public var ?angle:Float;

	/**
	 * The alpha (opacity) of the Game Object.
	 *
	 * @since 1.0.0
	**/
	public var ?alpha:Float;

	/**
	 * The origin of the Game Object.
	 *
	 * @since 1.0.0
	**/
	public var ?origin:Either<Float, Dynamic>;

	/**
	 * The scale mode of the GameObject.
	 *
	 * @since 1.0.0
	**/
	public var ?scaleMode:ScaleModes;

	/**
	 * The blend mode of the GameObject.
	 *
	 * @since 1.0.0
	**/
	public var ?blendMode:BlendModes;

	/**
	 * The visible state of the Game Object.
	 *
	 * @since 1.0.0
	**/
	public var ?visible:Bool;

	/**
	 * Add the GameObject to the scene.
	 *
	 * @since 1.0.0
	**/
	public var ?add:Bool;
};
