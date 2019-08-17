package phaserHaxe.scale;

enum abstract Events(String) to String
{
	/**
	 * The Scale Manager has successfully entered fullscreen mode.
	 *
	 * @event phaserHaxe.scale.Events.ENTER_FULLSCREEN
	 * @since 1.0.0
	**/
	var ENTER_FULLSCREEN = "enterfullscreen";

	/**
	 * The Scale Manager tried to enter fullscreen mode but failed.
	 *
	 * @event phaserHaxe.scale.Events.FULLSCREEN_FAILED
	 * @since 1.0.0
	**/
	var FULLSCREEN_FAILED = "fullscreenfailed";

	/**
	 * The Scale Manager tried to enter fullscreen mode, but it is unsupported by the browser.
	 *
	 * @event phaserHaxe.scale.Events.LEAVE_FULLSCREEN
	 * @since 1.0.0
	**/
	var FULLSCREEN_UNSUPPORTED = "fullscreenunsupported";

	/**
	 * The Scale Manager was in fullscreen mode, but has since left, either directly via game code,
	 * or via a user gestured, such as pressing the ESC key.
	 *
	 * @event phaserHaxe.scale.Events.LEAVE_FULLSCREEN
	 * @since 1.0.0
	**/
	var LEAVE_FULLSCREEN = "leavefullscreen";

	/**
	 * The Scale Manager Orientation Change Event.
	 *
	 * @event phaserHaxe.scale.Events.ORIENTATION_CHANGE
	 * @since 1.0.0
	 *
	 * @param orientation : string
	**/
	var ORIENTATION_CHANGE = "orientationchange";

	/**
	 * The Scale Manager Resize Event.
	 *
	 * This event is dispatched whenever the Scale Manager detects a resize event from the browser.
	 * It sends three parameters to the callback, each of them being Size components. You can read
	 * the `width`, `height`, `aspectRatio` and other properties of these components to help with
	 * scaling your own game content.
	 *
	 * @event phaserHaxe.scale.Events.RESIZE
	 * @since 1.0.0
	 *
	 * @param gameSize - A reference to the Game Size component. This is the un-scaled size of your game canvas.
	 * @param baseSize - A reference to the Base Size component. This is the game size multiplied by resolution.
	 * @param displaySize - A reference to the Display Size component. This is the scaled canvas size, after applying zoom and scale mode.
	 * @param resolution - The current resolution. Defaults to 1 at the moment.
	 * @param previousWidth - If the `gameSize` has changed, this value contains its previous width, otherwise it contains the current width.
	 * @param previousHeight - If the `gameSize` has changed, this value contains its previous height, otherwise it contains the current height.
	**/
	var RESIZE = "resize";
}
