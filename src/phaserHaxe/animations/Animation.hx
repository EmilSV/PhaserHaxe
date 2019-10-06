package phaserHaxe.animations;

import phaserHaxe.textures.Texture;
import phaserHaxe.textures.Frame;
import phaserHaxe.textures.TextureManager;


/**
 * A Frame based Animation.
 *
 * This consists of a key, some default values (like the frame rate) and a bunch of Frame objects.
 *
 * The Animation Manager creates these. Game Objects don't own an instance of these directly.
 * Game Objects have the Animation Component, which are like playheads to global Animations (these objects)
 * So multiple Game Objects can have playheads all pointing to this one Animation instance.
 *
 * @since 1.0.0
 *
**/
class Animation extends EventEmitter
{
	/**
	 * A reference to the global Animation Manager.
	 *
	 * @since 1.0.0
	**/
	public var manager:AnimationManager;

	/**
	 * The unique identifying string for this animation.
	 *
	 * @since 1.0.0
	**/
	public var key:String;

	/**
	 * A frame based animation (as opposed to a bone based animation)
	 *
	 * @since 1.0.0
	**/
	public var type:String = 'frame';

	/**
	 * Extract all the frame data into the frames array.
	 *
	 * @since 1.0.0
	**/
	public var frames:Array<AnimationFrame>;

	/**
	 * The frame rate of playback in frames per second (default 24 if duration is null)
	 *
	 * @since 1.0.0
	**/
	public var frameRate:Int;

	/**
	 * How long the animation should play for, in milliseconds.
	 * If the `frameRate` property has been set then it overrides this value,
	 * otherwise the `frameRate` is derived from `duration`.
	 *
	 * @since 1.0.0
	**/
	public var duration:Int;

	/**
	 * How many ms per frame, not including frame specific modifiers.
	 *
	 * @since 1.0.0
	**/
	public var msPerFrame:Int;

	/**
	 * Skip frames if the time lags, or always advanced anyway?
	 *
	 * @since 1.0.0
	**/
	public var skipMissedFrames:Bool;

	/**
	 * The delay in ms before the playback will begin.
	 *
	 * @since 1.0.0
	**/
	public var delay:Int;

	/**
	 * Number of times to repeat the animation. Set to -1 to repeat forever.
	 *
	 * @since 1.0.0
	**/
	public var repeat:Int;

	/**
	 * The delay in ms before the a repeat play starts.
	 *
	 * @since 1.0.0
	**/
	public var repeatDelay:Int;

	/**
	 * Should the animation yoyo (reverse back down to the start) before repeating?
	 *
	 * @since 1.0.0
	**/
	public var yoyo:Bool;

	/**
	 * Should the GameObject's `visible` property be set to `true` when the animation starts to play?
	 *
	 * @since 1.0.0
	**/
	public var showOnStart:Bool;

	/**
	 * Should the GameObject's `visible` property be set to `false` when the animation finishes?
	 *
	 * @since 1.0.0
	**/
	public var hideOnComplete:Bool;

	/**
	 * Global pause. All Game Objects using this Animation instance are impacted by this property.
	 *
	 * @since 1.0.0
	**/
	public var paused:Bool;

	/**
	 * @param manager - A reference to the global Animation Manager
	 * @param key - The unique identifying string for this animation.
	 * @param config - The Animation configuration.
	**/
	public function new(manager:AnimationManager, key:String, config:AnimationConfig)
	{
		super();

		inline function getValue<T1>(value:T1, defaultValue:T1)
		{
			return value == null ? defaultValue : value;
		}

		if (config == null)
		{
			config = AnimationConfig.defaultInstance;
		}

		this.manager = manager;

		this.key = key;

		this.frames = getFrames(manager.textureManager, getValue(config.frames, []), getValue(config.defaultTextureKey, null));

		if (config.duration == null && config.frameRate == null)
		{
			//  No duration or frameRate given, use default frameRate of 24fps
			this.frameRate = 24;
			this.duration = Std.int(frameRate / frames.length) * 1000;
		}
		else if (config.duration != null && config.frameRate == null)
		{
			//  Duration given but no frameRate, so set the frameRate based on duration
			//  I.e. 12 frames in the animation, duration = 4000 ms
			//  So frameRate is 12 / (4000 / 1000) = 3 fps
			this.duration = config.duration;
			this.frameRate = Std.int(frames.length / (duration / 1000));
		}
		else
		{
			//  frameRate given, derive duration from it (even if duration also specified)
			//  I.e. 15 frames in the animation, frameRate = 30 fps
			//  So duration is 15 / 30 = 0.5 * 1000 (half a second, or 500ms)
			this.frameRate = config.frameRate;
			this.duration = Std.int(frames.length / frameRate) * 1000;
		}

		this.msPerFrame = Std.int(1000 / frameRate);

		this.skipMissedFrames = getValue(config.skipMissedFrames, true);

		this.delay = getValue(config.delay, 0);

		this.repeat = getValue(config.repeat, 0);

		this.repeatDelay = getValue(config.repeatDelay, 0);

		this.yoyo = getValue(config.yoyo, false);

		this.showOnStart = getValue(config.showOnStart, false);

		this.hideOnComplete = getValue(config.hideOnComplete, false);

		this.paused = false;

		this.manager.on(AnimationEvents.PAUSE_ALL, this.pause, this);
		this.manager.on(AnimationEvents.RESUME_ALL, this.resume, this);
	}

	/**
	 * [description]
	 *
	 * @since 1.0.0
	 *
	 * @param textureManager - [description]
	 * @param frames - [description]
	 * @param [defaultTextureKey] - [description]
	 *
	 * @return {Phaser.Animations.AnimationFrame[]} [description]
	**/
	function getFrames(textureManager:TextureManager,
			frames:Either<String, Array<AnimationFrameConfig>>,
			?defaultTextureKey:String):Array<AnimationFrame>
	{
		inline function getValue<T>(value:T, defaultValue:T)
		{
			return value != null ? value : defaultValue;
		}

		var out = [];
		var prev:AnimationFrame = null;
		var animationFrame;
		var index:Int = 1;

		//  if frames is a string, we'll get all the frames from the texture manager as if it's a sprite sheet
		if (Std.is(frames, String))
		{
			var textureKey:String = (cast frames : String);

			var texture:Texture = textureManager.get(textureKey);
			var frameKeys:Array<String> = texture.getFrameNames();

			frames = [
				for (frameKey in frameKeys)
				{
					{key: textureKey, frame: frameKey}
				}
			];
		}

		if (!Std.is(frames, Array) || (cast frames : Array<AnimationFrameConfig>).length == 0)
		{
			return out;
		}

		var frames = (cast frames : Array<AnimationFrameConfig>);

		for (i in 0...frames.length)
		{
			var item = frames[i];

			var key = getValue(item.key, defaultTextureKey);

			if (key == null)
			{
				continue;
			}

			//  Could be an integer or a string
			var frame = getValue(item.frame, 0);

			//  The actual texture frame
			var textureFrame:Null<Frame> = textureManager.getFrame(key, frame);

			animationFrame = new AnimationFrame(key, frame, index, textureFrame);

			animationFrame.duration = getValue(item.duration, 0);

			animationFrame.isFirst = prev == null;

			//  The previously created animationFrame
			if (prev != null)
			{
				prev.nextFrame = animationFrame;

				animationFrame.prevFrame = prev;
			}

			out.push(animationFrame);

			prev = animationFrame;

			index++;
		}

		if (out.length > 0)
		{
			animationFrame.isLast = true;

			//  Link them end-to-end, so they loop
			animationFrame.nextFrame = out[0];

			out[0].prevFrame = animationFrame;

			//  Generate the progress data

			var slice = 1 / (out.length - 1);

			for (i in 0...out.length)
			{
				out[i].progress = i * slice;
			}
		}

		return out;
	}

	/**
	 * Check if the given frame index is valid.
	 *
	 * @since 1.0.0
	 *
	 * @param index - The index to be checked.
	 *
	 * @return `true` if the index is valid, otherwise `false`.
	**/
	public function checkFrame(index:Int)
	{
		return index >= 0 && index < this.frames.length;
	}

	/**
	 * [description]
	 *
	 * @since 1.0.0
	 *
	 * @param component - [description]
	**/
	private function completeAnimation(component)
	{
		if (this.hideOnComplete)
		{
			component.parent.visible = false;
		}

		component.stop();
	}

	/**
	 * [description]
	 *
	 * @since 1.0.0
	 *
	 * @return This Animation object.
	**/
	public function pause():Animation
	{
		paused = true;
		return this;
	}

	/**
	 * [description]
	 *
	 * @since 1.0.0
	 *
	 * @return This Animation object.
	**/
	public function resume():Animation
	{
		paused = false;
		return this;
	}
}
