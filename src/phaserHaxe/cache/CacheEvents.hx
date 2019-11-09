package phaserHaxe.cache;

enum abstract CacheEvents(String) from String to String
{
	/**
	 * The Cache Add Event.
	 *
	 * This event is dispatched by any Cache that extends the BaseCache each time a new object is added to it.
	 *
	 * @since 1.0.0
	 *
	 * @param cache:BaseCache - The cache to which the object was added.
	 * @param key:String - The key of the object added to the cache.
	 * @param object:Any - A reference to the object that was added to the cache.
	**/
	var ADD = "add";

	/**
	 * The Cache Remove Event.
	 *
	 * This event is dispatched by any Cache that extends the BaseCache each time an object is removed from it.
	 *
	 * @since 1.0.0
	 *
	 * @param cache:BaseCache - The cache from which the object was removed.
	 * @param key:String - The key of the object removed from the cache.
	 * @param object:Any - A reference to the object that was removed from the cache.
	**/
	var REMOVE = "remove";
}
