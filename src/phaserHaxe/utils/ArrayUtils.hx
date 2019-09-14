package phaserHaxe.utils;

import phaserHaxe.math.MathInt;
import phaserHaxe.math.MathUtility;
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
	 * @return The nearest value found in the array, or if a `key` was given, the nearest object with the matching property value.
	**/
	public static inline function findClosestInSorted<T>(value:Float, array:Array<T>,
			propertyAccessor:(T) -> Float):Float
	{
		if (array.length == 0)
		{
			return Math.NaN;
		}
		else if (array.length == 1)
		{
			return propertyAccessor(array[0]);
		}
		var i = 1, low:Float, high:Float;

		if (value < propertyAccessor(array[0]))
		{
			return propertyAccessor(array[0]);
		}
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
		return
			((high - value) <= (value - low)) ? propertyAccessor(array[i]) : propertyAccessor(array[i - 1]);
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

		if (safeRange(array, startIndex, endIndex))
		{
			for (i in startIndex...endIndex)
			{
				final child = array[i];
				if (propertyAccessor == null || (value != null && propertyAccessor(child) == value))
				{
					return child;
				}
			}
		}
		return null;
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

		if (randomIndex >= 0 && randomIndex < array.length)
		{
			return array[randomIndex];
		}
		else
		{
			return null;
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
	 * @function Phaser.Utils.Array.QuickSelect
	 * @since 3.0.0
	 *
	 * @param {array} arr - The array to sort.
	 * @param {integer} k - The k-th element index.
	 * @param {integer} [left=0] - The index of the left part of the range.
	 * @param {integer} [right] - The index of the right part of the range.
	 * @param {function} [compare] - An optional comparison function. Is passed two elements and should return 0, 1 or -1.
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
}
