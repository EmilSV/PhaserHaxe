package phaserHaxe.utils;

final class Utils
{
	/**
	 * A NOOP (No Operation) callback function.
	 *
	 * Used internally by Phaser when it's more expensive to determine if a callback exists
	 * than it is to just invoke an empty function.
	 *
	 * @since 1.0.0
	**/
	public static function NOOP() {};
}
