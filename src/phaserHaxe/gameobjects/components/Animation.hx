package phaserHaxe.gameobjects.components;

import phaserHaxe.math.MathConst;
import phaserHaxe.animations.AnimationEvents;
import phaserHaxe.animations.AnimationFrame;
import phaserHaxe.animations.AnimationManager;
import phaserHaxe.animations.Animation as BaseAnimation;
import phaserHaxe.gameobjects.components.IAnimation.IAnimationController;
import phaserHaxe.utils.types.Union;

/**
 * A Game Object Animation Controller.
 *
 * This controller lives as an instance within a Game Object, accessible as `sprite.anims`.
 *
 * @since 1.0.0
**/
typedef Animation<ParentT:GameObject & ICrop & IFlip & IOrigin & ISize & IVisible> = AnimationController<ParentT>;

/**
 * A Game Object Animation Controller.
 *
 * This controller lives as an instance within a Game Object, accessible as `sprite.anims`.
 *
 * @since 1.0.0
**/
class AnimationController<ParentT:GameObject & ICrop & IFlip & IOrigin & ISize & IVisible> implements IAnimationController
{
	/**
	 * The Game Object to which this animation controller belongs.
	 *
	 * @since 1.0.0
	**/
	public var parent:ParentT;

	/**
	 * A reference to the global Animation Manager.
	 *
	 * @since 1.0.0
	**/
	public var animationManager:AnimationManager;

	/**
	 * Is an animation currently playing or not?
	 *
	 * @since 1.0.0
	**/
	public var isPlaying:Bool = false;

	/**
	 * The current Animation loaded into this Animation Controller.
	 *
	 * @since 1.0.0
	**/
	public var currentAnim:BaseAnimation = null;

	/**
	 * The current AnimationFrame being displayed by this Animation Controller.
	 *
	 * @since 1.0.0
	**/
	public var currentFrame:AnimationFrame = null;

	/**
	 * The key of the next Animation to be loaded into this Animation Controller when the current animation completes.
	 *
	 * @since 1.0.0
	**/
	public var nextAnim:Null<String> = null;

	/**
	 * Time scale factor.
	 *
	 * @since 1.0.0
	**/
	private var _timeScale:Float = 1;

	/**
	 * The frame rate of playback in frames per second.
	 * The default is 24 if the `duration` property is `null`.
	 *
	 * @since 1.0.0
	**/
	private var frameRate:Float = 0;

	/**
	 * How long the animation should play for, in milliseconds.
	 * If the `frameRate` property has been set then it overrides this value,
	 * otherwise the `frameRate` is derived from `duration`.
	 *
	 * @since 1.0.0
	**/
	public var duration:Float = 0;

	/**
	 * ms per frame, not including frame specific modifiers that may be present in the Animation data.
	 *
	 * @since 1.0.0
	**/
	public var msPerFrame:Float = 0;

	/**
	 * Skip frames if the time lags, or always advanced anyway?
	 *
	 * @since 1.0.0
	**/
	public var skipMissedFrames:Bool = true;

	/**
	 * A delay before starting playback, in milliseconds.
	 *
	 * @since 1.0.0
	**/
	public var _delay:Int = 0;

	/**
	 * Number of times to repeat the animation (-1 for infinity)
	 *
	 * @since 1.0.0
	**/
	public var _repeat:Int = 0;

	/**
	 * Delay before the repeat starts, in milliseconds.
	 *
	 * @since 1.0.0
	**/
	public var _repeatDelay:Float = 0;

	/**
	 * Should the animation yoyo? (reverse back down to the start) before repeating?
	 *
	 * @since 1.0.0
	**/
	public var _yoyo:Bool = false;

	/**
	 * Will the playhead move forwards (`true`) or in reverse (`false`).
	 *
	 * @since 1.0.0
	**/
	public var forward:Bool = true;

	/**
	 * An Internal trigger that's play the animation in reverse mode ('true') or not ('false'),
	 * needed because forward can be changed by yoyo feature.
	 *
	 * @since 1.0.0
	**/
	private var _reverse:Bool = false;

	/**
	 * Internal time overflow accumulator.
	 *
	 * @since 1.0.0
	**/
	private var accumulator:Float = 0;

	/**
	 * The time point at which the next animation frame will change.
	 *
	 * @since 1.0.0
	**/
	private var nextTick:Float = 0;

	/**
	 * An internal counter keeping track of how many repeats are left to play.
	 *
	 * @since 1.0.0
	**/
	private var repeatCounter:Int = 0;

	/**
	 * An internal flag keeping track of pending repeats.
	 *
	 * @since 1.0.0
	**/
	public var pendingRepeat:Bool = false;

	/**
	 * Is the Animation paused?
	 *
	 * @since 1.0.0
	**/
	public var _paused:Bool = false;

	/**
	 * Was the animation previously playing before being paused?
	 *
	 * @since 1.0.0
	**/
	public var _wasPlaying:Bool = false;

	/**
	 * Internal property tracking if this Animation is waiting to stop.
	 *
	 * 0 = No
	 * 1 = Waiting for ms to pass
	 * 2 = Waiting for repeat
	 * 3 = Waiting for specific frame
	 *
	 * @since 1.0.0
	**/
	public var _pendingStop:Int = 0;

	/**
	 * Internal property used by _pendingStop.
	 *
	 * @since 1.0.0
	**/
	private var _pendingStopValue:Union<AnimationFrame, Float>;

	/**
	 * `true` if the current animation is paused, otherwise `false`.
	 *
	 * @since 1.0.0
	**/
	public var isPaused(get, never):Bool;

	/**
	 * The Game Object to which this animation controller belongs.
	 *
	 * @since 1.0.0
	**/
	@:noCompletion
	public var parentGameObject(get, set):GameObject;

	/**
	 * @param parent - The Game Object to which this animation controller belongs.
	**/
	public function new(parent:ParentT)
	{
		this.parent = parent;

		this.animationManager = parent.scene.sys.anims;

		this.animationManager.once(AnimationEvents.REMOVE_ANIMATION, this.remove, this);
	}

	private inline function get_isPaused():Bool
	{
		return _paused;
	}

	private inline function get_parentGameObject():GameObject
	{
		return parent;
	}

	private function set_parentGameObject(value:GameObject):GameObject
	{
		if (Std.is(value, ICrop)
			&& Std.is(value, IFlip)
			&& Std.is(value, IOrigin)
			&& Std.is(value, ISize)
			&& Std.is(value, IVisible))
		{
			return parent = cast value;
		}
		else
		{
			throw new Error("gameObject do not implement all the needed components : ICrop, IFlip, IOrigin, ISize, IVisible");
		}
	}

	/**
	 * Sets an animation to be played immediately after the current one completes.
	 *
	 * The current animation must enter a 'completed' state for this to happen, i.e. finish all of its repeats, delays, etc, or have the `stop` method called directly on it.
	 *
	 * An animation set to repeat forever will never enter a completed state.
	 *
	 * You can chain a new animation at any point, including before the current one starts playing, during it, or when it ends (via its `animationcomplete` callback).
	 * Chained animations are specific to a Game Object, meaning different Game Objects can have different chained animations without impacting the global animation they're playing.
	 *
	 * Call this method with no arguments to reset the chained animation.
	 *
	 * @since 1.0.0
	 *
	 * @param key - The string-based key of the animation to play next, as defined previously in the Animation Manager. Or an Animation instance.
	 *
	 * @return The Game Object that owns this Animation Component.
	**/
	public function chain(?key:Union<String, BaseAnimation>):ParentT
	{
		final key = if (Std.is(key, BaseAnimation))
		{
			(cast key : BaseAnimation).key;
		}
		else
		{
			(cast key : String);
		}

		nextAnim = key;

		return parent;
	}

	/**
	 * Sets the amount of time, in milliseconds, that the animation will be delayed before starting playback.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The amount of time, in milliseconds, to wait before starting playback.
	 *
	 * @return The Game Object that owns this Animation Component.
	**/
	public function setDelay(value:Int = 0):ParentT
	{
		_delay = value;
		return parent;
	}

	/**
	 * Gets the amount of time, in milliseconds that the animation will be delayed before starting playback.
	 *
	 * @since 1.0.0
	 *
	 * @return The amount of time, in milliseconds, the Animation will wait before starting playback.
	**/
	public function getDelay():Int
	{
		return _delay;
	}

	/**
	 * Waits for the specified delay, in milliseconds, then starts playback of the requested animation.
	 *
	 * @since 1.0.0
	 *
	 * @param delay - The delay, in milliseconds, to wait before starting the animation playing.
	 * @param key - The key of the animation to play.
	 * @param startFrame - The frame of the animation to start from.
	 *
	 * @return The Game Object that owns this Animation Component.
	**/
	public function delayedPlay(delay:Int, key:String, startFrame:Int = 0):ParentT
	{
		play(key, true, startFrame);

		nextTick += delay;

		return parent;
	}

	/**
	 * Returns the key of the animation currently loaded into this component.
	 *
	 * @since 1.0.0
	 *
	 * @return The key of the Animation loaded into this component.
	**/
	public function getCurrentKey():Null<String>
	{
		if (currentAnim != null)
		{
			return currentAnim.key;
		}
		else
		{
			return null;
		}
	}

	/**
	 * Internal method used to load an animation into this component.
	 *
	 * @since 1.0.0
	 *
	 * @param key - The key of the animation to load.
	 * @param startFrame - The start frame of the animation to load.
	 *
	 * @return The Game Object that owns this Animation Component.
	 */
	private function load(key:String, startFrame:Int = 0):ParentT
	{
		if (isPlaying)
		{
			stop();
		}

		//  Load the new animation in
		animationManager.load(this, key, startFrame);

		return parent;
	}

	/**
	 * Pause the current animation and set the `isPlaying` property to `false`.
	 * You can optionally pause it at a specific frame.
	 *
	 * @since 1.0.0
	 *
	 * @param atFrame - An optional frame to set after pausing the animation.
	 *
	 * @return The Game Object that owns this Animation Component.
	**/
	public function pause(?atFrame:AnimationFrame):ParentT
	{
		if (!_paused)
		{
			_paused = true;
			_wasPlaying = isPlaying;
			isPlaying = false;
		}

		if (atFrame != null)
		{
			updateFrame(atFrame);
		}

		return parent;
	}

	/**
	 * Resumes playback of a paused animation and sets the `isPlaying` property to `true`.
	 * You can optionally tell it to start playback from a specific frame.
	 *
	 * @since 1.0.0
	 *
	 * @param fromFrame - An optional frame to set before restarting playback.
	 *
	 * @return The Game Object that owns this Animation Component.
	**/
	public function resume(?fromFrame:AnimationFrame):ParentT
	{
		if (_paused)
		{
			_paused = false;
			isPlaying = _wasPlaying;
		}

		if (fromFrame != null)
		{
			updateFrame(fromFrame);
		}

		return parent;
	}

	/**
	 * Plays an Animation on a Game Object that has the Animation component, such as a Sprite.
	 *
	 * Animations are stored in the global Animation Manager and are referenced by a unique string-based key.
	 *
	 * @since 1.0.0
	 *
	 * @param key - The string-based key of the animation to play, as defined previously in the Animation Manager. Or an Animation instance.
	 * @param ignoreIfPlaying - If this animation is already playing then ignore this call.
	 * @param startFrame - Optionally start the animation playing from this frame index.
	 *
	 * @return The Game Object that owns this Animation Component.
	**/
	public function play(key:Union<String, BaseAnimation>,
			ignoreIfPlaying:Bool = false, startFrame:Int = 0):ParentT
	{
		var key = if (Std.is(key, BaseAnimation))
		{
			(cast key : BaseAnimation).key;
		}
		else
		{
			(cast key : String);
		}

		if (ignoreIfPlaying && isPlaying && currentAnim.key == key)
		{
			return parent;
		}

		forward = true;
		_reverse = false;

		return _startAnimation(key, startFrame);
	}

	/**
	 * Plays an Animation (in reverse mode) on the Game Object that owns this Animation Component.
	 *
	 * @fires Phaser.GameObjects.Components.Animation#onStartEvent
	 * @since 1.0.0
	 *
	 * @param key - The string-based key of the animation to play, as defined previously in the Animation Manager. Or an Animation instance.
	 * @param ignoreIfPlaying - If an animation is already playing then ignore this call.
	 * @param startFrame - Optionally start the animation playing from this frame index.
	 *
	 * @return The Game Object that owns this Animation Component.
	**/
	public function playReverse(key:Union<String, BaseAnimation>,
			ignoreIfPlaying:Bool = false, startFrame:Int = 0):ParentT
	{
		final key = if (Std.is(key, BaseAnimation))
		{
			(cast key : BaseAnimation).key;
		}
		else
		{
			(cast key : String);
		}

		if (ignoreIfPlaying && isPlaying && currentAnim.key == key)
		{
			return parent;
		}

		forward = false;
		_reverse = true;

		return _startAnimation(key, startFrame);
	}

	/**
	 * Load an Animation and fires 'onStartEvent' event, extracted from 'play' method.
	 *
	 * @fires Phaser.Animations.Events#START_ANIMATION_EVENT
	 * @fires Phaser.Animations.Events#SPRITE_START_ANIMATION_EVENT
	 * @fires Phaser.Animations.Events#SPRITE_START_KEY_ANIMATION_EVENT
	 * @since 1.0.0
	 *
	 * @param key - The string-based key of the animation to play, as defined previously in the Animation Manager.
	 * @param startFrame - Optionally start the animation playing from this frame index.
	 *
	 * @return The Game Object that owns this Animation Component.
	**/
	public function _startAnimation(key:String, startFrame:Int = 0):ParentT
	{
		throw new Error("Not Implemented");
		// this.load(key, startFrame);

		// var anim = this.currentAnim;
		// var gameObject = this.parent;

		// if (!anim)
		// {
		// 	return gameObject;
		// }

		// //  Should give us 9,007,199,254,740,991 safe repeats
		// this.repeatCounter = (this._repeat == -1) ? MathConst.INT_MAX : this._repeat;

		// anim.getFirstTick(this);

		// this.isPlaying = true;
		// this.pendingRepeat = false;

		// if (anim.showOnStart)
		// {
		// 	gameObject.visible = true;
		// }

		// var frame = this.currentFrame;

		// anim.emit(AnimationEvents.ANIMATION_START, [anim, frame, gameObject]);

		// gameObject.emit(AnimationEvents.SPRITE_ANIMATION_KEY_START + key, [anim, frame, gameObject]);

		// gameObject.emit(AnimationEvents.SPRITE_ANIMATION_START, [anim, frame, gameObject]);

		// return gameObject;
	}

	/**
	 * Reverse the Animation that is already playing on the Game Object.
	 *
	 * @since 1.0.0
	 *
	 * @return The Game Object that owns this Animation Component.
	**/
	public function reverse():ParentT
	{
		if (isPlaying)
		{
			_reverse = !_reverse;

			forward = !forward;
		}

		return parent;
	}

	/**
	 * Returns a value between 0 and 1 indicating how far this animation is through, ignoring repeats and yoyos.
	 * If the animation has a non-zero repeat defined, `getProgress` and `getTotalProgress` will be different
	 * because `getProgress` doesn't include any repeats or repeat delays, whereas `getTotalProgress` does.
	 *
	 * @since 1.0.0
	 *
	 * @return The progress of the current animation, between 0 and 1.
	**/
	public function getProgress():Float
	{
		var p = currentFrame.progress;

		if (!forward)
		{
			p = 1 - p;
		}

		return p;
	}

	/**
	 * Takes a value between 0 and 1 and uses it to set how far this animation is through playback.
	 * Does not factor in repeats or yoyos, but does handle playing forwards or backwards.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The progress value, between 0 and 1.
	 *
	 * @return The Game Object that owns this Animation Component.
	**/
	public function setProgress(value:Float = 0):ParentT
	{
		throw new Error("Not Implemented");

		// if (!forward)
		// {
		// 	value = 1 - value;
		// }

		// setCurrentFrame(currentAnim.getFrameByProgress(value));

		// return parent;
	}

	/**
	 * Handle the removal of an animation from the Animation Manager.
	 *
	 * @since 1.0.0
	 *
	 * @param key - The key of the removed Animation.
	 * @param animation - The removed Animation.
	**/
	public function remove(?key:String, ?animation:BaseAnimation):Void
	{
		if (animation == null)
		{
			animation = this.currentAnim;
		}

		if (isPlaying && animation.key == currentAnim.key)
		{
			stop();

			setCurrentFrame(currentAnim.frames[0]);
		}
	}

	/**
	 * Gets the number of times that the animation will repeat
	 * after its first iteration. For example, if returns 1, the animation will
	 * play a total of twice (the initial play plus 1 repeat).
	 * A value of -1 means the animation will repeat indefinitely.
	 *
	 * @since 1.0.0
	 *
	 * @return The number of times that the animation will repeat.
	**/
	public function getRepeat():Int
	{
		return _repeat;
	}

	/**
	 * Sets the number of times that the animation should repeat
	 * after its first iteration. For example, if repeat is 1, the animation will
	 * play a total of twice (the initial play plus 1 repeat).
	 * To repeat indefinitely, use -1. repeat should always be an integer.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The number of times that the animation should repeat.
	 *
	 * @return The Game Object that owns this Animation Component.
	**/
	public function setRepeat(value:Int):GameObject
	{
		_repeat = value;
		repeatCounter = (value == -1) ? MathConst.INT_MAX : value;
		return parent;
	}

	/**
	 * Gets the amount of delay between repeats, if any.
	 *
	 * @method Phaser.GameObjects.Components.Animation#getRepeatDelay
	 * @since 3.4.0
	 *
	 * @return {number} The delay between repeats.
	**/
	public function getRepeatDelay()
	{
		return this._repeatDelay;
	}

	/**
	 * Sets the amount of time in seconds between repeats.
	 * For example, if `repeat` is 2 and `repeatDelay` is 10, the animation will play initially,
	 * then wait for 10 seconds before repeating, then play again, then wait another 10 seconds
	 * before doing its final repeat.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The delay to wait between repeats, in seconds.
	 *
	 * @return The Game Object that owns this Animation Component.
	**/
	public function setRepeatDelay(value:Float):GameObject
	{
		_repeatDelay = value;
		return parent;
	}

	/**
	 * Restarts the current animation from its beginning, optionally including its delay value.
	 *
	 * @fires Phaser.Animations.Events#RESTART_ANIMATION_EVENT
	 * @fires Phaser.Animations.Events#SPRITE_RESTART_ANIMATION_EVENT
	 * @fires Phaser.Animations.Events#SPRITE_RESTART_KEY_ANIMATION_EVENT
	 * @since 1.0.0
	 *
	 * @param includeDelay - Whether to include the delay value of the animation when restarting.
	 *
	 * @return The Game Object that owns this Animation Component.
	**/
	public function restart(includeDelay:Bool = false):ParentT
	{
		throw new Error("Not Implemented");

		// var anim = this.currentAnim;
		// anim.getFirstTick(this, includeDelay);
		// this.forward = true;
		// this.isPlaying = true;
		// this.pendingRepeat = false;
		// this._paused = false;
		// //  Set frame
		// this.updateFrame(anim.frames[0]);

		// var gameObject = this.parent;
		// var frame = this.currentFrame;

		// anim.emit(AnimationEvents.ANIMATION_RESTART, [anim, frame, gameObject]);

		// gameObject.emit(AnimationEvents.SPRITE_ANIMATION_KEY_RESTART + anim.key, [anim, frame, gameObject]);
		// gameObject.emit(AnimationEvents.SPRITE_ANIMATION_RESTART, [anim, frame, gameObject]);

		// return this.parent;
	}

	/**
	 * Immediately stops the current animation from playing and dispatches the `animationcomplete` event.
	 *
	 * If no animation is set, no event will be dispatched.
	 *
	 * If there is another animation queued (via the `chain` method) then it will start playing immediately.
	 *
	 * @fires Phaser.GameObjects.Components.Animation#onCompleteEvent
	 * @since 1.0.0
	 *
	 * @return The Game Object that owns this Animation Component.
	**/
	public function stop():ParentT
	{
		_pendingStop = 0;
		isPlaying = false;

		var gameObject = parent;
		var anim = currentAnim;
		var frame = currentFrame;

		if (anim != null)
		{
			anim.emit(AnimationEvents.ANIMATION_COMPLETE, [anim, frame, gameObject]);
			gameObject.emit(AnimationEvents.SPRITE_ANIMATION_KEY_COMPLETE + anim.key, [anim, frame, gameObject]);
			gameObject.emit(AnimationEvents.SPRITE_ANIMATION_COMPLETE, [anim, frame, gameObject]);
		}

		if (nextAnim != null)
		{
			var key = this.nextAnim;
			nextAnim = null;
			play(key);
		}

		return gameObject;
	}

	/**
	 * Stops the current animation from playing after the specified time delay, given in milliseconds.
	 *
	 * @fires Phaser.GameObjects.Components.Animation#onCompleteEvent
	 * @since 1.0.0
	 *
	 * @param delay - The number of milliseconds to wait before stopping this animation.
	 *
	 * @return The Game Object that owns this Animation Component.
	**/
	public function stopAfterDelay(delay:Int):ParentT
	{
		_pendingStop = 1;
		_pendingStopValue = delay;
		return parent;
	}

	/**
	 * Stops the current animation from playing when it next repeats.
	 *
	 * @fires Phaser.GameObjects.Components.Animation#onCompleteEvent
	 * @since 1.0.0
	 *
	 * @return The Game Object that owns this Animation Component.
	**/
	public function stopOnRepeat():ParentT
	{
		_pendingStop = 2;
		return parent;
	}

	/**
	 * Stops the current animation from playing when it next sets the given frame.
	 * If this frame doesn't exist within the animation it will not stop it from playing.
	 *
	 * @fires Phaser.GameObjects.Components.Animation#onCompleteEvent
	 * @since 1.0.0
	 *
	 * @param frame - The frame to check before stopping this animation.
	 *
	 * @return The Game Object that owns this Animation Component.
	**/
	public function stopOnFrame(frame:AnimationFrame):GameObject
	{
		_pendingStop = 3;
		_pendingStopValue = frame;
		return parent;
	}

	/**
	 * Sets the Time Scale factor, allowing you to make the animation go go faster or slower than default.
	 * Where 1 = normal speed (the default), 0.5 = half speed, 2 = double speed, etc.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The time scale factor, where 1 is no change, 0.5 is half speed, etc.
	 *
	 * @return The Game Object that owns this Animation Component.
	**/
	public function setTimeScale(value:Float = 1):ParentT
	{
		if (value == null)
		{
			value = 1;
		}
		_timeScale = value;
		return parent;
	}

	/**
	 * Gets the Time Scale factor.
	 *
	 * @since 1.0.0
	 *
	 * @return The Time Scale value.
	**/
	public function getTimeScale():Float
	{
		return _timeScale;
	}

	/**
	 * Returns the total number of frames in this animation.
	 *
	 * @since 1.0.0
	 *
	 * @return The total number of frames in this animation.
	**/
	public function getTotalFrames():Int
	{
		return currentAnim.frames.length;
	}

	/**
	 * The internal update loop for the Animation Component.
	 *
	 * @since 1.0.0
	 *
	 * @param time - The current timestamp.
	 * @param delta - The delta time, in ms, elapsed since the last frame.
	**/
	public function update(time:Float, delta:Float)
	{
		throw new Error("Not Implemented");

		// if (currentAnim == null || !isPlaying || currentAnim.paused)
		// {
		// 	return;
		// }

		// accumulator += delta * _timeScale;

		// if (_pendingStop == 1)
		// {
		// 	_pendingStopValue = if (Std.is(_pendingStopValue, Float))
		// 	{
		// 		(cast _pendingStopValue : Float) - delta;
		// 	}
		// 	else
		// 	{
		// 		Math.NaN;
		// 	}

		// 	if ((cast _pendingStopValue : Float) <= 0)
		// 	{
		// 		return currentAnim.completeAnimation(this);
		// 	}
		// }

		// if (accumulator >= nextTick)
		// {
		// 	currentAnim.setFrame(this);
		// }
	}

	/**
	 * Sets the given Animation Frame as being the current frame
	 * and applies it to the parent Game Object, adjusting its size and origin as needed.
	 *
	 * @since 1.0.0
	 *
	 * @param animationFrame - The Animation Frame to set as being current.
	 *
	 * @return The Game Object this Animation Component belongs to.
	**/
	public function setCurrentFrame(animationFrame:AnimationFrame):ParentT
	{
		var gameObject = this.parent;

		this.currentFrame = animationFrame;

		gameObject.texture = animationFrame.frame.texture;
		gameObject.frame = animationFrame.frame;

		if (gameObject.isCropped)
		{
			gameObject.frame.updateCropUVs(gameObject._crop, gameObject.flipX, gameObject.flipY);
		}

		gameObject.setSizeToFrame();

		if (animationFrame.frame.customPivot)
		{
			gameObject.setOrigin(animationFrame.frame.pivotX, animationFrame.frame.pivotY);
		}
		else
		{
			gameObject.updateDisplayOrigin();
		}

		return gameObject;
	}

	/**
	 * Internal frame change handler.
	 *
	 * @fires Phaser.Animations.Events#SPRITE_ANIMATION_UPDATE_EVENT
	 * @fires Phaser.Animations.Events#SPRITE_ANIMATION_KEY_UPDATE_EVENT
	 * @since 1.0.0
	 *
	 * @param animationFrame - The animation frame to change to.
	**/
	private function updateFrame(animationFrame:AnimationFrame):Void
	{
		throw new Error("Not Implemented");

		// var gameObject = setCurrentFrame(animationFrame);

		// if (isPlaying)
		// {
		// 	if (animationFrame.setAlpha)
		// 	{
		// 		gameObject.alpha = animationFrame.alpha;
		// 	}

		// 	var anim = this.currentAnim;

		// 	gameObject.emit(AnimationEvents.SPRITE_ANIMATION_KEY_UPDATE + anim.key, [anim, animationFrame, gameObject]);
		// 	gameObject.emit(AnimationEvents.SPRITE_ANIMATION_UPDATE, [anim, animationFrame, gameObject]);

		// 	if (_pendingStop == 3 && _pendingStopValue == animationFrame)
		// 	{
		// 		currentAnim.completeAnimation(this);
		// 	}
		// }
	}

	/**
	 * Advances the animation to the next frame, regardless of the time or animation state.
	 * If the animation is set to repeat, or yoyo, this will still take effect.
	 *
	 * Calling this does not change the direction of the animation. I.e. if it was currently
	 * playing in reverse, calling this method doesn't then change the direction to forwards.
	 *
	 * @since 1.0.0
	 *
	 * @return The Game Object this Animation Component belongs to.
	**/
	public function nextFrame():ParentT
	{
		throw new Error("Not Implemented");

		// if (currentAnim != null)
		// {
		// 	currentAnim.nextFrame(this);
		// }

		// return parent;
	}

	/**
	 * Advances the animation to the previous frame, regardless of the time or animation state.
	 * If the animation is set to repeat, or yoyo, this will still take effect.
	 *
	 * Calling this does not change the direction of the animation. I.e. if it was currently
	 * playing in forwards, calling this method doesn't then change the direction to backwards.
	 *
	 * @since 1.0.0
	 *
	 * @return The Game Object this Animation Component belongs to.
	**/
	public function previousFrame():ParentT
	{
		throw new Error("Not Implemented");

		// if (currentAnim != null)
		// {
		// 	currentAnim.previousFrame(this);
		// }

		// return parent;
	}

	/**
	 * Sets if the current Animation will yoyo when it reaches the end.
	 * A yoyo'ing animation will play through consecutively, and then reverse-play back to the start again.
	 *
	 * @since 1.0.0
	 *
	 * @param value - `true` if the animation should yoyo, `false` to not.
	 *
	 * @return The Game Object this Animation Component belongs to.
	**/
	public function setYoyo(value:Bool = false):ParentT
	{
		_yoyo = value;
		return parent;
	}

	/**
	 * Gets if the current Animation will yoyo when it reaches the end.
	 * A yoyo'ing animation will play through consecutively, and then reverse-play back to the start again.
	 *
	 * @since 1.0.0
	 *
	 * @return `true` if the animation is set to yoyo, `false` if not.
	**/
	public function getYoyo():Bool
	{
		return _yoyo;
	}

	/**
	 * Destroy this Animation component.
	 *
	 * Unregisters event listeners and cleans up its references.
	 *
	 * @since 1.0.0
	**/
	public function destroy()
	{
		animationManager.off(AnimationEvents.REMOVE_ANIMATION, remove, this);
		animationManager = null;
		parent = null;
		currentAnim = null;
		currentFrame = null;
	}
}
