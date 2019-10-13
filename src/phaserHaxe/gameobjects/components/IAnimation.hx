package phaserHaxe.gameobjects.components;

import phaserHaxe.animations.AnimationFrame;
import phaserHaxe.animations.AnimationManager;
import phaserHaxe.animations.Animation as BaseAnimation;

/**
 * A Game Object Animation Controller.
 *
 * This controller lives as an instance within a Game Object, accessible as `sprite.anims`.
 *
 * @since 1.0.0
**/
typedef IAnimation = IAnimationController;

/**
 * A Game Object Animation Controller.
 *
 * This controller lives as an instance within a Game Object, accessible as `sprite.anims`.
 *
 * @since 1.0.0
**/
interface IAnimationController
{
	/**
	 * The Game Object to which this animation controller belongs.
	 *
	 * @since 1.0.0
	**/
	public var parentGameObject(get, set):GameObject;

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
	public var isPlaying:Bool;

	/**
	 * The current Animation loaded into this Animation Controller.
	 *
	 * @since 1.0.0
	**/
	public var currentAnim:BaseAnimation;

	/**
	 * The current AnimationFrame being displayed by this Animation Controller.
	 *
	 * @since 1.0.0
	**/ public var currentFrame:AnimationFrame;

	/**
	 * The key of the next Animation to be loaded into this Animation Controller when the current animation completes.
	 *
	 * @since 1.0.0
	**/
	public var nextAnim:Null<String>;

	/**
	 * Time scale factor.
	 *
	 * @since 1.0.0
	**/
	private var _timeScale:Float;

	/**
	 * The frame rate of playback in frames per second.
	 * The default is 24 if the `duration` property is `null`.
	 *
	 * @since 1.0.0
	**/
	@:allow(phaserHaxe)
	private var frameRate:Float;

	/**
	 * How long the animation should play for, in milliseconds.
	 * If the `frameRate` property has been set then it overrides this value,
	 * otherwise the `frameRate` is derived from `duration`.
	 *
	 * @since 1.0.0
	**/
	public var duration:Float;

	/**
	 * ms per frame, not including frame specific modifiers that may be present in the Animation data.
	 *
	 * @since 1.0.0
	**/
	public var msPerFrame:Float;

	/**
	 * Skip frames if the time lags, or always advanced anyway?
	 *
	 * @since 1.0.0
	**/
	public var skipMissedFrames:Bool;

	/**
	 * A delay before starting playback, in milliseconds.
	 *
	 * @since 1.0.0
	**/
	public var _delay:Int;

	/**
	 * Number of times to repeat the animation (-1 for infinity)
	 *
	 * @since 1.0.0
	**/
	public var _repeat:Int;

	/**
	 * Delay before the repeat starts, in milliseconds.
	 *
	 * @since 1.0.0
	**/
	public var _repeatDelay:Float;

	/**
	 * Should the animation yoyo? (reverse back down to the start) before repeating?
	 *
	 * @since 1.0.0
	**/
	public var _yoyo:Bool;

	/**
	 * Will the playhead move forwards (`true`) or in reverse (`false`).
	 *
	 * @since 1.0.0
	**/
	public var forward:Bool;

	/**
	 * An Internal trigger that's play the animation in reverse mode ('true') or not ('false'),
	 * needed because forward can be changed by yoyo feature.
	 *
	 * @since 1.0.0
	**/
	@:allow(phaserHaxe)
	private var _reverse:Bool;

	/**
	 * Internal time overflow accumulator.
	 *
	 * @since 1.0.0
	**/
	@:allow(phaserHaxe)
	private var accumulator:Float;

	/**
	 * The time point at which the next animation frame will change.
	 *
	 * @since 1.0.0
	**/
	@:allow(phaserHaxe)
	private var nextTick:Float;

	/**
	 * An internal counter keeping track of how many repeats are left to play.
	 *
	 * @since 1.0.0
	**/
	@:allow(phaserHaxe)
	private var repeatCounter:Int;

	/**
	 * An internal flag keeping track of pending repeats.
	 *
	 * @since 1.0.0
	**/
	public var pendingRepeat:Bool;

	/**
	 * Is the Animation paused?
	 *
	 * @since 1.0.0
	**/
	public var _paused:Bool;

	/**
	 * Was the animation previously playing before being paused?
	 *
	 * @since 1.0.0
	**/
	public var _wasPlaying:Bool;

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
	public var _pendingStop:Int;

	/**
	 * Internal property used by _pendingStop.
	 *
	 * @since 1.0.0
	**/
	private var _pendingStopValue:Either<AnimationFrame, Float>;

	/**
	 * `true` if the current animation is paused, otherwise `false`.
	 *
	 * @since 1.0.0
	**/
	public var isPaused(get, never):Bool;

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
	public function chain(?key:Either<String, BaseAnimation>):GameObject;

	/**
	 * Sets the amount of time, in milliseconds, that the animation will be delayed before starting playback.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The amount of time, in milliseconds, to wait before starting playback.
	 *
	 * @return The Game Object that owns this Animation Component.
	**/
	public function setDelay(value:Int = 0):GameObject;

	/**
	 * Gets the amount of time, in milliseconds that the animation will be delayed before starting playback.
	 *
	 * @since 1.0.0
	 *
	 * @return The amount of time, in milliseconds, the Animation will wait before starting playback.
	**/
	public function getDelay():Int;

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
	public function delayedPlay(delay:Int, key:String, startFrame:Int = 0):GameObject;

	/**
	 * Returns the key of the animation currently loaded into this component.
	 *
	 * @since 1.0.0
	 *
	 * @return The key of the Animation loaded into this component.
	**/
	public function getCurrentKey():Null<String>;

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
	private function load(key:String, startFrame:Int = 0):GameObject;

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
	public function pause(?atFrame:AnimationFrame):GameObject;

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
	public function resume(?fromFrame:AnimationFrame):GameObject;

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
	public function play(key:Either<String, BaseAnimation>,
		ignoreIfPlaying:Bool = false, startFrame:Int = 0):GameObject;

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
	public function playReverse(key:Either<String, BaseAnimation>,
		ignoreIfPlaying:Bool = false, startFrame:Int = 0):GameObject;

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
	public function _startAnimation(key:String, startFrame:Int = 0):GameObject;

	/**
	 * Reverse the Animation that is already playing on the Game Object.
	 *
	 * @since 1.0.0
	 *
	 * @return The Game Object that owns this Animation Component.
	**/
	public function reverse():GameObject;

	/**
	 * Returns a value between 0 and 1 indicating how far this animation is through, ignoring repeats and yoyos.
	 * If the animation has a non-zero repeat defined, `getProgress` and `getTotalProgress` will be different
	 * because `getProgress` doesn't include any repeats or repeat delays, whereas `getTotalProgress` does.
	 *
	 * @since 1.0.0
	 *
	 * @return The progress of the current animation, between 0 and 1.
	**/
	public function getProgress():Float;

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
	public function setProgress(value:Float = 0):GameObject;

	/**
	 * Handle the removal of an animation from the Animation Manager.
	 *
	 * @since 1.0.0
	 *
	 * @param key - The key of the removed Animation.
	 * @param animation - The removed Animation.
	**/
	public function remove(?key:String, ?animation:BaseAnimation):Void;

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
	public function getRepeat():Int;

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
	public function setRepeat(value:Int):GameObject;

	/**
	 * Gets the amount of delay between repeats, if any.
	 *
	 * @method Phaser.GameObjects.Components.Animation#getRepeatDelay
	 * @since 3.4.0
	 *
	 * @return {number} The delay between repeats.
	**/
	public function getRepeatDelay():Float;

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
	public function setRepeatDelay(value:Float):GameObject;

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
	public function restart(includeDelay:Bool = false):GameObject;

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
	public function stop():GameObject;

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
	public function stopAfterDelay(delay:Int):GameObject;

	/**
	 * Stops the current animation from playing when it next repeats.
	 *
	 * @fires Phaser.GameObjects.Components.Animation#onCompleteEvent
	 * @since 1.0.0
	 *
	 * @return The Game Object that owns this Animation Component.
	**/
	public function stopOnRepeat():GameObject;

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
	public function stopOnFrame(frame:AnimationFrame):GameObject;

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
	public function setTimeScale(value:Float = 1):GameObject;

	/**
	 * Gets the Time Scale factor.
	 *
	 * @since 1.0.0
	 *
	 * @return The Time Scale value.
	**/
	public function getTimeScale():Float;

	/**
	 * Returns the total number of frames in this animation.
	 *
	 * @since 1.0.0
	 *
	 * @return The total number of frames in this animation.
	**/
	public function getTotalFrames():Int;

	/**
	 * The internal update loop for the Animation Component.
	 *
	 * @since 1.0.0
	 *
	 * @param time - The current timestamp.
	 * @param delta - The delta time, in ms, elapsed since the last frame.
	**/
	public function update(time:Float, delta:Float):Void;

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
	public function setCurrentFrame(animationFrame:AnimationFrame):GameObject;

	/**
	 * Internal frame change handler.
	 *
	 * @fires Phaser.Animations.Events#SPRITE_ANIMATION_UPDATE_EVENT
	 * @fires Phaser.Animations.Events#SPRITE_ANIMATION_KEY_UPDATE_EVENT
	 * @since 1.0.0
	 *
	 * @param animationFrame - The animation frame to change to.
	**/
	@:allow(phaserHaxe)
	private function updateFrame(animationFrame:AnimationFrame):Void;

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
	public function nextFrame():GameObject;

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
	public function previousFrame():GameObject;

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
	public function setYoyo(value:Bool = false):GameObject;

	/**
	 * Gets if the current Animation will yoyo when it reaches the end.
	 * A yoyo'ing animation will play through consecutively, and then reverse-play back to the start again.
	 *
	 * @since 1.0.0
	 *
	 * @return `true` if the animation is set to yoyo, `false` if not.
	**/
	public function getYoyo():Bool;

	/**
	 * Destroy this Animation component.
	 *
	 * Unregisters event listeners and cleans up its references.
	 *
	 * @since 1.0.0
	**/
	public function destroy():Void;
}
