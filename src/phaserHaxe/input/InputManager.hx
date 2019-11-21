package phaserHaxe.input;

import phaserHaxe.math.Vector2;
import phaserHaxe.input.mouse.MouseManager;
import phaserHaxe.input.keyboard.KeyboardManager;
import phaserHaxe.input.touch.TouchManager;
import phaserHaxe.scale.ScaleManager;
import phaserHaxe.gameobjects.components.TransformMatrix;
import js.html.CanvasElement as HTMLCanvasElement;

@:forward
abstract InputManager(Dynamic) {}

class InputManager2
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
	 * @name Phaser.Input.InputManager#scaleManager
	 * @type {Phaser.Scale.ScaleManager}
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
	 * @name Phaser.Input.InputManager#mouse
	 * @type {?Phaser.Input.Mouse.MouseManager}
	 * @since 3.0.0
	 */
	public var mouse:MouseManager;

	/**
	 * A reference to the Touch Manager class, if enabled via the `input.touch` Game Config property.
	 *
	 * @name Phaser.Input.InputManager#touch
	 * @type {Phaser.Input.Touch.TouchManager}
	 * @since 3.0.0
	 */
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
	public var _tempHitTest:Array<Dynamic> = [];

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

	/**
	 * An internal private array that avoids needing to create a new array on every DOM mouse event.
	 *
	 * @since 1.0.0
	**/
	private var mousePointerContainer:Array<Pointer>;
}
