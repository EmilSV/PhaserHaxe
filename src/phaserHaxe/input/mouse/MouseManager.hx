package phaserHaxe.input.mouse;

import phaserHaxe.device.CanvasFeatures;

import js.Browser;
import haxe.Constraints.Function;

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
	public var target:Any = null;

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
	public var onMouseMove:Function = null;

	/**
	 * The Mouse Down Event handler.
	 * This function is sent the native DOM MouseEvent.
	 * Initially empty and bound in the `startListeners` method.
	 *
	 * @since 1.0.0
	**/
	public var onMouseDown:Function = null;

	/**
	 * The Mouse Up Event handler.
	 * This function is sent the native DOM MouseEvent.
	 * Initially empty and bound in the `startListeners` method.
	 *
	 * @since 1.0.0
	**/
	public var onMouseUp:Function = null;

	/**
	 * The Mouse Down Event handler specifically for events on the Window.
	 * This function is sent the native DOM MouseEvent.
	 * Initially empty and bound in the `startListeners` method.
	 *
	 * @since 1.0.0
	**/
	public var onMouseDownWindow:Function = null;

	/**
	 * The Mouse Up Event handler specifically for events on the Window.
	 * This function is sent the native DOM MouseEvent.
	 * Initially empty and bound in the `startListeners` method.
	 *
	 * @since 1.0.0
	**/
	public var onMouseUpWindow:Function = null;

	/**
	 * The Mouse Over Event handler.
	 * This function is sent the native DOM MouseEvent.
	 * Initially empty and bound in the `startListeners` method.
	 *
	 * @since 1.0.0
	**/
	public var onMouseOver:Function = null;

	/**
	 * The Mouse Out Event handler.
	 * This function is sent the native DOM MouseEvent.
	 * Initially empty and bound in the `startListeners` method.
	 *
	 * @since 1.0.0
	**/
	public var onMouseOut:Function = null;

	/**
	 * The Mouse Wheel Event handler.
	 * This function is sent the native DOM MouseEvent.
	 * Initially empty and bound in the `startListeners` method.
	 *
	 * @since 1.0.0
	**/
	public var onMouseWheel:Function = null;

	/**
	 * Internal pointerLockChange handler.
	 * This function is sent the native DOM MouseEvent.
	 * Initially empty and bound in the `startListeners` method.
	 *
	 * @since 1.0.0
	**/
	public var pointerLockChange:Function = null;

	/**
	 * @param {Phaser.Input.InputManager} inputManager - A reference to the Input Manager.
	**/
	public function new(inputManager:InputManager) {}

	/**
	 * The Touch Manager boot process.
	 *
	 * @method Phaser.Input.Mouse.MouseManager#boot
	 * @private
	 * @since 1.0.0
	**/
	private function boot()
	{
		// var config = this.manager.config;

		// this.enabled = config.inputMouse;
		// this.target = config.inputMouseEventTarget;
		// this.capture = config.inputMouseCapture;

		// if (!this.target)
		// {
		//     this.target = this.manager.game.canvas;
		// }
		// else if (typeof this.target === 'string')
		// {
		//     this.target = document.getElementById(this.target);
		// }

		// if (config.disableContextMenu)
		// {
		//     this.disableContextMenu();
		// }

		// if (this.enabled && this.target)
		// {
		//     this.startListeners();
		// }
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
	 * @return {Phaser.Input.Mouse.MouseManager} This Mouse Manager instance.
	**/
	public function disableContextMenu():MouseManager
	{
		Browser.document.body.addEventListener('contextmenu', function(event)
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
	 * @method Phaser.Input.Mouse.MouseManager#requestPointerLock
	 * @since 3.0.0
	 */
	function requestPointerLock()
	{
		// if (Features.pointerLock)
		// {
		//     var element = this.target;

		//     element.requestPointerLock = element.requestPointerLock || element.mozRequestPointerLock || element.webkitRequestPointerLock;

		//     element.requestPointerLock();
		// }
	}

	/**
	 * If the browser supports pointer lock, this will request that the pointer lock is released. If
	 * the browser successfully enters a locked state, a 'POINTER_LOCK_CHANGE_EVENT' will be
	 * dispatched - from the game's input manager - with an `isPointerLocked` property.
	 *
	 * @method Phaser.Input.Mouse.MouseManager#releasePointerLock
	 * @since 3.0.0
	**/
	function releasePointerLock()
	{
		// if (Features.pointerLock)
		// {
		//     document.exitPointerLock = document.exitPointerLock || document.mozExitPointerLock || document.webkitExitPointerLock;
		//     document.exitPointerLock();
		// }
	}

	/**
	 * Starts the Mouse Event listeners running.
	 * This is called automatically and does not need to be manually invoked.
	 *
	 * @method Phaser.Input.Mouse.MouseManager#startListeners
	 * @since 3.0.0
	**/
	function startListeners()
	{
		// var _this = this;
		// var canvas = this.manager.canvas;
		// var autoFocus = (window && window.focus && this.manager.game.config.autoFocus);

		// this.onMouseMove = function (event)
		// {
		//     if (!event.defaultPrevented && _this.enabled && _this.manager && _this.manager.enabled)
		//     {
		//         _this.manager.onMouseMove(event);

		//         if (_this.capture)
		//         {
		//             event.preventDefault();
		//         }
		//     }
		// };

		// this.onMouseDown = function (event)
		// {
		//     if (autoFocus)
		//     {
		//         window.focus();
		//     }

		//     if (!event.defaultPrevented && _this.enabled && _this.manager && _this.manager.enabled)
		//     {
		//         _this.manager.onMouseDown(event);

		//         if (_this.capture && event.target === canvas)
		//         {
		//             event.preventDefault();
		//         }
		//     }
		// };

		// this.onMouseDownWindow = function (event)
		// {
		//     if (!event.defaultPrevented && _this.enabled && _this.manager && _this.manager.enabled && event.target !== canvas)
		//     {
		//         //  Only process the event if the target isn't the canvas
		//         _this.manager.onMouseDown(event);
		//     }
		// };

		// this.onMouseUp = function (event)
		// {
		//     if (!event.defaultPrevented && _this.enabled && _this.manager && _this.manager.enabled)
		//     {
		//         _this.manager.onMouseUp(event);

		//         if (_this.capture && event.target === canvas)
		//         {
		//             event.preventDefault();
		//         }
		//     }
		// };

		// this.onMouseUpWindow = function (event)
		// {
		//     if (!event.defaultPrevented && _this.enabled && _this.manager && _this.manager.enabled && event.target !== canvas)
		//     {
		//         //  Only process the event if the target isn't the canvas
		//         _this.manager.onMouseUp(event);
		//     }
		// };

		// this.onMouseOver = function (event)
		// {
		//     if (!event.defaultPrevented && _this.enabled && _this.manager && _this.manager.enabled)
		//     {
		//         _this.manager.setCanvasOver(event);
		//     }
		// };

		// this.onMouseOut = function (event)
		// {
		//     if (!event.defaultPrevented && _this.enabled && _this.manager && _this.manager.enabled)
		//     {
		//         _this.manager.setCanvasOut(event);
		//     }
		// };

		// this.onMouseWheel = function (event)
		// {
		//     if (!event.defaultPrevented && _this.enabled && _this.manager && _this.manager.enabled)
		//     {
		//         _this.manager.onMouseWheel(event);
		//     }
		// };

		// var target = this.target;

		// if (!target)
		// {
		//     return;
		// }

		// var passive = { passive: true };
		// var nonPassive = { passive: false };

		// target.addEventListener('mousemove', this.onMouseMove, (this.capture) ? nonPassive : passive);
		// target.addEventListener('mousedown', this.onMouseDown, (this.capture) ? nonPassive : passive);
		// target.addEventListener('mouseup', this.onMouseUp, (this.capture) ? nonPassive : passive);
		// target.addEventListener('mouseover', this.onMouseOver, (this.capture) ? nonPassive : passive);
		// target.addEventListener('mouseout', this.onMouseOut, (this.capture) ? nonPassive : passive);
		// target.addEventListener('wheel', this.onMouseWheel, (this.capture) ? nonPassive : passive);

		// if (window && this.manager.game.config.inputWindowEvents)
		// {
		//     window.addEventListener('mousedown', this.onMouseDownWindow, nonPassive);
		//     window.addEventListener('mouseup', this.onMouseUpWindow, nonPassive);
		// }

		// if (Features.pointerLock)
		// {
		//     this.pointerLockChange = function (event)
		//     {
		//         var element = _this.target;

		//         _this.locked = (document.pointerLockElement === element || document.mozPointerLockElement === element || document.webkitPointerLockElement === element) ? true : false;

		//         _this.manager.onPointerLockChange(event);
		//     };

		//     document.addEventListener('pointerlockchange', this.pointerLockChange, true);
		//     document.addEventListener('mozpointerlockchange', this.pointerLockChange, true);
		//     document.addEventListener('webkitpointerlockchange', this.pointerLockChange, true);
		// }

		// this.enabled = true;
	}

	/**
	 * Stops the Mouse Event listeners.
	 * This is called automatically and does not need to be manually invoked.
	 *
	 * @since 1.0.0
	**/
	function stopListeners()
	{
		var target = this.target;

		// target.removeEventListener('mousemove', this.onMouseMove);
		// target.removeEventListener('mousedown', this.onMouseDown);
		// target.removeEventListener('mouseup', this.onMouseUp);
		// target.removeEventListener('mouseover', this.onMouseOver);
		// target.removeEventListener('mouseout', this.onMouseOut);

		// if (window)
		// {
		//     window.removeEventListener('mousedown', this.onMouseDownWindow);
		//     window.removeEventListener('mouseup', this.onMouseUpWindow);
		// }

		// if (Features.pointerLock)
		// {
		//     document.removeEventListener('pointerlockchange', this.pointerLockChange, true);
		//     document.removeEventListener('mozpointerlockchange', this.pointerLockChange, true);
		//     document.removeEventListener('webkitpointerlockchange', this.pointerLockChange, true);
		// }
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
