package phaserHaxe.gameobjects;

import phaserHaxe.Scene;
import phaserHaxe.gameobjects.Container;
import phaserHaxe.input.types.HitAreaCallback;
import phaserHaxe.input.types.InputConfiguration;
import phaserHaxe.gameobjects.types.JSONGameObject;
import phaserHaxe.cameras.scene2D.Camera;
import phaserHaxe.data.DataManager;
import phaserHaxe.types.input.InteractiveObject;
import phaserHaxe.physics.arcade.Body;

/**
 * The interface for Game Objects are useful mostly for mixins.
 *
 * @since 1.0.0
 *
**/
interface IGameObject extends IEventEmitter
{
	/**
	 * The Scene to which this Game Object belongs.
	 * Game Objects can only belong to one Scene.
	 * @since 1.0.0
	**/
	private var scene:Scene;

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
	public var state:Either<Int, String>;

	/**
	 * The parent Container of this Game Object, if it has one.
	 *
	 * @since 1.0.0
	**/
	public var parentContainer:Null<Container>;

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
	 * Sets the `active` property of this Game Object and returns this Game Object for further chaining.
	 * A Game Object with its `active` property set to `true` will be updated by the Scenes UpdateList.
	 *
	 * @since 1.0.0
	 *
	 * @param value - True if this Game Object should be set as active, false if not.
	 *
	 * @return This GameObject.
	**/
	public function setActive(value:Bool):IGameObject;

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
	public function setName(value:String):IGameObject;

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
	public function setState(value:Either<Int, String>):IGameObject;

	/**
	 * Adds a Data Manager component to this Game Object.
	 *
	 * @since 1.0.0
	 * @see Phaser.Data.DataManager
	 *
	 * @return This GameObject.
	**/
	public function setDataEnabled():IGameObject;

	/**
	 * Allows you to store a key value pair within this Game Objects Data Manager.
	 *
	 * If the Game Object has not been enabled for data (via `setDataEnabled`) then it will be enabled
	 * before setting the value.
	 *
	 * If the key doesn't already exist in the Data Manager then it is created.
	 *
	 * ```javascript
	 * sprite.setData('name', 'Red Gem Stone');
	 * ```
	 *
	 * You can also pass in an object of key value pairs as the first argument:
	 *
	 * ```javascript
	 * sprite.setData({ name: 'Red Gem Stone', level: 2, owner: 'Link', gold: 50 });
	 * ```
	 *
	 * To get a value back again you can call `getData`:
	 *
	 * ```javascript
	 * sprite.getData('gold');
	 * ```
	 *
	 * Or you can access the value directly via the `values` property, where it works like any other variable:
	 *
	 * ```javascript
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
	 * @since 1.0.0
	 *
	 * @param key - The key to set the value for. Or an object or key value pairs. If an object the `data` argument is ignored.
	 * @param value - The value to set for the given key. If an object is provided as the key this argument is ignored.
	 *
	 * @return This GameObject.
	**/
	public function setData(key:Either<String, {}>, ?value:Dynamic):IGameObject;

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
	public function getData(key:Either<String, Array<String>>):Dynamic;

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
	 * @param shape - Either an input configuration object, or a geometric shape that defines the hit area for the Game Object. If not specified a Rectangle will be used.
	 * @param callback - A callback to be invoked when the Game Object is interacted with. If you provide a shape you must also provide a callback.
	 * @param dropZone - Should this Game Object be treated as a drop zone target?
	 *
	 * @return This GameObject.
	**/
	public function setInteractive(?shape:Either<InputConfiguration, Any>,
		?callback:HitAreaCallback, dropZone:Bool = false):IGameObject;

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
	public function disableInteractive():IGameObject;

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
	public function removeInteractive():IGameObject;

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
}
