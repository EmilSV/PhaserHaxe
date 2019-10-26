package phaserHaxe.animations;

import phaserHaxe.animations.AnimationFrameConfig;
import phaserHaxe.utils.types.StringOrInt;
import phaserHaxe.utils.types.Union;

/**
 *
 *
 * @since 1.0.0
**/
typedef GenerateFrameNumbers =
{
	/**
	 * The starting frame of the animation.
	 *
	 * @since 1.0.0
	**/
	public var ?start:Int;

	/**
		*The ending frame of the animation.
		*
		* @since 1.0.0
	**/
	public var ?end:Int;

	/**
	 * A frame to put at the beginning of the animation, before `start` or `outputArray` or `frames`.
	 *
	 * @since 1.0.0
	**/
	public var ?first:StringOrInt;

	/**
	 * An array to concatenate the output onto.
	 *
	 * @since 1.0.0
	**/
	public var ?outputArray:Array<AnimationFrameConfig>;

	/**
	 * A custom sequence of frames.
	 *
	 * @since 1.0.0
	**/
	public var ?frames:Union<Bool, Array<Int>>;
};
