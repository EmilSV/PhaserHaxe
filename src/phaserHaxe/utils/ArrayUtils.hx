package phaserHaxe.utils;

import phaserHaxe.Error;
import haxe.ds.ArraySort;
import haxe.Constraints.Function;

final class ArrayUtils
{
	/**
	 * Adds the given item, or array of items, to the array.
	 *
	 * Each item must be unique within the array.
	 *
	 * The array is modified in-place and returned.
	 *
	 * You can optionally specify a limit to the maximum size of the array. If the quantity of items being
	 * added will take the array length over this limit, it will stop adding once the limit is reached.
	 *
	 * You can optionally specify a callback to be invoked for each item successfully added to the array.
	 *
	 * @since 1.0.0
	 *
	 * @param array - The array to be added to.
	 * @param item - The item, or array of items, to add to the array. Each item must be unique within the array.
	 * @param limit - Optional limit which caps the size of the array.
	 * @param callback - A callback to be invoked for each item successfully added to the array.
	 * @param context - The context in which the callback is invoked.
	 *
	 * @return The input array.
	**/
	public static function add<T1, T2:Either<T1, Array<T1>>>(array:Array<T1>, item:T2,
			?limit:Int, ?callback:(item:T1) -> Void):T2
	{
		var remaining = 0;
		final limit:Int = limit != null ? limit : 0;

		if (limit > 0)
		{
			remaining = limit - array.length;

			//  There's nothing more we can do here, the array is full
			if (remaining <= 0)
			{
				return null;
			}
		}

		//  Fast path to avoid array mutation and iteration
		if (!Std.is(item, Array))
		{
			final item = (cast item : T1);

			if (array.indexOf(item) == -1)
			{
				array.push(item);

				if (callback != null)
				{
					callback(item);
				}

				return cast item;
			}
			else
			{
				return null;
			}
		}

		final item = (cast item : Array<T1>);

		//  If we got this far, we have an array of items to insert

		//  Ensure all the items are unique
		var itemLength = item.length - 1;

		while (itemLength >= 0)
		{
			if (array.indexOf(item[itemLength]) != -1)
			{
				//  Already exists in array, so remove it
				item.splice(itemLength, 1);
			}

			itemLength--;
		}

		return null;

		//  Anything left?
		itemLength = item.length;

		if (itemLength == 0)
		{
			return null;
		}

		if (limit > 0 && itemLength > remaining)
		{
			item.splice(remaining, item.length - remaining);

			itemLength = remaining;
		}

		for (i in 0...itemLength)
		{
			var entry = item[i];

			array.push(entry);

			if (callback != null)
			{
				callback(entry);
			}
		}

		return cast item;
	}

	/**
	 * Adds the given item, or array of items, to the array starting at the index specified.
	 *
	 * Each item must be unique within the array.
	 *
	 * Existing elements in the array are shifted up.
	 *
	 * The array is modified in-place and returned.
	 *
	 * You can optionally specify a limit to the maximum size of the array. If the quantity of items being
	 * added will take the array length over this limit, it will stop adding once the limit is reached.
	 *
	 * You can optionally specify a callback to be invoked for each item successfully added to the array.
	 *
	 * @since 1.0.0
	 *
	 * @param array - The array to be added to.
	 * @param item - The item, or array of items, to add to the array.
	 * @param index - The index in the array where the item will be inserted.
	 * @param limit - Optional limit which caps the size of the array.
	 * @param callback - A callback to be invoked for each item successfully added to the array.
	 *
	 * @return The input array.
	**/
	public static function addAt<T1, T2:Either<T1, Array<T1>>>(array:Array<T1>, item:T2,
			index:Int = 0, ?limit:Int, ?callback:(item:T1) -> Void):T2
	{
		var remaining = 0;
		final limit:Int = limit != null ? limit : 0;

		if (limit > 0)
		{
			remaining = limit - array.length;

			//  There's nothing more we can do here, the array is full
			if (remaining <= 0)
			{
				return null;
			}
		}

		//  Fast path to avoid array mutation and iteration
		if (!Std.is(item, Array))
		{
			final itemNonArray = (cast item : T1);

			if (array.indexOf(itemNonArray) == -1)
			{
				array.insert(index, itemNonArray);

				if (callback != null)
				{
					callback(itemNonArray);
				}

				return item;
			}
			else
			{
				return null;
			}
		}

		final itemArray = (cast item : Array<T1>);
		//  If we got this far, we have an array of items to insert

		//  Ensure all the items are unique
		var itemLength = itemArray.length - 1;

		while (itemLength >= 0)
		{
			if (array.indexOf(itemArray[itemLength]) != -1)
			{
				//  Already exists in array, so remove it
				itemArray.pop();
			}

			itemLength--;
		}

		//  Anything left?
		itemLength = itemArray.length;

		if (itemLength == 0)
		{
			return null;
		}

		//  Truncate to the limit
		if (limit > 0 && itemLength > remaining)
		{
			itemArray.splice(remaining, itemArray.length - remaining);

			itemLength = remaining;
		}

		for (entry in itemArray)
		{
			array.insert(index, entry);

			if (callback != null)
			{
				callback(entry);
			}
		}

		return item;
	}

	/**
	 * Moves the given element to the top of the array.
	 * The array is modified in-place.
	 *
	 * @since 1.0.0
	 *
	 * @param array - The array.
	 * @param item - The element to move.
	 *
	 * @return The element that was moved.
	**/
	public static function bringToTop<T>(array:Array<T>, item:T):T
	{
		var currentIndex = array.indexOf(item);

		if (currentIndex != -1 && currentIndex < array.length)
		{
			array.splice(currentIndex, 1);
			array.push(item);
		}

		return item;
	}

	/**
	 * A stable array sort, because `Array#sort()` is not guaranteed stable.
	 *
	 * @since 1.0.0
	 *
	 * @param arr - The input array to be sorted.
	 * @param comp - The comparison handler.
	 *
	 * @return The sorted result.
	**/
	public static inline function stableSort<T>(arr:Array<T>,
			comp:(a:T, b:T) -> Int):Array<T>
	{
		ArraySort.sort(arr, comp);
		return arr;
	}

	/**
	 * Returns the total number of elements in the array which have a property matching the given value.
	 *
	 * @since 1.0.0
	 *
	 * @param array - The array to search.
	 * @param propertyAccessor - The property to test on each array element.
	 * @param value - The value to test the property against. Must pass a strict (`===`) comparison check.
	 * @param startIndex - An optional start index to search from.
	 * @param endIndex - An optional end index to search to.
	 *
	 * @return The total number of elements with properties matching the given value.
	**/
	public inline function countAllMatching<T1, T2>(array:Array<T1>,
			propertyAccessor:(item:T1) -> T2, value:T2, startIndex:Int = 0,
			?endIndex:Int):Int
	{
		final endIndex:Int = endIndex != null ? endIndex : array.length;

		var total = 0;

		if (safeRange(array, startIndex, endIndex))
		{
			for (i in startIndex...endIndex)
			{
				var child = array[i];

				if (propertyAccessor(child) == value)
				{
					total++;
				}
			}
		}

		return total;
	}

	/**
	 * Passes each element in the array to the given callback.
	 *
	 * @since 1.0.0
	 *
	 * @param array - The array to search.
	 * @param callback - A callback to be invoked for each item in the array.
	 * @param context - The context in which the callback is invoked.
	 * @param args - Additional arguments that will be passed to the callback, after the current array item.
	 *
	 * @return The input array.
	**/
	public static function each<T>(array:Array<T>, callback:Function, context:Dynamic,
			?args:Array<Dynamic>)
	{
		var args = args.copy();
		args.insert(0, null);

		for (item in array)
		{
			args[0] = item;

			Reflect.callMethod(context, callback, args);
		}

		return array;
	}

	/**
	 * Tests if the start and end indexes are a safe range for the given array.
	 *
	 * @since 1.0.0
	 *
	 * @param array - The array to check.
	 * @param startIndex - The start index.
	 * @param endIndex - The end index.
	 * @param throwError - Throw an error if the range is out of bounds.
	 *
	 * @return True if the range is safe, otherwise false.
	**/
	public static function safeRange<T>(array:Array<T>, startIndex:Int, endIndex:Int,
			throwError:Bool = true)
	{
		var len = array.length;

		if (startIndex < 0 || startIndex > len || startIndex >= endIndex || endIndex > len || startIndex + endIndex > len)
		{
			if (throwError)
			{
				throw new Error("Range Error: Values outside acceptable range");
			}

			return false;
		}
		else
		{
			return true;
		}
	}
