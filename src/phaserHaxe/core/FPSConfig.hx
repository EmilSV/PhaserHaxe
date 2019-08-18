package phaserHaxe.core;

/**
 *
 * @since 1.0.0
**/
@:structInit
final class FPSConfig
{
	/**
	 * The minimum acceptable rendering rate, in frames per second.
	 *
	 * @since 1.0.0
	**/
	public var min:Int;

	/**
	 * The optimum rendering rate, in frames per second.
	 *
	 * @since 1.0.0
	**/
	public var target:Int;

	/**
	 *  Use setTimeout instead of requestAnimationFrame to run the game loop.
	 *
	 * @since 1.0.0
	**/
	public var forceSetTimeOut:Bool;

	/**
	 *  Use setTimeout instead of requestAnimationFrame to run the game loop.
	 *
	 * @since 1.0.0
	**/
	public var deltaHistory:Int = 10;

	/**
	 * The amount of frames the time step counts before we trust the delta values again.
	 *
	 * @since 1.0.0
	**/
	public var panicMax:Int = 120;
}
