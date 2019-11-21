package phaserHaxe.input.keyboard;

import js.html.KeyboardEvent;
import phaserHaxe.input.keyboard.typedefs.CursorKeys;
import phaserHaxe.utils.types.Union3;
import phaserHaxe.utils.types.Union;
import phaserHaxe.input.keyboard.KeyCodes;
import phaserHaxe.core.GameEvents;
import phaserHaxe.input.keyboard.Key;
import phaserHaxe.scene.typedefs.SettingsObject;
import phaserHaxe.math.Snap.snapFloor as snapFloor;

/**
 * The Keyboard Plugin is an input plugin that belongs to the Scene-owned Input system.
 *
 * Its role is to listen for native DOM Keyboard Events and then process them.
 *
 * You do not need to create this class directly, the Input system will create an instance of it automatically.
 *
 * You can access it from within a Scene using `this.input.keyboard`. For example, you can do:
 *
 * ```haxe
 * input.keyboard.on('keydown', callback, context);
 * ```
 *
 * Or, to listen for a specific key:
 *
 * ```haxe
 * input.keyboard.on('keydown-A', callback, context);
 * ```
 *
 * You can also create Key objects, which you can then poll in your game loop:
 *
 * ```haxe
 * var spaceBar = input.keyboard.addKey(PhaserHaxe.input.keyboard.KeyCodes.SPACE);
 * ```
 *
 * If you have multiple parallel Scenes, each trying to get keyboard input, be sure to disable capture on them to stop them from
 * stealing input from another Scene in the list. You can do this with `this.input.keyboard.enabled = false` within the
 * Scene to stop all input, or `this.input.keyboard.preventDefault = false` to stop a Scene halting input on another Scene.
 *
 * _Note_: Many keyboards are unable to process certain combinations of keys due to hardware limitations known as ghosting.
 * See http://www.html5gamedevs.com/topic/4876-impossible-to-use-more-than-2-keyboard-input-buttons-at-the-same-time/ for more details.
 *
 * Also please be aware that certain browser extensions can disable or override Phaser keyboard handling.
 * For example the Chrome extension vimium is known to disable Phaser from using the D key, while EverNote disables the backtick key.
 * And there are others. So, please check your extensions before opening Phaser issues about keys that don't work.
 *
 * @since 1.0.0
**/
class KeyboardPlugin extends EventEmitter
{
	/**
	 * A reference to the core game, so we can listen for visibility events.
	 *
	 * @since 1.0.0
	**/
	public var game:Game;

	/**
	 * A reference to the Scene that this Input Plugin is responsible for.
	 *
	 * @since 1.0.0
	**/
	public var scene:Scene;

	/**
	 * A reference to the Scene Systems Settings.
	 *
	 * @since 1.0.0
	**/
	public var settings:SettingsObject;

	/**
	 * A reference to the Scene Input Plugin that created this Keyboard Plugin.
	 *
	 * @since 1.0.0
	**/
	public var sceneInputPlugin:InputPlugin;

	/**
	 * A reference to the global Keyboard Manager.
	 *
	 * @since 1.0.0
	**/
	public var manager:KeyboardManager;

	/**
	 * A boolean that controls if this Keyboard Plugin is enabled or not.
	 * Can be toggled on the fly.
	 *
	 * @since 1.0.0
	**/
	public var enabled:Bool = true;

	/**
	 * An array of Key objects to process.
	 *
	 * @since 1.0.0
	**/
	public var keys:Array<Key> = [];

	/**
	 * An array of KeyCombo objects to process.
	 *
	 * @since 1.0.0
	**/
	public var combos:Array<KeyCombo> = [];

	private var time:Float = 0;

	public function new(sceneInputPlugin:InputPlugin)
	{
		super();

		this.game = sceneInputPlugin.systems.game;

		this.scene = sceneInputPlugin.scene;

		this.settings = this.scene.sys.settings;

		this.sceneInputPlugin = sceneInputPlugin;

		this.manager = sceneInputPlugin.manager.keyboard;

		sceneInputPlugin.pluginEvents.once(InputEvents.BOOT, this.boot, this);
		sceneInputPlugin.pluginEvents.on(InputEvents.START, this.start, this);
	}

	/**
	 * This method is called automatically, only once, when the Scene is first created.
	 * Do not invoke it directly.
	 *
	 * @since 1.0.0
	**/
	private function boot()
	{
		var settings = this.settings.input;

		if (settings != null)
		{
			this.enabled = settings.keyboard != null;
		}
		else
		{
			this.enabled = true;
		}

		var captures = if (settings != null && settings.keyboard != null && settings.keyboard.capture != null)
		{
			settings.keyboard.capture;
		}
		else
		{
			null;
		}

		if (captures != null)
		{
			// this.addCaptures(captures);
		}

		this.sceneInputPlugin.pluginEvents.once(InputEvents.DESTROY, this.destroy, this);
	}

	/**
	 * This method is called automatically by the Scene when it is starting up.
	 * It is responsible for creating local systems, properties and listening for Scene events.
	 * Do not invoke it directly.
	 *
	 * @since 1.0.0
	**/
	private function start()
	{
		if (this.sceneInputPlugin.manager.useQueue)
		{
			this.sceneInputPlugin.pluginEvents.on(InputEvents.UPDATE, this.update, this);
		}
		else
		{
			this.sceneInputPlugin.manager.events.on(InputEvents.MANAGER_PROCESS, this.update, this);
		}

		this.sceneInputPlugin.pluginEvents.once(InputEvents.SHUTDOWN, this.shutdown, this);

		this.game.events.on(GameEvents.BLUR, this.resetKeys, this);
	}

	/**
	 * Checks to see if both this plugin and the Scene to which it belongs is active.
	 *
	 * @since 1.0.0
	 *
	 * @return `true` if the plugin and the Scene it belongs to is active.
	**/
	public function isActive():Bool
	{
		return enabled && scene.sys.isActive();
	}

	/**
	 * By default when a key is pressed Phaser will not stop the event from propagating up to the browser.
	 * There are some keys this can be annoying for, like the arrow keys or space bar, which make the browser window scroll.
	 *
	 * This `addCapture` method enables consuming keyboard events for specific keys, so they don't bubble up the browser
	 * and cause the default behaviors.
	 *
	 * Please note that keyboard captures are global. This means that if you call this method from within a Scene, to say prevent
	 * the SPACE BAR from triggering a page scroll, then it will prevent it for any Scene in your game, not just the calling one.
	 *
	 * You can pass a single key code value:
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
	 * Or, a comma-delimited string:
	 *
	 * ```javascript
	 * this.input.keyboard.addCapture('W,S,A,D');
	 * ```
	 *
	 * To use non-alpha numeric keys, use a string, such as 'UP', 'SPACE' or 'LEFT'.
	 *
	 * You can also provide an array mixing both strings and key code integers.
	 *
	 * @since 1.0.0
	 *
	 * @param keycode - The Key Codes to enable event capture for.
	 *
	 * @return This KeyboardPlugin object.
	**/
	public function addCapture<T:Union3<String, KeyCodes,
		Array<KeyCodes>>>(keycode:T):KeyboardPlugin
	{
		manager.addCapture(cast keycode);
		return this;
	}

	/**
	 * Removes an existing key capture.
	 *
	 * Please note that keyboard captures are global. This means that if you call this method from within a Scene, to remove
	 * the capture of a key, then it will remove it for any Scene in your game, not just the calling one.
	 *
	 * You can pass a single key code value:
	 *
	 * ```javascript
	 * this.input.keyboard.removeCapture(62);
	 * ```
	 *
	 * An array of key codes:
	 *
	 * ```javascript
	 * this.input.keyboard.removeCapture([ 62, 63, 64 ]);
	 * ```
	 *
	 * Or, a comma-delimited string:
	 *
	 * ```javascript
	 * this.input.keyboard.removeCapture('W,S,A,D');
	 * ```
	 *
	 * To use non-alpha numeric keys, use a string, such as 'UP', 'SPACE' or 'LEFT'.
	 *
	 * You can also provide an array mixing both strings and key code integers.
	 *
	 * @method Phaser.Input.Keyboard.KeyboardPlugin#removeCapture
	 * @since 3.16.0
	 *
	 * @param {(string|integer|integer[]|any[])} keycode - The Key Codes to disable event capture for.
	 *
	 * @return {Phaser.Input.Keyboard.KeyboardPlugin} This KeyboardPlugin object.
	**/
	public function removeCapture<T:Union3<String, Int,
		Array<Int>>>(keycode:T):KeyboardPlugin
	{
		manager.removeCapture(cast keycode);
		return this;
	}

	/**
	 * Returns an array that contains all of the keyboard captures currently enabled.
	 *
	 * @since 1.0.0
	 *
	 * @return An array of all the currently capturing key codes.
	**/
	public function getCaptures():Array<Int>
	{
		return manager.captures;
	}

	/**
	 * Allows Phaser to prevent any key captures you may have defined from bubbling up the browser.
	 * You can use this to re-enable event capturing if you had paused it via `disableGlobalCapture`.
	 *
	 * @since 1.0.0
	 *
	 * @return This KeyboardPlugin object.
	**/
	public function enableGlobalCapture():KeyboardPlugin
	{
		manager.preventDefault = true;
		return this;
	}

	/**
	 * Disables Phaser from preventing any key captures you may have defined, without actually removing them.
	 * You can use this to temporarily disable event capturing if, for example, you swap to a DOM element.
	 *
	 * @since 1.0.0
	 *
	 * @return This KeyboardPlugin object.
	**/
	public function disableGlobalCapture()
	{
		manager.preventDefault = false;
		return this;
	}

	/**
	 * Removes all keyboard captures.
	 *
	 * Note that this is a global change. It will clear all event captures across your game, not just for this specific Scene.
	 *
	 * @since 1.0.0
	 *
	 * @return This KeyboardPlugin object.
	**/
	public function clearCaptures():KeyboardPlugin
	{
		manager.clearCaptures();
		return this;
	}

	/**
	 * Creates and returns an object containing 4 hotkeys for Up, Down, Left and Right, and also Space Bar and shift.
	 *
	 * @since 1.0.0
	 *
	 * @return An object containing the properties: `up`, `down`, `left`, `right`, `space` and `shift`.
	**/
	public function createCursorKeys():CursorKeys
	{
		return {
			up: addKey(KeyCodes.UP),
			down: addKey(KeyCodes.DOWN),
			left: addKey(KeyCodes.LEFT),
			right: addKey(KeyCodes.RIGHT),
			space: addKey(KeyCodes.SPACE),
			shift: addKey(KeyCodes.SHIFT)
		};
	}

	// /**
	//  * A practical way to create an object containing user selected hotkeys.
	//  *
	//  * For example:
	//  *
	//  * ```javascript
	//  * this.input.keyboard.addKeys({ 'up': Phaser.Input.Keyboard.KeyCodes.W, 'down': Phaser.Input.Keyboard.KeyCodes.S });
	//  * ```
	//  *
	//  * would return an object containing the properties (`up` and `down`) mapped to W and S {@link Phaser.Input.Keyboard.Key} objects.
	//  *
	//  * You can also pass in a comma-separated string:
	//  *
	//  * ```javascript
	//  * this.input.keyboard.addKeys('W,S,A,D');
	//  * ```
	//  *
	//  * Which will return an object with the properties W, S, A and D mapped to the relevant Key objects.
	//  *
	//  * To use non-alpha numeric keys, use a string, such as 'UP', 'SPACE' or 'LEFT'.
	//  *
	//  * @method Phaser.Input.Keyboard.KeyboardPlugin#addKeys
	//  * @since 3.10.0
	//  *
	//  * @param {(object|string)} keys - An object containing Key Codes, or a comma-separated string.
	//  * @param {boolean} [enableCapture=true] - Automatically call `preventDefault` on the native DOM browser event for the key codes being added.
	//  * @param {boolean} [emitOnRepeat=false] - Controls if the Key will continuously emit a 'down' event while being held down (true), or emit the event just once (false, the default).
	//  *
	//  * @return {object} An object containing Key objects mapped to the input properties.
	//  */
	// public function addKeys(keys:Map<String, KeyCodes>, enableCapture = true,
	// 		emitOnRepeat = false)
	// {
	// 	// if (enableCapture === undefined) { enableCapture = true; }
	// 	// if (emitOnRepeat === undefined) { emitOnRepeat = false; }
	// 	// var output = {};
	// 	// if (typeof keys === 'string')
	// 	// {
	// 	//     keys = keys.split(',');
	// 	//     for (var i = 0; i < keys.length; i++)
	// 	//     {
	// 	//         var currentKey = keys[i].trim();
	// 	//         if (currentKey)
	// 	//         {
	// 	//             output[currentKey] = this.addKey(currentKey, enableCapture, emitOnRepeat);
	// 	//         }
	// 	//     }
	// 	// }
	// 	// else
	// 	// {
	// 	//     for (var key in keys)
	// 	//     {
	// 	//         output[key] = this.addKey(keys[key], enableCapture, emitOnRepeat);
	// 	//     }
	// 	// }
	// 	// return output;
	// }

	/**
	 * Adds a Key object to this Keyboard Plugin.
	 *
	 * The given argument can be either an existing Key object, a string, such as `A` or `SPACE`, or a key code value.
	 *
	 * If a Key object is given, and one already exists matching the same key code, the existing one is replaced with the new one.
	 *
	 * @since 1.0.0
	 *
	 * @param key - Either a Key object, a string, such as `A` or `SPACE`, or a key code value.
	 * @param enableCapture - Automatically call `preventDefault` on the native DOM browser event for the key codes being added.
	 * @param emitOnRepeat - Controls if the Key will continuously emit a 'down' event while being held down (true), or emit the event just once (false, the default).
	 *
	 * @return The newly created Key object, or a reference to it if it already existed in the keys array.
	**/
	public function addKey(key:Union3<Key, String, KeyCodes>, enableCapture:Bool = true,
			emitOnRepeat:Bool = false):Key
	{
		var keys = this.keys;

		if (Std.is(key, Key))
		{
			var key = (cast key : Key);
			var idx = keys.indexOf(key);

			if (idx > -1)
			{
				keys[idx] = key;
			}
			else
			{
				keys[key.keyCode] = key;
			}

			if (enableCapture)
			{
				this.addCapture(key.keyCode);
			}

			key.setEmitOnRepeat(emitOnRepeat);

			return key;
		}

		var key = if (Std.is(key, String))
		{
			KeyCodes.getByName((cast key : String).toUpperCase()).toInt();
		}
		else
		{
			cast key;
		}

		if (keys[key] == null)
		{
			keys[key] = new Key(this, key);

			if (enableCapture)
			{
				this.addCapture(key);
			}

			keys[key].setEmitOnRepeat(emitOnRepeat);
		}

		return keys[key];
	}

	/**
	 * Removes a Key object from this Keyboard Plugin.
	 *
	 * The given argument can be either a Key object, a string, such as `A` or `SPACE`, or a key code value.
	 *
	 * @since 1.0.0
	 *
	 * @param key - Either a Key object, a string, such as `A` or `SPACE`, or a key code value.
	 * @param destroy - Call `Key.destroy` on the removed Key object?
	 *
	 * @return This KeyboardPlugin object.
	**/
	public function removeKey<T:Union3<Key, String, KeyCodes>>(key:T,
			destroy:Bool = false):KeyboardPlugin
	{
		var key:Any = key;
		var keys = this.keys;
		var ref = null;

		if (Std.is(key, Key))
		{
			var key = (cast key : Key);
			var idx = keys.indexOf(key);

			if (idx > -1)
			{
				ref = this.keys[idx];

				this.keys[idx] = null;
			}
		}
		else if (Std.is(key, String))
		{
			key = KeyCodes.getByName((cast key : String).toUpperCase());
		}

		if (Std.is(key, Int) && keys[(cast key : Int)] != null)
		{
			var key = (cast key : Int);
			ref = keys[key];
			keys[key] = null;
		}

		if (ref != null)
		{
			ref.plugin = null;

			if (destroy)
			{
				ref.destroy();
			}
		}

		return this;
	}

	/**
	 * Creates a new KeyCombo.
	 *
	 * A KeyCombo will listen for a specific string of keys from the Keyboard, and when it receives them
	 * it will emit a `keycombomatch` event from this Keyboard Plugin.
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
	 * ```javascript
	 * this.input.keyboard.createCombo([ 38, 38, 40, 40, 37, 39, 37, 39, 66, 65, 13 ], { resetOnMatch: true });
	 *
	 * this.input.keyboard.on('keycombomatch', function (event) {
	 *     console.log('Konami Code entered!');
	 * });
	 * ```
	 *
	 * Or, to listen for the user entering the word PHASER:
	 *
	 * ```javascript
	 * this.input.keyboard.createCombo('PHASER');
	 * ```
	 *
	 * @method Phaser.Input.Keyboard.KeyboardPlugin#createCombo
	 * @since 3.10.0
	 *
	 * @param {(string|integer[]|object[])} keys - The keys that comprise this combo.
	 * @param {Phaser.Types.Input.Keyboard.KeyComboConfig} [config] - A Key Combo configuration object.
	 *
	 * @return {Phaser.Input.Keyboard.KeyCombo} The new KeyCombo object.
	**/
	public function createCombo(keys, config)
	{
		return new KeyCombo(this, keys, config);
	}

	/**
	 * Checks if the given Key object is currently being held down.
	 *
	 * The difference between this method and checking the `Key.isDown` property directly is that you can provide
	 * a duration to this method. For example, if you wanted a key press to fire a bullet, but you only wanted
	 * it to be able to fire every 100ms, then you can call this method with a `duration` of 100 and it
	 * will only return `true` every 100ms.
	 *
	 * If the Keyboard Plugin has been disabled, this method will always return `false`.
	 *
	 * @method Phaser.Input.Keyboard.KeyboardPlugin#checkDown
	 * @since 3.11.0
	 *
	 * @param {Phaser.Input.Keyboard.Key} key - A Key object.
	 * @param {number} [duration=0] - The duration which must have elapsed before this Key is considered as being down.
	 *
	 * @return {boolean} `true` if the Key is down within the duration specified, otherwise `false`.
	**/
	public function checkDown(key, duration)
	{
		if (this.enabled && key.isDown)
		{
			var t = snapFloor(this.time - key.timeDown, duration);

			if (t > key._tick)
			{
				key._tick = t;

				return true;
			}
		}

		return false;
	}

	/**
	 * Internal update handler called by the Input Plugin, which is in turn invoked by the Game step.
	 *
	 * @since 1.0.0
	**/
	private function update()
	{
		var queue = this.manager.queue;

		var len = queue.length;

		if (!isActive() || len == 0)
		{
			return;
		}

		var keys = this.keys;

		//  Process the event queue, dispatching all of the events that have stored up
		for (i in 0...len)
		{
			var event = queue[i];
			var code = event.keyCode;
			var key = keys[code];
			var repeat = false;

			//  Override the default functions (it's too late for the browser to use them anyway, so we may as well)
			if (event.cancelled != null && event.cancelled != 0)
			{
				//  Event allowed to flow across all handlers in this Scene, and any other Scene in the Scene list
				event.cancelled = 0;

				//  Won't reach any more local (Scene level) handlers
				event.stopImmediatePropagation = function()
				{
					event.cancelled = 1;
				};

				//  Won't reach any more handlers in any Scene further down the Scene list
				event.stopPropagation = function()
				{
					event.cancelled = -1;
				};
			}

			if (event.cancelled == -1)
			{
				//  This event has been stopped from broadcasting to any other Scene, so abort.
				continue;
			}

			if (event.type == "keydown")
			{
				//  Key specific callback first
				if (key != null)
				{
					repeat = key.isDown;

					key.onDown(event);
				}

				if (!(cast event).cancelled && (key == null || !repeat))
				{
					var name = KeyCodes.getNameByValue(code);
					if (name != null)
					{
						this.emit(KeyboardEvents.KEY_DOWN + name, [event]);

						//  Deprecated, kept in for compatibility with 3.15
						//  To be removed by 3.20.
						this.emit('keydown_' + name, [event]);
					}

					if (!(cast event).cancelled)
					{
						this.emit(KeyboardEvents.ANY_KEY_DOWN, [event]);
					}
				}
			}
			else
			{
				//  Key specific callback first
				if (key != null)
				{
					key.onUp(event);
				}

				if (event.cancelled == null || event.cancelled == 0)
				{
					var name = KeyCodes.getNameByValue(code);
					if (name != null)
					{
						this.emit(KeyboardEvents.KEY_UP + name, [event]);

						//  Deprecated, kept in for compatibility with 3.15
						//  To be removed by 3.20.
						this.emit('keyup_' + name, [event]);
					}

					if (event.cancelled == null || event.cancelled == 0)
					{
						this.emit(KeyboardEvents.ANY_KEY_UP, [event]);
					}
				}
			}

			//  Reset the cancel state for other Scenes to use
			if (event.cancelled == 1)
			{
				event.cancelled = 0;
			}
		}
	}

	/**
	 * Resets all Key objects created by _this_ Keyboard Plugin back to their default un-pressed states.
	 * This can only reset keys created via the `addKey`, `addKeys` or `createCursorKeys` methods.
	 * If you have created a Key object directly you'll need to reset it yourself.
	 *
	 * This method is called automatically when the Keyboard Plugin shuts down, but can be
	 * invoked directly at any time you require.
	 *
	 * @since 1.0.0
	 *
	 * @return This KeyboardPlugin object.
	**/
	public function resetKeys():KeyboardPlugin
	{
		for (i in 0...keys.length)
		{
			//  Because it's a sparsely populated array
			if (keys[i] != null)
			{
				keys[i].reset();
			}
		}

		return this;
	}

	/**
	 * Shuts this Keyboard Plugin down. This performs the following tasks:
	 *
	 * 1 - Resets all keys created by this Keyboard plugin.
	 * 2 - Stops and removes the keyboard event listeners.
	 * 3 - Clears out any pending requests in the queue, without processing them.
	 *
	 * @since 1.0.0
	 */
	private function shutdown()
	{
		this.resetKeys();

		if (this.sceneInputPlugin.manager.useQueue)
		{
			this.sceneInputPlugin.pluginEvents.off(InputEvents.UPDATE, this.update, this);
		}
		else
		{
			this.sceneInputPlugin.manager.events.off(InputEvents.MANAGER_PROCESS, this.update, this);
		}

		this.game.events.off(GameEvents.BLUR, this.resetKeys);

		this.removeAllListeners();
	}

	/**
	 * Destroys this Keyboard Plugin instance and all references it holds, plus clears out local arrays.
	 *
	 * @since 1.0.0
	**/
	private function destroy()
	{
		this.shutdown();

		var keys = this.keys;

		for (i in 0...keys.length)
		{
			//  Because it's a sparsely populated array
			if (keys[i] != null)
			{
				keys[i].destroy();
			}
		}

		this.keys = [];
		this.combos = [];

		this.scene = null;
		this.settings = null;
		this.sceneInputPlugin = null;
		this.manager = null;
	}
}
