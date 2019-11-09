package phaserHaxe.cache;

import haxe.ds.StringMap;

/**
 * The BaseCache is a base Cache class that can be used for storing references to any kind of data.
 *
 * Data can be added, retrieved and removed based on the given keys.
 *
 * Keys are string-based.
 *
 * @since 1.0.0
**/
class BaseCache
{
	/**
	 * The Map in which the cache objects are stored.
	 *
	 * You can query the Map directly or use the BaseCache methods.
	 *
	 * @since 1.0.0
	**/
	public var entries:StringMap<Any> = new StringMap<Any>();

	/**
	 * An instance of EventEmitter used by the cache to emit related events.
	 *
	 * @since 1.0.0
	**/
	public var events = new EventEmitter();

	public function new() {
		
	}

	/**
	 * Adds an item to this cache. The item is referenced by a unique string, which you are responsible
	 * for setting and keeping track of. The item can only be retrieved by using this string.
	 *
	 * @fires Phaser.Cache.Events#ADD
	 * @since 1.0.0
	 *
	 * @param key - The unique key by which the data added to the cache will be referenced.
	 * @param data - The data to be stored in the cache.
	 *
	 * @return This BaseCache object.
	**/
	public function add(key:String, data:Any):BaseCache
	{
		entries.set(key, data);

		events.emit(CacheEvents.ADD, [this, key, data]);

		return this;
	}

	/**
	 * Checks if this cache contains an item matching the given key.
	 * This performs the same action as `BaseCache.exists`.
	 *
	 * @since 1.0.0
	 *
	 * @param key - The unique key of the item to be checked in this cache.
	 *
	 * @return Returns `true` if the cache contains an item matching the given key, otherwise `false`.
	**/
	public inline function has(key:String):Bool
	{
		return entries.exists(key);
	}

	/**
	 * Checks if this cache contains an item matching the given key.
	 * This performs the same action as `BaseCache.has` and is called directly by the Loader.
	 *
	 * @since 1.0.0
	 *
	 * @param key - The unique key of the item to be checked in this cache.
	 *
	 * @return Returns `true` if the cache contains an item matching the given key, otherwise `false`.
	**/
	public inline function exists(key:String):Bool
	{
		return entries.exists(key);
	}

	/**
	 * Gets an item from this cache based on the given key.
	 *
	 * @since 1.0.0
	 *
	 * @param key - The unique key of the item to be retrieved from this cache.
	 *
	 * @return The item in the cache, or `null` if no item matching the given key was found.
	**/
	public inline function get(key:String):Any
	{
		return entries.get(key);
	}

	/**
	 * Removes and item from this cache based on the given key.
	 *
	 * If an entry matching the key is found it is removed from the cache and a `remove` event emitted.
	 * No additional checks are done on the item removed. If other systems or parts of your game code
	 * are relying on this item, it is up to you to sever those relationships prior to removing the item.
	 *
	 * @fires Phaser.Cache.Events#REMOVE
	 * @since 1.0.0
	 *
	 * @param key - The unique key of the item to remove from the cache.
	 *
	 * @return This BaseCache object.
	**/
	public function remove(key:String):BaseCache
	{
		var data = get(key);
		if (data != null)
		{
			entries.remove(key);
			events.emit(CacheEvents.REMOVE, [this, key, data]);
		}
		return this;
	}

	/**
	 * Returns all keys in use in this cache.
	 *
	 * @since 1.0.0
	 *
	 * @return Array containing all the keys.
	**/
	public inline function keys():Iterator<String>
	{
		return this.entries.keys();
	}

	/**
	 * Destroys this cache and all items within it.
	 *
	 * @since 1.0.0
	**/
	public function destroy():Void
	{
		entries.clear();
		events.removeAllListeners();
		entries = null;
		events = null;
	}
}
