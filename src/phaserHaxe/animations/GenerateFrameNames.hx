package phaserHaxe.animations;

import phaserHaxe.animations.AnimationFrameConfig;

/**
 *
 *
 * @since 1.0.0
**/
typedef GenerateFrameNames =
{
	/**
	 * The string to append to every resulting frame name if using a range or an array of `frames`.
	 *
	 * @since 1.0.0
	**/
	public var ?prefix:String;

	/**
	 * If `frames` is not provided, the number of the first frame to return.
	 *
	 * @since 1.0.0
	**/
	public var ?start:Int;

	/**
	 * If `frames` is not provided, the number of the last frame to return.
	 *
	 * @since 1.0.0
	**/
	public var ?end:Int;

	/**
	 * The string to append to every resulting frame name if using a range or an array of `frames`.
	 *
	 * @since 1.0.0
	**/
	public var ?suffix:String;

	/**
	 * The minimum expected lengths of each resulting frame's number. Numbers will be left-padded with zeroes until they are this long, then prepended and appended to create the resulting frame name.
	 *
	 * @since 1.0.0
	**/
	public var ?zeroPad:Int;

	/**
	 * The array to append the created configuration objects to.
	 *
	 * @since 1.0.0
	**/
	public var ?outputArray:Array<AnimationFrameConfig>;

	/**
	 * If provided as an array, the range defined by `start` and `end` will be ignored and these frame numbers will be used.
	 *
	 * @since 1.0.0
	**/
	public var ?frames:Either<Bool, Array<String>>;
};

/**
 * @typedef {object} Phaser.Types.Animations.GenerateFrameNames
 * @since 3.0.0
 *
 * @property {string} [prefix=''] - The string to append to every resulting frame name if using a range or an array of `frames`.
 * @property {integer} [start=0] - If `frames` is not provided, the number of the first frame to return.
 * @property {integer} [end=0] - If `frames` is not provided, the number of the last frame to return.
 * @property {string} [suffix=''] - The string to append to every resulting frame name if using a range or an array of `frames`.
 * @property {integer} [zeroPad=0] - The minimum expected lengths of each resulting frame's number. Numbers will be left-padded with zeroes until they are this long, then prepended and appended to create the resulting frame name.
 * @property {Phaser.Types.Animations.AnimationFrame[]} [outputArray=[]] - The array to append the created configuration objects to.
 * @property {boolean} [frames=false] - If provided as an array, the range defined by `start` and `end` will be ignored and these frame numbers will be used.
 */
