package phaserHaxe.core;

import phaserHaxe.core.KeyboardInputConfig;
import haxe.ds.Option;

/**
 * @since 1.0.0
**/
typedef InputConfig =
{
	/**
	 * Keyboard input configuration. `true` uses the default configuration and `false` disables keyboard input.
	 *
	 * @since 1.0.0
	**/
	public var ?keyboard:Option<KeyboardInputConfig>;

	/**
	 * Mouse input configuration. `true` uses the default configuration and `false` disables mouse input.
	 *
	 * @since 1.0.0
	**/
	public var ?mouse:Option<MouseInputConfig>;

	/**
	 * Touch input configuration. `true` uses the default configuration and `false` disables touch input.
	 *
	 * @since 1.0.0
	**/
	public var ?touch:Option<TouchInputConfig>;

	/**
	 * Gamepad input configuration. `true` enables gamepad input.
	 *
	 * @since 1.0.0
	**/
	public var ?gamepad:Option<GamepadInputConfig>;

	/**
	 * The maximum number of touch pointers.
	 *
	 * @since 1.0.0
	**/
	public var ?activePointers:Int;

	/**
	 * The smoothing factor to apply during Pointer movement.
	 *
	 * @since 1.0.0
	**/
	public var ?smoothFactor:Int;

	/**
	 * Should Phaser listen for input events on the Window? If you disable this, events like 'POINTER_UP_OUTSIDE' will no longer fire.
	 *
	 * @since 1.0.0
	**/
	public var ?windowEvents:Bool;
}
