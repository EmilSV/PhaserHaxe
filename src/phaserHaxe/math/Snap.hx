package phaserHaxe.math;

import haxe.Int64;
final class Snap
{
	/**
	 * Snap a value to nearest grid slice, using ceil.
	 *
	 * Example: if you have an interval gap of `5` and a position of `12`... you will snap to `15`.
	 * As will `14` snap to `15`... but `16` will snap to `20`.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The value to snap.
	 * @param gap - The interval gap of the grid.
	 * @param start - Optional starting offset for gap.
	 * @param divide - If `true` it will divide the snapped value by the gap before returning.
	 *
	 * @return The snapped value.
	**/
	public static function SnapCeil(value:Float, gap:Float, start:Float = 0, divide:Bool = false):Float
	{
		if (gap == 0)
		{
			return value;
		}
		value -= start;
		value = gap * Math.ceil(value / gap);
		return (divide) ? (start + value) / gap : start + value;
	}

	/**
	 * Snap a value to nearest grid slice, using floor.
	 *
	 * Example: if you have an interval gap of `5` and a position of `12`... you will snap to `10`.
	 * As will `14` snap to `10`... but `16` will snap to `15`.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The value to snap.
	 * @param gap - The interval gap of the grid.
	 * @param start - Optional starting offset for gap.
	 * @param divide - If `true` it will divide the snapped value by the gap before returning.
	 *
	 * @return The snapped value.
	**/
	public static function SnapFloor(value:Float, gap:Float, start:Float = 0, divide:Bool = false):Float
	{
		if (gap == 0)
		{
			return value;
		}
		value -= start;
		value = gap * Math.floor(value / gap);
		return (divide) ? (start + value) / gap : start + value;
	}

	/**
	 * Snap a value to nearest grid slice, using rounding.
	 *
	 * Example: if you have an interval gap of `5` and a position of `12`... you will snap to `10` whereas `14` will snap to `15`.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The value to snap.
	 * @param gap - The interval gap of the grid.
	 * @param start - Optional starting offset for gap.
	 * @param divide - If `true` it will divide the snapped value by the gap before returning.
	 *
	 * @return The snapped value.
	**/
	public static function SnapTo(value:Float, gap:Float, start:Float = 0, divide:Bool = false):Float
	{
		if (gap == 0)
		{
			return value;
		}
		value -= start;
		value = gap * Math.round(value / gap);
		return (divide) ? (start + value) / gap : start + value;
	}
}
