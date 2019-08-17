package phaserHaxe.core;

/**
 * @since 1.0.0
**/
@:structInit
final class MouseInputConfig
{
	/**
	 * Where the Mouse Manager listens for mouse input events. The default is the game canvas.
	 *
	 * @since 1.0.0
	**/
	public var target:Any = null;

	/**
	 * Whether mouse input events have `preventDefault` called on them.
	 *
	 * @since 1.0.0
	**/
	public var capture:Bool = true;
}
