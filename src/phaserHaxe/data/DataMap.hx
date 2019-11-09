package phaserHaxe.data;

import haxe.ds.StringMap;

@:allow(phaserHaxe)
private class DataMapImpl
{
	public var frozen:Bool = false;
	public final map:StringMap<Dynamic>;
	public final onSet:Null<(key:String, previousValue:Dynamic,
			value:Dynamic) -> Void> = null;

	public function new(?map:StringMap<Dynamic>,
			?onSet:(key:String, previousValue:Dynamic, value:Dynamic) -> Void)
	{
		this.map = map != null ? map : new StringMap<Dynamic>();
		this.onSet = onSet;
	}

	/**
	 * Maps `key` to `value` and calls onSet callback.
	 *
	 * If `key` already has a mapping, the previous value disappears.
	 *
	 * If `key` is `null`, the result is unspecified.
	 *
	 * @param key - The key to set the value for
	 * @param value - The value to set for the given key
	 *
	**/
	public function set(key:String, value:Dynamic):Void
	{
		if (!frozen)
		{
			var previousValue = map.get(key);
			map.set(key, value);
			if (onSet != null)
			{
				onSet(key, previousValue, value);
			}
		}
	}

	public inline function copy():DataMapImpl
	{
		return new DataMapImpl(this.map, this.onSet);
	}
}

abstract DataMap(DataMapImpl)
{
	/**
	 * Gets or sets the frozen state of this Data Map.
	 * A frozen Data Map will block all attempts to create new values or update existing ones.
	 *
	 * @since 1.0.0
	**/
	public var freeze(get, set):Bool;

	public function new(?map:StringMap<Dynamic>,
			?onSet:(key:String, previousValue:Dynamic, value:Dynamic) -> Void)
	{
		this = new DataMapImpl(map, onSet);
	}

	private inline function get_freeze():Bool
	{
		return this.frozen;
	}

	private inline function set_freeze(value):Bool
	{
		return this.frozen = value;
	}

	/**
	 * gets the underlying map that DataMap warps around
	 *
	 * @since 1.0.0
	**/
	public inline function getUnderlyingMap():Map<String, Dynamic>
	{
		return this.map;
	}

	/**
	 * Maps `key` to `value` and calls onSet callback.
	 *
	 * If `key` already has a mapping, the previous value disappears.
	 *
	 * If `key` is `null`, the result is unspecified.
	 *
	 * @param key - The key to set the value for
	 * @param value - The value to set for the given key
	 *
	**/
	public inline function set(key:String, value:Dynamic):Void
	{
		this.set(key, set);
	}

	/**
	 * Returns the current mapping of `key`.
	 * If no such mapping exists, `null` is returned.
	 *
	 * Note that a check like `map.get(key) == null` can hold for two reasons:
	 *
	 * 1. the map has no mapping for `key`
	 * 2. the map has a mapping with a value of `null`
	 *
	 * If it is important to distinguish these cases, `exists()` should be
	 * used.
	 *
	 * If `key` is `null`, the result is unspecified.
	**/
	@:arrayAccess public inline function get(key:String):Dynamic
	{
		return this.map.get(key);
	}

	// /**
	//  * Returns true if `key` has a mapping, false otherwise.
	//  *
	//  *  If `key` is `null`, the result is unspecified.
	// **/
	// public inline function exists(key:String):Dynamic
	// {
	// 	return this.map.exists(key);
	// }
	// /**
	//  * Removes the mapping of `key` and returns true if such a mapping existed,
	//  *	false otherwise.
	//  *
	//  * If `key` is `null`, the result is unspecified.
	// **/
	// public inline function remove(key:String):Dynamic
	// {
	// 	return this.map.remove(key);
	// }

	/**
	 * Returns an Iterator over the keys of `this` Map.
	 *
	 * The order of keys is undefined.
	**/
	public inline function keys():Iterator<String>
	{
		return this.map.keys();
	}

	/**
	 * Returns an Iterator over the values of `this` Map.
	 *
	 * The order of values is undefined.
	**/
	public inline function iterator():Iterator<Dynamic>
	{
		return this.map.iterator();
	}

	/**
	 * Returns an Iterator over the keys and values of `this` Map.
	 *
	 * The order of values is undefined.
	**/
	public inline function keyValueIterator():KeyValueIterator<String, Dynamic>
	{
		return this.map.keyValueIterator();
	}

	// /**
	//  * Returns a shallow copy of `this` map.
	//  *
	//  * The order of values is undefined.
	// **/
	// public inline function copy():DataMap
	// {
	// 	return cast this.copy();
	// }
	// /**
	//  * Returns a String representation of `this` Map.
	//  *
	//  * The exact representation depends on the platform and key-type.
	// **/
	// public inline function toString():String
	// {
	// 	return this.map.toString();
	// }
	// /**
	//  *	Removes all keys from `this` Map.
	// **/
	// public inline function clear():Void
	// {
	// 	this.map.clear();
	// }

	@:arrayAccess @:noCompletion public inline function arrayWrite(k:String,
			v:Dynamic):Dynamic
	{
		(cast this : DataMap).set(k, v);
		return v;
	}
}
