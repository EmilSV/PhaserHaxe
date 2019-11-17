package phaserHaxe.input.keyboard;

import phaserHaxe.input.keyboard.keys.KeyCodes;
import js.html.KeyboardEvent;
import haxe.Constraints.Function;
using StringTools

@:forward
abstract KeyboardManager(Dynamic) {}

class KeyboardManager2
{
	/**
	 * A reference to the Input Manager.
	 *
	 * @name Phaser.Input.Keyboard.KeyboardManager#manager
	 * @type {Phaser.Input.InputManager}
	 * @since 3.16.0
	**/
	public var manager:InputManager = inputManager;

	/**
	 * An internal event queue.
	 *
	 * @name Phaser.Input.Keyboard.KeyboardManager#queue
	 * @type {KeyboardEvent[]}
	 * @private
	 * @since 3.16.0
	**/
	public var queue:Array<KeyboardEvent> = [];

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
	 * @name Phaser.Input.Keyboard.KeyboardManager#preventDefault
	 * @type {boolean}
	 * @since 3.16.0
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
	public var target:Any;

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

	public function new()
	{
		inputManager.events.once(InputEvents.MANAGER_BOOT, boot, this);
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

		this.addCapture(config.inputKeyboardCapture);

		if (!this.target && window)
		{
			this.target = window;
		}

		if (this.enabled && this.target)
		{
			this.startListeners();
		}

		this.manager.game.events.on(GameEvents.POST_STEP, this.postUpdate, this);
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
	 * ```javascript
	 * this.input.keyboard.addCapture(62);
	 * ```
	 *
	 * An array of key codes:
	 *
	 * ```javascript
	 * this.input.keyboard.addCapture([ 62, 63, 64 ]);
	 * ```
	 *
	 * Or a string:
	 *
	 * ```javascript
	 * this.input.keyboard.addCapture('W,S,A,D');
	 * ```
	 *
	 * To use non-alpha numeric keys, use a string, such as 'UP', 'SPACE' or 'LEFT'.
	 *
	 * You can also provide an array mixing both strings and key code integers.
	 *
	 * If there are active captures after calling this method, the `preventDefault` property is set to `true`.
	 *
	 * @method Phaser.Input.Keyboard.KeyboardManager#addCapture
	 * @since 3.16.0
	 *
	 * @param {(string|integer|integer[]|any[])} keycode - The Key Codes to enable capture for, preventing them reaching the browser.
	**/
	public function addCapture(keycode:Any)
	{
		if (Std.is(keycode, String))
		{
			var keycodeStr = (cast keycode : String);
			keycode = keycodeStr.split(',');
		}

		if (!Std.is(keycode, Array))
		{
			keycode = [keycode];
		}

		var captures = this.captures;

		var keycode = (cast keycode : Array<Any>);

		for (i in 0...keycode.length)
		{
			var code = keycode[i];

			if (Std.is(code, String))
			{
				code = KeyCodes.get((code : String).trim().toUpperCase());
			}

			if (captures.indexOf(code) == -1)
			{
				captures.push(code);
			}
		}

		this.preventDefault = captures.length > 0;
	}
}
