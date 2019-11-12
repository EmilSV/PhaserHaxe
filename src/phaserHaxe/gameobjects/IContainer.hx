package phaserHaxe.gameobjects;

import phaserHaxe.gameobjects.components.IOrigin;
import phaserHaxe.gameobjects.components.TransformMatrix;
import phaserHaxe.gameobjects.components.IVisible;
import phaserHaxe.gameobjects.components.ITransform;
import phaserHaxe.gameobjects.components.IMask;
import phaserHaxe.gameobjects.components.IDepth;
import phaserHaxe.gameobjects.components.IComputedSize;
import phaserHaxe.gameobjects.components.IBlendMode;
import phaserHaxe.gameobjects.components.IAlpha;
import phaserHaxe.gameobjects.components.IScrollFactor;
import phaserHaxe.gameobjects.GameObject;
import phaserHaxe.utils.types.MultipleOrOne;
import phaserHaxe.utils.ArrayUtils;
import phaserHaxe.math.Vector2;
import phaserHaxe.gameobjects.components.IGetBounds;
import phaserHaxe.geom.Rectangle;
import phaserHaxe.gameobjects.components.TransformMatrix;
import phaserHaxe.textures.Frame;
import phaserHaxe.utils.types.StringOrInt;
import phaserHaxe.Scene;
import phaserHaxe.gameobjects.Container;
import phaserHaxe.input.typedefs.HitAreaCallback;
import phaserHaxe.input.typedefs.InputConfiguration;
import phaserHaxe.gameobjects.typedefs.JSONGameObject;
import phaserHaxe.cameras.scene2D.Camera;
import phaserHaxe.data.DataManager;
import phaserHaxe.types.input.InteractiveObject;
import phaserHaxe.physics.arcade.Body;
import phaserHaxe.gameobjects.components.IVisible;
import phaserHaxe.utils.types.Union;

@:allow(phaserHaxe)
interface IContainer extends IAlpha extends IBlendMode extends IComputedSize extends IDepth extends IMask extends ITransform extends IVisible extends IOrigin
{
	/**
	 * The Scene to which this Game Object belongs.
	 * Game Objects can only belong to one Scene.
	 * @since 1.0.0
	**/
	public var scene:Scene;

	/**
	 * A textual representation of this Game Object, i.e. `sprite`.
	 * Used internally by Phaser but is available for your own custom classes to populate.
	 * @since 1.0.0
	**/
	public var type:String;

	/**
	 * The current state of this Game Object.
	 *
	 * Phaser itself will never modify this value, although plugins may do so.
	 *
	 * Use this property to track the state of a Game Object during its lifetime. For example, it could move from
	 * a state of 'moving', to 'attacking', to 'dead'. The state value should be an integer (ideally mapped to a constant
	 * in your game code), or a string. These are recommended to keep it light and simple, with fast comparisons.
	 * If you need to store complex data about your Game Object, look at using the Data Component instead.
	 * @since 1.0.0
	**/
	public var state:StringOrInt;

	/**
	 * The parent Container of this Game Object, if it has one.
	 *
	 * @since 1.0.0
	**/
	public var parentContainer:Container;

	/**
	 * The name of this Game Object.
	 * Empty by default and never populated by Phaser, this is left for developers to use.
	 *
	 * @since 1.0.0
	**/
	public var name:String;

	/**
	 * The active state of this Game Object.
	 * A Game Object with an active state of `true` is processed by the Scenes UpdateList, if added to it.
	 * An active object is one which is having its logic and internal systems updated.
	 *
	 * @since 1.0.0
	 */
	public var active:Bool;

	/**
	 * The Tab Index of the Game Object.
	 * Reserved for future use by plugins and the Input Manager.
	 *
	 * @since 1.0.0
	**/
	public var tabIndex:Int;

	/**
	 * A Data Manager.
	 * It allows you to store, query and get key/value paired information specific to this Game Object.
	 * `null` by default. Automatically created if you use `getData` or `setData` or `setDataEnabled`.
	 *
	 * @since 1.0.0
	**/
	public var data:DataManager;

	/**
	 * The flags that are compared against `RENDER_MASK` to determine if this Game Object will render or not.
	 * The bits are 0001 | 0010 | 0100 | 1000 set by the components Visible, Alpha, Transform and Texture respectively.
	 * If those components are not used by your custom class then you can use this bitmask as you wish.
	 *
	 * @since 1.0.0
	**/
	public var renderFlags:Int;

	/**
	 * A bitmask that controls if this Game Object is drawn by a Camera or not.
	 * Not usually set directly, instead call `Camera.ignore`, however you can
	 * set this property directly using the Camera.id property:
	 *
	 * @example
	 * this.cameraFilter |= camera.id
	 *
	 * @since 1.0.0
	**/
	public var cameraFilter:Int;

	/**
	 * If this Game Object is enabled for input then this property will contain an InteractiveObject instance.
	 * Not usually set directly. Instead call `GameObject.setInteractive()`.
	 *
	 * @since 1.0.0
	**/
	public var input:Null<InteractiveObject>;

	/**
	 * If this Game Object is enabled for physics then this property will contain a reference to a Physics Body.
	 *
	 * @since 1.0.0
	**/
	public var body:Body;

	/**
	 * This Game Object will ignore all calls made to its destroy method if this flag is set to `true`.
	 * This includes calls that may come from a Group, Container or the Scene itself.
	 * While it allows you to persist a Game Object across Scenes, please understand you are entirely
	 * responsible for managing references to and from this Game Object.
	 *
	 * @since 1.0.0
	**/
	public var ignoreDestroy:Bool;

	/**
	 * Does this Container exclusively manage its children?
	 *
	 * The default is `true` which means a child added to this Container cannot
	 * belong in another Container, which includes the Scene display list.
	 *
	 * If you disable this then this Container will no longer exclusively manage its children.
	 * This allows you to create all kinds of interesting graphical effects, such as replicating
	 * Game Objects without reparenting them all over the Scene.
	 * However, doing so will prevent children from receiving any kind of input event or have
	 * their physics bodies work by default, as they're no longer a single entity on the
	 * display list, but are being replicated where-ever this Container is.
	 *
	 * @since 1.0.0
	**/
	public var exclusive:Bool;

	/**
	 * Containers can have an optional maximum size. If set to anything above 0 it
	 * will constrict the addition of new Game Objects into the Container, capping off
	 * the maximum limit the Container can grow in size to.
	 *
	 * @since 1.0.0
	**/
	public var maxSize:Int;

	/**
	 * The cursor position.
	 *
	 * @since 1.0.0
	**/
	public var position:Int;

	/**
	 * The horizontal scroll factor of this Container.
	 *
	 * The scroll factor controls the influence of the movement of a Camera upon this Container.
	 *
	 * When a camera scrolls it will change the location at which this Container is rendered on-screen.
	 * It does not change the Containers actual position values.
	 *
	 * For a Container, setting this value will only update the Container itself, not its children.
	 * If you wish to change the scrollFactor of the children as well, use the `setScrollFactor` method.
	 *
	 * A value of 1 means it will move exactly in sync with a camera.
	 * A value of 0 means it will not move at all, even if the camera moves.
	 * Other values control the degree to which the camera movement is mapped to this Container.
	 *
	 * Please be aware that scroll factor values other than 1 are not taken in to consideration when
	 * calculating physics collisions. Bodies always collide based on their world position, but changing
	 * the scroll factor is a visual adjustment to where the textures are rendered, which can offset
	 * them from physics bodies if not accounted for in your code.
	 *
	 * @since 1.0.0
	**/
	public var scrollFactorX:Float;

	/**
	 * The vertical scroll factor of this Container.
	 *
	 * The scroll factor controls the influence of the movement of a Camera upon this Container.
	 *
	 * When a camera scrolls it will change the location at which this Container is rendered on-screen.
	 * It does not change the Containers actual position values.
	 *
	 * For a Container, setting this value will only update the Container itself, not its children.
	 * If you wish to change the scrollFactor of the children as well, use the `setScrollFactor` method.
	 *
	 * A value of 1 means it will move exactly in sync with a camera.
	 * A value of 0 means it will not move at all, even if the camera moves.
	 * Other values control the degree to which the camera movement is mapped to this Container.
	 *
	 * Please be aware that scroll factor values other than 1 are not taken in to consideration when
	 * calculating physics collisions. Bodies always collide based on their world position, but changing
	 * the scroll factor is a visual adjustment to where the textures are rendered, which can offset
	 * them from physics bodies if not accounted for in your code.
	 *
	 * @since 1.0.0
	**/
	public var scrollFactorY:Float;

	/**
	 * The native (un-scaled) width of this Game Object.
	 *
	 * Changing this value will not change the size that the Game Object is rendered in-game.
	 * For that you need to either set the scale of the Game Object (`setScale`) or use
	 * the `displayWidth` property.
	 *
	 * @since 1.0.0
	**/
	public var width:Float;

	/**
	 * The native (un-scaled) height of this Game Object.
	 *
	 * Changing this value will not change the size that the Game Object is rendered in-game.
	 * For that you need to either set the scale of the Game Object (`setScale`) or use
	 * the `displayHeight` property.
	 *
	 * @since 1.0.0
	 */
	public var height:Float;

	/**
	 * The displayed width of this Game Object.
	 *
	 * This value takes into account the scale factor.
	 *
	 * Setting this value will adjust the Game Object's scale property.
	 *
	 * @since 1.0.0
	**/
	public var displayWidth(get, set):Float;

	/**
	 * The displayed height of this Game Object.
	 *
	 * This value takes into account the scale factor.
	 *
	 * Setting this value will adjust the Game Object's scale property.
	 *
	 * @since 1.0.0
	**/
	public var displayHeight(get, set):Float;

	/**
	 * Sets the `active` property of this Game Object and returns this Game Object for further chaining.
	 * A Game Object with its `active` property set to `true` will be updated by the Scenes UpdateList.
	 *
	 * @since 1.0.0
	 *
	 * @param value - True if this Game Object should be set as active, false if not.
	 *
	 * @return This GameObject.
	**/
	public function setActive(value:Bool):GameObject;

	/**
	 * Sets the `name` property of this Game Object and returns this Game Object for further chaining.
	 * The `name` property is not populated by Phaser and is presented for your own use.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The name to be given to this Game Object.
	 *
	 * @return This GameObject.
	**/
	public function setName(value:String):GameObject;

	/**
	 * Sets the current state of this Game Object.
	 *
	 * Phaser itself will never modify the State of a Game Object, although plugins may do so.
	 *
	 * For example, a Game Object could change from a state of 'moving', to 'attacking', to 'dead'.
	 * The state value should typically be an integer (ideally mapped to a constant
	 * in your game code), but could also be a string. It is recommended to keep it light and simple.
	 * If you need to store complex data about your Game Object, look at using the Data Component instead.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The state of the Game Object.
	 *
	 * @return This GameObject.
	**/
	public function setState(value:StringOrInt):GameObject;

	/**
	 * Adds a Data Manager component to this Game Object.
	 *
	 * @since 1.0.0
	 * @see Phaser.Data.DataManager
	 *
	 * @return This GameObject.
	**/
	public function setDataEnabled():GameObject;

	/**
	 * Allows you to store a key value pair within this Game Objects Data Manager.
	 *
	 * If the Game Object has not been enabled for data (via `setDataEnabled`) then it will be enabled
	 * before setting the value.
	 *
	 * If the key doesn't already exist in the Data Manager then it is created.
	 *
	 * ```haxe
	 * sprite.setData('name', 'Red Gem Stone');
	 * ```
	 *
	 * You can also pass in an object of key value pairs as the first argument:
	 *
	 * ```haxe
	 * sprite.setData({ name: 'Red Gem Stone', level: 2, owner: 'Link', gold: 50 });
	 * ```
	 *
	 * To get a value back again you can call `getData`:
	 *
	 * ```haxe
	 * sprite.getData('gold');
	 * ```
	 *
	 * Or you can access the value directly via the `values` property, where it works like any other variable:
	 *
	 * ```haxe
	 * sprite.data.values.gold += 50;
	 * ```
	 *
	 * When the value is first set, a `setdata` event is emitted from this Game Object.
	 *
	 * If the key already exists, a `changedata` event is emitted instead, along an event named after the key.
	 * For example, if you updated an existing key called `PlayerLives` then it would emit the event `changedata-PlayerLives`.
	 * These events will be emitted regardless if you use this method to set the value, or the direct `values` setter.
	 *
	 * Please note that the data keys are case-sensitive and must be valid JavaScript Object property strings.
	 * This means the keys `gold` and `Gold` are treated as two unique values within the Data Manager.
	 *
	 * @method Phaser.GameObjects.GameObject#setData
	 * @since 1.0.0
	 *
	 * @param key - The key to set the value for. Or an object or key value pairs. If an object the `data` argument is ignored.
	 * @param value - The value to set for the given key. If an object is provided as the key this argument is ignored.
	 *
	 * @return This GameObject.
	**/
	public function setData(key:Union<String, {}>, ?value:Dynamic):GameObject;

	/**
	 * Retrieves the value for the given key in this Game Objects Data Manager, or undefined if it doesn't exist.
	 *
	 * You can also access values via the `values` object. For example, if you had a key called `gold` you can do either:
	 *
	 * ```haxe
	 * sprite.getData('gold');
	 * ```
	 *
	 * Or access the value directly:
	 *
	 * ```haxe
	 * sprite.data.values.gold;
	 * ```
	 *
	 * You can also pass in an array of keys, in which case an array of values will be returned:
	 *
	 * ```haxe
	 * sprite.getData([ 'gold', 'armor', 'health' ]);
	 * ```
	 *
	 *
	 * @since 1.0.0
	 *
	 * @param key - The key of the value to retrieve, or an array of keys.
	 *
	 * @return The value belonging to the given key, or an array of values, the order of which will match the input array.
	**/
	public function getData(key:Union<String, Array<String>>):Dynamic;

	/**
	 * Pass this Game Object to the Input Manager to enable it for Input.
	 *
	 * Input works by using hit areas, these are nearly always geometric shapes, such as rectangles or circles, that act as the hit area
	 * for the Game Object. However, you can provide your own hit area shape and callback, should you wish to handle some more advanced
	 * input detection.
	 *
	 * If no arguments are provided it will try and create a rectangle hit area based on the texture frame the Game Object is using. If
	 * this isn't a texture-bound object, such as a Graphics or BitmapText object, this will fail, and you'll need to provide a specific
	 * shape for it to use.
	 *
	 * You can also provide an Input Configuration Object as the only argument to this method.
	 *
	 * @since 1.0.0
	 *
	 * @param shape - either an input configuration object, or a geometric shape that defines the hit area for the Game Object. If not specified a Rectangle will be used.
	 * @param callback - A callback to be invoked when the Game Object is interacted with. If you provide a shape you must also provide a callback.
	 * @param dropZone - Should this Game Object be treated as a drop zone target?
	 *
	 * @return This GameObject.
	**/
	public function setInteractive(?shape:Union<InputConfiguration, Any>,
		?callback:HitAreaCallback, dropZone:Bool = false):GameObject;

	/**
	 * If this Game Object has previously been enabled for input, this will disable it.
	 *
	 * An object that is disabled for input stops processing or being considered for
	 * input events, but can be turned back on again at any time by simply calling
	 * `setInteractive()` with no arguments provided.
	 *
	 * If want to completely remove interaction from this Game Object then use `removeInteractive` instead.
	 *
	 * @since 1.0.0
	 *
	 * @return This GameObject.
	**/
	public function disableInteractive():GameObject;

	/**
	 * If this Game Object has previously been enabled for input, this will queue it
	 * for removal, causing it to no longer be interactive. The removal happens on
	 * the next game step, it is not immediate.
	 *
	 * The Interactive Object that was assigned to this Game Object will be destroyed,
	 * removed from the Input Manager and cleared from this Game Object.
	 *
	 * If you wish to re-enable this Game Object at a later date you will need to
	 * re-create its InteractiveObject by calling `setInteractive` again.
	 *
	 * If you wish to only temporarily stop an object from receiving input then use
	 * `disableInteractive` instead, as that toggles the interactive state, where-as
	 * this erases it completely.
	 *
	 * If you wish to resize a hit area, don't remove and then set it as being
	 * interactive. Instead, access the hitarea object directly and resize the shape
	 * being used. I.e.: `sprite.input.hitArea.setSize(width, height)` (assuming the
	 * shape is a Rectangle, which it is by default.)
	 *
	 * @since 1.0.0
	 *
	 * @return This GameObject.
	**/
	public function removeInteractive():GameObject;

	/**
	 * To be overridden by custom GameObjects. Allows base objects to be used in a Pool.
	 *
	 * @since 1.0.0
	 *
	 * @param args - args
	**/
	public function update(?args:Array<Dynamic>):Void;

	/**
	 * Returns a JSON representation of the Game Object.
	 *
	 * @since 1.0.0
	 *
	 * @return A JSON representation of the Game Object.
	**/
	public function toJSON():JSONGameObject;

	/**
	 * Compares the renderMask with the renderFlags to see if this Game Object will render or not.
	 * Also checks the Game Object against the given Cameras exclusion list.
	 *
	 * @since 1.0.0
	 *
	 * @param camera - The Camera to check against this Game Object.
	 *
	 * @return True if the Game Object should be rendered, otherwise false.
	**/
	public function willRender(camera:Camera):Bool;

	/**
	 * Returns an array containing the display list index of either this Game Object, or if it has one,
	 * its parent Container. It then iterates up through all of the parent containers until it hits the
	 * root of the display list (which is index 0 in the returned array).
	 *
	 * Used internally by the InputPlugin but also useful if you wish to find out the display depth of
	 * this Game Object and all of its ancestors.
	 *
	 * @since 1.0.0
	 *
	 * @return An array of display list position indexes.
	**/
	public function getIndexList():Array<Int>;

	public function preDestroy():Void;

	/**
	 * Destroys this Game Object removing it from the Display List and Update List and
	 * severing all ties to parent resources.
	 *
	 * Also removes itself from the Input Manager and Physics Manager if previously enabled.
	 *
	 * Use this to remove a Game Object from your game if you don't ever plan to use it again.
	 * As long as no reference to it exists within your own code it should become free for
	 * garbage collection by the browser.
	 *
	 * If you just want to temporarily disable an object then look at using the
	 * Game Object Pool instead of destroying it, as destroyed objects cannot be resurrected.
	 *
	 * @since 1.0.0
	 *
	 * @param fromScene - Is this Game Object being destroyed as the result of a Scene shutdown?
	**/
	public function destroy(fromScene:Bool = false):Void;

	/**
	 * Internal function to allow Containers to be used for input and physics.
	 * Do not use this function. It has no effect.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The horizontal origin value.
	 * @param y - The vertical origin value. If not defined it will be set to the value of `x`.
	 *
	 * @return This Game Object instance.
	**/
	@:noCompletion
	public function setOrigin(x:Float = 0.5, ?y:Float):IContainer;

	/**
	 * Internal function to allow Containers to be used for input and physics.
	 * Do not use this function. It has no effect.
	 *
	 * @since 1.0.0
	 *
	 * @return This Game Object instance.
	**/
	@:noCompletion
	public function setOriginFromFrame():IContainer;

	/**
	 * Internal function to allow Containers to be used for input and physics.
	 * Do not use this function. It has no effect.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The horizontal display origin value.
	 * @param y - The vertical display origin value. If not defined it will be set to the value of `x`.
	 *
	 * @return This Game Object instance.
	**/
	@:noCompletion
	public function setDisplayOrigin(x:Float = 0, ?y:Float):IContainer;

	/**
	 * Internal function to allow Containers to be used for input and physics.
	 * Do not use this function. It has no effect.
	 *
	 * @since 1.0.0
	 *
	 * @return This Game Object instance.
	**/
	@:noCompletion
	public function updateDisplayOrigin():IContainer;

	/**
	 * Sets the size of this Game Object to be that of the given Frame.
	 *
	 * This will not change the size that the Game Object is rendered in-game.
	 * For that you need to either set the scale of the Game Object (`setScale`) or call the
	 * `setDisplaySize` method, which is the same thing as changing the scale but allows you
	 * to do so by giving pixel values.
	 *
	 * If you have enabled this Game Object for input, changing the size will _not_ change the
	 * size of the hit area. To do this you should adjust the `input.hitArea` object directly.
	 *
	 * @since 1.0.0
	 *
	 * @param frame - The frame to base the size of this Game Object on.
	 *
	 * @return This Game Object instance.
	**/
	public function setSizeToFrame(?frame:Frame):IContainer;

	/**
	 * Sets the internal size of this Game Object, as used for frame or physics body creation.
	 *
	 * This will not change the size that the Game Object is rendered in-game.
	 * For that you need to either set the scale of the Game Object (`setScale`) or call the
	 * `setDisplaySize` method, which is the same thing as changing the scale but allows you
	 * to do so by giving pixel values.
	 *
	 * If you have enabled this Game Object for input, changing the size will _not_ change the
	 * size of the hit area. To do this you should adjust the `input.hitArea` object directly.
	 *
	 * @since 1.0.0
	 *
	 * @param width - The width of this Game Object.
	 * @param height - The height of this Game Object.
	 *
	 * @return This Game Object instance.
	**/
	public function setSize(width:Float, height:Float):IContainer;

	/**
	 * Sets the display size of this Game Object.
	 *
	 * Calling this will adjust the scale.
	 *
	 * @since 1.0.0
	 *
	 * @param width - The width of this Game Object.
	 * @param height - The height of this Game Object.
	 *
	 * @return This Game Object instance.
	**/
	public function setDisplaySize(width:Float, height:Float):IContainer;

	/**
	 * Does this IContainer exclusively manage its children?
	 *
	 * The default is `true` which means a child added to this IContainer cannot
	 * belong in another IContainer, which includes the Scene display list.
	 *
	 * If you disable this then this IContainer will no longer exclusively manage its children.
	 * This allows you to create all kinds of interesting graphical effects, such as replicating
	 * Game Objects without reparenting them all over the Scene.
	 * However, doing so will prevent children from receiving any kind of input event or have
	 * their physics bodies work by default, as they're no longer a single entity on the
	 * display list, but are being replicated where-ever this IContainer is.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The exclusive state of this IContainer.
	 *
	 * @return This IContainer.
	**/
	public function setExclusive(value:Bool = true):IContainer;

	/**
	 * Gets the bounds of this IContainer. It works by iterating all children of the IContainer,
	 * getting their respective bounds, and then working out a min-max rectangle from that.
	 * It does not factor in if the children render or not, all are included.
	 *
	 * Some children are unable to return their bounds, such as Graphics objects, in which case
	 * they are skipped.
	 *
	 * Depending on the quantity of children in this IContainer it could be a really expensive call,
	 * so cache it and only poll it as needed.
	 *
	 * The values are stored and returned in a Rectangle object.
	 *
	 * @since 1.0.0
	 *
	 * @param output - A Geom.Rectangle object to store the values in. If not provided a new Rectangle will be created.
	 *
	 * @return The values stored in the output object.
	**/
	public function getBounds(?output:Rectangle):Rectangle;

	/**
	 * Takes a Point-like object, such as a Vector2, Geom.Point or object with public x and y properties,
	 * and transforms it into the space of this IContainer, then returns it in the output object.
	 *
	 * @since 1.0.0
	 *
	 * @param source - The Source Point to be transformed.
	 * @param output - A destination object to store the transformed point in. If none given a Vector2 will be created and returned.
	 *
	 * @return The transformed point.
	**/
	public function pointToContainer(source:Vector2, ?output:Vector2):Vector2;

	/**
	 * Returns the world transform matrix as used for Bounds checks.
	 *
	 * The returned matrix is temporal and shouldn't be stored.
	 *
	 * @since 1.0.0
	 *
	 * @return The world transform matrix.
	**/
	public function getBoundsTransformMatrix():TransformMatrix;

	/**
	 * Adds the given Game Object, or array of Game Objects, to this IContainer.
	 *
	 * Each Game Object must be unique within the IContainer.
	 *
	 * @since 1.0.0
	 *
	 * @param child - The Game Object, or array of Game Objects, to add to the IContainer.
	 *
	 * @return This IContainer instance.
	**/
	public function add(child:Array<GameObject>):IContainer;

	/**
	 * Adds the given Game Object, or array of Game Objects, to this IContainer at the specified position.
	 *
	 * Existing Game Objects in the IContainer are shifted up.
	 *
	 * Each Game Object must be unique within the IContainer.
	 *
	 * @since 1.0.0
	 *
	 * @param child - The Game Object, or array of Game Objects, to add to the IContainer.
	 * @param index - The position to insert the Game Object/s at.
	 *
	 * @return This IContainer instance.
	**/
	public function addAt(child:MultipleOrOne<GameObject>, index:Int = 0):IContainer;

	/**
	 * Returns the Game Object at the given position in this IContainer.
	 *
	 * @method Phaser.GameObjects.IContainer#getAt
	 * @since 1.0.0
	 *
	 * @param index - The position to get the Game Object from.
	 *
	 * @return The Game Object at the specified index, or `null` if none found.
	**/
	public function getAt(index:Int):Null<GameObject>;

	/**
	 * Returns the index of the given Game Object in this IContainer.
	 *
	 * @since 1.0.0
	 *
	 * @param child - The Game Object to search for in this IContainer.
	 *
	 * @return The index of the Game Object in this IContainer, or -1 if not found.
	 */
	public function getIndex(child:GameObject):Int;

	/**
	 * [description]
	 *
	 * @since 1.0.0
	**/
	public function sort(arg:Container.SortBy<GameObject>):IContainer;

	/**
	 * Searches for the first instance of a child with its `name` property matching the given argument.
	 * Should more than one child have the same name only the first is returned.
	 *
	 * @since 1.0.0
	 *
	 * @param name - The name to search for.
	 *
	 * @return The first child with a matching name, or `null` if none were found.
	**/
	public function getByName(name:String):Null<GameObject>;

	/**
	 * Returns a random Game Object from this IContainer.
	 *
	 * @since 1.0.0
	 *
	 * @param startIndex - An optional start index.
	 * @param length - An optional length, the total number of elements (from the startIndex) to choose from.
	 *
	 * @return A random child from the IContainer, or `null` if the IContainer is empty.
	**/
	public function getRandom(startIndex:Int = 0, ?length:Int):Null<GameObject>;

	/**
	 * Gets the first Game Object in this IContainer.
	 *
	 * You can also specify a function to get the property and value to search for, in which case it will return the first
	 * Game Object in this IContainer with a matching property and / or value.
	 *
	 * For example: `getFirst(go -> go.visible, true)` would return the first Game Object that had its `visible` property set.
	 *
	 * You can limit the search to the `startIndex` - `endIndex` range.
	 *
	 * @since 1.0.0
	 *
	 * @param propertyAccessor - The function to get the property to test on each Game Object in the IContainer.
	 * @param value - The value to test the property against.
	 * @param startIndex - An optional start index to search from.
	 * @param endIndex - An optional end index to search up to (but not included)
	 *
	 * @return The first matching Game Object, or `null` if none was found.
	**/
	public function getFirst<T>(?propertyAccessor:(GameObject) -> T, ?value:T,
		startIndex:Int = 0, ?endIndex:Int):Null<GameObject>;

	/**
	 * Returns all Game Objects in this IContainer.
	 *
	 * You can optionally specify a matching criteria using the `propertyAccessor` and `value` arguments.
	 *
	 * For example: `getAll(go -> go.body)` would return only Game Objects that have a body property.
	 *
	 * You can also specify a value to compare the property to:
	 *
	 * `getAll(go -> go.visible, true)` would return only Game Objects that have their visible property set to `true`.
	 *
	 * Optionally you can specify a start and end index. For example if this IContainer had 100 Game Objects,
	 * and you set `startIndex` to 0 and `endIndex` to 50, it would return matches from only
	 * the first 50 Game Objects.
	 *
	 * @since 1.0.0
	 *
	 * @param propertyAccessor - The function to get the property to test on each Game Object in the IContainer.
	 * @param value - If property is set then the `property` must strictly equal this value to be included in the results.
	 * @param startIndex - An optional start index to search from.
	 * @param endIndex - An optional end index to search up to (but not included)
	 *
	 * @return An array of matching Game Objects from this IContainer.
	**/
	public function getAll<T>(?propertyAccessor:(GameObject) -> T, ?value:T,
		startIndex:Int = 0, ?endIndex:Int):Array<GameObject>;

	/**
	 * Returns the total number of Game Objects in this IContainer that have a property
	 * matching the given value.
	 *
	 * For example: `count(go -> go.visible, true)` would count all the elements that have their visible property set.
	 *
	 * You can optionally limit the operation to the `startIndex` - `endIndex` range.
	 *
	 * @since 1.0.0
	 *
	 * @param propertyAccessor - The function to get the property to check.
	 * @param value - The value to check.
	 * @param startIndex - An optional start index to search from.
	 * @param endIndex - An optional end index to search up to (but not included)
	 *
	 * @return The total number of Game Objects in this IContainer with a property matching the given value.
	**/
	public function count<T>(propertyAccessor:(GameObject) -> T, value:T,
		startIndex:Int = 0, endIndex:Int):Int;

	/**
	 * Swaps the position of two Game Objects in this IContainer.
	 * Both Game Objects must belong to this IContainer.
	 *
	 * @since 1.0.0
	 *
	 * @param child1 - The first Game Object to swap.
	 * @param child2 - The second Game Object to swap.
	 *
	 * @return This IContainer instance.
	**/
	public function swap(child1:GameObject, child2:GameObject):IContainer;

	/**
	 * Moves a Game Object to a new position within this IContainer.
	 *
	 * The Game Object must already be a child of this IContainer.
	 *
	 * The Game Object is removed from its old position and inserted into the new one.
	 * Therefore the IContainer size does not change. Other children will change position accordingly.
	 *
	 * @since 1.0.0
	 *
	 * @param child - The Game Object to move.
	 * @param index - The new position of the Game Object in this IContainer.
	 *
	 * @return This IContainer instance.
	**/
	public function moveTo(child:GameObject, index:Int):IContainer;

	/**
	 * Removes the given Game Object, or array of Game Objects, from this IContainer.
	 *
	 * The Game Objects must already be children of this IContainer.
	 *
	 * You can also optionally call `destroy` on each Game Object that is removed from the IContainer.
	 *
	 * @since 1.0.0
	 *
	 * @param child - The Game Object, or array of Game Objects, to be removed from the IContainer.
	 * @param destroyChild - Optionally call `destroy` on each child successfully removed from this IContainer.
	 *
	 * @return This IContainer instance.
	**/
	public function remove(child:MultipleOrOne<GameObject>,
		destroyChild:Bool = false):IContainer;

	/**
	 * Removes the Game Object at the given position in this IContainer.
	 *
	 * You can also optionally call `destroy` on the Game Object, if one is found.
	 *
	 * @since 1.0.0
	 *
	 * @param index - The index of the Game Object to be removed.
	 * @param destroyChild - Optionally call `destroy` on the Game Object if successfully removed from this IContainer.
	 *
	 * @return This IContainer instance.
	**/
	public function removeAt(index:Int, destroyChild:Bool = false):IContainer;

	/**
	 * Removes the Game Objects between the given positions in this IContainer.
	 *
	 * You can also optionally call `destroy` on each Game Object that is removed from the IContainer.
	 *
	 * @since 1.0.0
	 *
	 * @param startIndex - An optional start index to search from.
	 * @param endIndex - An optional end index to search up to (but not included)
	 * @param destroyChild - Optionally call `destroy` on each Game Object successfully removed from this IContainer.
	 *
	 * @return This IContainer instance.
	**/
	public function removeBetween(startIndex:Int = 0, ?endIndex:Int,
		destroyChild:Bool = false):IContainer;

	/**
	 * Removes all Game Objects from this IContainer.
	 *
	 * You can also optionally call `destroy` on each Game Object that is removed from the IContainer.
	 *
	 * @since 1.0.0
	 *
	 * @param destroyChild - Optionally call `destroy` on each Game Object successfully removed from this IContainer.
	 *
	 * @return This IContainer instance.
	**/
	public function removeAll(destroyChild:Bool):IContainer;

	/**
	 * Brings the given Game Object to the top of this IContainer.
	 * This will cause it to render on-top of any other objects in the IContainer.
	 *
	 * @since 1.0.0
	 *
	 * @param child - The Game Object to bring to the top of the IContainer.
	 *
	 * @return This IContainer instance.
	**/
	public function bringToTop(child:GameObject):IContainer;

	/**
	 * Sends the given Game Object to the bottom of this IContainer.
	 * This will cause it to render below any other objects in the IContainer.
	 *
	 * @since 1.0.0
	 *
	 * @param child - The Game Object to send to the bottom of the IContainer.
	 *
	 * @return This IContainer instance.
	**/
	public function sendToBack(child:GameObject):IContainer;

	/**
	 * Moves the given Game Object up one place in this IContainer, unless it's already at the top.
	 *
	 * @since 1.0.0
	 *
	 * @param child - The Game Object to be moved in the IContainer.
	 *
	 * @return This IContainer instance.
	**/
	public function moveUp(child:GameObject):IContainer;

	/**
	 * Moves the given Game Object down one place in this IContainer, unless it's already at the bottom.
	 *
	 * @since 1.0.0
	 *
	 * @param child - The Game Object to be moved in the IContainer.
	 *
	 * @return This IContainer instance.
	**/
	public function moveDown(child:GameObject):IContainer;

	/**
	 * Reverses the order of all Game Objects in this IContainer.
	 *
	 * @since 1.0.0
	 *
	 * @return This IContainer instance.
	**/
	public function reverse():IContainer;

	/**
	 * Shuffles the all Game Objects in this IContainer using the Fisher-Yates implementation.
	 *
	 * @since 1.0.0
	 *
	 * @return This IContainer instance.
	**/
	public function shuffle():IContainer;

	/**
	 * Replaces a Game Object in this IContainer with the new Game Object.
	 * The new Game Object cannot already be a child of this IContainer.
	 *
	 * @since 1.0.0
	 *
	 * @param oldChild - The Game Object in this IContainer that will be replaced.
	 * @param newChild - The Game Object to be added to this IContainer.
	 * @param destroyChild - Optionally call `destroy` on the Game Object if successfully removed from this IContainer.
	 *
	 * @return This IContainer instance.
	**/
	public function replace(oldChild:GameObject, newChild:GameObject,
		destroyChild:Bool = false):IContainer;

	/**
	 * Returns `true` if the given Game Object is a direct child of this IContainer.
	 *
	 * This check does not scan nested Containers.
	 *
	 * @since 1.0.0
	 *
	 * @param child - The Game Object to check for within this IContainer.
	 *
	 * @return True if the Game Object is an immediate child of this IContainer, otherwise false.
	**/
	public function exists(child:GameObject):Bool;

	/**
	 * Sets the property to the given value on all Game Objects in this IContainer.
	 *
	 * Optionally you can specify a start and end index. For example if this IContainer had 100 Game Objects,
	 * and you set `startIndex` to 0 and `endIndex` to 50, it would return matches from only
	 * the first 50 Game Objects.
	 *
	 * @since 1.0.0
	 *
	 * @param propertySetter - The propertySetter that set the property on the Game Object.
	 * @param value - The value to get the property to.
	 * @param  startIndex - An optional start index to search from.
	 * @param  endIndex - An optional end index to search up to (but not included)
	 *
	 * @return This IContainer instance.
	**/
	public function setAll<T>(propertySetter:(GameObject, T) -> Void, value:T,
		startIndex:Int = 0, ?endIndex:Int):IContainer;

	/**
	 * Passes all Game Objects in this IContainer to the given callback.
	 *
	 * A copy of the IContainer is made before passing each entry to your callback.
	 * This protects against the callback itself modifying the IContainer.
	 *
	 * If you know for sure that the callback will not change the size of this IContainer
	 * then you can use the more performant `IContainer.iterate` method instead.
	 *
	 * @since 1.0.0
	 *
	 * @param callback - The function to call.
	 *
	 * @return This IContainer instance.
	**/
	public function each(callback:(GameObject) -> Void):IContainer;

	/**
	 * Passes all Game Objects in this IContainer to the given callback.
	 *
	 * Only use this method when you absolutely know that the IContainer will not be modified during
	 * the iteration, i.e. by removing or adding to its contents.
	 *
	 * @since 1.0.0
	 *
	 * @param callback - The function to call.
	 *
	 * @return This IContainer instance.
	**/
	public function iterate(callback:(GameObject) -> Void):IContainer;

	public function iterator():Iterator<GameObject>;

	/**
	 * Sets the scroll factor of this IContainer and optionally all of its children.
	 *
	 * The scroll factor controls the influence of the movement of a Camera upon this Game Object.
	 *
	 * When a camera scrolls it will change the location at which this Game Object is rendered on-screen.
	 * It does not change the Game Objects actual position values.
	 *
	 * A value of 1 means it will move exactly in sync with a camera.
	 * A value of 0 means it will not move at all, even if the camera moves.
	 * Other values control the degree to which the camera movement is mapped to this Game Object.
	 *
	 * Please be aware that scroll factor values other than 1 are not taken in to consideration when
	 * calculating physics collisions. Bodies always collide based on their world position, but changing
	 * the scroll factor is a visual adjustment to where the textures are rendered, which can offset
	 * them from physics bodies if not accounted for in your code.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The horizontal scroll factor of this Game Object.
	 * @param y - The vertical scroll factor of this Game Object. If not set it will use the `x` value.
	 * @param updateChildren - Apply this scrollFactor to all IContainer children as well?
	 *
	 * @return This Game Object instance.
	**/
	public function setScrollFactor(x:Float, ?y:Float,
		updateChildren:Bool = null):IContainer;

	public function toGameObject():GameObject;
}
