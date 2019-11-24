package phaserHaxe.input.typedefs;

import phaserHaxe.gameobjects.shape.Shape;
import phaserHaxe.input.typedefs.HitAreaCallback;
import phaserHaxe.cameras.scene2D.Camera;
import phaserHaxe.utils.types.Union;
import phaserHaxe.gameobjects.GameObject;

/**
 * @since 1.0.0
**/
typedef InteractiveObject =
{
	/**
	 * The Game Object to which this Interactive Object is bound.
	 *
	 * @since 1.0.0
	**/
	public var gameObject:GameObject;

	/**
	 * Is this Interactive Object currently enabled for input events?
	 *
	 * @since 1.0.0
	**/
	public var enabled:Bool;

	/**
	 * An Interactive Object that is 'always enabled' will receive input even if the parent object is invisible or won't render.
	 *
	 * @since 1.0.0
	**/
	public var alwaysEnabled:Bool;

	/**
	 * Is this Interactive Object draggable? Enable with `InputPlugin.setDraggable`.
	 *
	 * @since 1.0.0
	**/
	public var draggable:Bool;

	/**
	 * Is this Interactive Object a drag-targets drop zone? Set when the object is created.
	 *
	 * @since 1.0.0
	**/
	public var dropZone:Bool;

	/**
	 * Should this Interactive Object change the cursor (via css) when over? (desktop only)
	 *
	 * @since 1.0.0
	**/
	public var cursor:Null<String>;

	/**
	 * An optional drop target for a draggable Interactive Object.
	 *
	 * @since 1.0.0
	**/
	public var target:Null<GameObject>;

	/**
	 * The most recent Camera to be tested against this Interactive Object.
	 *
	 * @since 1.0.0
	**/
	public var camera:Camera;

	/**
	 *  The hit area for this Interactive Object. Typically a geometry shape, like a Rectangle or Circle
	 *
	 * @since 1.0.0
	**/
	public var hitArea:Any;

	/**
	 * The 'contains' check callback that the hit area shape will use for all hit tests.
	 *
	 * @since 1.0.0
	**/
	public var hitAreaCallback:HitAreaCallback;

	/**
	 * If this Interactive Object has been enabled for debug, via `InputPlugin.enableDebug` then this property holds its debug shape.
	 *
	 * @since 1.0.0
	**/
	public var hitAreaDebug:Shape;

	/**
	 * Was the hitArea for this Interactive Object created based on texture size (false), or a custom shape? (true)
	 *
	 * @since 1.0.0
	**/
	public var customHitArea:Bool;

	/**
	 * The x coordinate that the Pointer interacted with this object on, relative to the Game Object's top-left position.
	 *
	 * @since 1.0.0
	**/
	public var localX:Float;

	/**
	 * The y coordinate that the Pointer interacted with this object on, relative to the Game Object's top-left position.
	 *
	 * @since 1.0.0
	**/
	public var localY:Float;

	/**
	 *  The current drag state of this Interactive Object. 0 = Not being dragged, 1 = being checked for drag, or 2 = being actively dragged.
	 *
	 * @since 1.0.0
	**/
	public var dragState:DragState;

	/**
	 * The x coordinate of the Game Object that owns this Interactive Object when the drag started.
	 *
	 * @since 1.0.0
	**/
	public var dragStartX:Float;

	/**
	 * The y coordinate of the Game Object that owns this Interactive Object when the drag started.
	 *
	 * @since 1.0.0
	**/
	public var dragStartY:Float;

	/**
	 * The x coordinate that the Pointer started dragging this Interactive Object from.
	 *
	 * @since 1.0.0
	**/
	public var dragStartXGlobal:Float;

	/**
	 * The y coordinate that the Pointer started dragging this Interactive Object from.
	 *
	 * @since 1.0.0
	**/
	public var dragStartYGlobal:Float;

	/**
	 * The x coordinate that this Interactive Object is currently being dragged to.
	 *
	 * @since 1.0.0
	**/
	public var dragX:Float;

	/**
	 * The y coordinate that this Interactive Object is currently being dragged to.
	 *
	 * @since 1.0.0
	**/
	public var dragY:Float;
};
