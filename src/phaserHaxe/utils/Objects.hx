package phaserHaxe.utils;

#if js
import js.Syntax as JsSyntax;
#end

using Lambda;

final class Objects
{
	/**
	 * Finds the key within the top level of the source object, or returns defaultValue
	 *
	 * @since 1.0.0
	 *
	 * @param source - The object to search
	 * @param key - The key for the property on source. Must exist at the top level of the source object (no periods)
	 * @param defaultValue - The default value to use if the key does not exist.
	 *
	 * @return The value if found; otherwise, defaultValue (null if none provided)
	**/
	public function getFastValue(source:Null<{}>, key:String,
			?defaultValue:Dynamic):Dynamic
	{
		#if js
		var t = JsSyntax.typeof(source);

		if (JsSyntax.strictNeq(t, "object") || t == null)
		{
			return defaultValue;
		}
		else
			if (JsSyntax.code("{0}.hasOwnProperty({1})", source, key) && JsSyntax.field(source, key) != null)
		{
			return JsSyntax.field(source, key);
		}
		else
		{
			return defaultValue;
		}
		#else
		if (key == null)
		{
			return defaultValue;
		}

		switch (Type.typeof(source))
		{
			case TClass(c):
				if (!Type.getClassFields(c).has(key))
				{
					return defaultValue;
				}

				final p = Reflect.getProperty(source, key);

				if (p != null)
				{
					return p;
				}

				return defaultValue;

			case TObject:
				final p = Reflect.getProperty(source, key);

				if (p != null)
				{
					return p;
				}

				return defaultValue;

			default:
				return defaultValue;
		}
		return defaultValue;
		#end
	}
}
