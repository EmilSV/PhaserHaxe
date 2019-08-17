package phaserHaxe.core;

/**
 * @since 1.0.0
**/
@:structInit
final class TouchInputConfig
{
	/**
	 * Where the Touch Manager listens for touch input events. The default is the game canvas.
	 *
	 * @since 1.0.0
	**/
	public var target:Any;

	/**
	 * Whether touch input events have preventDefault() called on them.
	 *
	 * @since 1.0.0
	**/
	public var capture:Bool = true;
}
