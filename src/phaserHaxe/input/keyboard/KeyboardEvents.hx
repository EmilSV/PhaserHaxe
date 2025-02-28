package phaserHaxe.input.keyboard;

enum abstract KeyboardEvents(String) from String to String
{
	/**
	 * The Global Key Down Event.
	 *
	 * This event is dispatched by the Keyboard Plugin when any key on the keyboard is pressed down.
	 *
	 * Listen to this event from within a Scene using: `this.input.keyboard.on('keydown', listener)`.
	 *
	 * You can also listen for a specific key being pressed. See [Keyboard.Events.KEY_DOWN]{@linkcode Phaser.Input.Keyboard.Events#event:KEY_DOWN} for details.
	 *
	 * Finally, you can create Key objects, which you can also listen for events from. See [Keyboard.Events.DOWN]{@linkcode Phaser.Input.Keyboard.Events#event:DOWN} for details.
	 *
	 * _Note_: Many keyboards are unable to process certain combinations of keys due to hardware limitations known as ghosting.
	 * Read [this article on ghosting]{@link http://www.html5gamedevs.com/topic/4876-impossible-to-use-more-than-2-keyboard-input-buttons-at-the-same-time/} for details.
	 *
	 * Also, please be aware that some browser extensions can disable or override Phaser keyboard handling.
	 * For example, the Chrome extension vimium is known to disable Phaser from using the D key, while EverNote disables the backtick key.
	 * There are others. So, please check your extensions if you find you have specific keys that don't work.
	 *
	 * @since 1.0.0
	 *
	 * @param event {js.html.KeyboardEvent} - The native DOM Keyboard Event. You can inspect this to learn more about the key that was pressed, any modifiers, etc.
	**/
	var ANY_KEY_DOWN = "keydown";

	/**
	 * The Global Key Up Event.
	 *
	 * This event is dispatched by the Keyboard Plugin when any key on the keyboard is released.
	 *
	 * Listen to this event from within a Scene using: `this.input.keyboard.on('keyup', listener)`.
	 *
	 * You can also listen for a specific key being released. See [Keyboard.Events.KEY_UP]{@linkcode Phaser.Input.Keyboard.Events#event:KEY_UP} for details.
	 *
	 * Finally, you can create Key objects, which you can also listen for events from. See [Keyboard.Events.UP]{@linkcode Phaser.Input.Keyboard.Events#event:UP} for details.
	 *
	 * @since 1.0.0
	 *
	 * @param event {js.html.KeyboardEvent} - The native DOM Keyboard Event. You can inspect this to learn more about the key that was released, any modifiers, etc.
	**/
	var ANY_KEY_UP = "keyup";

	/**
	 * The Key Combo Match Event.
	 *
	 * This event is dispatched by the Keyboard Plugin when a [Key Combo]{@link Phaser.Input.Keyboard.KeyCombo} is matched.
	 *
	 * Listen for this event from the Key Plugin after a combo has been created:
	 *
	 * ```haxe
	 * input.keyboard.createCombo([ 38, 38, 40, 40, 37, 39, 37, 39, 66, 65, 13 ], { resetOnMatch: true });
	 *
	 * input.keyboard.on('keycombomatch', (event) -> {
	 *     Console.log('Konami Code entered!');
	 * });
	 * ```
	 *
	 * @since 1.0.0
	 *
	 * @param keycombo {Phaser.Input.Keyboard.KeyCombo} - The Key Combo object that was matched.
	 * @param event {js.html.KeyboardEvent} - The native DOM Keyboard Event of the final key in the combo. You can inspect this to learn more about any modifiers, etc.
	**/
	var COMBO_MATCH = "keycombomatch";

	/**
	 * The Key Down Event.
	 *
	 * This event is dispatched by a [Key]{@link Phaser.Input.Keyboard.Key} object when it is pressed.
	 *
	 * Listen for this event from the Key object instance directly:
	 *
	 * ```haxe
	 * var spaceBar = this.input.keyboard.addKey(Phaser.Input.Keyboard.KeyCodes.SPACE);
	 *
	 * spaceBar.on('down', listener)
	 * ```
	 *
	 * You can also create a generic 'global' listener. See [Keyboard.Events.ANY_KEY_DOWN]{@linkcode Phaser.Input.Keyboard.Events#event:ANY_KEY_DOWN} for details.
	 *
	 * @since 1.0.0
	 *
	 * @param key {Phaser.Input.Keyboard.Key} - The Key object that was pressed.
	 * @param event {js.html.KeyboardEvent} - The native DOM Keyboard Event. You can inspect this to learn more about any modifiers, etc.
	**/
	var DOWN = "down";

	/**
	 * The Key Down Event.
	 *
	 * This event is dispatched by the Keyboard Plugin when any key on the keyboard is pressed down.
	 *
	 * Unlike the `ANY_KEY_DOWN` event, this one has a special dynamic event name. For example, to listen for the `A` key being pressed
	 * use the following from within a Scene: `this.input.keyboard.on('keydown-A', listener)`. You can replace the `-A` part of the event
	 * name with any valid [Key Code string]{@link Phaser.Input.Keyboard.KeyCodes}. For example, this will listen for the space bar:
	 * `this.input.keyboard.on('keydown-SPACE', listener)`.
	 *
	 * You can also create a generic 'global' listener. See [Keyboard.Events.ANY_KEY_DOWN]{@linkcode Phaser.Input.Keyboard.Events#event:ANY_KEY_DOWN} for details.
	 *
	 * Finally, you can create Key objects, which you can also listen for events from. See [Keyboard.Events.DOWN]{@linkcode Phaser.Input.Keyboard.Events#event:DOWN} for details.
	 *
	 * _Note_: Many keyboards are unable to process certain combinations of keys due to hardware limitations known as ghosting.
	 * Read [this article on ghosting]{@link http://www.html5gamedevs.com/topic/4876-impossible-to-use-more-than-2-keyboard-input-buttons-at-the-same-time/} for details.
	 *
	 * Also, please be aware that some browser extensions can disable or override Phaser keyboard handling.
	 * For example, the Chrome extension vimium is known to disable Phaser from using the D key, while EverNote disables the backtick key.
	 * There are others. So, please check your extensions if you find you have specific keys that don't work.
	 *
	 * @since 1.0.0
	 *
	 * @param event {js.html.KeyboardEvent} - The native DOM Keyboard Event. You can inspect this to learn more about the key that was pressed, any modifiers, etc.
	**/
	var KEY_DOWN = "keydown-";

	/**
	 * The Key Up Event.
	 *
	 * This event is dispatched by the Keyboard Plugin when any key on the keyboard is released.
	 *
	 * Unlike the `ANY_KEY_UP` event, this one has a special dynamic event name. For example, to listen for the `A` key being released
	 * use the following from within a Scene: `this.input.keyboard.on('keyup-A', listener)`. You can replace the `-A` part of the event
	 * name with any valid [Key Code string]{@link Phaser.Input.Keyboard.KeyCodes}. For example, this will listen for the space bar:
	 * `input.keyboard.on('keyup-SPACE', listener)`.
	 *
	 * You can also create a generic 'global' listener. See [Keyboard.Events.ANY_KEY_UP]{@linkcode Phaser.Input.Keyboard.Events#event:ANY_KEY_UP} for details.
	 *
	 * Finally, you can create Key objects, which you can also listen for events from. See [Keyboard.Events.UP]{@linkcode Phaser.Input.Keyboard.Events#event:UP} for details.
	 *
	 * @since 1.0.0
	 *
	 * @param event {js.html.KeyboardEvent} - The native DOM Keyboard Event. You can inspect this to learn more about the key that was released, any modifiers, etc.
	**/
	var KEY_UP = "keyup-";

	/**
	 * The Key Up Event.
	 *
	 * This event is dispatched by a [Key]{@link Phaser.Input.Keyboard.Key} object when it is released.
	 *
	 * Listen for this event from the Key object instance directly:
	 *
	 * ```haxe
	 * var spaceBar = input.keyboard.addKey(phaserHaxe.input.keyboard.KeyCodes.SPACE);
	 *
	 * spaceBar.on('up', listener)
	 * ```
	 *
	 * You can also create a generic 'global' listener. See [Keyboard.Events.ANY_KEY_UP]{@linkcode Phaser.Input.Keyboard.Events#event:ANY_KEY_UP} for details.
	 *
	 * @event Phaser.Input.Keyboard.Events#UP
	 * @since 3.0.0
	 *
	 * @param key {Phaser.Input.Keyboard.Key} - The Key object that was released.
	 * @param event {js.html.KeyboardEvent}} - The native DOM Keyboard Event. You can inspect this to learn more about any modifiers, etc.
	**/
	var UP = "up";
}
