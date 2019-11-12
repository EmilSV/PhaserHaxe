package phaserHaxe.input.typedefs;

import haxe.Constraints.Function;

/**
 * A Phaser Input Event Data object.
 *
 * This object is passed to the registered event listeners and allows you to stop any further propagation.
 *
 * @since 1.0.0
**/
typedef EventData =
{
	/**
	 * The cancelled state of this Event.
	 *
	 * @since 1.0.0
	**/
	public var ?cancelled:Bool;

	/**
	 * Call this method to stop this event from passing any further down the event chain.
	 *
	 * @since 1.0.0
	**/
	public var stopPropagation:Function;
};
