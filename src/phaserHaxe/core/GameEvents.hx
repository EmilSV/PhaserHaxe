
package phaserHaxe.core;
enum abstract GameEvents(String) from String to String
{
	/**
	 * The Game Blur Event.
	 *
	 * This event is dispatched by the Game Visibility Handler when the window in which the Game instance is embedded
	 * enters a blurred state. The blur event is raised when the window loses focus. This can happen if a user swaps
	 * tab, or if they simply remove focus from the browser to another app.
	 *
	 * @since 1.0.0
	**/
	var BLUR = "blur";

	/**
	 * The Game Boot Event.
	 *
	 * This event is dispatched when the Phaser Game instance has finished booting, but before it is ready to start running.
	 * The global systems use this event to know when to set themselves up, dispatching their own `ready` events as required.
	 *
	 * @since 1.0.0
	**/
	var BOOT = "boot";

	/**
	 * The Game Context Lost Event.
	 *
	 * This event is dispatched by the Game if the WebGL Renderer it is using encounters a WebGL Context Lost event from the browser.
	 *
	 * The partner event is `CONTEXT_RESTORED`.
	 *
	 * @since 1.0.0
	**/
	var CONTEXT_LOST = "contextlost";

	/**
	 * The Game Context Restored Event.
	 *
	 * This event is dispatched by the Game if the WebGL Renderer it is using encounters a WebGL Context Restored event from the browser.
	 *
	 * The partner event is `CONTEXT_LOST`.
	 *
	 * @since 1.0.0
	**/
	var CONTEXT_RESTORED = "contextrestored";

	/**
	 * The Game Destroy Event.
	 *
	 * This event is dispatched when the game instance has been told to destroy itself.
	 * Lots of internal systems listen to this event in order to clear themselves out.
	 * Custom plugins and game code should also do the same.
	 *
	 * @since 1.0.0
	**/
	var DESTROY = "destroy";

	/**
	 * The Game Focus Event.
	 *
	 * This event is dispatched by the Game Visibility Handler when the window in which the Game instance is embedded
	 * enters a focused state. The focus event is raised when the window re-gains focus, having previously lost it.
	 *
	 * @since 1.0.0
	**/
	var FOCUS = "focus";

	/**
	 * The Game Hidden Event.
	 *
	 * This event is dispatched by the Game Visibility Handler when the document in which the Game instance is embedded
	 * enters a hidden state. Only browsers that support the Visibility API will cause this event to be emitted.
	 *
	 * In most modern browsers, when the document enters a hidden state, the Request Animation Frame and setTimeout, which
	 * control the main game loop, will automatically pause. There is no way to stop this from happening. It is something
	 * your game should account for in its own code, should the pause be an issue (i.e. for multiplayer games)
	 *
	 * @since 1.0.0
	**/
	var HIDDEN = "hidden";

	/**
	 * The Game Pause Event.
	 *
	 * This event is dispatched when the Game loop enters a paused state, usually as a result of the Visibility Handler.
	 *
	 * @since 1.0.0
	**/
	var PAUSE = "pause";

	/**
	 * The Game Post-Render Event.
	 *
	 * This event is dispatched right at the end of the render process.
	 *
	 * Every Scene will have rendered and been drawn to the canvas by the time this event is fired.
	 * Use it for any last minute post-processing before the next game step begins.
	 *
	 * @since 1.0.0
	 *
	 * @param {(Phaser.Renderer.Canvas.CanvasRenderer|Phaser.Renderer.WebGL.WebGLRenderer)} renderer - A reference to the current renderer being used by the Game instance.
	**/
	var POST_RENDER = "postrender";

	/**
	 * The Game Post-Step Event.
	 *
	 * This event is dispatched after the Scene Manager has updated.
	 * Hook into it from plugins or systems that need to do things before the render starts.
	 *
	 * @since 1.0.0
	 *
	 * @param time:Float - The current time. Either a High Resolution Timer value if it comes from Request Animation Frame, or Date.now if using SetTimeout.
	 * @param delta:Float - The delta time in ms since the last frame. This is a smoothed and capped value based on the FPS rate.
	**/
	var POST_STEP = "poststep";

	/**
	 * The Game Pre-Render Event.
	 *
	 * This event is dispatched immediately before any of the Scenes have started to render.
	 *
	 * The renderer will already have been initialized this frame, clearing itself and preparing to receive the Scenes for rendering, but it won't have actually drawn anything yet.
	 *
	 * @since 1.0.0
	 *
	 * @param {(Phaser.Renderer.Canvas.CanvasRenderer|Phaser.Renderer.WebGL.WebGLRenderer)} renderer - A reference to the current renderer being used by the Game instance.
	**/
	var PRE_RENDER = "prerender";

	/**
	 * The Game Pre-Step Event.
	 *
	 * This event is dispatched before the main Game Step starts. By this point in the game cycle none of the Scene updates have yet happened.
	 * Hook into it from plugins or systems that need to update before the Scene Manager does.
	 *
	 * @since 1.0.0
	 *
	 * @param time:Float - The current time. Either a High Resolution Timer value if it comes from Request Animation Frame, or Date.now if using SetTimeout.
	 * @param delta:Float - The delta time in ms since the last frame. This is a smoothed and capped value based on the FPS rate.
	**/
	var PRE_STEP = "prestep";

	/**
	 * The Game Ready Event.
	 *
	 * This event is dispatched when the Phaser Game instance has finished booting, the Texture Manager is fully ready,
	 * and all local systems are now able to start.
	 *
	 * @since 1.0.0
	**/
	var READY = "ready";

	/**
	 * The Game Resume Event.
	 *
	 * This event is dispatched when the game loop leaves a paused state and resumes running.
	 *
	 * @since 1.0.0
	**/
	var RESUME = "resume";

	/**
	 * The Game Step Event.
	 *
	 * This event is dispatched after the Game Pre-Step and before the Scene Manager steps.
	 * Hook into it from plugins or systems that need to update before the Scene Manager does, but after the core Systems have.
	 *
	 * @since 1.0.0
	 *
	 * @param time:Float - The current time. Either a High Resolution Timer value if it comes from Request Animation Frame, or Date.now if using SetTimeout.
	 * @param delta:Float - The delta time in ms since the last frame. This is a smoothed and capped value based on the FPS rate.
	**/
	var STEP = "step";

	/**
	 * The Game Visible Event.
	 *
	 * This event is dispatched by the Game Visibility Handler when the document in which the Game instance is embedded
	 * enters a visible state, previously having been hidden.
	 *
	 * Only browsers that support the Visibility API will cause this event to be emitted.
	 *
	 * @since 1.0.0
	**/
	var VISIBLE = "visible";
}
