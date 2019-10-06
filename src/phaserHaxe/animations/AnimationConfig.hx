package phaserHaxe.animations;

/**
 * [description]
 *
 * @since 1.0.0
**/
@:structInit
final class AnimationConfig
{
	@:allow(phaserHaxe.animations)
	private static final defaultInstance:AnimationConfig = {};

	/**
	 * The key that the animation will be associated with. i.e. sprite.animations.play(key)
	 *
	 * @since 1.0.0
	**/
	public var key:Null<String>;

	/**
	 * An object containing data used to generate the frames for the animation
	 *
	 * @since 1.0.0
	**/
	public var frames:Null<Array<AnimationFrameConfig>>;

	/**
	 * The key of the texture all frames of the animation will use. Can be overridden on a per frame basis.
	 *
	 * @since 1.0.0
	**/
	public var defaultTextureKey:Null<String>;

	/**
	 * The frame rate of playback in frames per second (default 24 if duration is null)
	 *
	 * @since 1.0.0
	**/
	public var frameRate:Null<Int>;

	/**
	 * How long the animation should play for in milliseconds. If not given its derived from frameRate.
	 *
	 * @since 1.0.0
	**/
	public var duration:Null<Int>;

	/**
	 * Skip frames if the time lags, or always advanced anyway?
	 *
	 * @since 1.0.0
	**/
	public var skipMissedFrames:Bool;

	/**
	 * Delay before starting playback. Value given in milliseconds.
	 *
	 * @since 1.0.0
	**/
	public var delay:Int;

	/**
	 * Delay before starting playback. Value given in milliseconds.
	 *
	 * @since 1.0.0
	**/
	public var repeat:Int;

	/**
	 * Delay before the animation repeats. Value given in milliseconds.
	 *
	 * @since 1.0.0
	**/
	public var repeatDelay:Int;

	/**
	 * Should the animation yoyo? (reverse back down to the start) before repeating?
	 *
	 * @since 1.0.0
	**/
	public var yoyo:Bool;

	/**
	 * Should sprite.visible = true when the animation starts to play?
	 *
	 * @since 1.0.0
	**/
	public var showOnStart:Bool;

	/**
	 * Should sprite.visible = true when the animation starts to play?
	 *
	 * @since 1.0.0
	**/
	public var hideOnComplete:Bool;

	public function new(?key:String, ?frames:Array<AnimationFrameConfig>,
			?defaultTextureKey:String, ?frameRate:Int, ?duration:Int,
			skipMissedFrames:Bool = true, delay:Int = 0, repeat:Int = 0,
			repeatDelay:Int = 0, yoyo:Bool = false, showOnStart:Bool = false,
			hideOnComplete:Bool = false)
	{
		this.key = key;
		this.frames = frames;
		this.defaultTextureKey = defaultTextureKey;
		this.skipMissedFrames = skipMissedFrames;
		this.delay = delay;
		this.repeat = repeat;
		this.repeatDelay = repeatDelay;
		this.yoyo = yoyo;
		this.showOnStart = showOnStart;
		this.hideOnComplete = hideOnComplete;
	}
}
