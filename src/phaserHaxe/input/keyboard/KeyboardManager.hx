package phaserHaxe.input.keyboard;

import phaserHaxe.utils.types.Union3;
import phaserHaxe.input.keyboard.keys.KeyCodes;
import js.html.KeyboardEvent as WebKeyboardEvent;
import haxe.Constraints.Function;
import phaserHaxe.core.GameEvents;
import phaserHaxe.utils.ArrayUtils.remove as arrayRemove;

using StringTools;

/**
 * The Keyboard Manager is a helper class that belongs to the global Input Manager.
 *
 * Its role is to listen for native DOM Keyboard Events and then store them for further processing by the Keyboard Plugin.
 *
 * You do not need to create this class directly, the Input Manager will create an instance of it automatically if keyboard
 * input has been enabled in the Game Config.
 *
 * @since 1.0.0
**/
class KeyboardManager
{
	/**
	 * A reference to the Input Manager.
	 *
	 * @since 1.0.0
	**/
	public var manager:InputManager;

	/**
	 * An internal event queue.
	 *
	 * @since 1.0.0
	**/
	private var queue:Array<WebKeyboardEvent> = [];

	/**
	 * A flag that controls if the non-modified keys, matching those stored in the `captures` array,
	 * have `preventDefault` called on them or not.
	 *
	 * A non-modified key is one that doesn't have a modifier key held down with it. The modifier keys are
	 * shift, control, alt and the meta key (Command on a Mac, the Windows Key on Windows).
	 * Therefore, if the user presses shift + r, it won't prevent this combination, because of the modifier.
	 * However, if the user presses just the r key on its own, it will have its event prevented.
	 *
	 * If you wish to stop capturing the keys, for example switching out to a DOM based element, then
	 * you can toggle this property at run-time.
	 *
	 * @since 1.0.0
	**/
	public var preventDefault:Bool = true;

	/**
	 * An array of Key Code values that will automatically have `preventDefault` called on them,
	 * as long as the `KeyboardManager.preventDefault` boolean is set to `true`.
	 *
	 * By default the array is empty.
	 *
	 * The key must be non-modified when pressed in order to be captured.
	 *
	 * A non-modified key is one that doesn't have a modifier key held down with it. The modifier keys are
	 * shift, control, alt and the meta key (Command on a Mac, the Windows Key on Windows).
	 * Therefore, if the user presses shift + r, it won't prevent this combination, because of the modifier.
	 * However, if the user presses just the r key on its own, it will have its event prevented.
	 *
	 * If you wish to stop capturing the keys, for example switching out to a DOM based element, then
	 * you can toggle the `KeyboardManager.preventDefault` boolean at run-time.
	 *
	 * If you need more specific control, you can create Key objects and set the flag on each of those instead.
	 *
	 * This array can be populated via the Game Config by setting the `input.keyboard.capture` array, or you
	 * can call the `addCapture` method. See also `removeCapture` and `clearCaptures`.
	 *
	 * @since 1.0.0
	**/
	public var captures:Array<Int> = [];

	/**
	 * A boolean that controls if the Keyboard Manager is enabled or not.
	 * Can be toggled on the fly.
	 *
	 * @since 1.0.0
	**/
	public var enabled:Bool = false;

	/**
	 * The Keyboard Event target, as defined in the Game Config.
	 * Typically the window in which the game is rendering, but can be any interactive DOM element.
	 *
	 * @since 1.0.0
	**/
	public var target:js.html.EventTarget;

	/**
	 * The Key Down Event handler.
	 * This function is sent the native DOM KeyEvent.
	 * Initially empty and bound in the `startListeners` method.
	 *
	 * @since 1.0.0
	**/
	public var onKeyDown:Null<Function> = null;

	/**
	 * The Key Up Event handler.
	 * This function is sent the native DOM KeyEvent.
	 * Initially empty and bound in the `startListeners` method.
	 *
	 * @since 1.0.0
	**/
	public var onKeyUp:Null<Function> = null;

	/**
	 * @param {Phaser.Input.InputManager} inputManager - A reference to the Input Manager.
	**/
	public function new(inputManager:InputManager)
	{
		this.manager = inputManager;

		inputManager.events.once(InputEvents.MANAGER_BOOT, this.boot, this);
	}

	/**
	 * The Keyboard Manager boot process.
	 *
	 * @since 1.0.0
	**/
	private function boot()
	{
		var config = this.manager.config;

		this.enabled = config.inputKeyboard;
		this.target = config.inputKeyboardEventTarget;

		addCapture(config.inputKeyboardCapture);

		if (target == null && js.Browser.window != null)
		{
			this.target = js.Browser.window;
		}

		if (enabled && target != null)
		{
			startListeners();
		}

		manager.game.events.on(GameEvents.POST_STEP, postUpdate, this);
	}

	/**
	 * Starts the Keyboard Event listeners running.
	 * This is called automatically and does not need to be manually invoked.
	 *
	 * @since 1.0.0
	**/
	public function startListeners()
	{
		this.onKeyDown = function(event:WebKeyboardEvent)
		{
			if (event.defaultPrevented || !enabled || manager == null)
			{
				// Do nothing if event already handled
				return;
			}

			this.queue.push(event);

			if (!manager.useQueue)
			{
				manager.events.emit(InputEvents.MANAGER_PROCESS);
			}

			var modified = (event.altKey || event.ctrlKey || event.shiftKey || event.metaKey);

			if (preventDefault && !modified && captures.indexOf(event.keyCode) > -1)
			{
				event.preventDefault();
			}
		};

		this.onKeyUp = function(event:WebKeyboardEvent)
		{
			if (event.defaultPrevented || !enabled || manager == null)
			{
				// Do nothing if event already handled
				return;
			}

			queue.push(event);

			if (manager.useQueue == null)
			{
				manager.events.emit(InputEvents.MANAGER_PROCESS);
			}

			var modified = (event.altKey || event.ctrlKey || event.shiftKey || event.metaKey);

			if (preventDefault && !modified && captures.indexOf(event.keyCode) > -1)
			{
				event.preventDefault();
			}
		};

		if (target != null)
		{
			target.addEventListener('keydown', onKeyDown, false);
			target.addEventListener('keyup', onKeyUp, false);

			enabled = true;
		}
	}

	/**
	 * Stops the Key Event listeners.
	 * This is called automatically and does not need to be manually invoked.
	 *
	 * @since 1.0.0
	**/
	public function stopListeners():Void
	{
		if (onKeyDown != null)
		{
			target.removeEventListener('keydown', onKeyDown, false);
		}
		if (onKeyUp != null)
		{
			target.removeEventListener('keyup', onKeyUp, false);
		}
		this.enabled = false;
	}

	/**
	 * Clears the event queue.
	 * Called automatically by the Input Manager.
	 *
	 * @since 1.0.0
	**/
	private function postUpdate():Void
	{
		this.queue = [];
	}

	/**
	 * By default when a key is pressed Phaser will not stop the event from propagating up to the browser.
	 * There are some keys this can be annoying for, like the arrow keys or space bar, which make the browser window scroll.
	 *
	 * This `addCapture` method enables consuming keyboard event for specific keys so it doesn't bubble up to the the browser
	 * and cause the default browser behavior.
	 *
	 * Please note that keyboard captures are global. This means that if you call this method from within a Scene, to say prevent
	 * the SPACE BAR from triggering a page scroll, then it will prevent it for any Scene in your game, not just the calling one.
	 *
	 * You can pass in a single key code value, or an array of key codes, or a string:
	 *
	 * ```haxe
	 * input.keyboard.addCapture(62);
	 * ```
	 *
	 * An array of key codes:
	 *
	 * ```haxe
	 * input.keyboard.addCapture([ 62, 63, 64 ]);
	 * ```
	 *
	 * Or a string:
	 *
	 * ```haxe
	 * input.keyboard.addCapture('W,S,A,D');
	 * ```
	 *
	 * To use non-alpha numeric keys, use a string, such as 'UP', 'SPACE' or 'LEFT'.
	 *
	 * You can also provide an array mixing both strings and key code integers.
	 *
	 * If there are active captures after calling this method, the `preventDefault` property is set to `true`.
	 *
	 * @since 1.0.0
	 *
	 * @param keycode - The Key Codes to enable capture for, preventing them reaching the browser.
	**/
	public function addCapture(keycode:Union3<KeyCodes, Array<KeyCodes>, String>)
	{
		var keycode:Any = keycode;

		if (Std.is(keycode, String))
		{
			var keycodeStr = (cast keycode : String);
			keycode = keycodeStr.split(',');
		}

		if (!Std.is(keycode, Array))
		{
			var code = keycode;

			var code = (cast code : Int);

			if (code != -1 && captures.indexOf(code) == -1)
			{
				captures.push(code);
			}
		}

		var keycode = (cast keycode : Array<Any>);

		for (i in 0...keycode.length)
		{
			var code = keycode[i];

			var code = if (Std.is(code, String))
			{
				KeyCodes.getByName((cast code : String).trim().toUpperCase());
			}
			else
			{
				(cast code : Int);
			}

			if (code != -1 && captures.indexOf(code) == -1)
			{
				captures.push(code);
			}
		}

		preventDefault = captures.length > 0;
	}

	/**
	 * Removes an existing key capture.
	 *
	 * Please note that keyboard captures are global. This means that if you call this method from within a Scene, to remove
	 * the capture of a key, then it will remove it for any Scene in your game, not just the calling one.
	 *
	 * You can pass in a single key code value, or an array of key codes, or a string:
	 *
	 * ```haxe
	 * this.input.keyboard.removeCapture(62);
	 * ```
	 *
	 * An array of key codes:
	 *
	 * ```haxe
	 * this.input.keyboard.removeCapture([ 62, 63, 64 ]);
	 * ```
	 *
	 * Or a string:
	 *
	 * ```haxe
	 * this.input.keyboard.removeCapture('W,S,A,D');
	 * ```
	 *
	 * To use non-alpha numeric keys, use a string, such as 'UP', 'SPACE' or 'LEFT'.
	 *
	 * You can also provide an array mixing both strings and key code integers.
	 *
	 * If there are no captures left after calling this method, the `preventDefault` property is set to `false`.
	 *
	 * @since 1.0.0
	 *
	 * @param keycode - The Key Codes to disable capture for, allowing them reaching the browser again.
	**/
	public function removeCapture(keycode:Union3<KeyCodes, Array<KeyCodes>, String>):Void
	{
		var keycode:Any = keycode;

		if (Std.is(keycode, String))
		{
			keycode = (cast keycode : String).split(',');
		}

		if (!Std.is(keycode, Array))
		{
			keycode = [keycode];
		}

		var keycode:Array<Any> = keycode;

		var captures = this.captures;

		for (i in 0...keycode.length)
		{
			var code = keycode[i];

			if (Std.is(code, String))
			{
				code = KeyCodes.getByName((cast code : String).toUpperCase());
			}

			arrayRemove(captures, (cast code : Int));
		}

		preventDefault = captures.length > 0;
	}

	/**
	 * Removes all keyboard captures and sets the `preventDefault` property to `false`.
	 *
	 * @since 1.0.0
	**/
	public function clearCaptures():Void
	{
		this.captures = [];

		this.preventDefault = false;
	}

	/**
	 * Destroys this Keyboard Manager instance.
	 *
	 * @since 1.0.0
	**/
	public function destroy():Void
	{
		this.stopListeners();

		this.clearCaptures();

		this.queue = [];

		this.manager.game.events.off(GameEvents.POST_RENDER, this.postUpdate, this);

		this.target = null;
		this.enabled = false;
		this.manager = null;
	}
}
