package phaserHaxe.animations;

import phaserHaxe.gameobjects.components.IVisible;
import phaserHaxe.textures.Texture;
import phaserHaxe.textures.Frame;
import phaserHaxe.textures.TextureManager;
import phaserHaxe.gameobjects.components.IAnimation.IAnimationController;
import phaserHaxe.math.MathUtility.clamp;
import phaserHaxe.utils.ArrayUtils.findClosestInSorted;
import phaserHaxe.utils.types.Union;

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
			config = {};
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
	 * Add frames to the end of the animation.
	 *
	 * @since 1.0.0
	 *
	 * @param config - [description]
	 *
	 * @return This Animation object.
	**/
	public function addFrame(config:Union<String, Array<AnimationFrameConfig>>):Animation
	{
		return addFrameAt(frames.length, config);
	}

	/**
	 * Add frame/s into the animation.
	 *
	 * @since 1.0.0
	 *
	 * @param index - The index to insert the frame at within the animation.
	 * @param config - [description]
	 *
	 * @return This Animation object.
	**/
	public function addFrameAt(index:Int,
			config:Union<String, Array<AnimationFrameConfig>>):Animation
	{
		var newFrames = getFrames(manager.textureManager, config);

		if (newFrames.length > 0)
		{
			if (index == 0)
			{
				frames = newFrames.concat(frames);
			}
			else if (index == frames.length)
			{
				frames = frames.concat(newFrames);
			}
			else
			{
				var pre = frames.slice(0, index);
				var post = frames.slice(index);

				frames = pre.concat(newFrames).concat(post);
			}

			updateFrameSequence();
		}

		return this;
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
	public function checkFrame(index:Int):Bool
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
	private function completeAnimation(component:IAnimationController):Void
	{
		if (hideOnComplete)
		{
			(cast component.parentGameObject : IVisible).visible = false;
		}

		component.stop();
	}

	/**
	 * [description]
	 *
	 * @since 1.0.0
	 *
	 * @param component - [description]
	 * @param includeDelay - [description]
	**/
	public function getFirstTick(component:IAnimationController,
			includeDelay:Bool = true)
	{
		//  When is the first update due?
		component.accumulator = 0;
		component.nextTick = component.msPerFrame + component.currentFrame.duration;

		if (includeDelay)
		{
			component.nextTick += component._delay;
		}
	}

	/**
	 * Returns the AnimationFrame at the provided index
	 *
	 * @since 1.0.0
	 *
	 * @param index - The index in the AnimationFrame array
	 *
	 * @return The frame at the index provided from the animation sequence
	**/
	private function getFrameAt(index:Int):AnimationFrame
	{
		return this.frames[index];
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
			frames:Union<String, Array<AnimationFrameConfig>>,
			?defaultTextureKey:String):Array<AnimationFrame>
	{
		inline function getValue<T>(value:T, defaultValue:T)
		{
			return value != null ? value : defaultValue;
		}

		var out = [];
		var prev:AnimationFrame = null;
		var animationFrame = null;
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
	 * [description]
	 *
	 * @since 1.0.0
	 *
	 * @param component - [description]
	**/
	public function getNextTick(component:IAnimationController):Void
	{
		// accumulator += delta * _timeScale
		// after a large delta surge (perf issue for example) we need to adjust for it here

		//  When is the next update due?
		component.accumulator -= component.nextTick;

		component.nextTick = component.msPerFrame + component.currentFrame.duration;
	}

	/**
	 * Loads the Animation values into the Animation Component.
	 *
	 * @since 1.0.0
	 *
	 * @param component - The Animation Component to load values into.
	 * @param startFrame - The start frame of the animation to load.
	**/
	@:allow(phaserHaxe)
	private function load(component:IAnimationController, startFrame:Int):Void
	{
		if (startFrame >= frames.length)
		{
			startFrame = 0;
		}

		if (component.currentAnim != this)
		{
			component.currentAnim = this;

			component.frameRate = frameRate;
			component.duration = duration;
			component.msPerFrame = msPerFrame;
			component.skipMissedFrames = skipMissedFrames;

			component._delay = delay;
			component._repeat = repeat;
			component._repeatDelay = repeatDelay;
			component._yoyo = yoyo;
		}

		var frame = frames[startFrame];

		if (startFrame == 0 && !component.forward)
		{
			frame = getLastFrame();
		}

		component.updateFrame(frame);
	}

	/**
	 * Returns the frame closest to the given progress value between 0 and 1.
	 *
	 * @since 1.0.0
	 *
	 * @param value - A value between 0 and 1.
	 *
	 * @return The frame closest to the given progress value.
	**/
	public function getFrameByProgress(value:Float):AnimationFrame
	{
		value = clamp(value, 0, 1);
		return findClosestInSorted(value, frames, i -> i.progress);
	}

	/** Advance the animation frame.
	 *
	 * @since 1.0.0
	 *
	 * @param component - The Animation Component to advance.
	**/
	public function nextFrame(component:IAnimationController):Void
	{
		var frame = component.currentFrame;

		//  TODO: Add frame skip support

		if (frame.isLast)
		{
			//  We're at the end of the animation

			//  Yoyo? (happens before repeat)
			if (component._yoyo)
			{
				this.handleYoyoFrame(component, false);
			}
			else if (component.repeatCounter > 0)
			{
				//  Repeat (happens before complete)

				if (component._reverse && component.forward)
				{
					component.forward = false;
				}
				else
				{
					this.repeatAnimation(component);
				}
			}
			else
			{
				this.completeAnimation(component);
			}
		}
		else
		{
			this.updateAndGetNextTick(component, frame.nextFrame);
		}
	}

	/**
	 * Handle the yoyo functionality in nextFrame and previousFrame methods.
	 *
	 * @since 1.0.0
	 *
	 * @param component - The Animation Component to advance.
	 * @param isReverse - Is animation in reverse mode? (Default: false)
	**/
	private function handleYoyoFrame(component:IAnimationController,
			isReverse:Bool = false)
	{
		if (component._reverse == !isReverse && component.repeatCounter > 0)
		{
			component.forward = isReverse;

			this.repeatAnimation(component);

			return;
		}
		if (component._reverse != isReverse && component.repeatCounter == 0)
		{
			this.completeAnimation(component);

			return;
		}

		component.forward = isReverse;

		var frame = isReverse ? component.currentFrame.nextFrame : component.currentFrame.prevFrame;

		this.updateAndGetNextTick(component, frame);
	}

	/**
	 * Returns the animation last frame.
	 *
	 * @method Phaser.Animations.Animation#getLastFrame
	 * @since 3.12.0
	 *
	 * @return {Phaser.Animations.AnimationFrame} component - The Animation Last Frame.
	**/
	public function getLastFrame()
	{
		return this.frames[this.frames.length - 1];
	}

	/**
	 * [description]
	 *
	 * @since 1.0.0
	 *
	 * @param component - [description]
	**/
	public function previousFrame(component:IAnimationController)
	{
		var frame = component.currentFrame;

		//  TODO: Add frame skip support

		if (frame.isFirst)
		{
			//  We're at the start of the animation

			if (component._yoyo)
			{
				this.handleYoyoFrame(component, true);
			}
			else if (component.repeatCounter > 0)
			{
				if (component._reverse && !component.forward)
				{
					component.currentFrame = this.getLastFrame();
					this.repeatAnimation(component);
				}
				else
				{
					//  Repeat (happens before complete)
					component.forward = true;
					this.repeatAnimation(component);
				}
			}
			else
			{
				this.completeAnimation(component);
			}
		}
		else
		{
			this.updateAndGetNextTick(component, frame.prevFrame);
		}
	}

	/**
	 * Update Frame and Wait next tick.
	 *
	 * @since 1.0.0
	 *
	 * @param frame - An Animation frame.
	**/
	private function updateAndGetNextTick(component:IAnimationController,
			frame:AnimationFrame)
	{
		component.updateFrame(frame);

		getNextTick(component);
	}

	/**
	 * [description]
	 *
	 * @since 1.0.0
	 *
	 * @param frame - [description]
	 *
	 * @return This Animation object.
	**/
	public function removeFrame(frame:AnimationFrame):Animation
	{
		var index = frames.indexOf(frame);

		if (index != -1)
		{
			removeFrameAt(index);
		}

		return this;
	}

	/**
	 * Removes a frame from the AnimationFrame array at the provided index
	 * and updates the animation accordingly.
	 *
	 * @since 1.0.0
	 *
	 * @param index - The index in the AnimationFrame array
	 *
	 * @return This Animation object.
	**/
	public function removeFrameAt(index:Int):Animation
	{
		frames.splice(index, 1);

		updateFrameSequence();

		return this;
	}

	/**
	 * [description]
	 *
	 * @fires Phaser.Animations.Events#ANIMATION_REPEAT
	 * @fires Phaser.Animations.Events#SPRITE_ANIMATION_REPEAT
	 * @fires Phaser.Animations.Events#SPRITE_ANIMATION_KEY_REPEAT
	 * @since 1.0.0
	 *
	 * @param component - [description]
	**/
	public function repeatAnimation(component:IAnimationController)
	{
		if (component._pendingStop == 2)
		{
			return completeAnimation(component);
		}

		if (component._repeatDelay > 0 && !component.pendingRepeat)
		{
			component.pendingRepeat = true;
			component.accumulator -= component.nextTick;
			component.nextTick += component._repeatDelay;
		}
		else
		{
			component.repeatCounter--;

			var currentFrame = component.currentFrame;

			component.updateFrame(component.forward ? currentFrame.nextFrame : currentFrame.prevFrame);

			if (component.isPlaying)
			{
				getNextTick(component);

				component.pendingRepeat = false;

				var frame = component.currentFrame;
				var parent = component.parentGameObject;

				emit(AnimationEvents.ANIMATION_REPEAT, [this, frame]);

				parent.emit(AnimationEvents.SPRITE_ANIMATION_KEY_REPEAT + this.key, [this, frame, component.repeatCounter, parent]);

				parent.emit(AnimationEvents.SPRITE_ANIMATION_REPEAT, [this, frame, component.repeatCounter, parent]);
			}
		}
	}

	/**
	 * Sets the texture frame the animation uses for rendering.
	 *
	 * @since 1.0.0
	 *
	 * @param component - [description]
	**/
	public function setFrame(component:IAnimationController)
	{
		//  Work out which frame should be set next on the child, and set it

		if (component.forward)
		{
			nextFrame(component);
		}
		else
		{
			previousFrame(component);
		}
	}

	/**
	 * Converts the animation data to JSON.
	 *
	 * @since 1.0.0
	 *
	 * @return [description]
	**/
	public function toJSON():JSONAnimation
	{
		return {
			key: this.key,
			type: this.type,
			frames: [
				for (frame in frames)
				{
					frame.toJSON();
				}
			],
			frameRate: this.frameRate,
			duration: this.duration,
			skipMissedFrames: this.skipMissedFrames,
			delay: this.delay,
			repeat: this.repeat,
			repeatDelay: this.repeatDelay,
			yoyo: this.yoyo,
			showOnStart: this.showOnStart,
			hideOnComplete: this.hideOnComplete
		};
	}

	/**
	 * [description]
	 *
	 * @since 1.0.0
	 *
	 * @return This Animation object.
	**/
	public function updateFrameSequence():Animation
	{
		var len = frames.length;
		var slice = 1 / (len - 1);

		var frame;

		for (i in 0...len)
		{
			frame = frames[i];

			frame.index = i + 1;
			frame.isFirst = false;
			frame.isLast = false;
			frame.progress = i * slice;

			if (i == 0)
			{
				frame.isFirst = true;

				if (len == 1)
				{
					frame.isLast = true;
					frame.nextFrame = frame;
					frame.prevFrame = frame;
				}
				else
				{
					frame.isLast = false;
					frame.prevFrame = frames[len - 1];
					frame.nextFrame = frames[i + 1];
				}
			}
			else if (i == len - 1 && len > 1)
			{
				frame.isLast = true;
				frame.prevFrame = frames[len - 2];
				frame.nextFrame = frames[0];
			}
			else if (len > 1)
			{
				frame.prevFrame = frames[i - 1];
				frame.nextFrame = frames[i + 1];
			}
		}

		return this;
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

	/**
	 * [description]
	 *
	 * @method Phaser.Animations.Animation#destroy
	 * @since 3.0.0
	**/
	public function destroy()
	{
		removeAllListeners();
		manager.off(AnimationEvents.PAUSE_ALL, this.pause, this);
		manager.off(AnimationEvents.RESUME_ALL, this.resume, this);
		manager.remove(this.key);

		for (frame in frames)
		{
			frame.destroy();
		}

		frames.resize(0);
		manager = null;
	}
}
