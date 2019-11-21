package phaserHaxe.input.mouse;

import js.html.MouseEvent as WebMouseEvent;
import js.Browser as WebBrowser;
import phaserHaxe.device.FeaturesInfo;

typedef MouseEventHandler = (event:WebMouseEvent) -> Void;

/**
 * The Mouse Manager is a helper class that belongs to the Input Manager.
 *
 * Its role is to listen for native DOM Mouse Events and then pass them onto the Input Manager for further processing.
 *
 * You do not need to create this class directly, the Input Manager will create an instance of it automatically.
 *
 * @since 1.0.0
**/
class MouseManager
{
	/**
	 * A reference to the Input Manager.
	 *
	 * @since 1.0.0
	**/
	public var manager:InputManager;

	/**
	 * If true the DOM mouse events will have event.preventDefault applied to them, if false they will propagate fully.
	 *
	 * @since 1.0.0
	**/
	public var capture:Bool = true;

	/**
	 * A boolean that controls if the Mouse Manager is enabled or not.
	 * Can be toggled on the fly.
	 *
	 * @since 1.0.0
	**/
	public var enabled:Bool = false;

	/**
	 * The Mouse target, as defined in the Game Config.
	 * Typically the canvas to which the game is rendering, but can be any interactive DOM element.
	 *
	 * @since 1.0.0
	**/
	public var target:js.html.EventTarget = null;

	/**
	 * If the mouse has been pointer locked successfully this will be set to true.
	 *
	 * @since 1.0.0
	**/
	public var locked:Bool = false;

	/**
	 * The Mouse Move Event handler.
	 * This function is sent the native DOM MouseEvent.
	 * Initially empty and bound in the `startListeners` method.
	 *
	 * @since 1.0.0
	**/
	public var onMouseMove:MouseEventHandler = null;

	/**
	 * The Mouse Down Event handler.
	 * This function is sent the native DOM MouseEvent.
	 * Initially empty and bound in the `startListeners` method.
	 *
	 * @since 1.0.0
	**/
	public var onMouseDown:MouseEventHandler = null;

	/**
	 * The Mouse Up Event handler.
	 * This function is sent the native DOM MouseEvent.
	 * Initially empty and bound in the `startListeners` method.
	 *
	 * @since 1.0.0
	**/
	public var onMouseUp:MouseEventHandler = null;

	/**
	 * The Mouse Down Event handler specifically for events on the Window.
	 * This function is sent the native DOM MouseEvent.
	 * Initially empty and bound in the `startListeners` method.
	 *
	 * @since 1.0.0
	**/
	public var onMouseDownWindow:MouseEventHandler = null;

	/**
	 * The Mouse Up Event handler specifically for events on the Window.
	 * This function is sent the native DOM MouseEvent.
	 * Initially empty and bound in the `startListeners` method.
	 *
	 * @since 1.0.0
	**/
	public var onMouseUpWindow:MouseEventHandler = null;

	/**
	 * The Mouse Over Event handler.
	 * This function is sent the native DOM MouseEvent.
	 * Initially empty and bound in the `startListeners` method.
	 *
	 * @since 1.0.0
	**/
	public var onMouseOver:MouseEventHandler = null;

	/**
	 * The Mouse Out Event handler.
	 * This function is sent the native DOM MouseEvent.
	 * Initially empty and bound in the `startListeners` method.
	 *
	 * @since 1.0.0
	**/
	public var onMouseOut:MouseEventHandler = null;

	/**
	 * The Mouse Wheel Event handler.
	 * This function is sent the native DOM MouseEvent.
	 * Initially empty and bound in the `startListeners` method.
	 *
	 * @since 1.0.0
	**/
	public var onMouseWheel:MouseEventHandler = null;

	/**
	 * Internal pointerLockChange handler.
	 * This function is sent the native DOM MouseEvent.
	 * Initially empty and bound in the `startListeners` method.
	 *
	 * @since 1.0.0
	**/
	public var pointerLockChange:MouseEventHandler = null;

	/**
	 * @param inputManager - A reference to the Input Manager.
	**/
	public function new(inputManager:InputManager)
	{
		this.manager = inputManager;

		inputManager.events.once(InputEvents.MANAGER_BOOT, this.boot, this);
	}

	/**
	 * The Touch Manager boot process.
	 *
	 * @since 1.0.0
	**/
	private function boot()
	{
		var config = this.manager.config;

		this.enabled = config.inputMouse;
		this.target = config.inputMouseEventTarget;
		this.capture = config.inputMouseCapture;

		if (this.target == null)
		{
			this.target = this.manager.game.canvas;
		}
		else if (Std.is(target, String))
		{
			this.target = WebBrowser.document.getElementById(cast target);
		}

		if (config.disableContextMenu)
		{
			disableContextMenu();
		}

		if (enabled && target != null)
		{
			startListeners();
		}
	}

	/**
	 * Attempts to disable the context menu from appearing if you right-click on the browser.
	 *
	 * Works by listening for the `contextmenu` event and prevent defaulting it.
	 *
	 * Use this if you need to enable right-button mouse support in your game, and the browser
	 * menu keeps getting in the way.
	 *
	 * @since 1.0.0
	 *
	 * @return This Mouse Manager instance.
	**/
	public function disableContextMenu():MouseManager
	{
		WebBrowser.document.body.addEventListener('contextmenu', function(event)
		{
			event.preventDefault();
			return false;
		});
		return this;
	}

	/**
	 * If the browser supports it, you can request that the pointer be locked to the browser window.
	 *
	 * This is classically known as 'FPS controls', where the pointer can't leave the browser until
	 * the user presses an exit key.
	 *
	 * If the browser successfully enters a locked state, a `POINTER_LOCK_CHANGE_EVENT` will be dispatched,
	 * from the games Input Manager, with an `isPointerLocked` property.
	 *
	 * It is important to note that pointer lock can only be enabled after an 'engagement gesture',
	 * see: https://w3c.github.io/pointerlock/#dfn-engagement-gesture.
	 *
	 * @since 1.0.0
	**/
	public function requestPointerLock()
	{
		if (FeaturesInfo.pointerLock)
		{
			var element = this.target;

			(cast element)
				.requestPointerLock = js.Syntax.code("{0}.requestPointerLock || {0}.mozRequestPointerLock|| {0}.webkitRequestPointerLoc",
				element);

			(cast element).requestPointerLock();
		}
	}

	/**
	 * If the browser supports pointer lock, this will request that the pointer lock is released. If
	 * the browser successfully enters a locked state, a 'POINTER_LOCK_CHANGE_EVENT' will be
	 * dispatched - from the game's input manager - with an `isPointerLocked` property.
	 *
	 * @since 1.0.0
	**/
	public function releasePointerLock():Void
	{
		if (FeaturesInfo.pointerLock)
		{
			var document:Dynamic = WebBrowser.document;

			(cast WebBrowser.document)
				.exitPointerLock = js.Syntax.code("{0}.exitPointerLock || {0}.mozExitPointerLock||{0}.webkitExitPointerLock", document);
			WebBrowser.document.exitPointerLock();
		}
	}

	/**
	 * Starts the Mouse Event listeners running.
	 * This is called automatically and does not need to be manually invoked.
	 *
	 * @since 1.0.0
	**/
	public function startListeners():Void
	{
		var _this = this;
		var canvas = this.manager.canvas;
		var autoFocus = (WebBrowser.supported && WebBrowser.window.focus != null && this.manager.game.config.autoFocus);

		this.onMouseMove = function(event:WebMouseEvent)
		{
			if (!event.defaultPrevented && enabled && manager != null && manager.enabled)
			{
				manager.onMouseMove(event);

				if (capture)
				{
					event.preventDefault();
				}
			}
		};

		this.onMouseDown = function(event)
		{
			if (autoFocus)
			{
				WebBrowser.window.focus();
			}

			if (!event.defaultPrevented && enabled && manager != null && manager.enabled)
			{
				manager.onMouseDown(event);

				if (capture && event.target == canvas)
				{
					event.preventDefault();
				}
			}
		};

		this.onMouseDownWindow = function(event)
		{
			if (!event.defaultPrevented && enabled && manager != null && manager.enabled && event.target != canvas)
			{
				//  Only process the event if the target isn't the canvas
				manager.onMouseDown(event);
			}
		};

		this.onMouseUp = function(event)
		{
			if (!event.defaultPrevented && enabled && manager != null && manager.enabled)
			{
				manager.onMouseUp(event);

				if (capture && event.target == canvas)
				{
					event.preventDefault();
				}
			}
		};

		this.onMouseUpWindow = function(event)
		{
			if (!event.defaultPrevented && enabled && manager != null && manager.enabled && event.target != canvas)
			{
				//  Only process the event if the target isn't the canvas
				manager.onMouseUp(event);
			}
		};

		this.onMouseOver = function(event)
		{
			if (!event.defaultPrevented && enabled && manager != null && manager.enabled)
			{
				manager.setCanvasOver(event);
			}
		};

		this.onMouseOut = function(event)
		{
			if (!event.defaultPrevented && enabled && manager != null && manager.enabled)
			{
				manager.setCanvasOut(event);
			}
		};

		this.onMouseWheel = function(event)
		{
			if (!event.defaultPrevented && enabled && manager != null && manager.enabled)
			{
				_this.manager.onMouseWheel(event);
			}
		};

		if (target == null)
		{
			return;
		}

		var passive = {passive: true};
		var nonPassive = {passive: false};

		target.addEventListener('mousemove', this.onMouseMove, (this.capture) ? nonPassive : passive);
		target.addEventListener('mousedown', this.onMouseDown, (this.capture) ? nonPassive : passive);
		target.addEventListener('mouseup', this.onMouseUp, (this.capture) ? nonPassive : passive);
		target.addEventListener('mouseover', this.onMouseOver, (this.capture) ? nonPassive : passive);
		target.addEventListener('mouseout', this.onMouseOut, (this.capture) ? nonPassive : passive);
		target.addEventListener('wheel', this.onMouseWheel, (this.capture) ? nonPassive : passive);

		if (WebBrowser.supported && this.manager.game.config.inputWindowEvents != null)
		{
			WebBrowser.window.addEventListener('mousedown', this.onMouseDownWindow, nonPassive);
			WebBrowser.window.addEventListener('mouseup', this.onMouseUpWindow, nonPassive);
		}

		if (FeaturesInfo.pointerLock)
		{
			this.pointerLockChange = function(event)
			{
				var element = _this.target;

				var document:Dynamic = WebBrowser.document;

				_this.locked = (document.pointerLockElement == element
					|| document.mozPointerLockElement == element
					|| document.webkitPointerLockElement == element) ? true : false;

				_this.manager.onPointerLockChange(event);
			};

			WebBrowser.document.addEventListener('pointerlockchange', this.pointerLockChange, true);
			WebBrowser.document.addEventListener('mozpointerlockchange', this.pointerLockChange, true);
			WebBrowser.document.addEventListener('webkitpointerlockchange', this.pointerLockChange, true);
		}

		enabled = true;
	}

	/**
	 * Stops the Mouse Event listeners.
	 * This is called automatically and does not need to be manually invoked.
	 *
	 * @since 1.0.0
	**/
	public function stopListeners()
	{
		target.removeEventListener('mousemove', this.onMouseMove);
		target.removeEventListener('mousedown', this.onMouseDown);
		target.removeEventListener('mouseup', this.onMouseUp);
		target.removeEventListener('mouseover', this.onMouseOver);
		target.removeEventListener('mouseout', this.onMouseOut);

		if (WebBrowser.supported)
		{
			WebBrowser.window.removeEventListener('mousedown', this.onMouseDownWindow);
			WebBrowser.window.removeEventListener('mouseup', this.onMouseUpWindow);
		}

		if (FeaturesInfo.pointerLock)
		{
			WebBrowser.document.removeEventListener("pointerlockchange", this.pointerLockChange, true);
			WebBrowser.document.removeEventListener("mozpointerlockchange", this.pointerLockChange, true);
			WebBrowser.document.removeEventListener("webkitpointerlockchange", this.pointerLockChange, true);
		}
	}

	/**
	 * Destroys this Mouse Manager instance.
	 *
	 * @since 1.0.0
	**/
	public function destroy()
	{
		this.stopListeners();

		this.target = null;
		this.enabled = false;
		this.manager = null;
	}
}
