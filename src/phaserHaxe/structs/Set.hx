package phaserHaxe.structs;

/**
 * @param entry - The Set entry.
 * @param index - The index of the entry within the Set.
 *
 * @return The callback result.
**/
typedef EachSetCallback<E> = (entry:E, index:Int) -> Null<Bool>;

/**
 * A Set is a collection of unique elements.
 *
 * @since 1.0.0
**/
class Set<T>
{
	/**
	 * The entries of this Set. Stored internally as an array.
	 *
	 * @since 1.0.0
	**/
	private var entries:Array<T> = [];

	/**
	 * The size of this Set. This is the number of entries within it.
	 * Changing the size will truncate the Set if the given value is smaller than the current size.
	 * Increasing the size larger than the current size has no effect.
	 *
	 * @since 1.0.0
	**/
	public var size(get, set):Int;

	/**
	 * @param elements - An optional array of elements to insert into this Set.
	**/
	public function new(?elements:Array<T>)
	{
		if (Std.is(elements, Array))
		{
			for (i in 0...elements.length)
			{
				set(elements[i]);
			}
		}
	}

	private inline function get_size():Int
	{
		return entries.length;
	}

	private inline function set_size(value:Int):Int
	{
		if (value < entries.length)
		{
			entries.resize(value);
		}
		return entries.length;
	}

	inline function iterator():Iterator<T>
	{
		return entries.iterator();
	}

	/**
	 * Inserts the provided value into this Set. If the value is already contained in this Set this method will have no effect.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The value to insert into this Set.
	 *
	 * @return This Set object.
	**/
	public function set(value:T):Set<T>
	{
		if (entries.indexOf(value) == -1)
		{
			entries.push(value);
		}

		return this;
	}

	/**
	 * Get an element of this Set which has a property of the specified name, if that property is equal to the specified value.
	 * If no elements of this Set satisfy the condition then this method will return `null`.
	 *
	 * @since 1.0.0
	 *
	 * @param propertyHandler - The property handler function that gets the property to check on the elements of this Set.
	 * @param value - The value to check for.
	 *
	 * @return The first element of this Set that meets the required condition, or `null` if this Set contains no elements that meet the condition.
	**/
	public inline function get<P>(propertyHandler:(entry:T) -> P, value:P):Null<T>
	{
		for (entry in entries)
		{
			if (propertyHandler(entry) == value)
			{
				return entry;
			}
		}
		return null;
	}

	/**
	 * Returns an array containing all the values in this Set.
	 *
	 * @since 1.0.0
	 *
	 * @return An array containing all the values in this Set.
	**/
	public function getArray():Array<T>
	{
		return entries.slice(0);
	}

	/**
	 * Removes the given value from this Set if this Set contains that value.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The value to remove from the Set.
	 *
	 * @return This Set object.
	**/
	public function delete(value:T):Set<T>
	{
		var index = entries.indexOf(value);

		if (index > -1)
		{
			entries.splice(index, 1);
		}

		return this;
	}

	/**
	 * Dumps the contents of this Set to the console via `console.group`.
	 *
	 * @since 1.0.0
	**/
	public function dump():Void
	{
		Console.group('Set');

		for (entry in entries)
		{
			Console.log(entry);
		}

		Console.groupEnd();
	}

	/**
	 * Clears this Set so that it no longer contains any values.
	 *
	 * @since 1.0.0
	 *
	 * @return This Set object.
	**/
	public function clear():Set<T>
	{
		entries.resize(0);

		return this;
	}

	/**
	 * Returns `true` if this Set contains the given value, otherwise returns `false`.
	 *
	 * @since 1.0.0
	 *
	 * @param {*} value - The value to check for in this Set.
	 *
	 * @return `true` if the given value was found in this Set, otherwise `false`.
	**/
	public function contains(value:T):Bool
	{
		return entries.indexOf(value) > -1;
	}

	/**
	 * Returns a new Set containing all values that are either in this Set or in the Set provided as an argument.
	 *
	 * @since 1.0.0
	 *
	 * @param set - The Set to perform the union with.
	 *
	 * @return A new Set containing all the values in this Set and the Set provided as an argument.
	**/
	public function union(set:Set<T>):Set<T>
	{
		var newSet = new Set();

		for (value in set)
		{
			newSet.set(value);
		}

		for (value in this)
		{
			newSet.set(value);
		}

		return newSet;
	}

	/**
	 * Returns a new Set that contains only the values which are in this Set and that are also in the given Set.
	 *
	 * @since 1.0.0
	 *
	 * @param set - The Set to intersect this set with.
	 *
	 * @return The result of the intersection, as a new Set.
	**/
	public function intersect(set:Set<T>):Set<T>
	{
		var newSet = new Set();

		for (value in this)
		{
			if (set.contains(value))
			{
				newSet.set(value);
			}
		}

		return newSet;
	}

	/**
	 * Returns a new Set containing all the values in this Set which are *not* also in the given Set.
	 *
	 * @since 1.0.0
	 *
	 * @param set - The Set to perform the difference with.
	 *
	 * @return A new Set containing all the values in this Set that are not also in the Set provided as an argument to this method.
	**/
	public function difference(set:Set<T>):Set<T>
	{
		var newSet = new Set();

		for (value in this)
		{
			if (!set.contains(value))
			{
				newSet.set(value);
			}
		}

		return newSet;
	}
}
