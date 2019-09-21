package phaserHaxe;

import haxe.ds.StringMap;
import haxe.Constraints.Function;

typedef Events = StringMap<Array<EE>>;

private final class EE
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

/**
 * Near copy of eventemitter3.
 * Minimal `EventEmitter` interface that is molded against the Node.js
 * `EventEmitter` interface.
**/
class EventEmitter
{
	public static inline var prefixed = false;

	private var _events:Events;
	private var _eventsCount:Int;

	public function new()
	{
		_events = new Events();
		_eventsCount = 0;
	}

	/**
	 * Add a listener for a given event.
	 *
	 * @param emitter emitter Reference to the `EventEmitter` instance.
	 * @param event The event name.
	 * @param fn The listener function.
	 * @param context The context to invoke the listener with.
	 * @param once Specify if the listener is a one-time listener.
	**/
	private static function s_addListener(emitter:EventEmitter, event:String,
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
	 * @param event The Event name.
	**/
	private static function clearEvent(emitter:EventEmitter, event:String):Void
	{
		emitter._eventsCount -= 1;
		emitter._events.remove(event);
	}

	/**
	 * Return an array listing the events for which the emitter has registered
	 * listeners.
	**/
	public function eventNames():Array<String>
	{
		if (_eventsCount == 0)
		{
			return [];
		}
		else
		{
			return [
				for (key in _events.keys())
				{
					key;
				}
			];
		}
	}

	/**
	 * Return the listeners registered for a given event.
	 *
	 * @param event - The event name.
	 * @returns The registered listeners.
	**/
	public function listeners(event:String):Null<Array<Function>>
	{
		var handlers = this._events.get(event);

		if (handlers == null)
		{
			return [];
		}

		var ee = [
			for (item in handlers)
			{
				item.fn;
			}
		];

		return ee;
	}

	/**
	 * Return the number of listeners listening to a given event.
	 *
	 * @param event - The event name.
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
	 * @param event - The event name.
	 * @returns `true` if the event had listeners, else `false`.
	**/
	public function emit(event:String, ?args:Array<Dynamic>):Bool
	{
		final args:Array<Dynamic> = args != null ? args : [];

		final listeners = _events.get(event);
		if (listeners == null)
		{
			return false;
		}

		final len = args.length;
		for (i in 0...len)
		{
			final listener = listeners[i];

			if (listener.once)
			{
				removeListener(event, listener.fn, null, true);
			}

			Reflect.callMethod(listener.context, listener.fn, args);
		}

		return true;
	}

	/**
	 * Add a listener for a given event.
	 *
	 * @param event - The event name.
	 * @param fn - The listener function.
	 * @param context - The context to invoke the listener with.
	 * @returns `this`.
	**/
	public function on(event:String, fn:Function, ?context:Dynamic):EventEmitter
	{
		return s_addListener(this, event, fn, context, false);
	}

	/**
	 * Add a one-time listener for a given event.
	 *
	 * @param event - The event name.
	 * @param fn - The listener function.
	 * @param context - The context to invoke the listener with.
	 * @returns `this`.
	**/
	public inline function once(event:String, fn:Function, ?context:Dynamic):EventEmitter
	{
		return s_addListener(this, event, fn, context, true);
	}

	/**
	 * Remove the listeners of a given event.
	 *
	 * @param event - The event name.
	 * @param fn - Only remove the listeners that match this function.
	 * @param context - Only remove the listeners that have this context.
	 * @param once - Only remove one-time listeners.
	 * @returns `this`.
	**/
	public function removeListener(event:String, ?fn:Function, ?context:Dynamic,
			once:Bool = false):EventEmitter
	{
		final listeners = _events.get(event);

		if (listeners == null)
		{
			return this;
		}

		if (fn == null)
		{
			clearEvent(this, event);
		}

		final len = listeners.length;
		var events:Null<Array<EE>> = [];
		for (item in listeners)
		{
			if (item.fn != fn || (once && !item.once) || (context != null && item.context != context))
			{
				events.push(item);
			}
		}

		//
		// Reset the array, or remove it completely if we have no more listeners.
		//
		if (events.length > 0)
		{
			this._events.set(event, events);
		}
		else
		{
			clearEvent(this, event);
		}

		return this;
	}

	/**
	 * Remove all listeners, or those of the specified event.
	 *
	 * @param event - The event name.
	 * @returns `this`.
	**/
	public function removeAllListeners(?event:String):EventEmitter
	{
		if (event != null)
		{
			final listeners = _events.get(event);
			if (listeners != null)
			{
				clearEvent(this, event);
			}
		}
		else
		{
			this._events = new Events();
			this._eventsCount = 0;
		}

		return this;
	}

	/**
	 * Remove the listeners of a given event.
	 *
	 * @param event - The event name.
	 * @param fn - Only remove the listeners that match this function.
	 * @param context - Only remove the listeners that have this context.
	 * @param once - Only remove one-time listeners.
	 * @returns `this`.
	**/
	public function off(event:String, ?fn:Function, ?context:Dynamic,
			once:Bool = false):EventEmitter
	{
		return removeListener(event, fn, context, once);
	}

	/**
	 * Remove the listeners of a given event.
	 *
	 * @param event - The event name.
	 * @param fn - Only remove the listeners that match this function.
	 * @param context - Only remove the listeners that have this context.
	 * @param once - Only remove one-time listeners.
	 * @returns `this`.
	**/
	public inline function addListener(event:String, fn:Function,
			context:Dynamic):EventEmitter
	{
		return on(event, fn, context);
	}
}
