package phaserHaxe;

import haxe.Constraints.Function;

interface IEventEmitter
{
	/**
	 * Return an array listing the events for which the emitter has registered
	 * listeners.
	**/
	public function eventNames():Array<String>;

	/**
	 * Return the listeners registered for a given event.
	 *
	 * @param event - The event name.
	 * @returns The registered listeners.
	**/
	public function listeners(event:String):Null<Array<Function>>;

	/**
	 * Return the number of listeners listening to a given event.
	 *
	 * @param event - The event name.
	 * @returns The number of listeners.
	**/
	public function listenerCount(event:String):Int;

	/**
	 * Calls each of the listeners registered for a given event.
	 *
	 * @param event - The event name.
	 * @returns `true` if the event had listeners, else `false`.
	**/
	public function emit(event:String, args:Array<Dynamic>):Bool;
	
    /**
	 * Add a listener for a given event.
	 *
	 * @param event - The event name.
	 * @param fn - The listener function.
	 * @param context - The context to invoke the listener with.
	 * @returns `this`.
	**/
	public function on(event:String, fn:Function, ?context:Dynamic):IEventEmitter;

	/**
	 * Add a one-time listener for a given event.
	 *
	 * @param event - The event name.
	 * @param fn - The listener function.
	 * @param context - The context to invoke the listener with.
	 * @returns `this`.
	**/
	public function once(event:String, fn:Function, ?context:Dynamic):IEventEmitter;
	/**
	 * Remove the listeners of a given event.
	 *
	 * @param event - The event name.
	 * @param fn - Only remove the listeners that match this function.
	 * @param context - Only remove the listeners that have this context.
	 * @param once - Only remove one-time listeners.
	 * @returns `this`.
	**/
	public function removeListener(event:String, fn:Function, context:Dynamic,
		once:Bool):IEventEmitter;

	/**
	 * Remove all listeners, or those of the specified event.
	 *
	 * @param event - The event name.
	 * @returns `this`.
	**/
	public function removeAllListeners(?event:String):IEventEmitter;

	/**
	 * Remove the listeners of a given event.
	 *
	 * @param event - The event name.
	 * @param fn - Only remove the listeners that match this function.
	 * @param context - Only remove the listeners that have this context.
	 * @param once - Only remove one-time listeners.
	 * @returns `this`.
	**/
	public function off(event:String, fn:Function, context:Dynamic,
		once:Bool):IEventEmitter;

	/**
	 * Remove the listeners of a given event.
	 *
	 * @param event - The event name.
	 * @param fn - Only remove the listeners that match this function.
	 * @param context - Only remove the listeners that have this context.
	 * @param once - Only remove one-time listeners.
	 * @returns `this`.
	**/
	public function addListener(event:String, fn:Function,
		context:Dynamic):IEventEmitter;
}
