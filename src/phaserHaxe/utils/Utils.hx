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

	/**
	 * Converts a charter code of a hex into its int value.
	 *
	 * @since 1.0.0
	 *
	 * @param code - charter code of a hex.
	 *
	 * @return the numeric value.
	**/
	public static function charterCodeHexToInt(code:Int):Int
	{
		return switch (code)
		{
			case "0".code: 0;
			case "1".code: 1;
			case "2".code: 2;
			case "3".code: 3;
			case "4".code: 4;
			case "5".code: 5;
			case "6".code: 6;
			case "7".code: 7;
			case "8".code: 8;
			case "9".code: 9;
			case "A".code | "a".code: 10;
			case "B".code | "b".code: 11;
			case "C".code | "c".code: 12;
			case "D".code | "d".code: 13;
			case "E".code | "e".code: 14;
			case "F".code | "f".code: 15;
			default:
				0;
		}
	}
}
