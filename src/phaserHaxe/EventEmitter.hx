package phaserHaxe;

import haxe.ds.StringMap;
import haxe.Constraints.Function;

typedef Events = StringMap<Null<Array<EE>>>;

private class EE
{
	public var fn:Function;
	public var context:Dynamic;
	public var once:Bool;

	public function new(fn:Function, context:Dynamic, once:Bool)
	{
		this.fn = fn;
		this.context = context;
		this.once = once;
	}
}

class EventEmitter
{
	private static inline var prefix:String = "~";

	private var _events:Events;
	private var _eventsCount:Int;

	/**
	 * Add a listener for a given event.
	 *
	 * @param emitter emitter Reference to the `EventEmitter` instance.
	 * @param event The event name.
	 * @param fn The listener function.
	 * @param context The context to invoke the listener with.
	 * @param once Specify if the listener is a one-time listener.
	**/
	private static function addListener(emitter:EventEmitter, event:String,
			fn:Function, ?context:Dynamic, once:Bool):EventEmitter
	{
		if (context == null)
		{
			context = emitter;
		}
		var listener = new EE(fn, context, once);
		var evt = event;

		var eventArray = emitter._events.get(event);

		if (eventArray == null)
		{
			emitter._events.set(evt, [listener]);
			emitter._eventsCount += 1;
		}
		else
		{
			eventArray.push(listener);
		}

		return emitter;
	}

	/**
	 * Clear event by name.
	 *
	 * @param emitter Reference to the `EventEmitter` instance.
	 * @param evt The Event name.
	**/
	private static function clearEvent(emitter:EventEmitter, evt:String)
	{
		var events = emitter._events.get(evt);
		if (events != null)
		{
			events.resize(0);
		}
	}

	public function eventNames():Array<String>
	{
		var names = [];
		var name:String;
		var events = this._events;

		if (_eventsCount == 0)
		{
			return names;
		}

		for (key in events.keys())
		{
			names.push(key);
		}

		return names;
	}

	public function listeners(event:String):Null<Array<Function>>
	{
		if (event == null)
		{
			return null;
		}
		var evt = event;
		var handlers = this._events.get(evt);

		if (handlers == null)
		{
			return null;
		}

		var ee = new Array<Function>();
		ee.resize(handlers.length);

		for (i in 0...handlers.length)
		{
			ee[i] = handlers[i].fn;
		}

		return ee;
	}

	/**
	 * Return the number of listeners listening to a given event.
	 *
	 * @param event The event name.
	 * @returns The number of listeners.
	**/
	public function listenerCount(event:String):Int
	{
		var listeners = this._events.get(event);

		if (listeners != null)
		{
			return listeners.length;
		}
		else
		{
			return 0;
		}
	}

	/**
	 * Calls each of the listeners registered for a given event.
	 *
	 * @param event The event name.
	 * @returns `true` if the event had listeners, else `false`.
	**/
	public function emit(event, args:Array<Dynamic>):Bool
	{
		var listeners = _events.get(event);
		if (listeners == null)
		{
			return false;
		}

		var len = args.length;

		for (listener in listeners)
		{
			Reflect.callMethod(listener.context, listener.fn, args);
		}

		return true;
	}

	/**
	 * Remove the listeners of a given event.
	 *
	 * @param {(String|Symbol)} event The event name.
	 * @param {Function} fn Only remove the listeners that match this function.
	 * @param {*} context Only remove the listeners that have this context.
	 * @param {Boolean} once Only remove one-time listeners.
	 * @returns {EventEmitter} `this`.
	**/
	public function removeListener(event:String, fn:Function, context:Dynamic,
			once:Bool):EventEmitter
	{
		return this;
	}
}
