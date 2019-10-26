package phaserHaxe.utils;

import phaserHaxe.utils.types.MultipleOrOne;
import js.html.svg.Length;
import phaserHaxe.math.MathInt;
import phaserHaxe.math.MathUtility;
import phaserHaxe.Error;
import haxe.ds.ArraySort;
import haxe.Constraints.Function;
import phaserHaxe.utils.types.Pair;
import phaserHaxe.utils.Iterator;
import phaserHaxe.utils.types.Union;

typedef RangeOptions =
{
	var ?max:Int;
	var ?qty:Int;
	var ?random:Bool;
	var ?randomB:Bool;
	var ?repeat:Int;
	var ?yoyo:Bool;
}

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
	public static function add<T1, T2:Union<T1, Array<T1>>>(array:Array<T1>, item:T2,
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
	public static function addAt<T1, T2:MultipleOrOne<T1>>(array:Array<T1>, item:T2,
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
	public static inline function countAllMatching<T1, T2>(array:Array<T1>,
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
	 * Passes each element in the array, between the start and end indexes, to the given callback.
	 *
	 * @since 1.0.0
	 *
	 * @param array - The array to search.
	 * @param callback - A callback to be invoked for each item in the array.
	 * @param context - The context in which the callback is invoked.
	 * @param startIndex - The start index to search from.
	 * @param endIndex - The end index to search to.
	 * @param args - Additional arguments that will be passed to the callback, after the child.
	 *
	 * @return The input array.
	**/
	public static function eachInRange<T>(array:Array<T>, callback:Function,
			context:Dynamic, startIndex:Int = 0, ?endIndex:Int, ?args:Array<Dynamic>)
	{
		final endIndex:Int = endIndex != null ? endIndex : array.length;

		if (safeRange(array, startIndex, endIndex))
		{
			var args = args.copy();
			args.insert(0, null);

			for (i in startIndex...endIndex)
			{
				args[0] = array[i];

				Reflect.callMethod(context, callback, args);
			}
		}

		return array;
	}

	/**
	 * Searches a pre-sorted array for the property with the closet value to the given number.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The value to search for in the array.
	 * @param array - The array to search, which must be sorted.
	 * @param propertyAccessor - The The function to get the property to search by.
	 *
	 * @return the nearest object with the matching property value.
	**/
	public static inline function findClosestInSorted<T>(value:Float, array:Array<T>,
			propertyAccessor:(T) -> Float):T
	{
		return if (array.length == 0)
		{
			return null;
		}
		else if (array.length == 1)
		{
			array[0];
		}
		else
		{
			var i = 1, low, high;

			if (value < propertyAccessor(array[0]))
			{
				array[0];
			}
			else
			{
				while (propertyAccessor(array[i]) < value)
				{
					i++;
				}

				if (i > array.length)
				{
					i = array.length;
				}

				low = propertyAccessor(array[i - 1]);
				high = propertyAccessor(array[i]);

				high - value <= value - low ? array[i] : array[i - 1];
			}
		}
	}

	/**
	 * Returns all elements in the array.
	 *
	 * You can optionally specify a matching criteria using the `propertyAccessor` and `value` arguments.
	 *
	 * For example: `getAll(i -> i.visible , true)` would return only elements that have their visible property set to true.
	 *
	 * Optionally you can specify a start and end index. For example if the array had 100 elements,
	 * and you set `startIndex` to 0 and `endIndex` to 50, it would return matches from only
	 * the first 50 elements.
	 *
	 * @since 1.0.0
	 *
	 * @param array - The array to search.
	 * @param propertyAccessor - The function to get the property to test on each array element.
	 * @param value - The value to test the property against.
	 * @param startIndex - An optional start index to search from.
	 * @param endIndex - An optional end index to search to.
	 *
	 * @return All matching elements from the array.
	**/
	public static inline function getAll<T1, T2>(array:Array<T1>,
			?propertyAccessor:(T1) -> T2, ?value:T2, startIndex:Int = 0,
			?endIndex:Int):Array<T1>
	{
		final endIndex:Int = endIndex != null ? endIndex : array.length;
		var output = [];

		if (safeRange(array, startIndex, endIndex))
		{
			for (i in startIndex...endIndex)
			{
				final child = array[i];
				if (propertyAccessor == null || (value != null && propertyAccessor(child) == value))
				{
					output.push(child);
				}
			}
		}
		return output;
	}

	/**
	 * Returns the first element in the array.
	 *
	 * You can optionally specify a matching criteria using the `propertyAccessor` and `value` arguments.
	 *
	 * For example: `getAll(i -> i.visible , true)` would return the first element that had its `visible` property set to true.
	 *
	 * Optionally you can specify a start and end index. For example if the array had 100 elements,
	 * and you set `startIndex` to 0 and `endIndex` to 50, it would search only the first 50 elements.
	 *
	 * @since 1.0.0
	 *
	 * @param array - The array to search.
	 * @param propertyAccessor -The function to get the property to test on each array element.
	 * @param value - The value to test the property against.
	 * @param startIndex - An optional start index to search from.
	 * @param endIndex - An optional end index to search up to (but not included)
	 *
	 * @return The first matching element from the array, or `null` if no element could be found in the range given.
	**/
	public static inline function getFirst<T1, T2>(array:Array<T1>,
			?propertyAccessor:(T1) -> T2, ?value:T2, startIndex:Int = 0,
			?endIndex:Int):Null<T1>
	{
		final endIndex:Int = endIndex != null ? endIndex : array.length;

		var result = null;

		if (safeRange(array, startIndex, endIndex))
		{
			for (i in startIndex...endIndex)
			{ 
				final child = array[i];
				if (propertyAccessor == null || (value != null && propertyAccessor(child) == value))
				{
					result = child;
					break;
				}
			}
		}

		return result;
	}

	/**
	 * Returns a Random element from the array.
	 *
	 * @since 1.0.0
	 *
	 * @param array - The array to select the random entry from.
	 * @param startIndex - An optional start index.
	 * @param length - An optional length, the total number of elements (from the startIndex) to choose from.
	 *
	 * @return A random element from the array, or `null` if no element could be found in the range given.
	**/
	public static function getRandom<T>(array:Array<T>, startIndex:Int = 0,
			?length:Int):Null<T>
	{
		final length:Int = length != null ? length : array.length;

		var randomIndex = startIndex + Math.floor(Math.random() * length);

		return if (randomIndex >= 0 && randomIndex < array.length)
		{
			array[randomIndex];
		}
		else
		{
			null;
		}
	}

	/**
	 * Moves the given array element down one place in the array.
	 * The array is modified in-place.
	 *
	 * @since 1.0.0
	 *
	 * @param array - The input array.
	 * @param item - The element to move down the array.
	 *
	 * @return The input array.
	**/
	public static function moveDown<T>(array:Array<T>, item:T):Array<T>
	{
		var currentIndex = array.indexOf(item);

		if (currentIndex > 0)
		{
			var index2 = currentIndex - 1;

			var item2 = array[index2];

			array[currentIndex] = item2;
			array[index2] = item;
		}

		return array;
	}

	/**
	 * Moves an element in an array to a new position within the same array.
	 * The array is modified in-place.
	 *
	 * @since 1.0.0
	 *
	 * @param array - The array.
	 * @param item - The element to move.
	 * @param index - The new index that the element will be moved to.
	 *
	 * @return The element that was moved.
	**/
	public static function moveTo<T>(array:Array<T>, item:T, index:Int):T
	{
		var currentIndex = array.indexOf(item);

		if (currentIndex == -1 || index < 0 || index >= array.length)
		{
			throw new Error('Supplied index out of bounds');
		}

		if (currentIndex != index)
		{
			//  Remove
			array.splice(currentIndex, 1);

			//  Add in new location
			array.insert(index, item);
		}
		return item;
	}

	/**
	 * Moves the given array element up one place in the array.
	 * The array is modified in-place.
	 *
	 * @since 1.0.0
	 *
	 * @param array - The input array.
	 * @param item - The element to move up the array.
	 *
	 * @return The input array.
	**/
	public static function moveUp<T>(array:Array<T>, item:T):Array<T>
	{
		var currentIndex = array.indexOf(item);

		if (currentIndex != -1 && currentIndex < array.length - 1)
		{
			//  The element one above `item` in the array
			var item2 = array[currentIndex + 1];
			var index2 = array.indexOf(item2);

			array[currentIndex] = item2;
			array[index2] = item;
		}

		return array;
	}

	/**
	 * Create an array representing the range of integers between, and inclusive of,
	 * the given `start` and `end` arguments. For example:
	 *
	 * `var array = numberArray(2, 4); // array = [2, 3, 4]`
	 * `var array = numberArray(0, 9); // array = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]`
	 *
	 * This is equivalent to `numberArrayStep(start, end, 1)`.
	 *
	 * @since 1.0.0
	 *
	 * @param start - The minimum value the array starts with.
	 * @param end - The maximum value the array contains.
	 *
	 * @return The array of number values.
	**/
	public static function numberArray(start:Int, end:Int):Array<Int>
	{
		var result = [];
		for (i in start...end)
		{
			result.push(i);
		}
		return result;
	}

	/**
	 * Create an array representing the range of numbers (usually integers), between, and inclusive of,
	 * the given `start` and `end` arguments with a prefix and / or suffix string. For example:
	 *
	 * `var array = numberArray(1, 4, 'Level '); // array = ["Level 1", "Level 2", "Level 3", "Level 4"]`
	 * `var array = numberArray(5, 7, 'HD-', '.png'); // array = ["HD-5.png", "HD-6.png", "HD-7.png"]`
	 *
	 * @since 1.0.0
	 *
	 * @param start - The minimum value the array starts with.
	 * @param end - The maximum value the array contains.
	 * @param prefix - Optional prefix to place before the number. If provided the array will contain strings, not integers.
	 * @param suffix - Optional suffix to place after the number. If provided the array will contain strings, not integers.
	 *
	 * @return The array of strings values.
	**/
	public static function numberArrayFixed(start:Int, end:Int, ?prefix:String,
			?suffix:String):Array<String>
	{
		var result = [];
		for (i in start...end)
		{
			var key = (prefix != null) ? prefix + Std.string(i) : Std.string(i);

			if (suffix != null)
			{
				key = key + suffix;
			}

			result.push(key);
		}

		return result;
	}

	/**
	 * Create an array of numbers (positive and/or negative) progressing from `start`
	 * up to but not including `end` by advancing by `step`.
	 *
	 * If `start` is less than `end` a zero-length range is created unless a negative `step` is specified.
	 *
	 * Certain values for `start` and `end` (eg. NaN/undefined/null) are currently coerced to 0;
	 * for forward compatibility make sure to pass in actual numbers.
	 *
	 * @example
	 * NumberArrayStep(4);
	 * // => [0, 1, 2, 3]
	 *
	 * NumberArrayStep(1, 5);
	 * // => [1, 2, 3, 4]
	 *
	 * NumberArrayStep(0, 20, 5);
	 * // => [0, 5, 10, 15]
	 *
	 * NumberArrayStep(0, -4, -1);
	 * // => [0, -1, -2, -3]
	 *
	 * NumberArrayStep(1, 4, 0);
	 * // => [1, 1, 1]
	 *
	 * NumberArrayStep(0);
	 * // => []
	 *
	 * @since 1.0.0
	 *
	 * @param start - The start of the range.
	 * @param end - The end of the range.
	 * @param step - The value to increment or decrement by.
	 *
	 * @return The array of number values.
	**/
	public static function numberArrayStep(start:Int = 0, ?end:Int,
			step:Int = 1):Array<Int>
	{
		final step = step != 0 ? step : 1;

		if (end == null)
		{
			end = start;
			start = 0;
		}

		var result = [];

		var total = Std.int(Math.max(MathUtility.roundAwayFromZero((end - start) / step), 0));

		for (i in 0...total)
		{
			result.push(start);
			start += step;
		}

		return result;
	}

	/**
	 * A [Floyd-Rivest](https://en.wikipedia.org/wiki/Floyd%E2%80%93Rivest_algorithm) quick selection algorithm.
	 *
	 * Rearranges the array items so that all items in the [left, k] range are smaller than all items in [k, right];
	 * The k-th element will have the (k - left + 1)th smallest value in [left, right].
	 *
	 * The array is modified in-place.
	 *
	 * Based on code by [Vladimir Agafonkin](https://www.npmjs.com/~mourner)
	 *
	 * @since 1.0.0
	 *
	 * @param arr - The array to sort.
	 * @param k - The k-th element index.
	 * @param left - The index of the left part of the range.
	 * @param right - The index of the right part of the range.
	 * @param compare - An optional comparison function. Is passed two elements and should return 0, 1 or -1.
	**/
	public static function quickSelect<T>(arr:Array<T>, k:Int, left:Int = 0, ?right:Int,
			?compare:(a:T, b:T) -> Int)
	{
		inline function swap<T>(arr:Array<T>, i:Int, j:Int)
		{
			var tmp = arr[i];
			arr[i] = arr[j];
			arr[j] = tmp;
		}

		var right:Int = right != null ? right : arr.length - 1;
		final compare:(T, T) -> Int = compare != null ? compare : Reflect.compare;

		while (right > left)
		{
			if (right - left > 600)
			{
				var n = right - left + 1;
				var m = k - left + 1;
				var z = Math.log(n);
				var s = 0.5 * Math.exp(2 * z / 3);
				var sd = 0.5 * Math.sqrt(z * s * (n - s) / n) * (m - n / 2 < 0 ? -1 : 1);
				var newLeft = MathInt.max(left, Math.floor(k - m * s / n + sd));
				var newRight = MathInt.min(right, Math.floor(k + (n - m) * s / n + sd));

				quickSelect(arr, k, newLeft, newRight, compare);
			}

			var t = arr[k];
			var i = left;
			var j = right;

			swap(arr, left, k);

			if (compare(arr[right], t) > 0)
			{
				swap(arr, left, right);
			}

			while (i < j)
			{
				swap(arr, i, j);

				i++;
				j--;

				while (compare(arr[i], t) < 0)
				{
					i++;
				}

				while (compare(arr[j], t) > 0)
				{
					j--;
				}
			}

			if (compare(arr[left], t) == 0)
			{
				swap(arr, left, j);
			}
			else
			{
				j++;
				swap(arr, j, right);
			}

			if (j <= k)
			{
				left = j + 1;
			}

			if (k <= j)
			{
				right = j - 1;
			}
		}
	}

	/**
	 * Creates an array populated with a range of values, based on the given arguments and configuration object.
	 *
	 * Range ([a,b,c], [1,2,3]) =
	 * a1, a2, a3, b1, b2, b3, c1, c2, c3
	 *
	 * Range ([a,b], [1,2,3], qty = 3) =
	 * a1, a1, a1, a2, a2, a2, a3, a3, a3, b1, b1, b1, b2, b2, b2, b3, b3, b3
	 *
	 * Range ([a,b,c], [1,2,3], repeat x1) =
	 * a1, a2, a3, b1, b2, b3, c1, c2, c3, a1, a2, a3, b1, b2, b3, c1, c2, c3
	 *
	 * Range ([a,b], [1,2], repeat -1 = endless, max = 14) =
	 * Maybe if max is set then repeat goes to -1 automatically?
	 * a1, a2, b1, b2, a1, a2, b1, b2, a1, a2, b1, b2, a1, a2 (capped at 14 elements)
	 *
	 * Range ([a], [1,2,3,4,5], random = true) =
	 * a4, a1, a5, a2, a3
	 *
	 * Range ([a, b], [1,2,3], random = true) =
	 * b3, a2, a1, b1, a3, b2
	 *
	 * Range ([a, b, c], [1,2,3], randomB = true) =
	 * a3, a1, a2, b2, b3, b1, c1, c3, c2
	 *
	 * Range ([a], [1,2,3,4,5], yoyo = true) =
	 * a1, a2, a3, a4, a5, a5, a4, a3, a2, a1
	 *
	 * Range ([a, b], [1,2,3], yoyo = true) =
	 * a1, a2, a3, b1, b2, b3, b3, b2, b1, a3, a2, a1
	 *
	 * @since 1.0.0
	 *
	 * @param a - The first array of range elements.
	 * @param b - The second array of range elements.
	 * @param options - A range configuration object. Can contain: repeat, random, randomB, yoyo, max, qty.
	 *
	 * @return An array of arranged elements.
	**/
	public static function range<T1, T2>(a:Array<T1>, b:Array<T2>,
			?options:RangeOptions):Array<Pair<T1, T2>>
	{
		inline function buildChunk<T1, T2>(a:Array<T1>, b:Array<T2>, qty:Int)
		{
			var out:Array<Pair<T1, T2>> = [];

			for (aIndex in 0...a.length)
			{
				for (bIndex in 0...b.length)
				{
					for (i in 0...qty)
					{
						out.push(new Pair(a[aIndex], b[bIndex]));
					}
				}
			}

			return out;
		}

		inline function getValue<T>(value:T, defaultValue:T)
		{
			return value != null ? value : defaultValue;
		}

		var max, qty, random;
		var randomB, repeat, yoyo;

		if (options != null)
		{
			max = getValue(options.max, 0);
			qty = getValue(options.qty, 1);
			random = getValue(options.random, false);
			randomB = getValue(options.randomB, false);
			repeat = getValue(options.repeat, 0);
			yoyo = getValue(options.yoyo, false);
		}
		else
		{
			max = 0;
			qty = 1;
			random = false;
			randomB = false;
			repeat = 0;
			yoyo = false;
		}

		var out = [];

		if (randomB)
		{
			shuffle(b);
		}

		//  Endless repeat, so limit by max
		if (repeat == -1)
		{
			if (max == 0)
			{
				repeat = 0;
			}
			else
			{
				//  Work out how many repeats we need
				var total = (a.length * b.length) * qty;

				if (yoyo)
				{
					total *= 2;
				}

				repeat = Math.ceil(max / total);
			}
		}

		for (i in Iterator.inclusive(0, repeat))
		{
			var chunk = buildChunk(a, b, qty);

			if (random)
			{
				shuffle(chunk);
			}

			out = out.concat(chunk);

			if (yoyo)
			{
				chunk.reverse();

				out = out.concat(chunk);
			}
		}

		if (max != 0)
		{
			out.splice(max, out.length - max);
		}

		return out;
	}

	/**
	 * Removes the given item, or array of items, from the array.
	 *
	 * The array is modified in-place.
	 *
	 * You can optionally specify a callback to be invoked for each item successfully removed from the array.
	 *
	 * @since 1.0.0
	 *
	 * @param array - The array to be modified.
	 * @param item - The item, or array of items, to be removed from the array.
	 * @param callback - A callback to be invoked for each item successfully removed from the array.
	 *
	 * @return The item, or array of items, that were successfully removed from the array.
	**/
	public static function remove<T1, T2:Union<T1, Array<T1>>>(array:Array<T1>,
			item:T2, ?callback:(T1) -> Void):Null<T2>
	{
		var index;
		//  Fast path to avoid array mutation and iteration
		if (!Std.is(item, Array))
		{
			final itemSingle = (cast item : T1);
			index = array.indexOf(itemSingle);
			if (index != -1)
			{
				spliceOne(array, index);
				if (callback != null)
				{
					callback(itemSingle);
				}
				return item;
			}
			else
			{
				return null;
			}
		}

		final itemArray = (cast item : Array<T1>);

		//  If we got this far, we have an array of items to remove
		var itemLength = itemArray.length - 1;
		while (itemLength >= 0)
		{
			var entry = itemArray[itemLength];
			index = array.indexOf(entry);
			if (index != -1)
			{
				spliceOne(array, index);
				if (callback != null)
				{
					callback(entry);
				}
			}
			else
			{
				//  Item wasn't found in the array, so remove it from our return results
				itemArray.pop();
			}
			itemLength--;
		}

		return item;
	}

	/**
	 * Removes the item from the given position in the array.
	 *
	 * The array is modified in-place.
	 *
	 * You can optionally specify a callback to be invoked for the item if it is successfully removed from the array.
	 *
	 * @since 1.0.0
	 *
	 * @param array - The array to be modified.
	 * @param index - The array index to remove the item from. The index must be in bounds or it will throw an error.
	 * @param callback - A callback to be invoked for the item removed from the array.
	 *
	 * @return The item that was removed.
	**/
	public static function removeAt<T>(array:Array<T>, index:Int,
			?callback:(T) -> Void):T
	{
		if (index < 0 || index > array.length - 1)
		{
			throw new Error("Index out of bounds");
		}

		var item = spliceOne(array, index);

		if (callback != null)
		{
			callback(item);
		}

		return item;
	}

	/**
	 * Removes the item within the given range in the array.
	 *
	 * The array is modified in-place.
	 *
	 * You can optionally specify a callback to be invoked for the item/s successfully removed from the array.
	 *
	 * @since 1.0.0
	 *
	 * @param array - The array to be modified.
	 * @param startIndex - The start index to remove from.
	 * @param endIndex - The end index to remove to.
	 * @param callback - A callback to be invoked for the item removed from the array.
	 *
	 * @return An array of items that were removed.
	**/
	public static function removeBetween<T>(array:Array<T>, startIndex:Int = 0,
			?endIndex:Int, ?callback:(T) -> Void):Array<T>
	{
		final endIndex:Int = endIndex != null ? endIndex : array.length;

		if (safeRange(array, startIndex, endIndex))
		{
			var size = endIndex - startIndex;

			var removed = array.splice(startIndex, size);

			if (callback != null)
			{
				for (entry in removed)
				{
					callback(entry);
				}
			}

			return removed;
		}
		else
		{
			return [];
		}
	}

	/**
	 * Removes a random object from the given array and returns it.
	 * Will return null if there are no array items that fall within the specified range or if there is no item for the randomly chosen index.
	 *
	 * @since 1.0.0
	 *
	 * @param array - The array to removed a random element from.
	 * @param start - The array index to start the search from.
	 * @param length - Optional restriction on the number of elements to randomly select from.
	 *
	 * @return The random element that was removed, or `null` if there were no array elements that fell within the given range.
	**/
	public static function removeRandomElement<T>(array:Array<T>, start:Int = 0,
			?length:Int)
	{
		final length:Int = length != null ? length : array.length;

		var randomIndex = start + Math.floor(Math.random() * length);

		return spliceOne(array, randomIndex);
	}

	/**
	 * Replaces an element of the array with the new element.
	 * The new element cannot already be a member of the array.
	 * The array is modified in-place.
	 *
	 * @since 1.0.0
	 *
	 * @param oldChild - The element in the array that will be replaced.
	 * @param newChild - The element to be inserted into the array at the position of `oldChild`.
	 *
	 * @return Returns true if the oldChild was successfully replaced, otherwise returns false.
	**/
	public static function replace<T>(array:Array<T>, oldChild:T, newChild:T):Bool
	{
		var index1 = array.indexOf(oldChild);
		var index2 = array.indexOf(newChild);

		if (index1 != -1 && index2 == -1)
		{
			array[index1] = newChild;
			return true;
		}
		else
		{
			return false;
		}
	}

	/**
	 * Moves the element at the start of the array to the end, shifting all items in the process.
	 * The "rotation" happens to the left.
	 *
	 * @since 1.0.0
	 *
	 * @param array - The array to shift to the left. This array is modified in place.
	 * @param total - The number of times to shift the array.
	 *
	 * @return The most recently shifted element.
	**/
	public static function rotateLeft<T>(array:Array<T>, total:Int = 1):Null<T>
	{
		var element = null;

		for (i in 0...total)
		{
			element = array.shift();
			array.push(element);
		}

		return element;
	}

	/**
	 * Moves the element at the end of the array to the start, shifting all items in the process.
	 * The "rotation" happens to the right.
	 *
	 * @since 1.0.0
	 *
	 * @param array - The array to shift to the right. This array is modified in place.
	 * @param total - The number of times to shift the array.
	 *
	 * @return The most recently shifted element.
	**/
	public static function rotateRight<T>(array:Array<T>, total:Int = 1):Null<T>
	{
		var element = null;

		for (i in 0...total)
		{
			element = array.pop();
			array.unshift(element);
		}

		return element;
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

	/**
	 * Moves the given element to the bottom of the array.
	 * The array is modified in-place.
	 *
	 * @since 1.0.0
	 *
	 * @param array - The array.
	 * @param item - The element to move.
	 *
	 * @return The element that was moved.
	**/
	public static function sendToBack<T>(array:Array<T>, item:T):T
	{
		var currentIndex = array.indexOf(item);

		if (currentIndex != -1 && currentIndex > 0)
		{
			array.splice(currentIndex, 1);
			array.unshift(item);
		}

		return item;
	}

	/**
	 * TODO: fix description of function
	 *
	 * Scans the array for elements with the given property. If found, the property is set to the `value`.
	 *
	 * For example: `SetAll('visible', true)` would set all elements that have a `visible` property to `false`.
	 *
	 * Optionally you can specify a start and end index. For example if the array had 100 elements,
	 * and you set `startIndex` to 0 and `endIndex` to 50, it would update only the first 50 elements.
	 *
	 * @since 1.0.0
	 *
	 * @param array - The array to search.
	 * @param propertySetter - The property to test for on each array element.
	 * @param value - The value to set the property to.
	 * @param startIndex - An optional start index to search from.
	 * @param endIndex - An optional end index to search to.
	 *
	 * @return The input array.
	**/
	public static inline function setAll<T1, T2>(array:Array<T1>,
			propertySetter:(T1, T2) -> Void, value:T2, startIndex:Int = 0,
			?endIndex:Int):Array<T1>
	{
		final endIndex:Int = endIndex != null ? endIndex : array.length;

		if (safeRange(array, startIndex, endIndex))
		{
			for (i in startIndex...endIndex)
			{
				var entry = array[i];

				propertySetter(entry, value);
			}
		}

		return array;
	}

	/**
	 * Removes a single item from an array and returns it without creating gc, like the native splice does.
	 * Based on code by Mike Reinstein.
	 *
	 * @since 1.0.0
	 *
	 * @param array - The array to splice from.
	 * @param index - The index of the item which should be spliced.
	 *
	 * @return The item which was spliced (removed).
	**/
	public static function spliceOne<T>(array:Array<T>, index:Int):Null<T>
	{
		if (index >= array.length)
		{
			return null;
		}

		var len = array.length - 1;

		var item = array[index];

		for (i in index...len)
		{
			array[i] = array[i + 1];
		}

		array.resize(len);

		return item;
	}

	/**
	 * Shuffles the contents of the given array using the Fisher-Yates implementation.
	 *
	 * The original array is modified directly and returned.
	 *
	 * @since 1.0.0
	 *
	 * @param array - The array to shuffle. This array is modified in place.
	 *
	 * @return The shuffled array.
	**/
	public static function shuffle<T>(array:Array<T>):Array<T>
	{
		for (i in Iterator.reverse((array.length - 1), 0))
		{
			var j = Math.floor(Math.random() * (i + 1));
			var temp = array[i];
			array[i] = array[j];
			array[j] = temp;
		}

		return array;
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
			?comp:(a:T, b:T) -> Int):Array<T>
	{
		ArraySort.sort(arr, comp != null ? comp : Reflect.compare);
		return arr;
	}

	/**
	 * Swaps the position of two elements in the given array.
	 * The elements must exist in the same array.
	 * The array is modified in-place.
	 *
	 * @since 1.0.0
	 *
	 * @param array - The input array.
	 * @param item1 - The first element to swap.
	 * @param item2 - The second element to swap.
	 *
	 * @return The input array.
	**/
	public static function swap<T>(array:Array<T>, item1:T, item2:T):Array<T>
	{
		if (item1 == item2)
		{
			return null;
		}

		var index1 = array.indexOf(item1);
		var index2 = array.indexOf(item2);

		if (index1 < 0 || index2 < 0)
		{
			throw new Error("Supplied items must be elements of the same array");
		}

		array[index1] = item2;
		array[index2] = item1;

		return array;
	}
}
