package phaserHaxe.core;

import haxe.Constraints.Function;
import phaserHaxe.utils.Utils;

/**
 * @since 1.0.0
**/
typedef CallbacksConfig =
{
	/**
	 * function to run at the start of the boot sequence.
	 *
	 * @since 1.0.0
	**/
	public var ?preBoot:BootCallback;

	/**
	 * A function to run at the end of the boot sequence. At this point,
	 * all the game systems have started and plugins have been loaded.
	 *
	 * @since 1.0.0
	**/
	public var ?postBoot:BootCallback;
}
