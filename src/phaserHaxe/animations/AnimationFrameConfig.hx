package phaserHaxe.animations;

import phaserHaxe.utils.StringOrInt;

/**
 *
 * @since 1.0.0
**/
typedef AnimationFrameConfig =
{
	/**
	 *  The key that the animation will be associated with. i.e. sprite.animations.play(key)
	 *
	 * @since 1.0.0
	**/
	public var key:String;

	/**
	 * The key of the Frame within the Texture that this AnimationFrame uses.
	 *
	 * @since 1.0.0
	**/
	public var frame:StringOrInt;

	/**
	 * Additional time (in ms) that this frame should appear for during playback.
	 *
	 * @since 1.0.0
	**/
	public var ?duration:Float;

	/**
	 *  [description]
	 *
	 * @since 1.0.0
	**/
	public var ?visible:Bool;
}
