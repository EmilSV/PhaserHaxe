package phaserHaxe.utils;

import haxe.ds.StringMap;

abstract CustomData(StringMap<Dynamic>)
{
	public inline function new()
	{
		this = new StringMap();
	}

	public static inline function assignFromDynamic(customData:CustomData,
			value:Dynamic, ?filter:(name:String) -> Bool):CustomData
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

	public static function cloneFromDynamic(value:Dynamic):Null<CustomData>
	{
		if (value == null)
		{
			return null;
		}

		final customData = new CustomData();

		return assignFromDynamic(customData, value);
	}

	public static inline function fromStringMap(value:StringMap<Dynamic>):CustomData
	{
		return cast value;
	}

	public static inline function toStringMap(value:CustomData):StringMap<Dynamic>
	{
		return cast value;
	}

	@:op([]) public inline function arrayRead(name:String):Null<Dynamic>
	{
		return this.get(name);
	}

	@:op([]) public inline function arrayWrite(name:String, value:Dynamic):Dynamic
	{
		this.set(name, value);
		return value;
	}

	@:op(a.b) public inline function felidRead(name:String):Null<Dynamic>
	{
		return this.get(name);
	}

	@:op(a.b) public inline function felidWrite(name:String, value:Dynamic):Dynamic
	{
		this.set(name, value);
		return value;
	}
}
