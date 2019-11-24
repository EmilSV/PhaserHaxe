package phaserHaxe.input;

import js.html.WheelEvent;
import phaserHaxe.cameras.scene2D.Camera;
import phaserHaxe.math.Vector2;
import phaserHaxe.math.Interpolation.smoothStepInterpolation;
import phaserHaxe.math.Angle.between as angleBetween;
import phaserHaxe.math.Fuzzy.equal as fuzzyEqual;
import phaserHaxe.math.Distance.distanceBetween as distanceBetween;
import js.html.Touch;
import js.html.TouchEvent;
import js.html.MouseEvent;
import js.html.UIEvent;
import js.Syntax;

/**
 * @classdesc
 * A Pointer object encapsulates both mouse and touch input within Phaser.
 *
 * By default, Phaser will create 2 pointers for your game to use. If you require more, i.e. for a multi-touch
 * game, then use the `InputPlugin.addPointer` method to do so, rather than instantiating this class directly,
 * otherwise it won't be managed by the input system.
 *
 * You can reference the current active pointer via `InputPlugin.activePointer`. You can also use the properties
 * `InputPlugin.pointer1` through to `pointer10`, for each pointer you have enabled in your game.
 *
 * The properties of this object are set by the Input Plugin during processing. This object is then sent in all
 * input related events that the Input Plugin emits, so you can reference properties from it directly in your
 * callbacks.
 *
 * @since 1.0.0
 *
 * @param {Phaser.Input.InputManager} manager - A reference to the Input Manager.
 * @param {integer} id - The internal ID of this Pointer.
**/
class Pointer
{
	/**
	 * A reference to the Input Manager.
	 *
	 * @since 1.0.0
	**/
	public var manager:InputManager = null;

	/**
	 * The internal ID of this Pointer.
	 *
	 * @since 1.0.0
	**/
	public var id(default, null):Int = 0;

	/**
	 * The most recent native DOM Event this Pointer has processed.
	 *
	 * @since 1.0.0
	**/
	public var event:UIEvent;

	/**
	 * The DOM element the Pointer was pressed down on, taken from the DOM event.
	 * In a default set-up this will be the Canvas that Phaser is rendering to, or the Window element.
	 *
	 * @since 1.0.0
	**/
	public var downElement(default, null):Any;

	/**
	 * The DOM element the Pointer was released on, taken from the DOM event.
	 * In a default set-up this will be the Canvas that Phaser is rendering to, or the Window element.
	 *
	 * @since 1.0.0
	**/
	public var upElement:Any;

	/**
	 * The camera the Pointer interacted with during its last update.
	 *
	 * A Pointer can only ever interact with one camera at once, which will be the top-most camera
	 * in the list should multiple cameras be positioned on-top of each other.
	 *
	 * @since 1.0.0
	**/
	public var camera:Camera = null;

	/**
	 * A read-only property that indicates which button was pressed, or released, on the pointer
	 * during the most recent event. It is only set during `up` and `down` events.
	 *
	 * On Touch devices the value is always 0.
	 *
	 * Users may change the configuration of buttons on their pointing device so that if an event's button property
	 * is zero, it may not have been caused by the button that is physically left–most on the pointing device;
	 * however, it should behave as if the left button was clicked in the standard button layout.
	 *
	 * @since 1.0.0
	**/
	public var button(default, null):Int = 0;

	/**
	 * 0: No button or un-initialized
	 * 1: Left button
	 * 2: Right button
	 * 4: Wheel button or middle button
	 * 8: 4th button (typically the "Browser Back" button)
	 * 16: 5th button (typically the "Browser Forward" button)
	 *
	 * For a mouse configured for left-handed use, the button actions are reversed.
	 * In this case, the values are read from right to left.
	 *
	 * @since 1.0.0
	**/
	public var buttons:Int = 0;

	/**
	 * The position of the Pointer in screen space.
	 *
	 * @since 1.0.0
	**/
	public var position(default, null):Vector2 = new Vector2();

	/**
	 * The previous position of the Pointer in screen space.
	 *
	 * The old x and y values are stored in here during the InputManager.transformPointer call.
	 *
	 * Use the properties `velocity`, `angle` and `distance` to create your own gesture recognition.
	 *
	 * @since 1.0.0
	**/
	public var prevPosition(default, null) = new Vector2();

	/**
	 * An internal vector used for calculations of the pointer speed and angle.
	 *
	 * @since 1.0.0
	**/
	private var midPoint = new Vector2(-1, -1);

	/**
	 * The current velocity of the Pointer, based on its current and previous positions.
	 *
	 * This value is smoothed out each frame, according to the `motionFactor` property.
	 *
	 * This property is updated whenever the Pointer moves, regardless of any button states. In other words,
	 * it changes based on movement alone - a button doesn't have to be pressed first.
	 *
	 * @since 1.0.0
	**/
	public var velocity(default, null) = new Vector2();

	/**
	 * The current angle the Pointer is moving, in radians, based on its previous and current position.
	 *
	 * The angle is based on the old position facing to the current position.
	 *
	 * This property is updated whenever the Pointer moves, regardless of any button states. In other words,
	 * it changes based on movement alone - a button doesn't have to be pressed first.
	 *
	 * @since 1.0.0
	**/
	public var angle(default, null):Float = 0;

	/**
	 * The distance the Pointer has moved, based on its previous and current position.
	 *
	 * This value is smoothed out each frame, according to the `motionFactor` property.
	 *
	 * This property is updated whenever the Pointer moves, regardless of any button states. In other words,
	 * it changes based on movement alone - a button doesn't have to be pressed first.
	 *
	 * If you need the total distance travelled since the primary buttons was pressed down,
	 * then use the `Pointer.getDistance` method.
	 *
	 * @since 1.0.0
	**/
	public var distance(default, null):Float = 0;

	/**
	 * The smoothing factor to apply to the Pointer position.
	 *
	 * Due to their nature, pointer positions are inherently noisy. While this is fine for lots of games, if you need cleaner positions
	 * then you can set this value to apply an automatic smoothing to the positions as they are recorded.
	 *
	 * The default value of zero means 'no smoothing'.
	 * Set to a small value, such as 0.2, to apply an average level of smoothing between positions. You can do this by changing this
	 * value directly, or by setting the `input.smoothFactor` property in the Game Config.
	 *
	 * Positions are only smoothed when the pointer moves. If the primary button on this Pointer enters an Up or Down state, then the position
	 * is always precise, and not smoothed.
	 *
	 * @since 1.0.0
	**/
	public var smoothFactor:Float = 0;

	/**
	 * The factor applied to the motion smoothing each frame.
	 *
	 * This value is passed to the Smooth Step Interpolation that is used to calculate the velocity,
	 * angle and distance of the Pointer. It's applied every frame, until the midPoint reaches the current
	 * position of the Pointer. 0.2 provides a good average but can be increased if you need a
	 * quicker update and are working in a high performance environment. Never set this value to
	 * zero.
	 *
	 * @since 1.0.0
	**/
	public var motionFactor:Float = 0.2;

	/**
	 * The x position of this Pointer, translated into the coordinate space of the most recent Camera it interacted with.
	 *
	 * If you wish to use this value _outside_ of an input event handler then you should update it first by calling
	 * the `Pointer.updateWorldPoint` method.
	 *
	 * @since 1.0.0
	**/
	public var worldX:Float = 0;

	/**
	 * The y position of this Pointer, translated into the coordinate space of the most recent Camera it interacted with.
	 *
	 * If you wish to use this value _outside_ of an input event handler then you should update it first by calling
	 * the `Pointer.updateWorldPoint` method.
	 *
	 * @since 1.0.0
	**/
	public var worldY:Float = 0;

	/**
	 * Time when this Pointer was most recently moved (regardless of the state of its buttons, if any)
	 *
	 * @since 1.0.0
	**/
	public var moveTime:Float = 0;

	/**
	 * X coordinate of the Pointer when Button 1 (left button), or Touch, was pressed, used for dragging objects.
	 *
	 * @since 1.0.0
	**/
	public var downX:Float = 0;

	/**
	 * Y coordinate of the Pointer when Button 1 (left button), or Touch, was pressed, used for dragging objects.
	 *
	 * @since 1.0.0
	**/
	public var downY:Float = 0;

	/**
	 * Time when Button 1 (left button), or Touch, was pressed, used for dragging objects.
	 *
	 * @since 1.0.0
	**/
	public var downTime:Float = 0;

	/**
	 * X coordinate of the Pointer when Button 1 (left button), or Touch, was released, used for dragging objects.
	 *
	 * @since 1.0.0
	**/
	public var upX:Float = 0;

	/**
	 * Y coordinate of the Pointer when Button 1 (left button), or Touch, was released, used for dragging objects.
	 *
	 * @since 1.0.0
	**/
	public var upY:Float = 0;

	/**
	 * Time when Button 1 (left button), or Touch, was released, used for dragging objects.
	 *
	 * @since 1.0.0
	**/
	public var upTime:Float = 0;

	/**
	 * Is the primary button down? (usually button 0, the left mouse button)
	 *
	 * @since 1.0.0
	**/
	public var primaryDown:Bool = false;

	/**
	 * Is _any_ button on this pointer considered as being down?
	 *
	 * @since 1.0.0
	**/
	public var isDown:Bool = false;

	/**
	 * Did the previous input event come from a Touch input (true) or Mouse? (false)
	 *
	 * @since 1.0.0
	**/
	public var wasTouch:Bool = false;

	/**
	 * Did this Pointer get canceled by a touchcancel event?
	 *
	 * Note: "canceled" is the American-English spelling of "cancelled". Please don't submit PRs correcting it!
	 *
	 * @since 1.0.0
	**/
	public var wasCanceled:Bool = false;

	/**
	 * If the mouse is locked, the horizontal relative movement of the Pointer in pixels since last frame.
	 *
	 * @since 1.0.0
	**/
	public var movementX:Float = 0;

	/**
	 * If the mouse is locked, the vertical relative movement of the Pointer in pixels since last frame.
	 *
	 * @since 1.0.0
	**/
	public var movementY:Float = 0;

	/**
	 * The identifier property of the Pointer as set by the DOM event when this Pointer is started.
	 *
	 * @since 1.0.0
	**/
	public var identifier:Float = 0;

	/**
	 * The pointerId property of the Pointer as set by the DOM event when this Pointer is started.
	 * The browser can and will recycle this value.
	 *
	 * @since 1.0.0
	**/
	public var pointerId:Float = null;

	/**
	 * An active Pointer is one that is currently pressed down on the display.
	 * A Mouse is always considered as active.
	 *
	 * @since 1.0.0
	**/
	public var active:Bool = false;

	/**
	 * Is this pointer Pointer Locked?
	 *
	 * Only a mouse pointer can be locked and it only becomes locked when requested via
	 * the browsers Pointer Lock API.
	 *
	 * You can request this by calling the `public var input.mouse.requestPointerLock()` method from
	 * a `pointerdown` or `pointerup` event handler.
	 *
	 * @since 1.0.0
	**/
	@:allow(phaserHaxe)
	public var locked(default, null):Bool = false;

	/**
	 * The horizontal scroll amount that occurred due to the user moving a mouse wheel or similar input device.
	 *
	 * @since 1.0.0
	**/
	public var deltaX:Float = 0;

	/**
	 * The vertical scroll amount that occurred due to the user moving a mouse wheel or similar input device.
	 * This value will typically be less than 0 if the user scrolls up and greater than zero if scrolling down.
	 *
	 * @since 1.0.0
	**/
	public var deltaY:Float = 0;

	/**
	 * The z-axis scroll amount that occurred due to the user moving a mouse wheel or similar input device.
	 *
	 * @since 1.0.0
	**/
	public var deltaZ:Float = 0;

	private var target:Dynamic;

	/**
	 * The x position of this Pointer.
	 * The value is in screen space.
	 * See `worldX` to get a camera converted position.
	 *
	 * @since 1.0.0
	**/
	public var x(get, set):Float;

	/**
	 * The y position of this Pointer.
	 * The value is in screen space.
	 * See `worldY` to get a camera converted position.
	 *
	 * @since 1.0.0
	**/
	public var y(get, set):Float;

	/**
	 * @param manager - A reference to the Input Manager.
	 * @param id - The internal ID of this Pointer.
	**/
	public function new(manager:InputManager, id:Int)
	{
		this.manager = manager;
		this.id = id;
		this.active = id == 0;
	}

	private inline function get_x():Float
	{
		return this.position.x;
	}

	private inline function set_x(value):Float
	{
		return this.position.x = value;
	}

	private inline function get_y():Float
	{
		return this.position.y;
	}

	private inline function set_y(value:Float):Float
	{
		return this.position.y = value;
	}

	/**
	 * Takes a Camera and updates this Pointer's `worldX` and `worldY` values so they are
	 * the result of a translation through the given Camera.
	 *
	 * Note that the values will be automatically replaced the moment the Pointer is
	 * updated by an input event, such as a mouse move, so should be used immediately.
	 *
	 * @since 1.0.0
	 *
	 * @param camera - The Camera which is being tested against.
	 *
	 * @return This Pointer object.
	**/
	public function updateWorldPoint(camera:Camera):Pointer
	{
		var x = this.x;
		var y = this.y;

		if (camera.resolution != 1)
		{
			x += camera.x;
			y += camera.y;
		}

		//  Stores the world point inside of tempPoint
		var temp = camera.getWorldPoint(x, y);

		worldX = temp.x;
		worldY = temp.y;

		return this;
	}

	/**
	 * Takes a Camera and returns a Vector2 containing the translated position of this Pointer
	 * within that Camera. This can be used to convert this Pointers position into camera space.
	 *
	 * @since 1.0.0
	 *
	 * @param camera - The Camera to use for the translation.
	 * @param output - A Vector2-like object in which to store the translated position.
	 *
	 * @return A Vector2 containing the translated coordinates of this Pointer, based on the given camera.
	**/
	public function positionToCamera(camera:Camera, ?output:Vector2):Vector2
	{
		return camera.getWorldPoint(this.x, this.y, output);
	}

	/**
	 * Calculates the motion of this Pointer, including its velocity and angle of movement.
	 * This method is called automatically each frame by the Input Manager.
	 *
	 * @since 1.0.0
	**/
	@:allow(phaserHaxe)
	private function updateMotion():Void
	{
		var cx = position.x;
		var cy = position.y;

		var mx = midPoint.x;
		var my = midPoint.y;

		if (cx == mx && cy == my)
		{
			//  Nothing to do here
			return;
		}

		//  Moving towards our goal ...
		var vx = smoothStepInterpolation(motionFactor, mx, cx);
		var vy = smoothStepInterpolation(motionFactor, my, cy);

		if (fuzzyEqual(vx, cx, 0.1))
		{
			vx = cx;
		}

		if (fuzzyEqual(vy, cy, 0.1))
		{
			vy = cy;
		}

		midPoint.set(vx, vy);

		var dx = cx - vx;
		var dy = cy - vy;

		velocity.set(dx, dy);

		angle = angleBetween(vx, vy, cx, cy);

		distance = Math.sqrt(dx * dx + dy * dy);
	}

	/**
	 * Internal method to handle a Mouse Up Event.
	 *
	 * @since 1.0.0
	 *
	 * @param event - The Mouse Event to process.
	**/
	@:allow(phaserHaxe)
	private function up(event:MouseEvent):Void
	{
		if (Syntax.code("'buttons' in {0}", event))
		{
			this.buttons = event.buttons;
		}

		this.event = event;

		button = event.button;

		upElement = event.target;

		//  Sets the local x/y properties
		manager.transformPointer(this, event.pageX, event.pageY, false);

		//  0: Main button pressed, usually the left button or the un-initialized state
		if (event.button == 0)
		{
			primaryDown = false;
			upX = x;
			upY = y;
			upTime = event.timeStamp;
		}

		isDown = false;

		wasTouch = false;
	}

	/**
	 * Internal method to handle a Mouse Down Event.
	 *
	 * @since 1.0.0
	 *
	 * @param event - The Mouse Event to process.
	**/
	@:allow(phaserHaxe)
	private function down(event:MouseEvent):Void
	{
		if (Syntax.code("'buttons' in {0}", event))
		{
			this.buttons = event.buttons;
		}

		this.event = event;

		button = event.button;

		downElement = event.target;

		//  Sets the local x/y properties
		manager.transformPointer(this, event.pageX, event.pageY, false);

		//  0: Main button pressed, usually the left button or the un-initialized state
		if (event.button == 0)
		{
			primaryDown = true;
			downX = x;
			downY = y;
			downTime = event.timeStamp;
		}

		isDown = true;

		wasTouch = false;
	}

	/**
	 * Internal method to handle a Mouse Move Event.
	 *
	 * @since 1.0.0
	 *
	 * @param event - The Mouse Event to process.
	**/
	@:allow(phaserHaxe)
	private function move(event:MouseEvent):Void
	{
		if (Syntax.code("'buttons' in {0}", event))
		{
			this.buttons = event.buttons;
		}

		this.event = event;

		//  Sets the local x/y properties
		manager.transformPointer(this, event.pageX, event.pageY, true);

		if (locked)
		{
			//  Multiple DOM events may occur within one frame, but only one Phaser event will fire
			this.movementX = Syntax.code("{0}.movementX || {0}.mozMovementX || {0}.webkitMovementX || 0", event);
			this.movementY = Syntax.code("{0}.movementY || {0}.mozMovementY || {0}.webkitMovementY || 0", event);
		}

		moveTime = event.timeStamp;

		wasTouch = false;
	}

	/**
	 * Internal method to handle a Mouse Wheel Event.
	 *
	 * @since 1.0.0
	 *
	 * @param event - The Wheel Event to process.
	**/
	@:allow(phaserHaxe)
	private function wheel(event:WheelEvent):Void
	{
		if (Syntax.code("'buttons' in {0}", event))
		{
			this.buttons = event.buttons;
		}

		this.event = event;

		//  Sets the local x/y properties
		manager.transformPointer(this, event.pageX, event.pageY, false);

		deltaX = event.deltaX;
		deltaY = event.deltaY;
		deltaZ = event.deltaZ;

		wasTouch = false;
	}

	/**
	 * Internal method to handle a Touch Start Event.
	 *
	 * @since 1.0.0
	 *
	 * @param touch - The Changed Touch from the Touch Event.
	 * @param event - The full Touch Event.
	**/
	private function touchStart(touch:Touch, event:TouchEvent):Void
	{
		if (Syntax.field(touch, "pointerId"))
		{
			pointerId = (touch : Dynamic).pointerId;
		}

		identifier = touch.identifier;
		target = touch.target;
		active = true;

		buttons = 1;

		this.event = event;

		downElement = touch.target;

		//  Sets the local x/y properties
		manager.transformPointer(this, touch.pageX, touch.pageY, false);

		primaryDown = true;
		downX = this.x;
		downY = this.y;
		downTime = event.timeStamp;

		isDown = true;

		wasTouch = true;
		wasCanceled = false;

		updateMotion();
	}

	/**
	 * Internal method to handle a Touch Move Event.
	 *
	 * @since 1.0.0
	 *
	 * @param touch - The Changed Touch from the Touch Event.
	 * @param event - The full Touch Event.
	**/
	private function touchMove(touch:Touch, event:TouchEvent):Void
	{
		this.event = event;

		//  Sets the local x/y properties
		manager.transformPointer(this, touch.pageX, touch.pageY, true);

		moveTime = event.timeStamp;

		wasTouch = true;

		updateMotion();
	}

	/**
	 * Internal method to handle a Touch End Event.
	 *
	 * @since 1.0.0
	 *
	 * @param touch - The Changed Touch from the Touch Event.
	 * @param event - The full Touch Event.
	**/
	private function touchEnd(touch:Touch, event:TouchEvent):Void
	{
		buttons = 0;

		this.event = event;

		upElement = touch.target;

		//  Sets the local x/y properties
		manager.transformPointer(this, touch.pageX, touch.pageY, false);

		primaryDown = false;
		upX = x;
		upY = y;
		this.upTime = event.timeStamp;

		isDown = false;

		wasTouch = true;
		wasCanceled = false;

		active = false;

		updateMotion();
	}

	/**
	 * Internal method to handle a Touch Cancel Event.
	 *
	 * @since 1.0.0
	 *
	 * @param touch - The Changed Touch from the Touch Event.
	 * @param event - The full Touch Event.
	**/
	private function touchCancel(touch:Touch, event:TouchEvent):Void
	{
		buttons = 0;

		this.event = event;

		upElement = touch.target;

		//  Sets the local x/y properties
		manager.transformPointer(this, touch.pageX, touch.pageY, false);

		primaryDown = false;
		upX = this.x;
		upY = this.y;
		upTime = event.timeStamp;

		isDown = false;

		wasTouch = true;
		wasCanceled = true;

		active = false;
	}

	/**
	 * Checks to see if any buttons are being held down on this Pointer.
	 *
	 * @since 1.0.0
	 *
	 * @return `true` if no buttons are being held down.
	**/
	public function noButtonDown():Bool
	{
		return buttons == 0;
	}

	/**
	 * Checks to see if the left button is being held down on this Pointer.
	 *
	 * @since 1.0.0
	 *
	 * @return `true` if the left button is being held down.
	**/
	public function leftButtonDown():Bool
	{
		return (this.buttons & 1) != 0;
	}

	/**
	 * Checks to see if the right button is being held down on this Pointer.
	 *
	 * @since 1.0.0
	 *
	 * @return `true` if the right button is being held down.
	 */
	public function rightButtonDown():Bool
	{
		return (this.buttons & 2) != 0;
	}

	/**
	 * Checks to see if the middle button is being held down on this Pointer.
	 *
	 * @since 1.0.0
	 *
	 * @return `true` if the middle button is being held down.
	 */
	public function middleButtonDown():Bool
	{
		return (this.buttons & 4) != 0;
	}

	/**
	 * Checks to see if the back button is being held down on this Pointer.
	 *
	 * @since 1.0.0
	 *
	 * @return {boolean} `true` if the back button is being held down.
	**/
	public function backButtonDown():Bool
	{
		return (buttons & 8) != 0;
	}

	/**
	 * Checks to see if the forward button is being held down on this Pointer.
	 *
	 * @since 1.0.0
	 *
	 * @return `true` if the forward button is being held down.
	**/
	public function forwardButtonDown():Bool
	{
		return (buttons & 16) != 0;
	}

	/**
	 * Checks to see if the left button was just released on this Pointer.
	 *
	 * @since 1.0.0
	 *
	 * @return `true` if the left button was just released.
	**/
	public function leftButtonReleased():Bool
	{
		return button == 0 && !isDown;
	}

	/**
	 * Checks to see if the right button was just released on this Pointer.
	 *
	 * @since 1.0.0
	 *
	 * @return `true` if the right button was just released.
	**/
	public function rightButtonReleased():Bool
	{
		return button == 2 && !isDown;
	}

	/**
	 * Checks to see if the middle button was just released on this Pointer.
	 *
	 * @since 1.0.0
	 *
	 * @return `true` if the middle button was just released.
	**/
	public function middleButtonReleased():Bool
	{
		return button == 1 && !isDown;
	}

	/**
	 * Checks to see if the back button was just released on this Pointer.
	 *
	 * @since 1.0.0
	 *
	 * @return `true` if the back button was just released.
	**/
	public function backButtonReleased():Bool
	{
		return button == 3 && !isDown;
	}

	/**
	 * Checks to see if the forward button was just released on this Pointer.
	 *
	 * @since 1.0.0
	 *
	 * @return `true` if the forward button was just released.
	**/
	public function forwardButtonReleased():Bool
	{
		return button == 4 && !isDown;
	}

	/**
	 * If the Pointer has a button pressed down at the time this method is called, it will return the
	 * distance between the Pointer's `downX` and `downY` values and the current position.
	 *
	 * If no button is held down, it will return the last recorded distance, based on where
	 * the Pointer was when the button was released.
	 *
	 * If you wish to get the distance being travelled currently, based on the velocity of the Pointer,
	 * then see the `Pointer.distance` property.
	 *
	 * @since 1.0.0
	 *
	 * @return The distance the Pointer moved.
	**/
	public function getDistance():Float
	{
		return if (isDown)
		{
			distanceBetween(downX, downY, x, y);
		}
		else
		{
			distanceBetween(downX, downY, upX, upY);
		}
	}

	/**
	 * If the Pointer has a button pressed down at the time this method is called, it will return the
	 * horizontal distance between the Pointer's `downX` and `downY` values and the current position.
	 *
	 * If no button is held down, it will return the last recorded horizontal distance, based on where
	 * the Pointer was when the button was released.
	 *
	 * @since 1.0.0
	 *
	 * @return The horizontal distance the Pointer moved.
	**/
	public function getDistanceX():Float
	{
		return if (isDown)
		{
			Math.abs(downX - x);
		}
		else
		{
			Math.abs(downX - upX);
		}
	}

	/**
	 * If the Pointer has a button pressed down at the time this method is called, it will return the
	 * vertical distance between the Pointer's `downX` and `downY` values and the current position.
	 *
	 * If no button is held down, it will return the last recorded vertical distance, based on where
	 * the Pointer was when the button was released.
	 *
	 * @since 1.0.0
	 *
	 * @return The vertical distance the Pointer moved.
	**/
	public function getDistanceY():Float
	{
		return if (isDown)
		{
			Math.abs(this.downY - this.y);
		}
		else
		{
			Math.abs(this.downY - this.upY);
		}
	}

	/**
	 * If the Pointer has a button pressed down at the time this method is called, it will return the
	 * duration since the button was pressed down.
	 *
	 * If no button is held down, it will return the last recorded duration, based on the time
	 * the Pointer button was released.
	 *
	 * @since 1.0.0
	 *
	 * @return The duration the Pointer was held down for in milliseconds.
	**/
	public function getDuration():Float
	{
		return if (isDown)
		{
			manager.time - downTime;
		}
		else
		{
			upTime - downTime;
		}
	}

	/**
	 * If the Pointer has a button pressed down at the time this method is called, it will return the
	 * angle between the Pointer's `downX` and `downY` values and the current position.
	 *
	 * If no button is held down, it will return the last recorded angle, based on where
	 * the Pointer was when the button was released.
	 *
	 * The angle is based on the old position facing to the current position.
	 *
	 * If you wish to get the current angle, based on the velocity of the Pointer, then
	 * see the `Pointer.angle` property.
	 *
	 * @since 1.0.0
	 *
	 * @return The angle between the Pointer's coordinates in radians.
	**/
	public function getAngle():Float
	{
		return if (isDown)
		{
			angleBetween(downX, downY, x, y);
		}
		else
		{
			angleBetween(downX, downY, upX, upY);
		}
	}

	/**
	 * Takes the previous and current Pointer positions and then generates an array of interpolated values between
	 * the two. The array will be populated up to the size of the `steps` argument.
	 *
	 * ```haxe
	 * var points = pointer.getInterpolatedPosition(4);
	 *
	 * // points[0] = { x: 0, y: 0 }
	 * // points[1] = { x: 2, y: 1 }
	 * // points[2] = { x: 3, y: 2 }
	 * // points[3] = { x: 6, y: 3 }
	 * ```
	 *
	 * Use this if you need to get smoothed values between the previous and current pointer positions. DOM pointer
	 * events can often fire faster than the main browser loop, and this will help you avoid janky movement
	 * especially if you have an object following a Pointer.
	 *
	 * Note that if you provide an output array it will only be populated up to the number of steps provided.
	 * It will not clear any previous data that may have existed beyond the range of the steps count.
	 *
	 * Internally it uses the Smooth Step interpolation calculation.
	 *
	 * @method Phaser.Input.Pointer#getInterpolatedPosition
	 * @since 1.0.0
	 *
	 * @param steps - The number of interpolation steps to use.
	 * @param out - An array to store the results in. If not provided a new one will be created.
	 *
	 * @return An array of interpolated values.
	**/
	public function getInterpolatedPosition(steps:Int = 10,
			out:Array<Vector2>):Array<Vector2>
	{
		var out:Array<Vector2> = out != null ? out : [];

		var prevX = this.prevPosition.x;
		var prevY = this.prevPosition.y;

		var curX = this.position.x;
		var curY = this.position.y;

		for (i in 0...steps)
		{
			var t = (1 / steps) * i;

			out[i] = {
				x: smoothStepInterpolation(t, prevX, curX),
				y: smoothStepInterpolation(t, prevY, curY)
			};
		}

		return out;
	}

	/**
	 * Destroys this Pointer instance and resets its external references.
	 *
	 * @since 1.0.0
	**/
	public function destroy():Void
	{
		camera = null;
		manager = null;
		position = null;
	}
}
