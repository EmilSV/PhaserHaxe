package phaserHaxe.core;

/**
 * @since 1.0.0
**/
@:structInit
final class KeyboardInputConfig
{
	/**
	 * Where the Keyboard Manager listens for keyboard input events.
	 *
	 * @since 1.0.0
	**/
	public var target:Any = null;

	/**
	 * `preventDefault` will be called on every non-modified key which has a key code in this array. By default it is empty.
	 *
	 * @since 1.0.0
	**/
	public var capture:Null<Array<Int>> = null;
}
