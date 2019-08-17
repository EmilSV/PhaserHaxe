package phaserHaxe.core;

/**
 * @since 1.0.0
**/
@:structInit
final class InputConfig
{
	/**
	 * Keyboard input configuration. `true` uses the default configuration and `false` disables keyboard input.
	 *
	 * @since 1.0.0
	**/
	public var keyboard:Either<Bool, KeyboardInputConfig> = true;

	/**
	 * Mouse input configuration. `true` uses the default configuration and `false` disables mouse input.
	 *
	 * @since 1.0.0
	**/
	public var mouse:Either<Bool, MouseInputConfig> = true;

	/**
	 * Touch input configuration. `true` uses the default configuration and `false` disables touch input.
	 *
	 * @since 1.0.0
	**/
	public var touch:Either<Bool, TouchInputConfig> = true;

	/**
	 * Gamepad input configuration. `true` enables gamepad input.
	 *
	 * @since 1.0.0
	**/
	public var gamepad:Either<Bool, GamepadInputConfig> = false;

	/**
	 * The maximum number of touch pointers.
	 *
	 * @since 1.0.0
	**/
	public var activePointers:Int = 1;

	/**
	 * The smoothing factor to apply during Pointer movement.
	 *
	 * @since 1.0.0
	**/
	public var smoothFactor:Int = 0;

	/**
	 * Should Phaser listen for input events on the Window? If you disable this, events like 'POINTER_UP_OUTSIDE' will no longer fire.
	 *
	 * @since 1.0.0
	**/
	public var windowEvents:Bool = true;
}
