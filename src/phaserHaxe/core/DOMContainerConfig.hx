package phaserHaxe.core;

/**
 * @since 1.0.0
**/
@:structInit
final class DOMContainerConfig
{
	/**
	 *  Should the game create a div element to act as a DOM Container? Only enable if you're using DOM Element objects. You must provide a parent object if you use this feature.
	 *
	 * @since 1.0.0
	**/
	public var createContainer:Bool = false;

	/**
	 * Should the DOM Container that is created (if `dom.createContainer` is true) be positioned behind (true) or over the top (false, the default) of the game canvas?
	 *
	 * @since 1.0.0
	**/
	public var behindCanvas:Bool = false;
}
