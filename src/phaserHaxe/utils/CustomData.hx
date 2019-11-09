package phaserHaxe.utils;

import haxe.ds.StringMap;

private class CustomDataMap<T>
{
	private final onSet:(key:String, previousValue:T, value:T) -> Void = null;
	private final onGet:(key:String, value:T) -> Void = null;

	public var frozen:Bool;
	public final map:StringMap<T>;

	public function new(map:StringMap<T>,
			?onSet:(key:String, previousValue:T, value:T) -> Void,
			?onGet:(key:String, value:T) -> Void)
	{
		this.map = map;
		this.onSet = onSet;
		this.onGet = onGet;
	}

	public function get(key:String):T
	{
		var value = map.get(key);
		if (onGet != null)
		{
			onGet(key, value);
		}
		return value;
	}

	public function set(key:String, value:T):Void
	{
		if (frozen)
		{
			return;
		}

		if (onSet != null)
		{
			var previousValue = map.get(key);
			map.set(key, value);
			onSet(key, previousValue, value);
		}
		else
		{
			map.set(key, value);
		}
	}

	public inline function keys():Iterator<String>
	{
		return map.keys();
	}

	public inline function clear():Void
	{
		map.clear();
	}
}

abstract CustomData<T>(CustomDataMap<T>)
{
	public inline function new(?onSet:(key:String, previousValue:T, value:T) -> Void,
			?onGet:(key:String, value:T) -> Void)
	{
		this = new CustomDataMap(new StringMap<T>(), onSet, onGet);
	}

	public static function assignFromDynamic<T>(customData:CustomData<T>, value:Dynamic,
			?filter:(name:String) -> Bool):CustomData<T>
	{
		final names = switch (Type.typeof(value))
		{
			case TClass(c):
				Type.getInstanceFields(c);

			case TUnknown | TObject:
				Reflect.fields(value);
			default:
				[];
		}

		for (name in names)
		{
			if (filter != null && !filter(name))
			{
				continue;
			}

			final felidValue = Reflect.field(value, name);

			if (Std.is(felidValue, Array))
			{
				customData[name] = (cast felidValue).slice(0);
			}
			else
			{
				customData[name] = felidValue;
			}
		}

		return customData;
	}

	public static function createFromDynamic(value:Dynamic):Null<CustomData<Dynamic>>
	{
		if (value == null)
		{
			return null;
		}

		final customData = new CustomData();

		return assignFromDynamic(customData, value);
	}

	public static inline function getKeys<T>(data:CustomData<T>):Iterator<String>
	{
		return (cast data : CustomDataMap<T>).keys();
	}

	public static inline function clear<T>(data:CustomData<T>):Void
	{
		(cast data : CustomDataMap<T>).clear();
	}

	public static inline function isFrozen<T>(data:CustomData<T>):Bool
	{
		return (cast data : CustomDataMap<T>).frozen;
	}

	public static inline function setFrozen<T>(data:CustomData<T>, value:Bool):Bool
	{
		return (cast data : CustomDataMap<T>).frozen = value;
	}

	public static inline function freeze<T>(data:CustomData<T>):Void
	{
		(cast data : CustomDataMap<T>).frozen = true;
	}

	public static inline function unFreeze<T>(data:CustomData<T>):Void
	{
		(cast data : CustomDataMap<T>).frozen = false;
	}

	public static inline function fromStringMap<T>(value:StringMap<T>):CustomData<T>
	{
		return cast new CustomDataMap(value);
	}

	public static inline function toStringMap<T>(value:CustomData<T>):StringMap<T>
	{
		return (cast value : CustomDataMap<T>).map;
	}

	@:op([]) public inline function arrayRead(name:String):Null<T>
	{
		return this.get(name);
	}

	@:op([]) public inline function arrayWrite(name:String, value:T):T
	{
		this.set(name, value);
		return value;
	}

	@:op(a.b) public inline function felidRead(name:String):Null<T>
	{
		return this.get(name);
	}

	@:op(a.b) public inline function felidWrite(name:String, value:T):T
	{
		this.set(name, value);
		return value;
	}
}
