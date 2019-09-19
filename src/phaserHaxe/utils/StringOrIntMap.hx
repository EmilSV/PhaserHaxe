package phaserHaxe.utils;

import haxe.ds.StringMap;
import haxe.ds.IntMap;

class StringOrIntMap<T>
{
	public var intMap:IntMap<T>;
	public var stringMap:StringMap<T>;

	public function new()
	{
		intMap = new IntMap();
		stringMap = new StringMap();
	}

	public inline function set(key:StringOrInt, value:T):Void
	{
		if (key.isInt())
		{
			intMap.set(key.getInt(), value);
		}
		else
		{
			stringMap.set(key.getString(), value);
		}
	}

	public inline function get(key:StringOrInt):T
	{
		return if (key.isInt())
		{
			intMap.get(key.getInt());
		}
		else
		{
			stringMap.get(key.getString());
		}
	}

	public inline function exists(key:StringOrInt):Bool
	{
		return if (key.isInt())
		{
			intMap.exists(key.getInt());
		}
		else
		{
			stringMap.exists(key.getString());
		}
	}

	public inline function remove(key:StringOrInt):Bool
	{
		return if (key.isInt())
		{
			intMap.remove(key.getInt());
		}
		else
		{
			stringMap.remove(key.getString());
		}
	}


	public inline function clear():Void
	{
		intMap.clear();
		stringMap.clear();
	}
}
