package phaserHaxe.animations;

import phaserHaxe.animations.AnimationFrameData;

typedef AnimationData =
{
	/**
	 * The key that the animation will be associated with. i.e. sprite.animations.play(key)
	 *
	 * @since 1.0.0
	**/
	public var ?key:String;

	/**
	 * A frame based animation (as opposed to a bone based animation)
	 *
	 * @since 1.0.0
	**/
	public var ?type:String;

	/**
	 *  An object containing data used to generate the frames for the animation
	 *
	 * @since 1.0.0
	**/
	public var ?frames:Array<AnimationFrameData>;

	/**
	 * The key of the texture all frames of the animation will use. Can be overridden on a per frame basis.
	 *
	 * @since 1.0.0
	**/
	public var ?defaultTextureKey:String;

	/**
	 * The frame rate of playback in frames per second (default 24 if duration is null)
	 *
	 * @since 1.0.0
	**/
	public var ?frameRate:Int;

	/**
	 * How long the animation should play for in milliseconds. If not given its derived from frameRate.
	 *
	 * @since 1.0.0
	**/
	public var ?duration:Int;

	/**
	 * Skip frames if the time lags, or always advanced anyway?
	 *
	 * @since 1.0.0
	**/
	public var ?skipMissedFrames:Bool;

	/**
	 * Delay before starting playback. Value given in milliseconds.
	 *
	 * @since 1.0.0
	**/
	public var ?delay:Int;

	/**
	 * Number of times to repeat the animation (-1 for infinity)
	 *
	 * @since 1.0.0
	**/
	public var ?repeat:Int;

	/**
	 * Delay before the animation repeats. Value given in milliseconds.
	 *
	 * @since 1.0.0
	**/
	public var ?repeatDelay:Int;

	/**
	 * Should the animation yoyo? (reverse back down to the start) before repeating?
	 *
	 * @since 1.0.0
	**/
	public var ?yoyo:Bool;

	/**
	 * Should sprite.visible = true when the animation starts to play?
	 *
	 * @since 1.0.0
	**/
	public var ?showOnStart:Bool;

	/**
	 * Should sprite.visible = false when the animation finishes?
	 *
	 * @since 1.0.0
	**/
	public var ?hideOnComplete:Bool;
}
