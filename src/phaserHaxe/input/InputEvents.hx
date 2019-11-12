package phaserHaxe.input;

enum abstract InputEvents(String)
{
	/**
	 * The Input Plugin Boot Event.
	 *
	 * This internal event is dispatched by the Input Plugin when it boots, signalling to all of its systems to create themselves.
	 *
	 * @since 1.0.0
	**/
	var BOOT = "boot";

	/**
	 * The Input Plugin Destroy Event.
	 *
	 * This internal event is dispatched by the Input Plugin when it is destroyed, signalling to all of its systems to destroy themselves.
	 *
	 * @since 1.0.0
	**/
	var DESTROY = "destroy";

	/**
	 * The Pointer Drag End Input Event.
	 *
	 * This event is dispatched by the Input Plugin belonging to a Scene if a pointer stops dragging a Game Object.
	 *
	 * Listen to this event from within a Scene using: `this.input.on('dragend', listener)`.
	 *
	 * To listen for this event from a _specific_ Game Object, use the [GAMEOBJECT_DRAG_END]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_DRAG_END} event instead.
	 *
	 * @since 1.0.0
	 *
	 * @param pointer {Phaser.Input.Pointer} - The Pointer responsible for triggering this event.
	 * @param gameObject {Phaser.GameObjects.GameObject} - The interactive Game Object that this pointer stopped dragging.
	**/
	var DRAG_END = "dragend";

	/**
	 * The Pointer Drag Enter Input Event.
	 *
	 * This event is dispatched by the Input Plugin belonging to a Scene if a pointer drags a Game Object into a Drag Target.
	 *
	 * Listen to this event from within a Scene using: `this.input.on('dragenter', listener)`.
	 *
	 * A Pointer can only drag a single Game Object at once.
	 *
	 * To listen for this event from a _specific_ Game Object, use the [GAMEOBJECT_DRAG_ENTER]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_DRAG_ENTER} event instead.
	 *
	 * @since 1.0.0
	 *
	 * @param pointer {Phaser.Input.Pointer} - The Pointer responsible for triggering this event.
	 * @param gameObject {Phaser.GameObjects.GameObject} - The interactive Game Object that this pointer is dragging.
	 * @param target {Phaser.GameObjects.GameObject} - The drag target that this pointer has moved into.
	**/
	var DRAG_ENTER = "dragenter";

	/**
	 * The Pointer Drag Input Event.
	 *
	 * This event is dispatched by the Input Plugin belonging to a Scene if a pointer moves while dragging a Game Object.
	 *
	 * Listen to this event from within a Scene using: `this.input.on('drag', listener)`.
	 *
	 * A Pointer can only drag a single Game Object at once.
	 *
	 * To listen for this event from a _specific_ Game Object, use the [GAMEOBJECT_DRAG]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_DRAG} event instead.
	 *
	 * @since 1.0.0
	 *
	 * @param pointer {Phaser.Input.Pointer} - The Pointer responsible for triggering this event.
	 * @param gameObject {Phaser.GameObjects.GameObject} - The interactive Game Object that this pointer is dragging.
	 * @param dragX {Float} - The x coordinate where the Pointer is currently dragging the Game Object, in world space.
	 * @param dragY {Float} - The y coordinate where the Pointer is currently dragging the Game Object, in world space.
	**/
	var DRAG = "drag";

	/**
	 * The Pointer Drag Leave Input Event.
	 *
	 * This event is dispatched by the Input Plugin belonging to a Scene if a pointer drags a Game Object out of a Drag Target.
	 *
	 * Listen to this event from within a Scene using: `this.input.on('dragleave', listener)`.
	 *
	 * A Pointer can only drag a single Game Object at once.
	 *
	 * To listen for this event from a _specific_ Game Object, use the [GAMEOBJECT_DRAG_LEAVE]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_DRAG_LEAVE} event instead.
	 *
	 * @since 1.0.0
	 *
	 * @param pointer {Phaser.Input.Pointer}  - The Pointer responsible for triggering this event.
	 * @param gameObject {Phaser.GameObjects.GameObject} - The interactive Game Object that this pointer is dragging.
	 * @param target {Phaser.GameObjects.GameObject} - The drag target that this pointer has left.
	**/
	var DRAG_LEAVE = "dragleave";

	/**
	 * The Pointer Drag Over Input Event.
	 *
	 * This event is dispatched by the Input Plugin belonging to a Scene if a pointer drags a Game Object over a Drag Target.
	 *
	 * When the Game Object first enters the drag target it will emit a `dragenter` event. If it then moves while within
	 * the drag target, it will emit this event instead.
	 *
	 * Listen to this event from within a Scene using: `this.input.on('dragover', listener)`.
	 *
	 * A Pointer can only drag a single Game Object at once.
	 *
	 * To listen for this event from a _specific_ Game Object, use the [GAMEOBJECT_DRAG_OVER]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_DRAG_OVER} event instead.
	 *
	 * @since 1.0.0
	 *
	 * @param pointer {Phaser.Input.Pointer} - The Pointer responsible for triggering this event.
	 * @param gameObject {Phaser.GameObjects.GameObject} - The interactive Game Object that this pointer is dragging.
	 * @param target {Phaser.GameObjects.GameObject} - The drag target that this pointer has moved over.
	**/
	var DRAG_OVER = "dragover";

	/**
	 * The Pointer Drag Start Input Event.
	 *
	 * This event is dispatched by the Input Plugin belonging to a Scene if a pointer starts to drag any Game Object.
	 *
	 * Listen to this event from within a Scene using: `this.input.on('dragstart', listener)`.
	 *
	 * A Pointer can only drag a single Game Object at once.
	 *
	 * To listen for this event from a _specific_ Game Object, use the [GAMEOBJECT_DRAG_START]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_DRAG_START} event instead.
	 *
	 * @since 1.0.0
	 *
	 * @param pointer {Phaser.Input.Pointer} - The Pointer responsible for triggering this event.
	 * @param gameObject {Phaser.GameObjects.GameObject} - The interactive Game Object that this pointer is dragging.
	**/
	var DRAG_START = "dragstart";

	/**
	 * The Pointer Drop Input Event.
	 *
	 * This event is dispatched by the Input Plugin belonging to a Scene if a pointer drops a Game Object on a Drag Target.
	 *
	 * Listen to this event from within a Scene using: `this.input.on('drop', listener)`.
	 *
	 * To listen for this event from a _specific_ Game Object, use the [GAMEOBJECT_DROP]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_DROP} event instead.
	 *
	 * @since 1.0.0
	 *
	 * @param pointer {Phaser.Input.Pointer} - The Pointer responsible for triggering this event.
	 * @param gameObject {Phaser.GameObjects.GameObject} - The interactive Game Object that this pointer was dragging.
	 * @param target {Phaser.GameObjects.GameObject} - The Drag Target the `gameObject` has been dropped on.
	**/
	var DROP = "drop";

	/**
	 * The Input Plugin Game Out Event.
	 *
	 * This event is dispatched by the Input Plugin if the active pointer leaves the game canvas and is now
	 * outside of it, elsewhere on the web page.
	 *
	 * Listen to this event from within a Scene using: `this.input.on('gameout', listener)`.
	 *
	 * @since 1.0.0
	 *
	 * @param time {Float} - The current time. Either a High Resolution Timer value if it comes from Request Animation Frame, or Date.now if using SetTimeout.
	 * @param event {Union<MouseEvent,TouchEvent>} - The DOM Event that triggered the canvas out.
	**/
	var GAME_OUT = "gameout";

	/**
	 * The Input Plugin Game Over Event.
	 *
	 * This event is dispatched by the Input Plugin if the active pointer enters the game canvas and is now
	 * over of it, having previously been elsewhere on the web page.
	 *
	 * Listen to this event from within a Scene using: `this.input.on('gameover', listener)`.
	 *
	 * @since 1.0.1
	 *
	 * @param time {Float} - The current time. Either a High Resolution Timer value if it comes from Request Animation Frame, or Date.now if using SetTimeout.
	 * @param event {Union<MouseEvent,TouchEvent>} - The DOM Event that triggered the canvas over.
	**/
	var GAME_OVER = "gameover";

	/**
	 * The Game Object Down Input Event.
	 *
	 * This event is dispatched by the Input Plugin belonging to a Scene if a pointer is pressed down on _any_ interactive Game Object.
	 *
	 * Listen to this event from within a Scene using: `this.input.on('gameobjectdown', listener)`.
	 *
	 * To receive this event, the Game Objects must have been set as interactive.
	 * See [GameObject.setInteractive]{@link Phaser.GameObjects.GameObject#setInteractive} for more details.
	 *
	 * To listen for this event from a _specific_ Game Object, use the [GAMEOBJECT_POINTER_DOWN]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_POINTER_DOWN} event instead.
	 *
	 * The event hierarchy is as follows:
	 *
	 * 1. [GAMEOBJECT_POINTER_DOWN]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_POINTER_DOWN}
	 * 2. [GAMEOBJECT_DOWN]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_DOWN}
	 * 3. [POINTER_DOWN]{@linkcode Phaser.Input.Events#event:POINTER_DOWN} or [POINTER_DOWN_OUTSIDE]{@linkcode Phaser.Input.Events#event:POINTER_DOWN_OUTSIDE}
	 *
	 * With the top event being dispatched first and then flowing down the list. Note that higher-up event handlers can stop
	 * the propagation of this event.
	 *
	 * @since 1.0.0
	 *
	 * @param pointer {Phaser.Input.Pointer} - The Pointer responsible for triggering this event.
	 * @param gameObject {Phaser.GameObjects.GameObject} - The Game Object the pointer was pressed down on.
	 * @param event {Phaser.Types.Input.EventData} - The Phaser input event. You can call `stopPropagation()` to halt it from going any further in the event flow.
	**/
	var GAMEOBJECT_DOWN = "gameobjectdown";

	/**
	 * The Game Object Drag End Event.
	 *
	 * This event is dispatched by an interactive Game Object if a pointer stops dragging it.
	 *
	 * Listen to this event from a Game Object using: `gameObject.on('dragend', listener)`.
	 * Note that the scope of the listener is automatically set to be the Game Object instance itself.
	 *
	 * To receive this event, the Game Object must have been set as interactive and enabled for drag.
	 * See [GameObject.setInteractive](Phaser.GameObjects.GameObject#setInteractive) for more details.
	 *
	 * @since 1.0.0
	 *
	 * @param pointer {Phaser.Input.Pointer} - The Pointer responsible for triggering this event.
	 * @param dragX {Float} - The x coordinate where the Pointer stopped dragging the Game Object, in world space.
	 * @param dragY {Float} - The y coordinate where the Pointer stopped dragging the Game Object, in world space.
	**/
	var GAMEOBJECT_DRAG_END = "dragend";

	/**
	 * The Game Object Drag Enter Event.
	 *
	 * This event is dispatched by an interactive Game Object if a pointer drags it into a drag target.
	 *
	 * Listen to this event from a Game Object using: `gameObject.on('dragenter', listener)`.
	 * Note that the scope of the listener is automatically set to be the Game Object instance itself.
	 *
	 * To receive this event, the Game Object must have been set as interactive and enabled for drag.
	 * See [GameObject.setInteractive]{@link Phaser.GameObjects.GameObject#setInteractive} for more details.
	 *
	 * @since 1.0.0
	 *
	 * @param pointer {Phaser.Input.Pointer} - The Pointer responsible for triggering this event.
	 * @param target {Phaser.GameObjects.GameObject} - The drag target that this pointer has moved into.
	**/
	var GAMEOBJECT_DRAG_ENTER = "dragenter";

	/**
	 * The Game Object Drag Event.
	 *
	 * This event is dispatched by an interactive Game Object if a pointer moves while dragging it.
	 *
	 * Listen to this event from a Game Object using: `gameObject.on('drag', listener)`.
	 * Note that the scope of the listener is automatically set to be the Game Object instance itself.
	 *
	 * To receive this event, the Game Object must have been set as interactive and enabled for drag.
	 * See [GameObject.setInteractive]{@link Phaser.GameObjects.GameObject#setInteractive} for more details.
	 *
	 * @event Phaser.Input.Events#GAMEOBJECT_DRAG
	 * @since 3.0.0
	 *
	 * @param pointer {Phaser.Input.Pointer} - The Pointer responsible for triggering this event.
	 * @param dragX {Float} - The x coordinate where the Pointer is currently dragging the Game Object, in world space.
	 * @param dragY {Float} - The y coordinate where the Pointer is currently dragging the Game Object, in world space.
	**/
	var GAMEOBJECT_DRAG = "drag";

	/**
	 * The Game Object Drag Leave Event.
	 *
	 * This event is dispatched by an interactive Game Object if a pointer drags it out of a drag target.
	 *
	 * Listen to this event from a Game Object using: `gameObject.on('dragleave', listener)`.
	 * Note that the scope of the listener is automatically set to be the Game Object instance itself.
	 *
	 * To receive this event, the Game Object must have been set as interactive and enabled for drag.
	 * See [GameObject.setInteractive]{@link Phaser.GameObjects.GameObject#setInteractive} for more details.
	 *
	 * @since 1.0.0
	 *
	 * @param pointer {Phaser.Input.Pointer} - The Pointer responsible for triggering this event.
	 * @param target {Phaser.GameObjects.GameObject} - The drag target that this pointer has left.
	**/
	var GAMEOBJECT_DRAG_LEAVE = "dragleave";

	/**
	 * The Game Object Drag Over Event.
	 *
	 * This event is dispatched by an interactive Game Object if a pointer drags it over a drag target.
	 *
	 * When the Game Object first enters the drag target it will emit a `dragenter` event. If it then moves while within
	 * the drag target, it will emit this event instead.
	 *
	 * Listen to this event from a Game Object using: `gameObject.on('dragover', listener)`.
	 * Note that the scope of the listener is automatically set to be the Game Object instance itself.
	 *
	 * To receive this event, the Game Object must have been set as interactive and enabled for drag.
	 * See [GameObject.setInteractive]{@link Phaser.GameObjects.GameObject#setInteractive} for more details.
	 *
	 * @since 1.0.0
	 *
	 * @param pointer {Phaser.Input.Pointer} - The Pointer responsible for triggering this event.
	 * @param target {Phaser.GameObjects.GameObject} - The drag target that this pointer has moved over.
	**/
	var GAMEOBJECT_DRAG_OVER = "dragover";

	/**
	 * The Game Object Drag Start Event.
	 *
	 * This event is dispatched by an interactive Game Object if a pointer starts to drag it.
	 *
	 * Listen to this event from a Game Object using: `gameObject.on('dragstart', listener)`.
	 * Note that the scope of the listener is automatically set to be the Game Object instance itself.
	 *
	 * To receive this event, the Game Object must have been set as interactive and enabled for drag.
	 * See [GameObject.setInteractive]{@link Phaser.GameObjects.GameObject#setInteractive} for more details.
	 *
	 * There are lots of useful drag related properties that are set within the Game Object when dragging occurs.
	 * For example, `gameObject.input.dragStartX`, `dragStartY` and so on.
	 *
	 * @since 1.0.0
	 *
	 * @param pointer {Phaser.Input.Pointer} - The Pointer responsible for triggering this event.
	 * @param dragX {Float} - The x coordinate where the Pointer is currently dragging the Game Object, in world space.
	 * @param dragY {Float] - The y coordinate where the Pointer is currently dragging the Game Object, in world space.
	**/
	var GAMEOBJECT_DRAG_START = "dragstart";

	/**
	 * The Game Object Drop Event.
	 *
	 * This event is dispatched by an interactive Game Object if a pointer drops it on a Drag Target.
	 *
	 * Listen to this event from a Game Object using: `gameObject.on('drop', listener)`.
	 * Note that the scope of the listener is automatically set to be the Game Object instance itself.
	 *
	 * To receive this event, the Game Object must have been set as interactive and enabled for drag.
	 * See [GameObject.setInteractive]{@link Phaser.GameObjects.GameObject#setInteractive} for more details.
	 *
	 * @since 1.0.0
	 *
	 * @param pointer {Phaser.Input.Pointer} - The Pointer responsible for triggering this event.
	 * @param target {Phaser.GameObjects.GameObject} - The Drag Target the `gameObject` has been dropped on.
	**/
	var GAMEOBJECT_DROP = "drop";

	/**
	 * The Game Object Move Input Event.
	 *
	 * This event is dispatched by the Input Plugin belonging to a Scene if a pointer is moved across _any_ interactive Game Object.
	 *
	 * Listen to this event from within a Scene using: `this.input.on('gameobjectmove', listener)`.
	 *
	 * To receive this event, the Game Objects must have been set as interactive.
	 * See [GameObject.setInteractive]{@link Phaser.GameObjects.GameObject#setInteractive} for more details.
	 *
	 * To listen for this event from a _specific_ Game Object, use the [GAMEOBJECT_POINTER_MOVE]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_POINTER_MOVE} event instead.
	 *
	 * The event hierarchy is as follows:
	 *
	 * 1. [GAMEOBJECT_POINTER_MOVE]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_POINTER_MOVE}
	 * 2. [GAMEOBJECT_MOVE]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_MOVE}
	 * 3. [POINTER_MOVE]{@linkcode Phaser.Input.Events#event:POINTER_MOVE}
	 *
	 * With the top event being dispatched first and then flowing down the list. Note that higher-up event handlers can stop
	 * the propagation of this event.
	 *
	 * @since 1.0.0
	 *
	 * @param pointer {Phaser.Input.Pointer} - The Pointer responsible for triggering this event.
	 * @param gameObject {Phaser.GameObjects.GameObject} - The Game Object the pointer was moved on.
	 * @param event {Phaser.Types.Input.EventData} - The Phaser input event. You can call `stopPropagation()` to halt it from going any further in the event flow.
	**/
	var GAMEOBJECT_MOVE = "gameobjectmove";

	/**
	 * The Game Object Out Input Event.
	 *
	 * This event is dispatched by the Input Plugin belonging to a Scene if a pointer moves out of _any_ interactive Game Object.
	 *
	 * Listen to this event from within a Scene using: `this.input.on('gameobjectout', listener)`.
	 *
	 * To receive this event, the Game Objects must have been set as interactive.
	 * See [GameObject.setInteractive]{@link Phaser.GameObjects.GameObject#setInteractive} for more details.
	 *
	 * To listen for this event from a _specific_ Game Object, use the [GAMEOBJECT_POINTER_OUT]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_POINTER_OUT} event instead.
	 *
	 * The event hierarchy is as follows:
	 *
	 * 1. [GAMEOBJECT_POINTER_OUT]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_POINTER_OUT}
	 * 2. [GAMEOBJECT_OUT]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_OUT}
	 * 3. [POINTER_OUT]{@linkcode Phaser.Input.Events#event:POINTER_OUT}
	 *
	 * With the top event being dispatched first and then flowing down the list. Note that higher-up event handlers can stop
	 * the propagation of this event.
	 *
	 * @since 1.0.0
	 *
	 * @param pointer {Phaser.Input.Pointer} - The Pointer responsible for triggering this event.
	 * @param gameObject {Phaser.GameObjects.GameObject} - The Game Object the pointer moved out of.
	 * @param event {Phaser.Types.Input.EventData} - The Phaser input event. You can call `stopPropagation()` to halt it from going any further in the event flow.
	**/
	var GAMEOBJECT_OUT = "gameobjectout";

	/**
	 * The Game Object Over Input Event.
	 *
	 * This event is dispatched by the Input Plugin belonging to a Scene if a pointer moves over _any_ interactive Game Object.
	 *
	 * Listen to this event from within a Scene using: `this.input.on('gameobjectover', listener)`.
	 *
	 * To receive this event, the Game Objects must have been set as interactive.
	 * See [GameObject.setInteractive]{@link Phaser.GameObjects.GameObject#setInteractive} for more details.
	 *
	 * To listen for this event from a _specific_ Game Object, use the [GAMEOBJECT_POINTER_OVER]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_POINTER_OVER} event instead.
	 *
	 * The event hierarchy is as follows:
	 *
	 * 1. [GAMEOBJECT_POINTER_OVER]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_POINTER_OVER}
	 * 2. [GAMEOBJECT_OVER]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_OVER}
	 * 3. [POINTER_OVER]{@linkcode Phaser.Input.Events#event:POINTER_OVER}
	 *
	 * With the top event being dispatched first and then flowing down the list. Note that higher-up event handlers can stop
	 * the propagation of this event.
	 *
	 * @since 1.0.0
	 *
	 * @param pointer {Phaser.Input.Pointer} - The Pointer responsible for triggering this event.
	 * @param gameObject {Phaser.GameObjects.GameObject} - The Game Object the pointer moved over.
	 * @param event {Phaser.Types.Input.EventData} - The Phaser input event. You can call `stopPropagation()` to halt it from going any further in the event flow.
	**/
	var GAMEOBJECT_OVER = "gameobjectover";

	/**
	 * The Game Object Pointer Down Event.
	 *
	 * This event is dispatched by an interactive Game Object if a pointer is pressed down on it.
	 *
	 * Listen to this event from a Game Object using: `gameObject.on('pointerdown', listener)`.
	 * Note that the scope of the listener is automatically set to be the Game Object instance itself.
	 *
	 * To receive this event, the Game Object must have been set as interactive.
	 * See [GameObject.setInteractive]{@link Phaser.GameObjects.GameObject#setInteractive} for more details.
	 *
	 * The event hierarchy is as follows:
	 *
	 * 1. [GAMEOBJECT_POINTER_DOWN]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_POINTER_DOWN}
	 * 2. [GAMEOBJECT_DOWN]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_DOWN}
	 * 3. [POINTER_DOWN]{@linkcode Phaser.Input.Events#event:POINTER_DOWN} or [POINTER_DOWN_OUTSIDE]{@linkcode Phaser.Input.Events#event:POINTER_DOWN_OUTSIDE}
	 *
	 * With the top event being dispatched first and then flowing down the list. Note that higher-up event handlers can stop
	 * the propagation of this event.
	 *
	 * @event Phaser.Input.Events#GAMEOBJECT_POINTER_DOWN
	 * @since 1.0.0
	 *
	 * @param pointer {Phaser.Input.Pointer} - The Pointer responsible for triggering this event.
	 * @param localX {Float} - The x coordinate that the Pointer interacted with this object on, relative to the Game Object's top-left position.
	 * @param localY {Float} - The y coordinate that the Pointer interacted with this object on, relative to the Game Object's top-left position.
	 * @param event {Phaser.Types.Input.EventData} - The Phaser input event. You can call `stopPropagation()` to halt it from going any further in the event flow.
	**/
	var GAMEOBJECT_POINTER_DOWN = "pointerdown";

	/**
	 * The Game Object Pointer Move Event.
	 *
	 * This event is dispatched by an interactive Game Object if a pointer is moved while over it.
	 *
	 * Listen to this event from a Game Object using: `gameObject.on('pointermove', listener)`.
	 * Note that the scope of the listener is automatically set to be the Game Object instance itself.
	 *
	 * To receive this event, the Game Object must have been set as interactive.
	 * See [GameObject.setInteractive]{@link Phaser.GameObjects.GameObject#setInteractive} for more details.
	 *
	 * The event hierarchy is as follows:
	 *
	 * 1. [GAMEOBJECT_POINTER_MOVE]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_POINTER_MOVE}
	 * 2. [GAMEOBJECT_MOVE]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_MOVE}
	 * 3. [POINTER_MOVE]{@linkcode Phaser.Input.Events#event:POINTER_MOVE}
	 *
	 * With the top event being dispatched first and then flowing down the list. Note that higher-up event handlers can stop
	 * the propagation of this event.
	 *
	 * @since 1.0.0
	 *
	 * @param pointer {Phaser.Input.Pointer} - The Pointer responsible for triggering this event.
	 * @param localX {Float} - The x coordinate that the Pointer interacted with this object on, relative to the Game Object's top-left position.
	 * @param localY {Float} - The y coordinate that the Pointer interacted with this object on, relative to the Game Object's top-left position.
	 * @param event {Phaser.Types.Input.EventData} - The Phaser input event. You can call `stopPropagation()` to halt it from going any further in the event flow.
	**/
	var GAMEOBJECT_POINTER_MOVE = "pointermove";

	/**
	 * The Game Object Pointer Out Event.
	 *
	 * This event is dispatched by an interactive Game Object if a pointer moves out of it.
	 *
	 * Listen to this event from a Game Object using: `gameObject.on('pointerout', listener)`.
	 * Note that the scope of the listener is automatically set to be the Game Object instance itself.
	 *
	 * To receive this event, the Game Object must have been set as interactive.
	 * See [GameObject.setInteractive]{@link Phaser.GameObjects.GameObject#setInteractive} for more details.
	 *
	 * The event hierarchy is as follows:
	 *
	 * 1. [GAMEOBJECT_POINTER_OUT]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_POINTER_OUT}
	 * 2. [GAMEOBJECT_OUT]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_OUT}
	 * 3. [POINTER_OUT]{@linkcode Phaser.Input.Events#event:POINTER_OUT}
	 *
	 * With the top event being dispatched first and then flowing down the list. Note that higher-up event handlers can stop
	 * the propagation of this event.
	 *
	 * @since 1.0.0
	 *
	 * @param pointer {Phaser.Input.Pointer} - The Pointer responsible for triggering this event.
	 * @param event {Phaser.Types.Input.EventData} - The Phaser input event. You can call `stopPropagation()` to halt it from going any further in the event flow.
	**/
	var GAMEOBJECT_POINTER_OUT = "pointerout";

	/**
	 * The Game Object Pointer Over Event.
	 *
	 * This event is dispatched by an interactive Game Object if a pointer moves over it.
	 *
	 * Listen to this event from a Game Object using: `gameObject.on('pointerover', listener)`.
	 * Note that the scope of the listener is automatically set to be the Game Object instance itself.
	 *
	 * To receive this event, the Game Object must have been set as interactive.
	 * See [GameObject.setInteractive]{@link Phaser.GameObjects.GameObject#setInteractive} for more details.
	 *
	 * The event hierarchy is as follows:
	 *
	 * 1. [GAMEOBJECT_POINTER_OVER]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_POINTER_OVER}
	 * 2. [GAMEOBJECT_OVER]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_OVER}
	 * 3. [POINTER_OVER]{@linkcode Phaser.Input.Events#event:POINTER_OVER}
	 *
	 * With the top event being dispatched first and then flowing down the list. Note that higher-up event handlers can stop
	 * the propagation of this event.
	 *
	 * @since 1.0.0
	 *
	 * @param pointer {Phaser.Input.Pointer} - The Pointer responsible for triggering this event.
	 * @param localX {Float} - The x coordinate that the Pointer interacted with this object on, relative to the Game Object's top-left position.
	 * @param localY {Float} - The y coordinate that the Pointer interacted with this object on, relative to the Game Object's top-left position.
	 * @param event {Phaser.Types.Input.EventData} - The Phaser input event. You can call `stopPropagation()` to halt it from going any further in the event flow.
	**/
	var GAMEOBJECT_POINTER_OVER = "pointerover";

	/**
	 * The Game Object Pointer Up Event.
	 *
	 * This event is dispatched by an interactive Game Object if a pointer is released while over it.
	 *
	 * Listen to this event from a Game Object using: `gameObject.on('pointerup', listener)`.
	 * Note that the scope of the listener is automatically set to be the Game Object instance itself.
	 *
	 * To receive this event, the Game Object must have been set as interactive.
	 * See [GameObject.setInteractive]{@link Phaser.GameObjects.GameObject#setInteractive} for more details.
	 *
	 * The event hierarchy is as follows:
	 *
	 * 1. [GAMEOBJECT_POINTER_UP]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_POINTER_UP}
	 * 2. [GAMEOBJECT_UP]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_UP}
	 * 3. [POINTER_UP]{@linkcode Phaser.Input.Events#event:POINTER_UP} or [POINTER_UP_OUTSIDE]{@linkcode Phaser.Input.Events#event:POINTER_UP_OUTSIDE}
	 *
	 * With the top event being dispatched first and then flowing down the list. Note that higher-up event handlers can stop
	 * the propagation of this event.
	 *
	 * @since 1.0.0
	 *
	 * @param pointer {Phaser.Input.Pointer} - The Pointer responsible for triggering this event.
	 * @param localX {Float} - The x coordinate that the Pointer interacted with this object on, relative to the Game Object's top-left position.
	 * @param localY {Float} - The y coordinate that the Pointer interacted with this object on, relative to the Game Object's top-left position.
	 * @param event {Phaser.Types.Input.EventData} - The Phaser input event. You can call `stopPropagation()` to halt it from going any further in the event flow.
	**/
	var GAMEOBJECT_POINTER_UP = "pointerup";

	/**
	 * The Game Object Pointer Wheel Event.
	 *
	 * This event is dispatched by an interactive Game Object if a pointer has its wheel moved while over it.
	 *
	 * Listen to this event from a Game Object using: `gameObject.on('wheel', listener)`.
	 * Note that the scope of the listener is automatically set to be the Game Object instance itself.
	 *
	 * To receive this event, the Game Object must have been set as interactive.
	 * See [GameObject.setInteractive]{@link Phaser.GameObjects.GameObject#setInteractive} for more details.
	 *
	 * The event hierarchy is as follows:
	 *
	 * 1. [GAMEOBJECT_POINTER_WHEEL]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_POINTER_WHEEL}
	 * 2. [GAMEOBJECT_WHEEL]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_WHEEL}
	 * 3. [POINTER_WHEEL]{@linkcode Phaser.Input.Events#event:POINTER_WHEEL}
	 *
	 * With the top event being dispatched first and then flowing down the list. Note that higher-up event handlers can stop
	 * the propagation of this event.
	 *
	 * @since 1.0.0
	 *
	 * @param pointer {Phaser.Input.Pointer} - The Pointer responsible for triggering this event.
	 * @param deltaX {Float}- The horizontal scroll amount that occurred due to the user moving a mouse wheel or similar input device.
	 * @param deltaY {Float} - The vertical scroll amount that occurred due to the user moving a mouse wheel or similar input device. This value will typically be less than 0 if the user scrolls up and greater than zero if scrolling down.
	 * @param deltaZ {Float} - The z-axis scroll amount that occurred due to the user moving a mouse wheel or similar input device.
	 * @param event {Phaser.Types.Input.EventData} - The Phaser input event. You can call `stopPropagation()` to halt it from going any further in the event flow.
	**/
	var GAMEOBJECT_POINTER_WHEEL = "wheel";

	/**
	 * The Game Object Up Input Event.
	 *
	 * This event is dispatched by the Input Plugin belonging to a Scene if a pointer is released while over _any_ interactive Game Object.
	 *
	 * Listen to this event from within a Scene using: `this.input.on('gameobjectup', listener)`.
	 *
	 * To receive this event, the Game Objects must have been set as interactive.
	 * See [GameObject.setInteractive]{@link Phaser.GameObjects.GameObject#setInteractive} for more details.
	 *
	 * To listen for this event from a _specific_ Game Object, use the [GAMEOBJECT_POINTER_UP]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_POINTER_UP} event instead.
	 *
	 * The event hierarchy is as follows:
	 *
	 * 1. [GAMEOBJECT_POINTER_UP]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_POINTER_UP}
	 * 2. [GAMEOBJECT_UP]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_UP}
	 * 3. [POINTER_UP]{@linkcode Phaser.Input.Events#event:POINTER_UP} or [POINTER_UP_OUTSIDE]{@linkcode Phaser.Input.Events#event:POINTER_UP_OUTSIDE}
	 *
	 * With the top event being dispatched first and then flowing down the list. Note that higher-up event handlers can stop
	 * the propagation of this event.
	 *
	 * @since 1.0.0
	 *
	 * @param pointer {Phaser.Input.Pointer} - The Pointer responsible for triggering this event.
	 * @param gameObject {Phaser.GameObjects.GameObject} - The Game Object the pointer was over when released.
	 * @param event {Phaser.Types.Input.EventData} - The Phaser input event. You can call `stopPropagation()` to halt it from going any further in the event flow.
	**/
	var GAMEOBJECT_UP = "gameobjectup";

	/**
	 * The Game Object Wheel Input Event.
	 *
	 * This event is dispatched by the Input Plugin belonging to a Scene if a pointer has its wheel moved while over _any_ interactive Game Object.
	 *
	 * Listen to this event from within a Scene using: `this.input.on('gameobjectwheel', listener)`.
	 *
	 * To receive this event, the Game Objects must have been set as interactive.
	 * See [GameObject.setInteractive]{@link Phaser.GameObjects.GameObject#setInteractive} for more details.
	 *
	 * To listen for this event from a _specific_ Game Object, use the [GAMEOBJECT_POINTER_WHEEL]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_POINTER_WHEEL} event instead.
	 *
	 * The event hierarchy is as follows:
	 *
	 * 1. [GAMEOBJECT_POINTER_WHEEL]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_POINTER_WHEEL}
	 * 2. [GAMEOBJECT_WHEEL]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_WHEEL}
	 * 3. [POINTER_WHEEL]{@linkcode Phaser.Input.Events#event:POINTER_WHEEL}
	 *
	 * With the top event being dispatched first and then flowing down the list. Note that higher-up event handlers can stop
	 * the propagation of this event.
	 *
	 * @since 1.0.0
	 *
	 * @param pointer {Phaser.Input.Pointer} - The Pointer responsible for triggering this event.
	 * @param gameObject {Phaser.GameObjects.GameObject} - The Game Object the pointer was over when the wheel changed.
	 * @param deltaX {Float} - The horizontal scroll amount that occurred due to the user moving a mouse wheel or similar input device.
	 * @param deltaY {Float} - The vertical scroll amount that occurred due to the user moving a mouse wheel or similar input device. This value will typically be less than 0 if the user scrolls up and greater than zero if scrolling down.
	 * @param deltaZ {Float} - The z-axis scroll amount that occurred due to the user moving a mouse wheel or similar input device.
	 * @param event {Phaser.Types.Input.EventData} - The Phaser input event. You can call `stopPropagation()` to halt it from going any further in the event flow.
	**/
	var GAMEOBJECT_WHEEL = "gameobjectwheel";

	/**
	 * The Input Manager Boot Event.
	 *
	 * This internal event is dispatched by the Input Manager when it boots.
	 *
	 * @since 1.0.0
	**/
	var MANAGER_BOOT = "boot";

	/**
	 * The Input Manager Process Event.
	 *
	 * This internal event is dispatched by the Input Manager when not using the legacy queue system,
	 * and it wants the Input Plugins to update themselves.
	 *
	 * @since 1.0.0
	 *
	 * @param time {Float} - The current time. Either a High Resolution Timer value if it comes from Request Animation Frame, or Date.now if using SetTimeout.
	 * @param delta {Float} - The delta time in ms since the last frame. This is a smoothed and capped value based on the FPS rate.
	**/
	var MANAGER_PROCESS = "process";

	/**
	 * The Input Manager Update Event.
	 *
	 * This internal event is dispatched by the Input Manager as part of its update step.
	 *
	 * @since 1.0.0
	**/
	var MANAGER_UPDATE = "update";

	/**
	 * The Pointer Down Input Event.
	 *
	 * This event is dispatched by the Input Plugin belonging to a Scene if a pointer is pressed down anywhere.
	 *
	 * Listen to this event from within a Scene using: `this.input.on('pointerdown', listener)`.
	 *
	 * The event hierarchy is as follows:
	 *
	 * 1. [GAMEOBJECT_POINTER_DOWN]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_POINTER_DOWN}
	 * 2. [GAMEOBJECT_DOWN]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_DOWN}
	 * 3. [POINTER_DOWN]{@linkcode Phaser.Input.Events#event:POINTER_DOWN} or [POINTER_DOWN_OUTSIDE]{@linkcode Phaser.Input.Events#event:POINTER_DOWN_OUTSIDE}
	 *
	 * With the top event being dispatched first and then flowing down the list. Note that higher-up event handlers can stop
	 * the propagation of this event.
	 *
	 * @since 1.0.0
	 *
	 * @param pointer {Phaser.Input.Pointer} - The Pointer responsible for triggering this event.
	 * @param currentlyOver {Array<Phaser.GameObjects.GameObject>} - An array containing all interactive Game Objects that the pointer was over when the event was created.
	**/
	var POINTER_DOWN = "pointerdown";

	/**
	 * The Pointer Down Outside Input Event.
	 *
	 * This event is dispatched by the Input Plugin belonging to a Scene if a pointer is pressed down anywhere outside of the game canvas.
	 *
	 * Listen to this event from within a Scene using: `this.input.on('pointerdownoutside', listener)`.
	 *
	 * The event hierarchy is as follows:
	 *
	 * 1. [GAMEOBJECT_POINTER_DOWN]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_POINTER_DOWN}
	 * 2. [GAMEOBJECT_DOWN]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_DOWN}
	 * 3. [POINTER_DOWN]{@linkcode Phaser.Input.Events#event:POINTER_DOWN} or [POINTER_DOWN_OUTSIDE]{@linkcode Phaser.Input.Events#event:POINTER_DOWN_OUTSIDE}
	 *
	 * With the top event being dispatched first and then flowing down the list. Note that higher-up event handlers can stop
	 * the propagation of this event.
	 *
	 * @since 1.0.0
	 *
	 * @param pointer {Phaser.Input.Pointer} - The Pointer responsible for triggering this event.
	**/
	var POINTER_DOWN_OUTSIDE = "pointerdownoutside";

	/**
	 * The Pointer Move Input Event.
	 *
	 * This event is dispatched by the Input Plugin belonging to a Scene if a pointer is moved anywhere.
	 *
	 * Listen to this event from within a Scene using: `this.input.on('pointermove', listener)`.
	 *
	 * The event hierarchy is as follows:
	 *
	 * 1. [GAMEOBJECT_POINTER_MOVE]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_POINTER_MOVE}
	 * 2. [GAMEOBJECT_MOVE]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_MOVE}
	 * 3. [POINTER_MOVE]{@linkcode Phaser.Input.Events#event:POINTER_MOVE}
	 *
	 * With the top event being dispatched first and then flowing down the list. Note that higher-up event handlers can stop
	 * the propagation of this event.
	 *
	 * @since 1.0.0
	 *
	 * @param pointer {Phaser.Input.Pointer} - The Pointer responsible for triggering this event.
	 * @param currentlyOver {Array<Phaser.GameObjects.GameObject>} - An array containing all interactive Game Objects that the pointer was over when the event was created.
	**/
	var POINTER_MOVE = "pointermove";

	/**
	 * The Pointer Out Input Event.
	 *
	 * This event is dispatched by the Input Plugin belonging to a Scene if a pointer moves out of any interactive Game Object.
	 *
	 * Listen to this event from within a Scene using: `this.input.on('pointerup', listener)`.
	 *
	 * The event hierarchy is as follows:
	 *
	 * 1. [GAMEOBJECT_POINTER_OUT]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_POINTER_OUT}
	 * 2. [GAMEOBJECT_OUT]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_OUT}
	 * 3. [POINTER_OUT]{@linkcode Phaser.Input.Events#event:POINTER_OUT}
	 *
	 * With the top event being dispatched first and then flowing down the list. Note that higher-up event handlers can stop
	 * the propagation of this event.
	 *
	 * @since 1.0.0
	 *
	 * @param pointer {Phaser.Input.Pointer} - The Pointer responsible for triggering this event.
	 * @param justOut {Array<Phaser.GameObjects.GameObject>} - An array containing all interactive Game Objects that the pointer moved out of when the event was created.
	**/
	var POINTER_OUT = "pointerout";

	/**
	 * The Pointer Over Input Event.
	 *
	 * This event is dispatched by the Input Plugin belonging to a Scene if a pointer moves over any interactive Game Object.
	 *
	 * Listen to this event from within a Scene using: `this.input.on('pointerover', listener)`.
	 *
	 * The event hierarchy is as follows:
	 *
	 * 1. [GAMEOBJECT_POINTER_OVER]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_POINTER_OVER}
	 * 2. [GAMEOBJECT_OVER]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_OVER}
	 * 3. [POINTER_OVER]{@linkcode Phaser.Input.Events#event:POINTER_OVER}
	 *
	 * With the top event being dispatched first and then flowing down the list. Note that higher-up event handlers can stop
	 * the propagation of this event.
	 *
	 * @event Phaser.Input.Events#POINTER_OVER
	 * @since 1.0.0
	 *
	 * @param pointer {Phaser.Input.Pointer} - The Pointer responsible for triggering this event.
	 * @param justOver {Array<Phaser.GameObjects.GameObject>} - An array containing all interactive Game Objects that the pointer moved over when the event was created.
	**/
	var POINTER_OVER = "pointerover";

	/**
	 * The Pointer Up Input Event.
	 *
	 * This event is dispatched by the Input Plugin belonging to a Scene if a pointer is released anywhere.
	 *
	 * Listen to this event from within a Scene using: `this.input.on('pointerup', listener)`.
	 *
	 * The event hierarchy is as follows:
	 *
	 * 1. [GAMEOBJECT_POINTER_UP]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_POINTER_UP}
	 * 2. [GAMEOBJECT_UP]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_UP}
	 * 3. [POINTER_UP]{@linkcode Phaser.Input.Events#event:POINTER_UP} or [POINTER_UP_OUTSIDE]{@linkcode Phaser.Input.Events#event:POINTER_UP_OUTSIDE}
	 *
	 * With the top event being dispatched first and then flowing down the list. Note that higher-up event handlers can stop
	 * the propagation of this event.
	 *
	 * @since 1.0.0
	 *
	 * @param pointer {Phaser.Input.Pointer} - The Pointer responsible for triggering this event.
	 * @param currentlyOver {Array<Phaser.GameObjects.GameObject>} - An array containing all interactive Game Objects that the pointer was over when the event was created.
	**/
	var POINTER_UP = "pointerup";

	/**
	 * The Pointer Up Outside Input Event.
	 *
	 * This event is dispatched by the Input Plugin belonging to a Scene if a pointer is released anywhere outside of the game canvas.
	 *
	 * Listen to this event from within a Scene using: `this.input.on('pointerupoutside', listener)`.
	 *
	 * The event hierarchy is as follows:
	 *
	 * 1. [GAMEOBJECT_POINTER_UP]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_POINTER_UP}
	 * 2. [GAMEOBJECT_UP]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_UP}
	 * 3. [POINTER_UP]{@linkcode Phaser.Input.Events#event:POINTER_UP} or [POINTER_UP_OUTSIDE]{@linkcode Phaser.Input.Events#event:POINTER_UP_OUTSIDE}
	 *
	 * With the top event being dispatched first and then flowing down the list. Note that higher-up event handlers can stop
	 * the propagation of this event.
	 *
	 * @since 1.0.0
	 *
	 * @param pointer {Phaser.Input.Pointer} - The Pointer responsible for triggering this event.
	**/
	var POINTER_UP_OUTSIDE = "pointerupoutside";

	/**
	 * The Pointer Wheel Input Event.
	 *
	 * This event is dispatched by the Input Plugin belonging to a Scene if a pointer has its wheel updated.
	 *
	 * Listen to this event from within a Scene using: `this.input.on('wheel', listener)`.
	 *
	 * The event hierarchy is as follows:
	 *
	 * 1. [GAMEOBJECT_POINTER_WHEEL]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_POINTER_WHEEL}
	 * 2. [GAMEOBJECT_WHEEL]{@linkcode Phaser.Input.Events#event:GAMEOBJECT_WHEEL}
	 * 3. [POINTER_WHEEL]{@linkcode Phaser.Input.Events#event:POINTER_WHEEL}
	 *
	 * With the top event being dispatched first and then flowing down the list. Note that higher-up event handlers can stop
	 * the propagation of this event.
	 *
	 * @since 1.0.0
	 *
	 * @param pointer {Phaser.Input.Pointer} - The Pointer responsible for triggering this event.
	 * @param currentlyOver {Array<Phaser.GameObjects.GameObject>} - An array containing all interactive Game Objects that the pointer was over when the event was created.
	 * @param deltaX {Float} - The horizontal scroll amount that occurred due to the user moving a mouse wheel or similar input device.
	 * @param deltaY {Float} - The vertical scroll amount that occurred due to the user moving a mouse wheel or similar input device. This value will typically be less than 0 if the user scrolls up and greater than zero if scrolling down.
	 * @param deltaZ {Float} - The z-axis scroll amount that occurred due to the user moving a mouse wheel or similar input device.
	**/
	var POINTER_WHEEL = "wheel";

	/**
	 * The Input Manager Pointer Lock Change Event.
	 *
	 * This event is dispatched by the Input Manager when it is processing a native Pointer Lock Change DOM Event.
	 *
	 * @since 1.0.0
	 *
	 * @param event {Event} - The native DOM Event.
	 * @param locked {boolean} - The locked state of the Mouse Pointer.
	**/
	var POINTERLOCK_CHANGE = "pointerlockchange";

	/**
	 * The Input Plugin Pre-Update Event.
	 *
	 * This internal event is dispatched by the Input Plugin at the start of its `preUpdate` method.
	 * This hook is designed specifically for input plugins, but can also be listened to from user-land code.
	 *
	 * @since 1.0.0
	**/
	var PRE_UPDATE = "preupdate";

	/**
	 * The Input Plugin Shutdown Event.
	 *
	 * This internal event is dispatched by the Input Plugin when it shuts down, signalling to all of its systems to shut themselves down.
	 *
	 * @since 1.0.0
	**/
	var SHUTDOWN = "shutdown";

	/**
	 * The Input Plugin Start Event.
	 *
	 * This internal event is dispatched by the Input Plugin when it has finished setting-up,
	 * signalling to all of its internal systems to start.
	 *
	 * @since 1.0.0
	**/
	var START = "start";

	/**
	 * The Input Plugin Update Event.
	 *
	 * This internal event is dispatched by the Input Plugin at the start of its `update` method.
	 * This hook is designed specifically for input plugins, but can also be listened to from user-land code.
	 *
	 * @event Phaser.Input.Events#UPDATE
	 * @since 3.0.0
	 *
	 * @param time {Float} - The current time. Either a High Resolution Timer value if it comes from Request Animation Frame, or Date.now if using SetTimeout.
	 * @param delta {Float} - The delta time in ms since the last frame. This is a smoothed and capped value based on the FPS rate.
	**/
	var UPDATE = "update";
}
