package phaserHaxe.data;

enum abstract DataEvents(String) from String to String
{
	/**
	 * The Change Data Event.
	 *
	 * This event is dispatched by a Data Manager when an item in the data store is changed.
	 *
	 * Game Objects with data enabled have an instance of a Data Manager under the `data` property. So, to listen for
	 * a change data event from a Game Object you would use: `sprite.data.on('changedata', listener)`.
	 *
	 * This event is dispatched for all items that change in the Data Manager.
	 * To listen for the change of a specific item, use the `CHANGE_DATA_KEY_EVENT` event.
	 *
	 * @since 1.0.0
	 *
	 * @param parent:Any - A reference to the object that the Data Manager responsible for this event belongs to.
	 * @param key:String - The unique key of the data item within the Data Manager.
	 * @param value:Any - The new value of the item in the Data Manager.
	 * @param previousValue:Any - The previous value of the item in the Data Manager.
	**/
	var CHANGE_DATA = "changedata";

	/**
	 * The Change Data Key Event.
	 *
	 * This event is dispatched by a Data Manager when an item in the data store is changed.
	 *
	 * Game Objects with data enabled have an instance of a Data Manager under the `data` property. So, to listen for
	 * the change of a specific data item from a Game Object you would use: `sprite.data.on('changedata-key', listener)`,
	 * where `key` is the unique string key of the data item. For example, if you have a data item stored called `gold`
	 * then you can listen for `sprite.data.on('changedata-gold')`.
	 *
	 * @since 1.0.0
	 *
	 * @param parent:Any - A reference to the object that owns the instance of the Data Manager responsible for this event.
	 * @param key:String - The unique key of the data item within the Data Manager.
	 * @param value:Any - The item that was updated in the Data Manager. This can be of any data type, i.e. a string, boolean, number, object or instance.
	 * @param previousValue:Any - The previous item that was updated in the Data Manager. This can be of any data type, i.e. a string, boolean, number, object or instance.
	**/
	var CHANGE_DATA_KEY = "changedata-";

	/**
	 * The Remove Data Event.
	 *
	 * This event is dispatched by a Data Manager when an item is removed from it.
	 *
	 * Game Objects with data enabled have an instance of a Data Manager under the `data` property. So, to listen for
	 * the removal of a data item on a Game Object you would use: `sprite.data.on('removedata', listener)`.
	 *
	 * @since 1.0.0
	 *
	 * @param parent:Any - A reference to the object that owns the instance of the Data Manager responsible for this event.
	 * @param key:String - The unique key of the data item within the Data Manager.
	 * @param data:Any - The item that was removed from the Data Manager. This can be of any data type, i.e. a string, boolean, number, object or instance.
	**/
	var REMOVE_DATA = "removedata";

	/**
	 * The Set Data Event.
	 *
	 * This event is dispatched by a Data Manager when a new item is added to the data store.
	 *
	 * Game Objects with data enabled have an instance of a Data Manager under the `data` property. So, to listen for
	 * the addition of a new data item on a Game Object you would use: `sprite.data.on('setdata', listener)`.
	 *
	 * @since 1.0.0
	 *
	 * @param parent:Any - A reference to the object that owns the instance of the Data Manager responsible for this event.
	 * @param key:String - The unique key of the data item within the Data Manager.
	 * @param data:Any - The item that was added to the Data Manager. This can be of any data type, i.e. a string, boolean, number, object or instance.
	**/
	var SET_DATA = "setdata";
}
