package phaserHaxe.structs;

import haxe.Constraints.Function;
import phaserHaxe.utils.ArrayUtils;
import phaserHaxe.utils.types.Union;

/**
 * @param item - The item which is currently being processed.
 * @param args - Additional arguments that will be passed to the callback, after the child.
**/
typedef EachListCallback<I> = (item:I, ?args:Array<Dynamic>) -> Void;

class List<T>
{
	/**
	 * The parent of this list.
	 *
	 * @since 1.0.0
	**/
	public var parent:Any;

	/**
	 * The objects that belong to this collection.
	 *
	 * @since 1.0.0
	**/
	public var list:Array<T> = [];

	/**
	 * The index of the current element.
	 *
	 * This is used internally when iterating through the list with the {@link #first}, {@link #last}, {@link #get}, and {@link #previous} properties.
	 *
	 * @since 1.0.0
	**/
	public var position:Int = 0;

	/**
	 * A callback that is invoked every time a child is added to this list.
	 *
	 * @since 1.0.0
	**/
	public var addCallback:(T) -> Void = (item) -> {};

	/**
	 * A callback that is invoked every time a child is removed from this list.
	 *
	 * @since 1.0.0
	**/
	public var removeCallback:(T) -> Void = (item) -> {};

	/**
	 * The number of items inside the List.
	 *
	 * @since 1.0.0
	**/
	public var length(get, never):Int;

	/**
	 * The first item in the List or `null` for an empty List.
	 *
	 * @since 1.0.0
	**/
	public var first(get, never):T;

	/**
	 * The last item in the List, or `null` for an empty List.
	 *
	 * @since 1.0.0
	**/
	public var last(get, never):T;

	/**
	 * The next item in the List, or `null` if the entire List has been traversed.
	 *
	 * This property can be read successively after reading {@link #first} or manually setting the {@link #position} to iterate the List.
	 *
	 * @since 1.0.0
	**/
	public var next(get, never):T;

	/**
	 * The previous item in the List, or `null` if the entire List has been traversed.
	 *
	 * This property can be read successively after reading {@link #last} or manually setting the {@link #position} to iterate the List backwards.
	 *
	 * @since 1.0.0
	**/
	public var previous(get, never):T;

	public function new(?parent:Any)
	{
		this.parent = parent;
	}

	private inline function get_length():Int
	{
		return list.length;
	}

	private inline function get_first():Null<T>
	{
		position = 0;

		return if (list.length > 0)
		{
			list[0];
		}
		else
		{
			null;
		}
	}

	private inline function get_last():Null<T>
	{
		if (list.length > 0)
		{
			position = list.length - 1;

			return list[position];
		}
		else
		{
			return null;
		}
	}

	private inline function get_next():Null<T>
	{
		if (position < list.length)
		{
			position++;

			return list[position];
		}
		else
		{
			return null;
		}
	}

	private inline function get_previous():Null<T>
	{
		if (position > 0)
		{
			position--;

			return list[position];
		}
		else
		{
			return null;
		}
	}

	/**
	 * Adds the given item to the end of the list. Each item must be unique.
	 *
	 * @since 1.0.0
	 *
	 * @param child - The item, or array of items, to add to the list.
	 * @param skipCallback - Skip calling the List.addCallback if this child is added successfully.
	 *
	 * @return The list's underlying array.
	**/
	public inline function add<TChild:Union<T, Array<T>>>(child:TChild,
			skipCallback:Bool):TChild
	{
		return if (skipCallback)
		{
			ArrayUtils.add(list, child);
		}
		else
		{
			ArrayUtils.add(list, child, 0, addCallback);
		}
	}

	/**
	 * Adds an item to list, starting at a specified index. Each item must be unique within the list.
	 *
	 * @since 1.0.0
	 *
	 * @param child - The item, or array of items, to add to the list.
	 * @param index - The index in the list at which the element(s) will be inserted.
	 * @param skipCallback - Skip calling the List.addCallback if this child is added successfully.
	 *
	 * @return The List's underlying array.
	**/
	public inline function addAt<TChild:Union<T, Array<T>>>(child:TChild,
			index:Int = 0, skipCallback:Bool = false):TChild
	{
		return if (skipCallback)
		{
			ArrayUtils.addAt(list, child, index);
		}
		else
		{
			ArrayUtils.addAt(list, child, index, 0, addCallback);
		}
	}

	/**
	 * Retrieves the item at a given position inside the List.
	 *
	 * @since 1.0.0
	 *
	 * @param index - The index of the item.
	 *
	 * @return The retrieved item, or `null` if it's outside the List's bounds.
	**/
	public inline function getAt(index:Int):Null<T>
	{
		return if (index < list.length)
		{
			list[index];
		}
		else
		{
			null;
		}
	}

	/**
	 * Locates an item within the List and returns its index.
	 *
	 * @since 1.0.0
	 *
	 * @param child - The item to locate.
	 *
	 * @return The index of the item within the List, or -1 if it's not in the List.
	**/
	public inline function getIndex(child:T):Int
	{
		//  Return -1 if given child isn't a child of this display list
		return list.indexOf(child);
	}

	/**
	 * Sort the contents of this List so the items are in order based on the given property.
	 * For example, `sort('alpha')` would sort the List contents based on the value of their `alpha` property.
	 *
	 * @since 1.0.0
	 *
	 * @param property - The property to lexically sort by.
	 * @param handler - Provide your own custom handler function. Will receive 2 children which it should compare and return a boolean.
	 *
	 * @return This List object.
	**/
	public inline function sort(?comp:(a:T, b:T) -> Int):List<T>
	{
		ArrayUtils.stableSort(list, comp);
		return this;
	}

	/**
	 * Searches for the first instance of a child with its `name`
	 * property matching the given argument. Should more than one child have
	 * the same name only the first is returned.
	 *
	 * @since 1.0.0
	 *
	 * @param name - The name to search for.
	 *
	 * @return The first child with a matching name, or null if none were found.
	**/
	public function getByName(name:String):T
	{
		return ArrayUtils.getFirst(list, (item) -> Reflect.field(item, "name"), name);
	}

	/**
	 * Returns a random child from the group.
	 *
	 * @since 1.0.0
	 *
	 * @param startIndex - Offset from the front of the group (lowest child).
	 * @param length - Restriction on the number of values you want to randomly select from.
	 *
	 * @return A random child of this Group.
	**/
	public inline function getRandom(startIndex:Int, length:Int):T
	{
		return ArrayUtils.getRandom(list, startIndex, length);
	}

	/**
	 * Returns the first element in a given part of the List which matches a specific criterion.
	 *
	 * @since 1.0.0
	 *
	 * @param propertyAccessor - The function to get the property to test on each array element.
	 * @param value - The value to test the `property` against, or `undefined` to allow any value and only check for existence.
	 * @param startIndex - The position in the List to start the search at.
	 * @param endIndex - The position in the List to optionally stop the search at. It won't be checked.
	 *
	 * @return The first item which matches the given criterion, or `null` if no such item exists.
	**/
	public inline function getFirst<TValue>(propertyAccessor:(T) -> TValue,
			?value:TValue, startIndex:Int = 0, ?endIndex:Int):Null<T>
	{
		return ArrayUtils.getFirst(list, propertyAccessor, value, startIndex, endIndex);
	}

	/**
	 * Returns all children in this List.
	 *
	 * You can optionally specify a matching criteria using the `property` and `value` arguments.
	 *
	 * For example: `getAll('parent')` would return only children that have a property called `parent`.
	 *
	 * You can also specify a value to compare the property to:
	 *
	 * `getAll('visible', true)` would return only children that have their visible property set to `true`.
	 *
	 * Optionally you can specify a start and end index. For example if this List had 100 children,
	 * and you set `startIndex` to 0 and `endIndex` to 50, it would return matches from only
	 * the first 50 children in the List.
	 *
	 * @since 1.0.0
	 *
	 * @param property - An optional property to test against the value argument.
	 * @param value - If property is set then Child.property must strictly equal this value to be included in the results.
	 * @param startIndex - The first child index to start the search from.
	 * @param endIndex - The last child index to search up until.
	 *
	 * @return All items of the List which match the given criterion, if any.
	**/
	public inline function getAll<TValue>(?propertyAccessor:(T) -> TValue,
			?value:TValue, ?startIndex:Int = 0, ?endIndex:Int)
	{
		return ArrayUtils.getAll(list, propertyAccessor, value, startIndex, endIndex);
	}

	/**
	 * Returns the total number of items in the List which have a property matching the given value.
	 *
	 * @since 1.0.0
	 *
	 * @param property - The property to test on each item.
	 * @param value - The value to test the property against.
	 *
	 * @return The total number of matching elements.
	**/
	public inline function count<TValue>(propertyAccessor:(T) -> TValue, value:TValue)
	{
		return ArrayUtils.countAllMatching(list, propertyAccessor, value);
	}

	/**
	 * Swaps the positions of two items in the list.
	 *
	 * @since 1.0.0
	 *
	 * @param child1 - The first item to swap.
	 * @param child2 - The second item to swap.
	**/
	public inline function swap(child1:T, child2:T):Void
	{
		ArrayUtils.swap(list, child1, child2);
	}

	/**
	 * Moves an item in the List to a new position.
	 *
	 * @since 1.0.0
	 *
	 * @param child - The item to move.
	 * @param index - Moves an item in the List to a new position.
	 *
	 * @return The item that was moved.
	**/
	public inline function moveTo(child:T, index:Int):T
	{
		return ArrayUtils.moveTo(list, child, index);
	}

	/**
	 * Removes one or many items from the List.
	 *
	 * @since 1.0.0
	 *
	 * @param child - The item, or array of items, to remove.
	 * @param skipCallback - Skip calling the List.removeCallback.
	 *
	 * @return The item, or array of items, which were successfully removed from the List.
	**/
	public inline function remove(child:T, skipCallback:Bool = false)
	{
		return if (skipCallback)
		{
			ArrayUtils.remove(list, child);
		}
		else
		{
			ArrayUtils.remove(list, child, removeCallback);
		}
	}

	/**
	 * Removes the item at the given position in the List.
	 *
	 * @since 1.0.0
	 *
	 * @param index - The position to remove the item from.
	 * @param skipCallback - Skip calling the List.removeCallback.
	 *
	 * @return The item that was removed.
	**/
	public inline function removeAt(index:Int, skipCallback:Bool = false)
	{
		return if (skipCallback)
		{
			ArrayUtils.removeAt(list, index);
		}
		else
		{
			ArrayUtils.removeAt(list, index, removeCallback);
		}
	}

	/**
	 * Removes the items within the given range in the List.
	 *
	 * @since 1.0.0
	 *
	 * @param startIndex - The index to start removing from.
	 * @param endIndex - The position to stop removing at. The item at this position won't be removed.
	 * @param skipCallback - Skip calling the List.removeCallback.
	 *
	 * @return An array of the items which were removed.
	**/
	public inline function removeBetween(startIndex:Int = 0, endIndex:Int,
			skipCallback:Bool = false)
	{
		return if (skipCallback)
		{
			ArrayUtils.removeBetween(list, startIndex, endIndex);
		}
		else
		{
			ArrayUtils.removeBetween(list, startIndex, endIndex, removeCallback);
		}
	}

	/**
	 * Removes all the items.
	 *
	 * @since 1.0.0
	 *
	 * @param skipCallback - Skip calling the List.removeCallback.
	 *
	 * @return This List object.
	**/
	public inline function removeAll(skipCallback:Bool = false)
	{
		var i = list.length;

		while (i-- != 0)
		{
			remove(list[i], skipCallback);
		}

		return this;
	}

	/**
	 * Brings the given child to the top of this List.
	 *
	 * @since 1.0.0
	 *
	 * @param child - The item to bring to the top of the List.
	 *
	 * @return The item which was moved.
	**/
	public inline function bringToTop(child:T):T
	{
		return ArrayUtils.bringToTop(list, child);
	}

	/**
	 * Sends the given child to the bottom of this List.
	 *
	 * @since 1.0.0
	 *
	 * @param child - The item to send to the back of the list.
	 *
	 * @return The item which was moved.
	**/
	public inline function sendToBack(child:T):T
	{
		return ArrayUtils.sendToBack(list, child);
	}

	/**
	 * Moves the given child up one place in this group unless it's already at the top.
	 *
	 * @since 1.0.0
	 *
	 * @param child - The item to move up.
	 *
	 * @return The item which was moved.
	**/
	public inline function moveUp(child:T):T
	{
		ArrayUtils.moveUp(list, child);
		return child;
	}

	/**
	 * Moves the given child down one place in this group unless it's already at the bottom.
	 *
	 * @since 1.0.0
	 *
	 * @param child - The item to move down.
	 *
	 * @return The item which was moved.
	**/
	public inline function moveDown(child:T):T
	{
		ArrayUtils.moveDown(list, child);
		return child;
	}

	/**
	 * Reverses the order of all children in this List.
	 *
	 * @since 1.0.0
	 *
	 * @return This List object.
	**/
	public inline function reverse():List<T>
	{
		list.reverse();
		return this;
	}

	/**
	 * Shuffles the items in the list.
	 *
	 * @since 1.0.0
	 *
	 * @return This List object.
	**/
	public inline function shuffle():List<T>
	{
		ArrayUtils.shuffle(list);
		return this;
	}

	/**
	 * Replaces a child of this List with the given newChild. The newChild cannot be a member of this List.
	 *
	 * @since 1.0.0
	 *
	 * @param oldChild - The child in this List that will be replaced.
	 * @param newChild - The child to be inserted into this List.
	 *
	 * @return Returns the oldChild that was replaced within this group.
	**/
	public inline function replace(oldChild:T, newChild:T):T
	{
		ArrayUtils.replace(list, oldChild, newChild);
		return oldChild;
	}

	/**
	 * Checks if an item exists within the List.
	 *
	 * @since 1.0.0
	 *
	 * @param child - The item to check for the existence of.
	 *
	 * @return `true` if the item is found in the list, otherwise `false`.
	**/
	public inline function exists(child:T):Bool
	{
		return list.indexOf(child) > -1;
	}

	/**
	 * TODO: fix description of function
	 *
	 * Sets the property `key` to the given value on all members of this List.
	 *
	 * @since 1.0.0
	 *
	 * @param propertySetter - The name of the property to set.
	 * @param value - The value to set the property to.
	 * @param startIndex - The first child index to start the search from.
	 * @param endIndex - The last child index to search up until.
	**/
	public inline function setAll<TValue>(propertySetter:(T, TValue) -> Void,
			value:TValue, startIndex:Int = 0, ?endIndex:Int)
	{
		ArrayUtils.setAll(list, propertySetter, value, startIndex, endIndex);
		return this;
	}

	/**
	 * Passes all children to the given callback.
	 *
	 * @since 1.0.0
	 *
	 * @param callback - The function to call..
	 * @param args - Additional arguments that will be passed to the callback, after the child.
	**/
	public function each(callback:EachListCallback<T>, ?args:Array<Dynamic>)
	{
		for (item in list)
		{
			callback(item, args);
		}
	}

	/**
	 * Clears the List and recreates its internal array.
	 *
	 * @since 1.0.0
	**/
	public function shutdown()
	{
		removeAll();
		list = [];
	}

	/**
	 * Destroys this List.
	 *
	 * @since 1.0.0
	**/
	public function destroy()
	{
		removeAll();

		parent = null;
		addCallback = null;
		removeCallback = null;
	}
}
