package phaserHaxe.input;

import phaserHaxe.gameobjects.components.IOrigin;
import phaserHaxe.math.MathUtility;
import phaserHaxe.gameobjects.components.ITransform;
import phaserHaxe.gameobjects.components.IScrollFactor;
import phaserHaxe.cameras.scene2D.Camera;
import phaserHaxe.gameobjects.GameObject;
import phaserHaxe.input.typedefs.InteractiveObject;
import phaserHaxe.core.GameEvents;
import phaserHaxe.math.Vector2;
import phaserHaxe.input.mouse.MouseManager;
import phaserHaxe.input.keyboard.KeyboardManager;
import phaserHaxe.input.touch.TouchManager;
import phaserHaxe.scale.ScaleManager;
import phaserHaxe.gameobjects.components.TransformMatrix;
import js.html.CanvasElement as HTMLCanvasElement;
import js.html.Event as WebEvent;
import js.html.TouchEvent as WebTouchEvent;
import js.html.MouseEvent as WebMouseEvent;
import js.html.WheelEvent as WebWheelEvent;

/**
 * The Input Manager is responsible for handling the pointer related systems in a single Phaser Game instance.
 *
 * Based on the Game Config it will create handlers for mouse and touch support.
 *
 * Keyboard and Gamepad are plugins, handled directly by the InputPlugin class.
 *
 * It then manages the events, pointer creation and general hit test related operations.
 *
 * You rarely need to interact with the Input Manager directly, and as such, all of its properties and methods
 * should be considered private. Instead, you should use the Input Plugin, which is a Scene level system, responsible
 * for dealing with all input events for a Scene.
 *
 * @since 1.0.0
**/
class InputManager
{
	/**
	 * The Game instance that owns the Input Manager.
	 * A Game only maintains on instance of the Input Manager at any time.
	 *
	 * @since 1.0.0
	**/
	public var game(default, null):Game;

	/**
	 * A reference to the global Game Scale Manager.
	 * Used for all bounds checks and pointer scaling.
	 *
	 * @since 1.0.0
	**/
	public var scaleManager:ScaleManager;

	/**
	 * The Canvas that is used for all DOM event input listeners.
	 *
	 * @since 1.0.0
	**/
	public var canvas:HTMLCanvasElement;

	/**
	 * The Game Configuration object, as set during the game boot.
	 *
	 * @since 1.0.0
	**/
	public var config:Config;

	/**
	 * If set, the Input Manager will run its update loop every frame.
	 *
	 * @since 1.0.0
	**/
	public var enabled:Bool = true;

	/**
	 * The Event Emitter instance that the Input Manager uses to emit events from.
	 *
	 * @since 1.0.0
	**/
	public var events:EventEmitter = new EventEmitter();

	/**
	 * Are any mouse or touch pointers currently over the game canvas?
	 * This is updated automatically by the canvas over and out handlers.
	 *
	 * @since 1.0.0
	**/
	public var isOver(default, null):Bool = true;

	/**
	 * The default CSS cursor to be used when interacting with your game.
	 *
	 * See the `setDefaultCursor` method for more details.
	 *
	 * @since 1.0.0
	**/
	public var defaultCursor:String = '';

	/**
	 * A reference to the Keyboard Manager class, if enabled via the `input.keyboard` Game Config property.
	 *
	 * @since 1.0.0
	**/
	public var keyboard:Null<KeyboardManager>;

	/**
	 * A reference to the Mouse Manager class, if enabled via the `input.mouse` Game Config property.
	 *
	 * @since 1.0.0
	**/
	public var mouse:Null<MouseManager>;

	/**
	 * A reference to the Touch Manager class, if enabled via the `input.touch` Game Config property.
	 *
	 * @since 1.0.0
	**/
	public var touch:TouchManager;

	/**
	 * An array of Pointers that have been added to the game.
	 * The first entry is reserved for the Mouse Pointer, the rest are Touch Pointers.
	 *
	 * By default there is 1 touch pointer enabled. If you need more use the `addPointer` method to start them,
	 * or set the `input.activePointers` property in the Game Config.
	 *
	 * @since 1.0.0
	**/
	public var pointers:Array<Pointer> = [];

	/**
	 * The number of touch objects activated and being processed each update.
	 *
	 * You can change this by either calling `addPointer` at run-time, or by
	 * setting the `input.activePointers` property in the Game Config.
	 *
	 * @since 1.0.0
	**/
	public var pointersTotal(default, null):Int;

	/**
	 * The mouse has its own unique Pointer object, which you can reference directly if making a _desktop specific game_.
	 * If you are supporting both desktop and touch devices then do not use this property, instead use `activePointer`
	 * which will always map to the most recently interacted pointer.
	 *
	 * @since 1.0.0
	**/
	public var mousePointer:Null<Pointer>;

	/**
	 * The most recently active Pointer object.
	 *
	 * If you've only 1 Pointer in your game then this will accurately be either the first finger touched, or the mouse.
	 *
	 * If your game doesn't need to support multi-touch then you can safely use this property in all of your game
	 * code and it will adapt to be either the mouse or the touch, based on device.
	 *
	 * @since 1.0.0
	**/
	public var activePointer:Pointer;

	/**
	 * If the top-most Scene in the Scene List receives an input it will stop input from
	 * propagating any lower down the scene list, i.e. if you have a UI Scene at the top
	 * and click something on it, that click will not then be passed down to any other
	 * Scene below. Disable this to have input events passed through all Scenes, all the time.
	 *
	 * @since 1.0.0
	**/
	public var globalTopOnly:Bool = true;

	/**
	 * The time this Input Manager was last updated.
	 * This value is populated by the Game Step each frame.
	 *
	 * @since 1.0.0
	**/
	public var time(default, null):Float = 0;

	/**
	 * A re-cycled point-like object to store hit test values in.
	 *
	 * @since 1.0.0
	**/
	private var _tempPoint:Vector2 = {x: 0, y: 0};

	/**
	 * A re-cycled array to store hit results in.
	 *
	 * @since 1.0.0
	**/
	public var _tempHitTest:Array<GameObject> = [];

	/**
	 * A re-cycled matrix used in hit test calculations.
	 *
	 * @since 1.0.0
	**/
	private var _tempMatrix:TransformMatrix = new TransformMatrix();

	/**
	 * A re-cycled matrix used in hit test calculations.
	 *
	 * @since 1.0.0
	**/
	private var _tempMatrix2:TransformMatrix = new TransformMatrix();

	/**
	 * An internal private var that records Scenes aborting event processing.
	 *
	 * @since 1.0.0
	**/
	private var _tempSkip:Bool;

	@:noCompletion
	public var useQueue:Bool = false;

	/**
	 * An internal private array that avoids needing to create a new array on every DOM mouse event.
	 *
	 * @since 1.0.0
	**/
	private var mousePointerContainer:Array<Pointer>;

	public function new(game:Game, config:Config)
	{
		this.game = game;

		this.config = config;

		this.keyboard = (config.inputKeyboard) ? new KeyboardManager(this) : null;

		this.mouse = (config.inputMouse) ? new MouseManager(this) : null;

		this.touch = (config.inputTouch) ? new TouchManager(this) : null;

		this.pointersTotal = config.inputActivePointers;

		if (config.inputTouch && this.pointersTotal == 1)
		{
			this.pointersTotal = 2;
		}

		for (i in 0...pointersTotal)
		{
			var pointer = new Pointer(this, i);

			pointer.smoothFactor = config.inputSmoothFactor;

			this.pointers.push(pointer);
		}

		this.mousePointer = config.inputMouse ? this.pointers[0] : null;

		this.activePointer = this.pointers[0];

		this.mousePointerContainer = [this.mousePointer];

		game.events.once(GameEvents.BOOT, this.boot, this);
	}

	/**
	 * The Boot handler is called by Phaser.Game when it first starts up.
	 * The renderer is available by now.
	 *
	 * @since 1.0.0
	**/
	private function boot():Void
	{
		this.canvas = this.game.canvas;

		this.scaleManager = this.game.scale;

		events.emit(InputEvents.MANAGER_BOOT);

		game.events.on(GameEvents.PRE_RENDER, this.preRender, this);

		game.events.once(GameEvents.DESTROY, this.destroy, this);
	}

	/**
	 * Internal canvas state change, called automatically by the Mouse Manager.
	 *
	 * @since 1.0.0
	 *
	 * @param event - The DOM Event.
	**/
	@:allow(phaserHaxe)
	private function setCanvasOver(event:WebEvent):Void
	{
		this.isOver = true;
		this.events.emit(InputEvents.GAME_OVER, [event]);
	}

	/**
	 * Internal canvas state change, called automatically by the Mouse Manager.
	 *
	 * @fires Phaser.Input.Events#GAME_OUT
	 * @since 1.0.0
	 *
	 * @param event - The DOM Event.
	**/
	@:allow(phaserHaxe)
	private function setCanvasOut(event:WebEvent):Void
	{
		isOver = false;
		events.emit(InputEvents.GAME_OUT, [event]);
	}

	/**
	 * Internal update, called automatically by the Game Step right at the start.
	 *
	 * @since 1.0.0
	**/
	private function preRender():Void
	{
		var time = this.game.loop.now;
		var delta = this.game.loop.delta;
		var scenes:Array<Scene> = this.game.scene.getScenes(true, true);

		this.time = time;

		this.events.emit(InputEvents.MANAGER_UPDATE);

		for (i in 0...scenes.length)
		{
			var scene = scenes[i];

			if (scene.sys.input && scene.sys.input.updatePoll(time, delta) && this.globalTopOnly)
			{
				//  If the Scene returns true, it means it captured some input that no other Scene should get, so we bail out
				return;
			}
		}
	}

	/**
	 * Tells the Input system to set a custom cursor.
	 *
	 * This cursor will be the default cursor used when interacting with the game canvas.
	 *
	 * If an Interactive Object also sets a custom cursor, this is the cursor that is reset after its use.
	 *
	 * Any valid CSS cursor value is allowed, including paths to image files, i.e.:
	 *
	 * ```haxe
	 *  input.setDefaultCursor('url(assets/cursors/sword.cur), pointer');
	 * ```
	 *
	 * Please read about the differences between browsers when it comes to the file formats and sizes they support:
	 *
	 * https://developer.mozilla.org/en-US/docs/Web/CSS/cursor
	 * https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_User_Interface/Using_URL_values_for_the_cursor_property
	 *
	 * It's up to you to pick a suitable cursor format that works across the range of browsers you need to support.
	 *
	 * @since 1.0.0
	 *
	 * @param cursor - The CSS to be used when setting the default cursor.
	**/
	private function setDefaultCursor(cursor:String):Void
	{
		defaultCursor = cursor;

		if (canvas.style.cursor != cursor)
		{
			canvas.style.cursor = cursor;
		}
	}

	/**
	 * Called by the InputPlugin when processing over and out events.
	 *
	 * Tells the Input Manager to set a custom cursor during its postUpdate step.
	 *
	 * https://developer.mozilla.org/en-US/docs/Web/CSS/cursor
	 *
	 * @since 1.0.0
	 *
	 * @param interactiveObject - The Interactive Object that called this method.
	**/
	private function setCursor(interactiveObject:InteractiveObject):Void
	{
		if (interactiveObject.cursor != null)
		{
			canvas.style.cursor = interactiveObject.cursor;
		}
	}

	/**
	 * Called by the InputPlugin when processing over and out events.
	 *
	 * Tells the Input Manager to clear the hand cursor, if set, during its postUpdate step.
	 *
	 * @since 1.0.0
	 *
	 * @param interactiveObject - The Interactive Object that called this method.
	**/
	private function resetCursor(interactiveObject:InteractiveObject):Void
	{
		if (interactiveObject.cursor != null && canvas != null)
		{
			canvas.style.cursor = defaultCursor;
		}
	}

	/**
	 * Adds new Pointer objects to the Input Manager.
	 *
	 * By default Phaser creates 2 pointer objects: `mousePointer` and `pointer1`.
	 *
	 * You can create more either by calling this method, or by setting the `input.activePointers` property
	 * in the Game Config, up to a maximum of 10 pointers.
	 *
	 * The first 10 pointers are available via the `InputPlugin.pointerX` properties, once they have been added
	 * via this method.
	 *
	 * @since 1.0.0
	 *
	 * @param quantity The number of new Pointers to create. A maximum of 10 is allowed in total.
	 *
	 * @return An array containing all of the new Pointer objects that were created.
	**/
	public function addPointer(quantity:Int = 1):Array<Pointer>
	{
		var output = [];

		if (pointersTotal + quantity > 10)
		{
			quantity = 10 - pointersTotal;
		}

		for (_ in 0...quantity)
		{
			var id = pointers.length;

			var pointer = new Pointer(this, id);

			pointer.smoothFactor = config.inputSmoothFactor;

			pointers.push(pointer);

			pointersTotal++;

			output.push(pointer);
		}

		return output;
	}

	/**
	 * Internal method that gets a list of all the active Input Plugins in the game
	 * and updates each of them in turn, in reverse order (top to bottom), to allow
	 * for DOM top-level event handling simulation.
	 *
	 * @since 1.0.0
	 *
	 * @param type - The type of event to process.
	 * @param pointers - An array of Pointers on which the event occurred.
	**/
	public function updateInputPlugins(type:Int, pointers:Array<Pointer>):Void
	{
		var scenes:Array<Scene> = this.game.scene.getScenes(true, true);

		this._tempSkip = false;

		for (scene in scenes)
		{
			if (scene.sys.input)
			{
				var capture = scene.sys.input.update(type, pointers);

				if ((capture && this.globalTopOnly) || this._tempSkip)
				{
					//  If the Scene returns true, or called stopPropagation, it means it captured some input that no other Scene should get, so we bail out
					return;
				}
			}
		}
	}

	//  event.targetTouches = list of all touches on the TARGET ELEMENT (i.e. game dom element)
	//  event.touches = list of all touches on the ENTIRE DOCUMENT, not just the target element
	//  event.changedTouches = the touches that CHANGED in this event, not the total number of them

	/**
	 * Processes a touch start event, as passed in by the TouchManager.
	 *
	 * @since 1.0.0
	 *
	 * @param event - The native DOM Touch event.
	**/
	private function onTouchStart(event:WebTouchEvent):Void
	{
		// var pointers = this.pointers;
		// var changed = [];

		// for (var c = 0; c < event.changedTouches.length; c++)
		// {
		//     var changedTouch = event.changedTouches[c];

		//     for (var i = 1; i < this.pointersTotal; i++)
		//     {
		//         var pointer = pointers[i];

		//         if (!pointer.active)
		//         {
		//             pointer.touchstart(changedTouch, event);

		//             this.activePointer = pointer;

		//             changed.push(pointer);

		//             break;
		//         }
		//     }
		// }

		// this.updateInputPlugins(CONST.TOUCH_START, changed);
	}

	/**
	 * Processes a touch move event, as passed in by the TouchManager.
	 *
	 * @since 1.0.0
	 *
	 * @param event - The native DOM Touch event.
	**/
	private function onTouchMove(event:WebTouchEvent):Void
	{
		// var pointers = this.pointers;
		// var changed = [];

		// for (var c = 0; c < event.changedTouches.length; c++)
		// {
		//     var changedTouch = event.changedTouches[c];

		//     for (var i = 1; i < this.pointersTotal; i++)
		//     {
		//         var pointer = pointers[i];

		//         if (pointer.active && pointer.identifier === changedTouch.identifier)
		//         {
		//             pointer.touchmove(changedTouch, event);

		//             this.activePointer = pointer;

		//             changed.push(pointer);

		//             break;
		//         }
		//     }
		// }

		// this.updateInputPlugins(CONST.TOUCH_MOVE, changed);
	}

	//  For touch end its a list of the touch points that have been removed from the surface
	//  https://developer.mozilla.org/en-US/docs/DOM/TouchList
	//  event.changedTouches = the touches that CHANGED in this event, not the total number of them

	/**
	 * Processes a touch end event, as passed in by the TouchManager.
	 *
	 * @since 1.0.0
	 *
	 * @param event - The native DOM Touch event.
	**/
	private function onTouchEnd(event:WebTouchEvent):Void
	{
		// var pointers = this.pointers;
		// var changed = [];

		// for (var c = 0; c < event.changedTouches.length; c++)
		// {
		//     var changedTouch = event.changedTouches[c];

		//     for (var i = 1; i < this.pointersTotal; i++)
		//     {
		//         var pointer = pointers[i];

		//         if (pointer.active && pointer.identifier === changedTouch.identifier)
		//         {
		//             pointer.touchend(changedTouch, event);

		//             changed.push(pointer);

		//             break;
		//         }
		//     }
		// }

		// this.updateInputPlugins(CONST.TOUCH_END, changed);
	}

	/**
	 * Processes a touch cancel event, as passed in by the TouchManager.
	 *
	 * @since 1.0.0
	 *
	 * @param event - The native DOM Touch event.
	**/
	private function onTouchCancel(event:WebTouchEvent):Void
	{
		// var pointers = this.pointers;
		// var changed = [];

		// for (var c = 0; c < event.changedTouches.length; c++)
		// {
		//     var changedTouch = event.changedTouches[c];

		//     for (var i = 1; i < this.pointersTotal; i++)
		//     {
		//         var pointer = pointers[i];

		//         if (pointer.active && pointer.identifier === changedTouch.identifier)
		//         {
		//             pointer.touchcancel(changedTouch, event);

		//             changed.push(pointer);

		//             break;
		//         }
		//     }
		// }

		// this.updateInputPlugins(CONST.TOUCH_CANCEL, changed);
	}

	/**
	 * Processes a mouse down event, as passed in by the MouseManager.
	 *
	 * @since 1.0.0
	 *
	 * @param event - The native DOM Mouse event.
	**/
	@:allow(phaserHaxe)
	private function onMouseDown(event:WebMouseEvent):Void
	{
		mousePointer.down(event);

		mousePointer.updateMotion();

		updateInputPlugins(InputConst.MOUSE_DOWN, mousePointerContainer);
	}

	/**
	 * Processes a mouse move event, as passed in by the MouseManager.
	 *
	 * @since 1.0.0
	 *
	 * @param event - The native DOM Mouse event.
	**/
	@:allow(phaserHaxe)
	private function onMouseMove(event:WebMouseEvent)
	{
		mousePointer.move(event);

		mousePointer.updateMotion();

		updateInputPlugins(InputConst.MOUSE_MOVE, mousePointerContainer);
	}

	/**
	 * Processes a mouse up event, as passed in by the MouseManager.
	 *
	 * @since 1.0.0
	 *
	 * @param event - The native DOM Mouse event.
	**/
	@:allow(phaserHaxe)
	private function onMouseUp(event:WebMouseEvent)
	{
		mousePointer.up(event);

		mousePointer.updateMotion();

		updateInputPlugins(InputConst.MOUSE_UP, mousePointerContainer);
	}

	/**
	 * Processes a mouse wheel event, as passed in by the MouseManager.
	 *
	 * @since 1.0.0
	 *
	 * @param event - The native DOM Wheel event.
	**/
	@:allow(phaserHaxe)
	private function onMouseWheel(event:WebWheelEvent)
	{
		mousePointer.wheel(event);

		updateInputPlugins(InputConst.MOUSE_WHEEL, mousePointerContainer);
	}

	/**
	 * Processes a pointer lock change event, as passed in by the MouseManager.
	 *
	 * @since 1.0.0
	 *
	 * @param event - The native DOM Mouse event.
	**/
	@:allow(phaserHaxe)
	private function onPointerLockChange(event:WebMouseEvent):Void
	{
		var isLocked = mouse.locked;

		mousePointer.locked = isLocked;

		events.emit(InputEvents.POINTERLOCK_CHANGE, [event, isLocked]);
	}

	/**
	 * Checks if the given Game Object should be considered as a candidate for input or not.
	 *
	 * Checks if the Game Object has an input component that is enabled, that it will render,
	 * and finally, if it has a parent, that the parent parent, or any ancestor, is visible or not.
	 *
	 * @since 1.0.0
	 *
	 * @param gameObject - The Game Object to test.
	 * @param camera - The Camera which is being tested against.
	 *
	 * @return `true` if the Game Object should be considered for input, otherwise `false`.
	**/
	private function inputCandidate(gameObject:GameObject, camera:Camera):Bool
	{
		var input = gameObject.input;

		if (input == null || !input.enabled || (!input.alwaysEnabled && !gameObject.willRender(camera)))
		{
			return false;
		}

		var visible = true;
		var parent = gameObject.parentContainer;

		while (parent != null)
		{
			if (!parent.willRender(camera))
			{
				visible = false;
				break;
			}

			parent = parent.parentContainer;
		}

		return visible;
	}

	/**
	 * TODO: output parameter lies about where the array comes from
	 *
	 * Performs a hit test using the given Pointer and camera, against an array of interactive Game Objects.
	 *
	 * The Game Objects are culled against the camera, and then the coordinates are translated into the local camera space
	 * and used to determine if they fall within the remaining Game Objects hit areas or not.
	 *
	 * If nothing is matched an empty array is returned.
	 *
	 * This method is called automatically by InputPlugin.hitTestPointer and doesn't usually need to be invoked directly.
	 *
	 * @since 1.0.0
	 *
	 * @param pointer - The Pointer to test against.
	 * @param gameObjects - An array of interactive Game Objects to check.
	 * @param camera - The Camera which is being tested against.
	 * @param output - An array to store the results in. If not given, a new empty array is created.
	 *
	 * @return An array of the Game Objects that were hit during this hit test.
	**/
	public function hitTest(pointer:Pointer, gameObjects:Array<GameObject>,
			camera:Camera, ?output:Array<GameObject>):Array<GameObject>
	{
		// if (output === undefined) { output = this._tempHitTest; }

		if (output == null)
		{
			output = this._tempHitTest;
		}

		var tempPoint = this._tempPoint;

		var csx = camera.scrollX;
		var csy = camera.scrollY;

		output.resize(0);

		var x = pointer.x;
		var y = pointer.y;

		if (camera.resolution != 1)
		{
			x += camera.x;
			y += camera.y;
		}

		//  Stores the world point inside of tempPoint
		camera.getWorldPoint(x, y, tempPoint);

		pointer.worldX = tempPoint.x;
		pointer.worldY = tempPoint.y;

		var point:Vector2 = {x: 0, y: 0};

		var matrix = this._tempMatrix;
		var parentMatrix = this._tempMatrix2;

		for (i in 0...gameObjects.length)
		{
			var gameObject = gameObjects[i];

			if (!Std.is(gameObject, ITransform))
			{
				continue;
			}

			var gameObjectTransform = (cast gameObject : ITransform);

			var scrollFactorX;
			var scrollFactorY;

			if (Std.is(gameObject, IScrollFactor))
			{
				var gameObject = (cast gameObject : IScrollFactor);
				scrollFactorX = gameObject.scrollFactorX;
				scrollFactorY = gameObject.scrollFactorY;
			}
			else
			{
				scrollFactorX = 1;
				scrollFactorY = 1;
			}

			//  Checks if the Game Object can receive input (isn't being ignored by the camera, invisible, etc)
			//  and also checks all of its parents, if any
			if (!this.inputCandidate(gameObject, camera))
			{
				continue;
			}

			var px = tempPoint.x + (csx * scrollFactorX) - csx;
			var py = tempPoint.y + (csy * scrollFactorY) - csy;

			if (gameObject.parentContainer != null && Std.is(gameObject, ITransform))
			{
				gameObjectTransform.getWorldTransformMatrix(matrix, parentMatrix);

				matrix.applyInverse(px, py, point);
			}
			else
			{
				MathUtility.transformXY(px, py, gameObjectTransform.x,
					gameObjectTransform.y, gameObjectTransform.rotation,
					gameObjectTransform.scaleX, gameObjectTransform.scaleY, point);
			}

			if (pointWithinHitArea(gameObject, point.x, point.y))
			{
				output.push(gameObject);
			}
		}

		return output;
	}

	/**
	 * Checks if the given x and y coordinate are within the hit area of the Game Object.
	 *
	 * This method assumes that the coordinate values have already been translated into the space of the Game Object.
	 *
	 * If the coordinates are within the hit area they are set into the Game Objects Input `localX` and `localY` properties.
	 *
	 * @since 1.0.0
	 *
	 * @param gameObject - The interactive Game Object to check against.
	 * @param x - The translated x coordinate for the hit test.
	 * @param y - The translated y coordinate for the hit test.
	 *
	 * @return `true` if the coordinates were inside the Game Objects hit area, otherwise `false`.
	**/
	public function pointWithinHitArea(gameObject:GameObject, x:Float, y:Float):Bool
	{
		//  Normalize the origin
		if (Std.is(gameObject, IOrigin))
		{
			var gameObject = (cast gameObject : IOrigin);
			x += gameObject.displayOriginX;
			y += gameObject.displayOriginY;
		}
		var input = gameObject.input;

		if (input != null && input.hitAreaCallback(input.hitArea, x, y, gameObject))
		{
			input.localX = x;
			input.localY = y;

			return true;
		}
		else
		{
			return false;
		}
	}

	/**
	 * Checks if the given x and y coordinate are within the hit area of the Interactive Object.
	 *
	 * This method assumes that the coordinate values have already been translated into the space of the Interactive Object.
	 *
	 * If the coordinates are within the hit area they are set into the Interactive Objects Input `localX` and `localY` properties.
	 *
	 * @since 1.0.0
	 *
	 * @param object - The Interactive Object to check against.
	 * @param x - The translated x coordinate for the hit test.
	 * @param y - The translated y coordinate for the hit test.
	 *
	 * @return `true` if the coordinates were inside the Game Objects hit area, otherwise `false`.
	**/
	public function pointWithinInteractiveObject(object:InteractiveObject, x:Float,
			y:Float):Bool
	{
		if (object.hitArea == null)
		{
			return false;
		}
		//  Normalize the origin
		if (Std.is(object.gameObject, IOrigin))
		{
			var gameObject = (cast object.gameObject : IOrigin);
			x += gameObject.displayOriginX;
			y += gameObject.displayOriginY;
		}

		object.localX = x;
		object.localY = y;

		return object.hitAreaCallback(object.hitArea, x, y, object.gameObject);
	}

	/**
	 * Transforms the pageX and pageY values of a Pointer into the scaled coordinate space of the Input Manager.
	 *
	 * @since 1.0.0
	 *
	 * @param pointer - The Pointer to transform the values for.
	 * @param pageX - The Page X value.
	 * @param pageY - The Page Y value.
	 * @param wasMove - Are we transforming the Pointer from a move event, or an up / down event?
	**/
	public function transformPointer(pointer:Pointer, pageX:Float, pageY:Float,
			wasMove:Bool):Void
	{
		var p0 = pointer.position;
		var p1 = pointer.prevPosition;

		//  Store previous position
		p1.x = p0.x;
		p1.y = p0.y;

		//  Translate coordinates
		var x = this.scaleManager.transformX(pageX);
		var y = this.scaleManager.transformY(pageY);

		var a = pointer.smoothFactor;

		if (!wasMove || a == 0)
		{
			//  Set immediately
			p0.x = x;
			p0.y = y;
		}
		else
		{
			//  Apply smoothing
			p0.x = x * a + p1.x * (1 - a);
			p0.y = y * a + p1.y * (1 - a);
		}
	}

	/**
	 * Destroys the Input Manager and all of its systems.
	 *
	 * There is no way to recover from doing this.
	 *
	 * @since 1.0.0
	**/
	public function destroy()
	{
		this.events.removeAllListeners();

		this.game.events.off(GameEvents.PRE_RENDER);

		if (this.keyboard != null)
		{
			this.keyboard.destroy();
		}

		if (this.mouse != null)
		{
			this.mouse.destroy();
		}

		if (this.touch != null)
		{
			this.touch.destroy();
		}

		for (i in 0...pointers.length)
		{
			this.pointers[i].destroy();
		}

		this.pointers = [];
		this._tempHitTest = [];
		this._tempMatrix.destroy();
		this.canvas = null;
		this.game = null;
	}
}
