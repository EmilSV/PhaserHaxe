package phaserHaxe.input.keyboard;

import phaserHaxe.input.InputEvents;
import phaserHaxe.input.keyboard.web.WebKeyboardEvent;

/**
 * A generic Key object which can be passed to the Process functions (and so on)
 * keycode must be an integer
 *
 * @since 1.0.0
**/
class Key extends EventEmitter
{
	/**
	 * The Keyboard Plugin instance that owns this Key object.
	 *
	 * @since 1.0.0
	**/
	public var plugin:KeyboardPlugin;

	/**
	 * The keycode of this key.
	 *
	 * @since 1.0.0
	**/
	public var keyCode:Int;

	/**
	 * The original DOM event.
	 *
	 * @since 1.0.0
	**/
	public var originalEvent:WebKeyboardEvent = null;

	/**
	 * Can this Key be processed?
	 *
	 * @since 1.0.0
	**/
	public var enabled:Bool = true;

	/**
	 * The "down" state of the key. This will remain `true` for as long as the keyboard thinks this key is held down.
	 *
	 * @since 1.0.0
	**/
	public var isDown:Bool = false;

	/**
	 * The "up" state of the key. This will remain `true` for as long as the keyboard thinks this key is up.
	 *
	 * @since 1.0.0
	**/
	public var isUp:Bool = true;

	/**
	 * The down state of the ALT key, if pressed at the same time as this key.
	 *
	 * @since 1.0.0
	**/
	public var altKey:Bool = false;

	/**
	 * The down state of the CTRL key, if pressed at the same time as this key.
	 *
	 * @since 1.0.0
	**/
	public var ctrlKey:Bool = false;

	/**
	 * The down state of the SHIFT key, if pressed at the same time as this key.
	 *
	 * @since 1.0.0
	**/
	public var shiftKey:Bool = false;

	/**
	 * The down state of the Meta key, if pressed at the same time as this key.
	 * On a Mac the Meta Key is the Command key. On Windows keyboards, it's the Windows key.
	 *
	 * @since 1.0.0
	**/
	public var metaKey:Bool = false;

	/**
	 * The location of the modifier key. 0 for standard (or unknown), 1 for left, 2 for right, 3 for numpad.
	 *
	 * @since 1.0.0
	**/
	public var location:Int = 0;

	/**
	 * The timestamp when the key was last pressed down.
	 *
	 * @since 1.0.0
	**/
	public var timeDown:Float = 0;

	/**
	 * The number of milliseconds this key was held down for in the previous down - up sequence.
	 * This value isn't updated every game step, only when the Key changes state.
	 * To get the current duration use the `getDuration` method.
	 *
	 * @since 1.0.0
	**/
	public var duration:Float = 0;

	/**
	 * The timestamp when the key was last released.
	 *
	 * @since 1.0.0
	**/
	public var timeUp:Float = 0;

	/**
	 * When a key is held down should it continuously fire the `down` event each time it repeats?
	 *
	 * By default it will emit the `down` event just once, but if you wish to receive the event
	 * for each repeat as well, enable this property.
	 *
	 * @since 1.0.0
	**/
	public var emitOnRepeat:Bool = false;

	/**
	 * If a key is held down this holds down the number of times the key has 'repeated'.
	 *
	 * @since 1.0.0
	**/
	public var repeats:Int = 0;

	/**
	 * True if the key has just been pressed (NOTE: requires to be reset, see justDown getter)
	 *
	 * @since 1.0.0
	**/
	@:allow(phaserHaxe)
	private var _justDown:Bool = false;

	/**
	 * True if the key has just been pressed (NOTE: requires to be reset, see justDown getter)
	 *
	 * @since 1.0.0
	**/
	@:allow(phaserHaxe)
	public var _justUp:Bool = false;

	/**
	 * Internal tick counter.
	 *
	 * @since 1.0.0
	**/
	public var _tick:Int = -1;

	private var preventDefault:Bool;

	public function new(plugin:KeyboardPlugin, keyCode:Int)
	{
		super();
		this.plugin = plugin;
		this.keyCode = keyCode;
	}

	/**
	 * Controls if this Key will continuously emit a `down` event while being held down (true),
	 * or emit the event just once, on first press, and then skip future events (false).
	 *
	 * @since 1.0.0
	 *
	 * @param value - Emit `down` events on repeated key down actions, or just once?
	 *
	 * @return This Key instance.
	**/
	public function setEmitOnRepeat(value:Bool):Key
	{
		emitOnRepeat = value;
		return this;
	}

	/**
	 * Processes the Key Down action for this Key.
	 * Called automatically by the Keyboard Plugin.
	 *
	 * @fires Phaser.Input.Keyboard.Events#DOWN
	 * @since 1.0.0
	 *
	 * @param event - The native DOM Keyboard event.
	**/
	public function onDown(event:WebKeyboardEvent):Void
	{
		originalEvent = event;

		if (!enabled)
		{
			return;
		}

		altKey = event.altKey;
		ctrlKey = event.ctrlKey;
		shiftKey = event.shiftKey;
		metaKey = event.metaKey;
		location = event.location;

		repeats++;

		if (!isDown)
		{
			isDown = true;
			isUp = false;
			timeDown = event.timeStamp;
			duration = 0;
			_justDown = true;
			_justUp = false;

			emit(KeyboardEvents.DOWN, [this, event]);
		}
		else if (emitOnRepeat)
		{
			emit(KeyboardEvents.DOWN, [this, event]);
		}
	}

	/**
	 * Processes the Key Up action for this Key.
	 * Called automatically by the Keyboard Plugin.
	 *
	 * @since 1.0.0
	 *
	 * @param event - The native DOM Keyboard event.
	**/
	public function onUp(event:WebKeyboardEvent):Void
	{
		originalEvent = event;

		if (!enabled)
		{
			return;
		}

		isDown = false;
		isUp = true;
		timeUp = event.timeStamp;
		duration = timeUp - timeDown;
		repeats = 0;

		_justDown = false;
		_justUp = true;
		_tick = -1;

		emit(KeyboardEvents.UP, [this, event]);
	}

	/**
	 * Resets this Key object back to its default un-pressed state.
	 *
	 * @since 1.0.0
	 *
	 * @return This Key instance.
	**/
	public function reset():Key
	{
		preventDefault = true;
		enabled = true;
		isDown = false;
		isUp = true;
		altKey = false;
		ctrlKey = false;
		shiftKey = false;
		metaKey = false;
		timeDown = 0;
		duration = 0;
		timeUp = 0;
		repeats = 0;
		_justDown = false;
		_justUp = false;
		_tick = -1;

		return this;
	}

	/**
	 * Returns the duration, in ms, that the Key has been held down for.
	 *
	 * If the key is not currently down it will return zero.
	 *
	 * The get the duration the Key was held down for in the previous up-down cycle,
	 * use the `Key.duration` property value instead.
	 *
	 * @since 1.0.0
	 *
	 * @return The duration, in ms, that the Key has been held down for if currently down.
	**/
	public function getDuration():Float
	{
		if (isDown)
		{
			return plugin.game.loop.time - timeDown;
		}
		else
		{
			return 0;
		}
	}

	/**
	 * Removes any bound event handlers and removes local references.
	 *
	 * @since 1.0.0
	**/
	public function destroy():Void
	{
		removeAllListeners();

		originalEvent = null;

		plugin = null;
	}
}
