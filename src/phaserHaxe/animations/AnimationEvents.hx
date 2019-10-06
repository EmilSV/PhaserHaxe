package phaserHaxe.animations;

enum abstract AnimationEvents(String) from String to String
{
	/**
	 * The Add Animation Event.
	 *
	 * This event is dispatched when a new animation is added to the global Animation Manager.
	 *
	 * This can happen either as a result of an animation instance being added to the Animation Manager,
	 * or the Animation Manager creating a new animation directly.
	 *
	 * @event PhaserHaxe.Animations.Events#ADD_ANIMATION
	 * @since 1.0.0
	 *
	 * @param key:String - The key of the Animation that was added to the global Animation Manager.
	 * @param animation:PhaserHaxe.Animations.Animation - An instance of the newly created Animation.
	**/
	var ADD_ANIMATION = "add";

	/**
	 * The Animation Complete Event.
	 *
	 * This event is dispatched by an Animation instance when it completes, i.e. finishes playing or is manually stopped.
	 *
	 * Be careful with the volume of events this could generate. If a group of Sprites all complete the same
	 * animation at the same time, this event will invoke its handler for each one of them.
	 *
	 * @event PhaserHaxe.Animations.Events#ANIMATION_COMPLETE
	 * @since 1.0.0
	 *
	 * @param animation:PhaserHaxe.Animations.Animation - A reference to the Animation that completed.
	 * @param frame:PhaserHaxe.Animations.AnimationFrame - The current Animation Frame that the Animation completed on.
	 * @param gameObject:PhaserHaxe.GameObjects.Sprite - A reference to the Game Object on which the animation completed.
	**/
	var ANIMATION_COMPLETE = "complete";

	/**
	 * The Animation Repeat Event.
	 *
	 * This event is dispatched when a currently playing animation repeats.
	 *
	 * The event is dispatched directly from the Animation object itself. Which means that listeners
	 * bound to this event will be invoked every time the Animation repeats, for every Game Object that may have it.
	 *
	 * @event PhaserHaxe.Animations.Events#ANIMATION_REPEAT
	 * @since 1.0.0
	 *
	 * @param animation:PhaserHaxe.Animations.Animation - A reference to the Animation that repeated.
	 * @param frame:PhaserHaxe.Animations.AnimationFrame - The current Animation Frame that the Animation was on when it repeated.
	**/
	var ANIMATION_REPEAT = "repeat";

	/**
	 * The Animation Restart Event.
	 *
	 * This event is dispatched by an Animation instance when it restarts.
	 *
	 * Be careful with the volume of events this could generate. If a group of Sprites all restart the same
	 * animation at the same time, this event will invoke its handler for each one of them.
	 *
	 * @event PhaserHaxe.Animations.Events#ANIMATION_RESTART
	 * @since 1.0.0
	 *
	 * @param animation:PhaserHaxe.Animations.Animation - A reference to the Animation that restarted playing.
	 * @param frame:PhaserHaxe.Animations.AnimationFrame - The current Animation Frame that the Animation restarted with.
	 * @param gameObject:PhaserHaxe.GameObjects.Sprite - A reference to the Game Object on which the animation restarted playing.
	**/
	var ANIMATION_RESTART = "restart";

	/**
	 * The Animation Start Event.
	 *
	 * This event is dispatched by an Animation instance when it starts playing.
	 *
	 * Be careful with the volume of events this could generate. If a group of Sprites all play the same
	 * animation at the same time, this event will invoke its handler for each one of them.
	 *
	 * @event PhaserHaxe.Animations.Events#ANIMATION_START
	 * @since 1.0.0
	 *
	 * @param animation:PhaserHaxe.Animations.Animation - A reference to the Animation that started playing.
	 * @param frame:PhaserHaxe.Animations.AnimationFrame - The current Animation Frame that the Animation started with.
	 * @param gameObject:PhaserHaxe.GameObjects.Sprite - A reference to the Game Object on which the animation started playing.
	**/
	var ANIMATION_START = "start";

	/**
	 * The Pause All Animations Event.
	 *
	 * This event is dispatched when the global Animation Manager is told to pause.
	 *
	 * When this happens all current animations will stop updating, although it doesn't necessarily mean
	 * that the game has paused as well.
	 *
	 * @event PhaserHaxe.Animations.Events#PAUSE_ALL
	 * @since 1.0.0
	**/
	var PAUSE_ALL = "pauseall";

	/**
	 * The Remove Animation Event.
	 *
	 * This event is dispatched when an animation is removed from the global Animation Manager.
	 *
	 * @event PhaserHaxe.Animations.Events#REMOVE_ANIMATION
	 * @since 1.0.0
	 *
	 * @param key:String - The key of the Animation that was removed from the global Animation Manager.
	 * @param animation:PhaserHaxe.Animations.Animation - An instance of the removed Animation.
	**/
	var REMOVE_ANIMATION = "remove";

	/**
	 * The Resume All Animations Event.
	 *
	 * This event is dispatched when the global Animation Manager resumes, having been previously paused.
	 *
	 * When this happens all current animations will continue updating again.
	 *
	 * @event PhaserHaxe.Animations.Events#RESUME_ALL
	 * @since 1.0.0
	**/
	var RESUME_ALL = "resumeall";

	/**
	 * The Sprite Animation Complete Event.
	 *
	 * This event is dispatched by a Sprite when an animation finishes playing on it.
	 *
	 * Listen for it on the Sprite using `sprite.on('animationcomplete', listener)`
	 *
	 * This same event is dispatched for all animations. To listen for a specific animation, use the `SPRITE_ANIMATION_KEY_COMPLETE` event.
	 *
	 * @event PhaserHaxe.Animations.Events#SPRITE_ANIMATION_COMPLETE
	 * @since 1.0.0
	 *
	 * @param animation:PhaserHaxe.Animations.Animation - A reference to the Animation that completed.
	 * @param frame:PhaserHaxe.Animations.AnimationFrame - The current Animation Frame that the Animation completed on.
	 * @param gameObject:PhaserHaxe.GameObjects.Sprite - A reference to the Game Object on which the animation completed.
	**/
	var SPRITE_ANIMATION_COMPLETE = "animationcomplete";

	/**
	 * The Sprite Animation Key Complete Event.
	 *
	 * This event is dispatched by a Sprite when a specific animation finishes playing on it.
	 *
	 * Listen for it on the Sprite using `sprite.on('animationcomplete-key', listener)` where `key` is the key of
	 * the animation. For example, if you had an animation with the key 'explode' you should listen for `animationcomplete-explode`.
	 *
	 * @event PhaserHaxe.Animations.Events#SPRITE_ANIMATION_KEY_COMPLETE
	 * @since 1.0.0
	 *
	 * @param animation:PhaserHaxe.Animations.Animation - A reference to the Animation that completed.
	 * @param frame:PhaserHaxe.Animations.AnimationFrame - The current Animation Frame that the Animation completed on.
	 * @param gameObject:PhaserHaxe.GameObjects.Sprite - A reference to the Game Object on which the animation completed.
	**/
	var SPRITE_ANIMATION_KEY_COMPLETE = "animationcomplete-";

	/**
	 * The Sprite Animation Key Repeat Event.
	 *
	 * This event is dispatched by a Sprite when a specific animation repeats playing on it.
	 *
	 * Listen for it on the Sprite using `sprite.on('animationrepeat-key', listener)` where `key` is the key of
	 * the animation. For example, if you had an animation with the key 'explode' you should listen for `animationrepeat-explode`.
	 *
	 * @event PhaserHaxe.Animations.Events#SPRITE_ANIMATION_KEY_REPEAT
	 * @since 1.0.0
	 *
	 * @param animation:PhaserHaxe.Animations.Animation - A reference to the Animation that is repeating on the Sprite.
	 * @param frame:PhaserHaxe.Animations.AnimationFrame - The current Animation Frame that the Animation started with.
	 * @param repeatCount:Int - The number of times the Animation has repeated so far.
	 * @param gameObject:PhaserHaxe.GameObjects.Sprite - A reference to the Game Object on which the animation repeated playing.
	**/
	var SPRITE_ANIMATION_KEY_REPEAT = "animationrepeat-";

	/**
	 * The Sprite Animation Key Restart Event.
	 *
	 * This event is dispatched by a Sprite when a specific animation restarts playing on it.
	 *
	 * Listen for it on the Sprite using `sprite.on('animationrestart-key', listener)` where `key` is the key of
	 * the animation. For example, if you had an animation with the key 'explode' you should listen for `animationrestart-explode`.
	 *
	 * @event PhaserHaxe.Animations.Events#SPRITE_ANIMATION_KEY_RESTART
	 * @since 1.0.0
	 *
	 * @param animation:PhaserHaxe.Animations.Animation - A reference to the Animation that was restarted on the Sprite.
	 * @param frame:PhaserHaxe.Animations.AnimationFrame - The current Animation Frame that the Animation restarted with.
	 * @param gameObject:PhaserHaxe.GameObjects.Sprite - A reference to the Game Object on which the animation restarted playing.
	**/
	var SPRITE_ANIMATION_KEY_RESTART = "animationrestart-";

	/**
	 * The Sprite Animation Key Start Event.
	 *
	 * This event is dispatched by a Sprite when a specific animation starts playing on it.
	 *
	 * Listen for it on the Sprite using `sprite.on('animationstart-key', listener)` where `key` is the key of
	 * the animation. For example, if you had an animation with the key 'explode' you should listen for `animationstart-explode`.
	 *
	 * @event PhaserHaxe.Animations.Events#SPRITE_ANIMATION_KEY_START
	 * @since 1.0.0
	 *
	 * @param animation:PhaserHaxe.Animations.Animation - A reference to the Animation that was started on the Sprite.
	 * @param frame:PhaserHaxe.Animations.AnimationFrame - The current Animation Frame that the Animation started with.
	 * @param gameObject:PhaserHaxe.GameObjects.Sprite - A reference to the Game Object on which the animation started playing.
	**/
	var SPRITE_ANIMATION_KEY_START = "animationstart-";

	/**
	 * The Sprite Animation Key Update Event.
	 *
	 * This event is dispatched by a Sprite when a specific animation playing on it updates. This happens when the animation changes frame,
	 * based on the animation frame rate and other factors like `timeScale` and `delay`.
	 *
	 * Listen for it on the Sprite using `sprite.on('animationupdate-key', listener)` where `key` is the key of
	 * the animation. For example, if you had an animation with the key 'explode' you should listen for `animationupdate-explode`.
	 *
	 * @event PhaserHaxe.Animations.Events#SPRITE_ANIMATION_KEY_UPDATE
	 * @since 1.0.0
	 *
	 * @param animation:PhaserHaxe.Animations.Animation - A reference to the Animation that has updated on the Sprite.
	 * @param frame:PhaserHaxe.Animations.AnimationFrame - The current Animation Frame of the Animation.
	 * @param gameObject:PhaserHaxe.GameObjects.Sprite - A reference to the Game Object on which the animation updated.
	**/
	var SPRITE_ANIMATION_KEY_UPDATE = "animationupdate-";

	/**
	 * The Sprite Animation Repeat Event.
	 *
	 * This event is dispatched by a Sprite when an animation repeats playing on it.
	 *
	 * Listen for it on the Sprite using `sprite.on('animationrepeat', listener)`
	 *
	 * This same event is dispatched for all animations. To listen for a specific animation, use the `SPRITE_ANIMATION_KEY_REPEAT` event.
	 *
	 * @event PhaserHaxe.Animations.Events#SPRITE_ANIMATION_REPEAT
	 * @since 1.0.0
	 *
	 * @param animation:PhaserHaxe.Animations.Animation - A reference to the Animation that is repeating on the Sprite.
	 * @param frame:PhaserHaxe.Animations.AnimationFrame - The current Animation Frame that the Animation started with.
	 * @param repeatCount:Int - The number of times the Animation has repeated so far.
	 * @param gameObject:PhaserHaxe.GameObjects.Sprite - A reference to the Game Object on which the animation repeated playing.
	**/
	var SPRITE_ANIMATION_REPEAT = "animationrepeat";

	/**
	 * The Sprite Animation Restart Event.
	 *
	 * This event is dispatched by a Sprite when an animation restarts playing on it.
	 *
	 * Listen for it on the Sprite using `sprite.on('animationrestart', listener)`
	 *
	 * This same event is dispatched for all animations. To listen for a specific animation, use the `SPRITE_ANIMATION_KEY_RESTART` event.
	 *
	 * @event PhaserHaxe.Animations.Events#SPRITE_ANIMATION_RESTART
	 * @since 1.0.0
	 *
	 * @param animation:PhaserHaxe.Animations.Animation - A reference to the Animation that was restarted on the Sprite.
	 * @param frame:PhaserHaxe.Animations.AnimationFrame - The current Animation Frame that the Animation restarted with.
	 * @param gameObject:PhaserHaxe.GameObjects.Sprite - A reference to the Game Object on which the animation restarted playing.
	 */
	var SPRITE_ANIMATION_RESTART = "animationrestart";

	/**
	 * The Sprite Animation Start Event.
	 *
	 * This event is dispatched by a Sprite when an animation starts playing on it.
	 *
	 * Listen for it on the Sprite using `sprite.on('animationstart', listener)`
	 *
	 * This same event is dispatched for all animations. To listen for a specific animation, use the `SPRITE_ANIMATION_KEY_START` event.
	 *
	 * @event PhaserHaxe.Animations.Events#SPRITE_ANIMATION_START
	 * @since 1.0.0
	 *
	 * @param animation:PhaserHaxe.Animations.Animation - A reference to the Animation that was started on the Sprite.
	 * @param frame:PhaserHaxe.Animations.AnimationFrame - The current Animation Frame that the Animation started with.
	 * @param gameObject:PhaserHaxe.GameObjects.Sprite - A reference to the Game Object on which the animation started playing.
	**/
	var SPRITE_ANIMATION_START = "animationstart";

	/**
	 * The Sprite Animation Update Event.
	 *
	 * This event is dispatched by a Sprite when an animation playing on it updates. This happens when the animation changes frame,
	 * based on the animation frame rate and other factors like `timeScale` and `delay`.
	 *
	 * Listen for it on the Sprite using `sprite.on('animationupdate', listener)`
	 *
	 * This same event is dispatched for all animations. To listen for a specific animation, use the `SPRITE_ANIMATION_KEY_UPDATE` event.
	 *
	 * @event PhaserHaxe.Animations.Events#SPRITE_ANIMATION_UPDATE
	 * @since 1.0.0
	 *
	 * @param animation:PhaserHaxe.Animations.Animation - A reference to the Animation that has updated on the Sprite.
	 * @param frame:PhaserHaxe.Animations.AnimationFrame - The current Animation Frame of the Animation.
	 * @param gameObject:PhaserHaxe.GameObjects.Sprite - A reference to the Game Object on which the animation updated.
	**/
	var SPRITE_ANIMATION_UPDATE = "animationupdate";
}
