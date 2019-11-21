package phaserHaxe.input.keyboard;

import js.html.KeyboardEvent;
import phaserHaxe.input.keyboard.web.WebKeyboardEvent;
import phaserHaxe.utils.types.Union3;
import phaserHaxe.input.keyboard.KeyboardPlugin;
import phaserHaxe.input.keyboard.KeyCodes;
import phaserHaxe.input.keyboard.KeyboardEvents;
import phaserHaxe.input.keyboard.typedefs.KeyComboConfig;
import phaserHaxe.input.keyboard.typedefs.KeyboardKeydownCallback;
import phaserHaxe.utils.types.Union;

/**
 * A KeyCombo will listen for a specific string of keys from the Keyboard, and when it receives them
 * it will emit a `keycombomatch` event from the Keyboard Manager.
 *
 * The keys to be listened for can be defined as:
 *
 * A string (i.e. 'ATARI')
 * An array of either integers (key codes) or strings, or a mixture of both
 * An array of objects (such as Key objects) with a public 'keyCode' property
 *
 * For example, to listen for the Konami code (up, up, down, down, left, right, left, right, b, a, enter)
 * you could pass the following array of key codes:
 *
 * ```haxe
 * input.keyboard.createCombo([ 38, 38, 40, 40, 37, 39, 37, 39, 66, 65, 13 ], { resetOnMatch: true });
 *
 * input.keyboard.on('keycombomatch', function (event) {
 *     console.log('Konami Code entered!');
 * });
 * ```
 *
 * Or, to listen for the user entering the word PHASER:
 *
 * ```haxe
 * input.keyboard.createCombo('PHASER');
 * ```
 *
 * @since 1.0.0
 *
**/
class KeyCombo
{
	/**
	 * A reference to the Keyboard Manager
	 *
	 * @since 1.0.0
	**/
	public var manager:KeyboardPlugin;

	/**
	 * A flag that controls if this Key Combo is actively processing keys or not.
	 *
	 * @since 1.0.0
	**/
	public var enabled:Bool = true;

	/**
	 * An array of the keyCodes that comprise this combo.
	 *
	 * @since 1.0.0
	**/
	public var keyCodes:Array<KeyCodes> = [];

	/**
	 * The current keyCode the combo is waiting for.
	 *
	 * @since 1.0.0
	**/
	public var current:KeyCodes;

	/**
	 * The current index of the key being waited for in the 'keys' string.
	 *
	 * @since 1.0.0
	**/
	public var index:Int = 0;

	/**
	 * The length of this combo (in keycodes)
	 *
	 * @since 1.0.0
	**/
	public var size:Float;

	/**
	 * The time the previous key in the combo was matched.
	 *
	 * @since 1.0.0
	**/
	public var timeLastMatched:Float = 0;

	/**
	 * Has this Key Combo been matched yet?
	 *
	 * @since 1.0.0
	**/
	public var matched:Bool = false;

	/**
	 * The time the entire combo was matched.
	 *
	 * @since 1.0.0
	**/
	public var timeMatched:Float = 0;

	/**
	 * If they press the wrong key do we reset the combo?
	 *
	 * @since 1.0.0
	**/
	public var resetOnWrongKey:Bool = true;

	/**
	 * The max delay in ms between each key press. Above this the combo is reset. 0 means disabled.
	 *
	 * @since 1.0.0
	**/
	public var maxKeyDelay:Int = 0;

	/**
	 * If previously matched and they press the first key of the combo again, will it reset?
	 *
	 * @since 1.0.0
	**/
	public var resetOnMatch:Bool = false;

	/**
	 * If the combo matches, will it delete itself?
	 *
	 * @since 1.0.0
	**/
	public var deleteOnMatch:Bool = false;

	/**
	 * The internal Key Down handler.
	 *
	 * @fires Phaser.Input.Keyboard.Events#COMBO_MATCH
	 * @since 1.0.0
	**/
	private var onKeyDown:KeyboardKeydownCallback;

	/**
	 * How far complete is this combo? A value between 0 and 1.
	 *
	 * @since 1.0.0
	**/
	public var progress(get, never):Float;

	public function new(keyboardPlugin:KeyboardPlugin,
			keys:Array<Union3<String, KeyCodes, {keyCode:Null<Int>}>>,
			config:KeyComboConfig)
	{
		if (config == null)
		{
			config = {};
		}

		inline function getValue<T>(value:T, defaultValue:T)
		{
			return value != null ? value : defaultValue;
		}

		if (keys.length < 2)
		{
			throw new Error("Can't have a zero or single length combo");
		}

		this.manager = keyboardPlugin;

		for (char in keys)
		{
			if (Std.is(char, String))
			{
				this.keyCodes.push((cast char : String).toUpperCase().charCodeAt(0));
			}
			else if (Std.is(char, Int))
			{
				this.keyCodes.push((cast char : Int));
			}
			else if ((cast char : {keyCode: Int}).keyCode != null)
			{
				this.keyCodes.push((cast char : {keyCode: Int}).keyCode);
			}
		}

		this.current = this.keyCodes[0];

		this.size = this.keyCodes.length;

		this.resetOnWrongKey = getValue(config.resetOnWrongKey, true);

		this.maxKeyDelay = getValue(config.maxKeyDelay, 0);

		this.resetOnMatch = getValue(config.resetOnMatch, false);

		this.deleteOnMatch = getValue(config.deleteOnMatch, false);

		var onKeyDownHandler = function(event)
		{
			if (this.matched || !this.enabled)
			{
				return;
			}

			var matched = processKeyCombo(event, this);

			if (matched)
			{
				this.manager.emit(KeyboardEvents.COMBO_MATCH, [this, event]);

				if (this.resetOnMatch)
				{
					resetKeyCombo(this);
				}
				else if (this.deleteOnMatch)
				{
					this.destroy();
				}
			}
		}

		this.onKeyDown = onKeyDownHandler;

		this.manager.on(KeyboardEvents.ANY_KEY_DOWN, this.onKeyDown);
	}

	private inline function get_progress():Float
	{
		return index / size;
	}

	/**
	 * Destroys this Key Combo and all of its references.
	 *
	 * @since 1.0.0
	**/
	public function destroy()
	{
		this.enabled = false;
		this.keyCodes = [];

		this.manager.off(KeyboardEvents.ANY_KEY_DOWN, this.onKeyDown);

		this.manager = null;
	}

	/**
	 * Used internally by the KeyCombo class.
	 *
	 * @since 1.0.0
	 *
	 * @param event - The native Keyboard Event.
	 * @param combo - The KeyCombo object to be processed.
	 *
	 * @return `true` if the combo was matched, otherwise `false`.
	**/
	private static function processKeyCombo(event:WebKeyboardEvent, combo:KeyCombo)
	{
		if (combo.matched)
		{
			return true;
		}

		var comboMatched = false;
		var keyMatched = false;

		if (event.keyCode == combo.current)
		{
			//  Key was correct
			if (combo.index > 0 && combo.maxKeyDelay > 0)
			{
				//  We have to check to see if the delay between
				//  the new key and the old one was too long (if enabled)

				var timeLimit = combo.timeLastMatched + combo.maxKeyDelay;

				//  Check if they pressed it in time or not
				if (event.timeStamp <= timeLimit)
				{
					keyMatched = true;
					comboMatched = advanceKeyCombo(event, combo);
				}
			}
			else
			{
				keyMatched = true;

				//  We don't check the time for the first key pressed, so just advance it
				comboMatched = advanceKeyCombo(event, combo);
			}
		}

		if (!keyMatched && combo.resetOnWrongKey)
		{
			//  Wrong key was pressed
			combo.index = 0;
			combo.current = combo.keyCodes[0];
		}

		if (comboMatched)
		{
			combo.timeLastMatched = event.timeStamp;
			combo.matched = true;
			combo.timeMatched = event.timeStamp;
		}

		return comboMatched;
	}

	/**
	 * Used internally by the KeyCombo class.
	 * Return `true` if it reached the end of the combo, `false` if not.
	 *
	 * @since 1.0.0
	 *
	 * @param event - The native Keyboard Event.
	 * @param combo - The KeyCombo object to advance.
	 *
	 * @return `true` if it reached the end of the combo, `false` if not.
	**/
	private static function advanceKeyCombo(event:WebKeyboardEvent, combo:KeyCombo):Bool
	{
		combo.timeLastMatched = event.timeStamp;
		combo.index++;

		if (combo.index == combo.size)
		{
			return true;
		}
		else
		{
			combo.current = combo.keyCodes[combo.index];
			return false;
		}
	}

	/**
	 * Used internally by the KeyCombo class.
	 *
	 * @since 1.0.0
	 *
	 * @param combo - The KeyCombo to reset.
	 *
	 * @return The KeyCombo.
	**/
	private static function resetKeyCombo(combo:KeyCombo):KeyCombo
	{
		combo.current = combo.keyCodes[0];
		combo.index = 0;
		combo.timeLastMatched = 0;
		combo.matched = false;
		combo.timeMatched = 0;
		return combo;
	}
}
