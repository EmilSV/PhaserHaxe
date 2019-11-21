package phaserHaxe.input;

enum abstract InputConst(Int)
{
	/**
	 * The mouse pointer is being held down.
	 *
	 * @since 1.0.0
	**/
	var MOUSE_DOWN = 0;

	/**
	 * The mouse pointer is being moved.
	 *
	 * @since 1.0.0
	**/
	var MOUSE_MOVE = 1;

	/**
	 * The mouse pointer is released.
	 *
	 * @since 1.0.0
	**/
	var MOUSE_UP = 2;

	/**
	 * A touch pointer has been started.
	 *
	 * @since 1.0.0
	**/
	var TOUCH_START = 3;

	/**
	 * A touch pointer has been started.
	 *
	 * @since 1.0.0
	**/
	var TOUCH_MOVE = 4;

	/**
	 * A touch pointer has been started.
	 *
	 * @since 1.0.0
	**/
	var TOUCH_END = 5;

	/**
	 * The pointer lock has changed.
	 *
	 * @since 1.0.0
	**/
	var POINTER_LOCK_CHANGE = 6;

	/**
	 * A touch pointer has been been cancelled by the browser.
	 *
	 * @since 1.0.0
	**/
	var TOUCH_CANCEL = 7;

	/**
	 * The mouse wheel changes.
	 *
	 * @since 1.0.0
	**/
	var MOUSE_WHEEL = 8;
}
