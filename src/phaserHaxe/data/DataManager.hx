package phaserHaxe.data;

import haxe.ds.StringMap;
import phaserHaxe.utils.types.Union;
import phaserHaxe.utils.types.MultipleOrOne;

typedef DataEachCallback = (parent:Any, key:String, value:Dynamic) -> Void;

class DataManager
{
	/**
	 * The object that this DataManager belongs to.
	 *
	 * @since 1.0.0
	**/
	public var parent:Any;

	/**
	 * The DataManager's event emitter.
	 *
	 * @since 1.0.0
	**/
	public var events(default, null):EventEmitter;

	/**
	 * The public values list. You can use this to access anything you have stored
	 * in this Data Manager. For example, if you set a value called `gold` you can
	 * access it via:
	 *
	 * ```haxe
	 *  this.data.values["gold"];
	 * ```
	 *
	 * You can also modify it directly:
	 *
	 * ```haxe
	 *  this.data.values["gold"] += 1000;
	 * ```
	 *
	 * Doing so will emit a `setdata` event from the parent of this Data Manager.
	 *
	 * Do not modify this object directly. Adding properties directly to this object will not
	 * emit any events. Always use `DataManager.set` to create new items the first time around.
	 *
	 * @since 1.0.0
	**/
	public var values(default, null):DataMap;

	/**
	 * Gets or sets the frozen state of this Data Manager.
	 * A frozen Data Manager will block all attempts to create new values or update existing ones.
	 *
	 * @since 1.0.0
	**/
	public var freeze(get, set):Bool;

	public function new(parent:{?events:EventEmitter, ?sys:Dynamic},
			eventEmitter:EventEmitter)
	{
		this.parent = parent;
		this.events = eventEmitter;

		this.values = new DataMap(new StringMap(), onDataSet);

		if (eventEmitter == null)
		{
			if (parent.events != null)
			{
				events = parent.events;
			}
			else
			{
				events = Std.is(parent, EventEmitter) ? cast parent : null;
			}
		}

		if (parent.sys == null && events != null)
		{
			events.once('destroy', this.destroy, this);
		}
	}

	private inline function get_freeze():Bool
	{
		return values.freeze;
	}

	private inline function set_freeze(value:Bool):Bool
	{
		return values.freeze = value;
	}

	private function onDataSet(key:String, previousValue:Dynamic, value:Dynamic):Void
	{
		events.emit(DataEvents.CHANGE_DATA, [parent, key, value, previousValue]);
		events.emit(DataEvents.CHANGE_DATA + key, [parent, value, previousValue]);
	}

	/**
	 * Retrieves the value for the given key, or undefined if it doesn't exist.
	 *
	 * You can also access values via the `values` object. For example, if you had a key called `gold` you can do either:
	 *
	 * ```haxe
	 * this.data.get('gold');
	 * ```
	 *
	 * Or access the value directly:
	 *
	 * ```haxe
	 * this.data.values.gold;
	 * ```
	 *
	 * You can also pass in an array of keys, in which case an array of values will be returned:
	 *
	 * ```haxe
	 * this.data.get([ 'gold', 'armor', 'health' ]);
	 * ```
	 *
	 * This approach is useful for destructuring arrays in ES6.
	 *
	 * @since 1.0.0
	 *
	 * @param key - The key of the value to retrieve, or an array of keys.
	 *
	 * @return The value belonging to the given key, or an array of values, the order of which will match the input array.
	**/
	public function get(key:MultipleOrOne<String>):MultipleOrOne<Dynamic>
	{
		var list = this.values.getUnderlyingMap();

		if (key.isArray())
		{
			var key = key.getArray();
			var output = [];

			for (i in 0...key.length)
			{
				output.push(list[key[i]]);
			}

			return output;
		}
		else
		{
			return list[key.getOne()];
		}
	}

	/**
	 * Retrieves all data values in a new map.
	 *
	 * @since 1.0.0
	 *
	 * @return All data values.
	**/
	public function getAll():Map<String, Dynamic>
	{
		return values.getUnderlyingMap().copy();
	}

	/**
	 * Queries the DataManager for the values of keys matching the given regular expression.
	 *
	 * @since 1.0.0
	 *
	 * @param search - A regular expression object.
	 *
	 * @return The values of the keys matching the search string.
	**/
	public function query(search:EReg):Map<String, Dynamic>
	{
		final results = new StringMap();

		for (key => value in values.getUnderlyingMap())
		{
			if (search.match(key))
			{
				results.set(key, value);
			}
		}

		return results;
	}

	/**
	 * Sets a value for the given key. If the key doesn't already exist in the Data Manager then it is created.
	 *
	 * ```haxe
	 * data.set('name', 'Red Gem Stone');
	 * ```
	 *
	 * You can also pass in an map as the first argument:
	 *
	 * ```haxe
	 * data.set({ "name" => 'Red Gem Stone', "level" => 2, "owner" => "Link", "gold" => 50 });
	 * ```
	 *
	 * To get a value back again you can call `get`:
	 *
	 * ```haxe
	 * data.get('gold');
	 * ```
	 *
	 * Or you can access the value directly via the `values` property, where it works like a map:
	 *
	 * ```haxe
	 * data.values["gold"] += 50;
	 * ```
	 *
	 * When the value is first set, a `setdata` event is emitted.
	 *
	 * If the key already exists, a `changedata` event is emitted instead, along an event named after the key.
	 * For example, if you updated an existing key called `PlayerLives` then it would emit the event `changedata-PlayerLives`.
	 * These events will be emitted regardless if you use this method to set the value, or the direct `values` setter.
	 *
	 * Please note that the data keys are case-sensitive and must be valid JavaScript Object property strings.
	 * This means the keys `gold` and `Gold` are treated as two unique values within the Data Manager.
	 *
	 * @fires Phaser.Data.Events#SET_DATA
	 * @fires Phaser.Data.Events#CHANGE_DATA
	 * @fires Phaser.Data.Events#CHANGE_DATA_KEY
	 * @since 1.0.0
	 *
	 * @param key - The key to set the value for. Or an object or key value pairs. If an object the `data` argument is ignored.
	 * @param data - The value to set for the given key. If an object is provided as the key this argument is ignored.
	 *
	 * @return This DataManager object.
	**/
	public function set(key:Union<String, Map<String, Any>>, data:Any):DataManager
	{
		if (freeze)
		{
			return this;
		}

		if (Std.is(key, String))
		{
			return setValue(cast key, data);
		}
		else
		{
			var key = (cast key : Map<String, Any>);
			for (entryKey => entryValue in key)
			{
				setValue(entryKey, entryValue);
			}
		}

		return this;
	}

	/**
	 * Internal value setter, called automatically by the `set` method.
	 *
	 * @fires Phaser.Data.Events#SET_DATA
	 * @fires Phaser.Data.Events#CHANGE_DATA
	 * @fires Phaser.Data.Events#CHANGE_DATA_KEY
	 * @since 1.0.0
	 *
	 * @param key - The key to set the value for.
	 * @param data - The value to set.
	 *
	 * @return This DataManager object.
	**/
	public function setValue(key:String, data:Any):DataManager
	{
		if (freeze)
		{
			return this;
		}

		if (has(key))
		{
			values[key] = data;
		}
		else
		{
			values.getUnderlyingMap().set(key, data);
			events.emit(DataEvents.SET_DATA, [parent, key, data]);
		}

		return this;
	}

	/**
	 * Passes all data entries to the given callback.
	 *
	 * @since 1.0.0
	 *
	 * @param callback - The function to call.
	 *
	 * @return This DataManager object.
	**/
	public inline function each(callback:DataEachCallback):DataManager
	{
		for (key => value in values.getUnderlyingMap())
		{
			callback(parent, key, value);
		}

		return this;
	}

	/**
	 * Merge the given object of key value pairs into this DataManager.
	 *
	 * Any newly created values will emit a `setdata` event. Any updated values (see the `overwrite` argument)
	 * will emit a `changedata` event.
	 *
	 * @fires Phaser.Data.Events#SET_DATA
	 * @fires Phaser.Data.Events#CHANGE_DATA
	 * @fires Phaser.Data.Events#CHANGE_DATA_KEY
	 * @since 1.0.0
	 *
	 * @param data - The data to merge.
	 * @param overwrite - Whether to overwrite existing data. Defaults to true.
	 *
	 * @return This DataManager object.
	**/
	public function merge(data:Map<String, Dynamic>, overwrite:Bool = true):DataManager
	{
		for (key => value in data)
		{
			if (overwrite || (!overwrite && !has(key)))
			{
				setValue(key, value);
			}
		}

		return this;
	}

	/**
	 * Remove the value for the given key.
	 *
	 * If the key is found in this Data Manager it is removed from the internal lists and a
	 * `removedata` event is emitted.
	 *
	 * You can also pass in an array of keys, in which case all keys in the array will be removed:
	 *
	 * ```haxe
	 * this.data.remove([ 'gold', 'armor', 'health' ]);
	 * ```
	 *
	 * @fires Phaser.Data.Events#REMOVE_DATA
	 * @since 1.0.0
	 *
	 * @param key - The key to remove, or an array of keys to remove.
	 *
	 * @return This DataManager object.
	**/
	public function remove(key:MultipleOrOne<String>):DataManager
	{
		if (freeze)
		{
			return this;
		}

		if (key.isArray())
		{
			var key = key.getArray();

			for (i in 0...key.length)
			{
				this.removeValue(key[i]);
			}
		}
		else
		{
			var key = key.getOne();

			return removeValue(key);
		}

		return this;
	}

	/**
	 * Internal value remover, called automatically by the `remove` method.
	 *
	 * @fires Phaser.Data.Events#REMOVE_DATA
	 * @since 1.0.0
	 *
	 * @param key - The key to set the value for.
	 *
	 * @return This DataManager object.
	**/
	private function removeValue(key:String):DataManager
	{
		if (has(key))
		{
			var data = values[key];

			values.getUnderlyingMap().remove(key);

			events.emit(DataEvents.REMOVE_DATA, [parent, key, data]);
		}
		return this;
	}

	/**
	 * Retrieves the data associated with the given 'key', deletes it from this Data Manager, then returns it.
	 *
	 * @fires Phaser.Data.Events#REMOVE_DATA
	 * @since 1.0.0
	 *
	 * @param key - The key of the value to retrieve and delete.
	 *
	 * @return The value of the given key.
	**/
	public function pop(key:String):Dynamic
	{
		var data = null;

		if (!freeze && has(key))
		{
			data = values[key];
			values.getUnderlyingMap().remove(key);

			events.emit(DataEvents.REMOVE_DATA, [this.parent, key, data]);
		}

		return data;
	}

	/**
	 * Determines whether the given key is set in this Data Manager.
	 *
	 * Please note that the keys are case-sensitive and must be valid JavaScript Object property strings.
	 * This means the keys `gold` and `Gold` are treated as two unique values within the Data Manager.
	 *
	 * @since 1.0.0
	 *
	 * @param key - The key to check.
	 *
	 * @return Returns `true` if the key exists, otherwise `false`.
	**/
	public function has(key:String):Bool
	{
		return values.getUnderlyingMap().exists(key);
	}

	/**
	 * Freeze or unfreeze this Data Manager. A frozen Data Manager will block all attempts
	 * to create new values or update existing ones.
	 *
	 * @since 1.0.0
	 *
	 * @param value - Whether to freeze or unfreeze the Data Manager.
	 *
	 * @return This DataManager object.
	**/
	public function setFreeze(value:Bool):DataManager
	{
		freeze = value;
		return this;
	}

	/**
	 * Delete all data in this Data Manager and unfreeze it.
	 *
	 * @since 1.0.0
	 *
	 * @return This DataManager object.
	**/
	public function reset():DataManager
	{
		values.getUnderlyingMap().clear();
		freeze = false;
		return this;
	}

	/**
	 * Destroy this data manager.
	 *
	 * @since 1.0.0
	**/
	public function destroy():Void
	{
		reset();

		events.off(DataEvents.CHANGE_DATA);
		events.off(DataEvents.SET_DATA);
		events.off(DataEvents.REMOVE_DATA);

		parent = null;
	}

	/**
	 * Return the total number of entries in this Data Manager.
	 *
	 * @since 1.0.0
	**/
	public function getCount():Int
	{
		var i = 0;

		for (entry in values.getUnderlyingMap())
		{
			i++;
		}

		return i;
	}
}
