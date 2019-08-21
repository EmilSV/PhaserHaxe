package phaserHaxe.device;

import js.Syntax as JSSyntax;

final class Input
{
	public static final touch:Bool = {
		#if js
		JSSyntax.code("!!('ontouchstart' in document.documentElement || (navigator.maxTouchPoints && navigator.maxTouchPoints >= 1))");
		#else
		false;
		#end
	}

	public static final mspointer:Bool = {
		#if js
		JSSyntax.code("!!(navigator.msPointerEnabled || navigator.pointerEnabled)");
		#else
		false;
		#end
	}

	public static final gamepads:Bool = {
		#if js
		JSSyntax.code("!!(navigator.getGamepads)");
		#else
		false;
		#end
	}

	public static final wheelEvent:String =
		{
			var wheelEvent = null;
			#if js
			JSSyntax.code(" 
                // See https://developer.mozilla.org/en-US/docs/Web/Events/wheel
				if ('onwheel' in window || (Browser.ie && 'WheelEvent' in window))
				{
					// DOM3 Wheel Event: FF 17+, IE 9+, Chrome 31+, Safari 7+
					{0} = 'wheel';
				} else if ('onmousewheel' in window)
				{
					// Non-FF legacy: IE 6-9, Chrome 1-31, Safari 5-7.
					{0} = 'mousewheel';
				} else if (Browser.firefox && 'MouseScrollEvent' in window)
				{
					// FF prior to 17. This should probably be scrubbed.
					{0} = 'DOMMouseScroll';
				}", wheelEvent);
			#end
			wheelEvent;
		}
}
