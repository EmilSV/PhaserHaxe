package phaserHaxe.gameobjects;

import phaserHaxe.gameobjects.components.*;
import phaserHaxe.gameobjects.sprite.ISpriteRenderer;
import phaserHaxe.renderer.webgl.WebGLRenderer;
import phaserHaxe.cameras.scene2D.Camera;
import phaserHaxe.renderer.canvas.CanvasRenderer;
import phaserHaxe.gameobjects.components.IVisible.VisibleMixin;
import phaserHaxe.gameobjects.components.ITransform.TransformMixin;
import phaserHaxe.gameobjects.components.IMask.MaskMixin;
import phaserHaxe.gameobjects.components.IDepth.DepthMixin;
import phaserHaxe.gameobjects.components.IComputedSize.ComputedSizeImplementation;
import phaserHaxe.gameobjects.components.IBlendMode.BlendModeMixin;
import phaserHaxe.gameobjects.components.IAlpha.AlphaMixin;
import phaserHaxe.geom.RectangleUtil;
import phaserHaxe.gameobjects.IGetBoundsTransformMatrix;
import phaserHaxe.gameobjects.GameObject;
import phaserHaxe.utils.types.MultipleOrOne;
import phaserHaxe.utils.ArrayUtils;
import phaserHaxe.math.Vector2;
import phaserHaxe.gameobjects.components.IGetBounds;
import phaserHaxe.geom.Rectangle;
import phaserHaxe.gameobjects.components.TransformMatrix;
import phaserHaxe.textures.Frame;

@:build(phaserHaxe.macro.Mixin.build(AlphaMixin, BlendModeMixin, DepthMixin, MaskMixin, TransformMixin, VisibleMixin))
class Container extends GameObject implements IAlpha implements IBlendMode
		implements IComputedSize implements IDepth implements IMask
		implements ITransform implements IVisible implements IOrigin
		implements IGetBoundsTransformMatrix implements ISpriteRenderer
{
	/**
	 * An array holding the children of this Container.
	 *
	 * @since 1.0.0
	**/
	public var list:Array<GameObject>;

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
	public var exclusive:Bool = true;

	/**
	 * Containers can have an optional maximum size. If set to anything above 0 it
	 * will constrict the addition of new Game Objects into the Container, capping off
	 * the maximum limit the Container can grow in size to.
	 *
	 * @since 1.0.0
	**/
	public var maxSize:Int = -1;

	/**
	 * The cursor position.
	 *
	 * @since 1.0.0
	**/
	public var position:Int = 0;

	/**
	 * Internal Transform Matrix used for local space conversion.
	 *
	 * @since 1.0.0
	**/
	private var localTransform = new TransformMatrix();

	/**
	 * Internal temporary Transform Matrix used to avoid object creation.
	 *
	 * @since 1.0.0
	**/
	private var tempTransformMatrix:TransformMatrix = new TransformMatrix();

	/**
	 * A reference to the Scene Display List.
	 *
	 * @since 1.0.0
	**/
	private var _displayList:DisplayList;

	/**
	 * The property key to sort by.
	 *
	 * @since 1.0.0
	**/
	private var _sortKey = "";

	/**
	 * A reference to the Scene Systems Event Emitter.
	 *
	 * @since 1.0.0
	**/
	private var _sysEvents:EventEmitter;

	/**
	 * Internal value to allow Containers to be used for input and physics.
	 * Do not change this value. It has no effect other than to break things.
	 *
	 * @since 1.0.0
	**/
	@:noCompletion
	private var _displayOriginX:Float;

	/**
	 * Internal value to allow Containers to be used for input and physics.
	 * Do not change this value. It has no effect other than to break things.
	 *
	 * @since 1.0.0
	**/
	@:noCompletion
	private var _displayOriginY:Float;

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
	public var scrollFactorX:Float = 1;

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
	public var scrollFactorY:Float = 1;

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
	 * Internal value to allow Containers to be used for input and physics.
	 * Do not change this value. It has no effect other than to break things.
	 *
	 * @since 1.0.0
	**/
	@:noCompletion
	public var originX(get, set):Float;

	/**
	 * Internal value to allow Containers to be used for input and physics.
	 * Do not change this value. It has no effect other than to break things.
	 *
	 * @since 1.0.0
	**/
	@:noCompletion
	public var originY(get, set):Float;

	/**
	 * Internal value to allow Containers to be used for input and physics.
	 * Do not change this value. It has no effect other than to break things.
	 *
	 * @since 1.0.0
	**/
	@:noCompletion
	public var displayOriginX(get, set):Float;

	/**
	 * Internal value to allow Containers to be used for input and physics.
	 * Do not change this value. It has no effect other than to break things.
	 *
	 * @since 1.0.0
	**/
	@:noCompletion
	public var displayOriginY(get, set):Float;

	/**
	 * The number of Game Objects inside this Container.
	 *
	 * @since 1.0.0
	**/
	public var length(get, never):Float;

	/**
	 * Returns the first Game Object within the Container, or `null` if it is empty.
	 *
	 * You can move the cursor by calling `Container.next` and `Container.previous`.
	 *
	 * @since 1.0.0
	**/
	public var first(get, never):GameObject;

	/**
	 * Returns the last Game Object within the Container, or `null` if it is empty.
	 *
	 * You can move the cursor by calling `Container.next` and `Container.previous`.
	 *
	 * @since 1.0.0
	**/
	public var last(get, never):GameObject;

	/**
	 * Returns the next Game Object within the Container, or `null` if it is empty.
	 *
	 * You can move the cursor by calling `Container.next` and `Container.previous`.
	 *
	 * @since 1.0.0
	**/
	public var next(get, never):GameObject;

	/**
	 * Returns the previous Game Object within the Container, or `null` if it is empty.
	 *
	 * You can move the cursor by calling `Container.next` and `Container.previous`.
	 *
	 * @since 1.0.0
	**/
	public var previous(get, never):GameObject;

	private inline function get_displayWidth():Float
	{
		return ComputedSizeImplementation.get_displayWidth(this);
	}

	private inline function set_displayWidth(value:Float):Float
	{
		return ComputedSizeImplementation.set_displayWidth(this, value);
	}

	private inline function get_displayHeight():Float
	{
		return ComputedSizeImplementation.get_displayHeight(this);
	}

	private inline function set_displayHeight(value:Float):Float
	{
		return ComputedSizeImplementation.set_displayHeight(this, value);
	}

	private inline function get_originX():Float
	{
		return 0.5;
	}

	private inline function set_originX(value:Float):Float
	{
		return 0.5;
	}

	private inline function get_originY():Float
	{
		return 0.5;
	}

	private inline function set_originY(value:Float):Float
	{
		return 0.5;
	}

	private inline function get_displayOriginX():Float
	{
		return this.width * 0.5;
	}

	private inline function set_displayOriginX(value:Float):Float
	{
		return this.width * 0.5;
	}

	private inline function get_displayOriginY():Float
	{
		return this.height * 0.5;
	}

	private inline function set_displayOriginY(value:Float):Float
	{
		return this.height * 0.5;
	}

	private inline function get_length()
	{
		return list.length;
	}

	private inline function get_first():GameObject
	{
		position = 0;
		return if (list.length > 0)
		{
			list[0];
		}
		else
		{
			null;
		}
	}

	private inline function get_last():GameObject
	{
		return if (list.length > 0)
		{
			position = list.length - 1;
			list[position];
		}
		else
		{
			null;
		}
	}

	private inline function get_next():GameObject
	{
		return if (position < list.length)
		{
			position++;
			return list[position];
		}
		else
		{
			return null;
		}
	}

	private inline function get_previous():GameObject
	{
		return if (position < list.length)
		{
			position--;
			return list[position];
		}
		else
		{
			return null;
		}
	}

	public function new(scene:Scene, x:Float, y:Float, children:Array<GameObject>)
	{
		super(scene, "Container");

		this._displayList = scene.sys.displayList;

		this._sysEvents = scene.sys.events;

		this.setPosition(x, y);

		this.clearAlpha();

		this.setBlendMode(SKIP_CHECK);

		if (children != null)
		{
			this.add(children);
		}
	}

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
	public inline function setOrigin(x:Float = 0.5, ?y:Float):Container
	{
		return this;
	}

	/**
	 * Internal function to allow Containers to be used for input and physics.
	 * Do not use this function. It has no effect.
	 *
	 * @since 1.0.0
	 *
	 * @return This Game Object instance.
	**/
	@:noCompletion
	public inline function setOriginFromFrame():Container
	{
		return this;
	}

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
	public function setDisplayOrigin(x:Float = 0, ?y:Float):Container
	{
		return this;
	}

	/**
	 * Internal function to allow Containers to be used for input and physics.
	 * Do not use this function. It has no effect.
	 *
	 * @since 1.0.0
	 *
	 * @return This Game Object instance.
	**/
	@:noCompletion
	public function updateDisplayOrigin():Container
	{
		return this;
	}

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
	public function setSizeToFrame(?frame:Frame):Container
	{
		width = frame.realWidth;
		height = frame.realHeight;
		return this;
	}

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
	public function setSize(width:Float, height:Float):Container
	{
		this.width = width;
		this.height = width;
		return this;
	}

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
	public function setDisplaySize(width:Float, height:Float):Container
	{
		displayWidth = width;
		displayHeight = height;
		return this;
	}

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
	 *
	 * @param value - The exclusive state of this Container.
	 *
	 * @return This Container.
	**/
	public function setExclusive(value:Bool = true):Container
	{
		this.exclusive = value;
		return this;
	}

	/**
	 * Gets the bounds of this Container. It works by iterating all children of the Container,
	 * getting their respective bounds, and then working out a min-max rectangle from that.
	 * It does not factor in if the children render or not, all are included.
	 *
	 * Some children are unable to return their bounds, such as Graphics objects, in which case
	 * they are skipped.
	 *
	 * Depending on the quantity of children in this Container it could be a really expensive call,
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
	public function getBounds(?output:Rectangle):Rectangle
	{
		if (output == null)
		{
			output = new Rectangle();
		}

		output.setTo(this.x, this.y, 0, 0);
		if (this.list.length > 0)
		{
			var children = this.list;
			var tempRect = new Rectangle();
			for (i in 0...children.length)
			{
				var entry = children[i];
				if (Std.is(entry, IGetBounds))
				{
					(cast entry : IGetBounds).getBounds(tempRect);
					RectangleUtil.union(tempRect, output, output);
				}
			}
		}
		return output;
	}

	/**
	 * Internal add handler.
	 *
	 * @method Phaser.GameObjects.Container#addHandler
	 * @private
	 * @since 1.0.0
	 *
	 * @param gameObject - The Game Object that was just added to this Container.
	**/
	private function addHandler(gameObject:GameObject):Void
	{
		gameObject.once(Events.DESTROY, this.remove, this);

		if (this.exclusive)
		{
			this._displayList.remove(gameObject);

			if (gameObject.parentContainer != null)
			{
				gameObject.parentContainer.remove(gameObject);
			}

			gameObject.parentContainer = this;
		}
	}

	/**
	 * Internal remove handler.
	 *
	 * @since 1.0.0
	 *
	 * @param gameObject - The Game Object that was just removed from this Container.
	**/
	private function removeHandler(gameObject:GameObject)
	{
		gameObject.off(Events.DESTROY, this.remove);

		if (exclusive)
		{
			gameObject.parentContainer = null;
		}
	}

	/**
	 * Takes a Point-like object, such as a Vector2, Geom.Point or object with public x and y properties,
	 * and transforms it into the space of this Container, then returns it in the output object.
	 *
	 * @since 1.0.0
	 *
	 * @param source - The Source Point to be transformed.
	 * @param output - A destination object to store the transformed point in. If none given a Vector2 will be created and returned.
	 *
	 * @return The transformed point.
	**/
	public function pointToContainer(source:Vector2, ?output:Vector2):Vector2
	{
		if (output == null)
		{
			output = new Vector2();
		}

		if (parentContainer != null)
		{
			return parentContainer.pointToContainer(source, output);
		}

		var tempMatrix = this.tempTransformMatrix;

		//  No need to loadIdentity because applyITRS overwrites every value anyway
		tempMatrix.applyITRS(x, y, rotation, scaleX, scaleY);

		tempMatrix.invert();

		tempMatrix.transformPoint(source.x, source.y, output);

		return output;
	}

	/**
	 * Returns the world transform matrix as used for Bounds checks.
	 *
	 * The returned matrix is temporal and shouldn't be stored.
	 *
	 * @since 1.0.0
	 *
	 * @return The world transform matrix.
	**/
	public function getBoundsTransformMatrix():TransformMatrix
	{
		throw new Error("Not implemented");
	}

	/**
	 * Adds the given Game Object, or array of Game Objects, to this Container.
	 *
	 * Each Game Object must be unique within the Container.
	 *
	 * @since 1.0.0
	 *
	 * @param child - The Game Object, or array of Game Objects, to add to the Container.
	 *
	 * @return This Container instance.
	**/
	public function add(child:Array<GameObject>):Container
	{
		ArrayUtils.add(this.list, child, this.maxSize, this.addHandler);

		return this;
	}

	/**
	 * Adds the given Game Object, or array of Game Objects, to this Container at the specified position.
	 *
	 * Existing Game Objects in the Container are shifted up.
	 *
	 * Each Game Object must be unique within the Container.
	 *
	 * @since 1.0.0
	 *
	 * @param child - The Game Object, or array of Game Objects, to add to the Container.
	 * @param index - The position to insert the Game Object/s at.
	 *
	 * @return This Container instance.
	**/
	public function addAt(child:MultipleOrOne<GameObject>, index:Int = 0):Container
	{
		ArrayUtils.addAt(list, child, index, maxSize, addHandler);

		return this;
	}

	/**
	 * Returns the Game Object at the given position in this Container.
	 *
	 * @method Phaser.GameObjects.Container#getAt
	 * @since 1.0.0
	 *
	 * @param index - The position to get the Game Object from.
	 *
	 * @return The Game Object at the specified index, or `null` if none found.
	**/
	public function getAt(index:Int):Null<GameObject>
	{
		return if (list.length > index && index >= 0)
		{
			list[index];
		}
		else
		{
			null;
		}
	}

	/**
	 * Returns the index of the given Game Object in this Container.
	 *
	 * @since 1.0.0
	 *
	 * @param child - The Game Object to search for in this Container.
	 *
	 * @return The index of the Game Object in this Container, or -1 if not found.
	 */
	public function getIndex(child:GameObject):Int
	{
		return list.indexOf(child);
	}

	/**
	 * [description]
	 *
	 * @since 1.0.0
	**/
	public inline function sort(arg:SortBy<GameObject>)
	{
		switch (arg)
		{
			case Property(p):
				ArrayUtils.stableSort(list, (childA, childB) ->
					{
						return Reflect.compare(p(childA), p(childB));
					});
			case Compare(c):
				ArrayUtils.stableSort(list, c);
		}
		return this;
	}

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
	public inline function getByName(name:String):Null<GameObject>
	{
		return ArrayUtils.getFirst(list, go -> go.name, name);
	}

	/**
	 * Returns a random Game Object from this Container.
	 *
	 * @since 1.0.0
	 *
	 * @param startIndex - An optional start index.
	 * @param length - An optional length, the total number of elements (from the startIndex) to choose from.
	 *
	 * @return A random child from the Container, or `null` if the Container is empty.
	**/
	public inline function getRandom(startIndex:Int = 0, ?length:Int)
	{
		return ArrayUtils.getRandom(list, startIndex, length);
	}

	/**
	 * Gets the first Game Object in this Container.
	 *
	 * You can also specify a function to get the property and value to search for, in which case it will return the first
	 * Game Object in this Container with a matching property and / or value.
	 *
	 * For example: `getFirst(go -> go.visible, true)` would return the first Game Object that had its `visible` property set.
	 *
	 * You can limit the search to the `startIndex` - `endIndex` range.
	 *
	 * @since 1.0.0
	 *
	 * @param propertyAccessor - The function to get the property to test on each Game Object in the Container.
	 * @param value - The value to test the property against.
	 * @param startIndex - An optional start index to search from.
	 * @param endIndex - An optional end index to search up to (but not included)
	 *
	 * @return The first matching Game Object, or `null` if none was found.
	**/
	public inline function getFirst<T>(?propertyAccessor:(GameObject) -> T, ?value:T,
			startIndex:Int = 0, ?endIndex:Int):Null<GameObject>
	{
		return ArrayUtils.getFirst(list, propertyAccessor, value, startIndex, endIndex);
	}

	/**
	 * Returns all Game Objects in this Container.
	 *
	 * You can optionally specify a matching criteria using the `propertyAccessor` and `value` arguments.
	 *
	 * For example: `getAll(go -> go.body)` would return only Game Objects that have a body property.
	 *
	 * You can also specify a value to compare the property to:
	 *
	 * `getAll(go -> go.visible, true)` would return only Game Objects that have their visible property set to `true`.
	 *
	 * Optionally you can specify a start and end index. For example if this Container had 100 Game Objects,
	 * and you set `startIndex` to 0 and `endIndex` to 50, it would return matches from only
	 * the first 50 Game Objects.
	 *
	 * @since 1.0.0
	 *
	 * @param propertyAccessor - The function to get the property to test on each Game Object in the Container.
	 * @param value - If property is set then the `property` must strictly equal this value to be included in the results.
	 * @param startIndex - An optional start index to search from.
	 * @param endIndex - An optional end index to search up to (but not included)
	 *
	 * @return An array of matching Game Objects from this Container.
	**/
	public inline function getAll<T>(?propertyAccessor:(GameObject) -> T, ?value:T,
			startIndex:Int = 0, ?endIndex:Int):Array<GameObject>
	{
		return ArrayUtils.getAll(list, propertyAccessor, value, startIndex, endIndex);
	}

	/**
	 * Returns the total number of Game Objects in this Container that have a property
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
	 * @return The total number of Game Objects in this Container with a property matching the given value.
	**/
	public function count<T>(propertyAccessor:(GameObject) -> T, value:T,
			startIndex:Int = 0, endIndex:Int):Int
	{
		return
			ArrayUtils.countAllMatching(list, propertyAccessor, value, startIndex, endIndex);
	}

	/**
	 * Swaps the position of two Game Objects in this Container.
	 * Both Game Objects must belong to this Container.
	 *
	 * @since 1.0.0
	 *
	 * @param child1 - The first Game Object to swap.
	 * @param child2 - The second Game Object to swap.
	 *
	 * @return This Container instance.
	**/
	public inline function swap(child1:GameObject, child2:GameObject):Container
	{
		ArrayUtils.swap(list, child1, child2);
		return this;
	}

	/**
	 * Moves a Game Object to a new position within this Container.
	 *
	 * The Game Object must already be a child of this Container.
	 *
	 * The Game Object is removed from its old position and inserted into the new one.
	 * Therefore the Container size does not change. Other children will change position accordingly.
	 *
	 * @since 1.0.0
	 *
	 * @param child - The Game Object to move.
	 * @param index - The new position of the Game Object in this Container.
	 *
	 * @return This Container instance.
	**/
	public inline function moveTo(child:GameObject, index:Int):Container
	{
		ArrayUtils.moveTo(list, child, index);
		return this;
	}

	/**
	 * Removes the given Game Object, or array of Game Objects, from this Container.
	 *
	 * The Game Objects must already be children of this Container.
	 *
	 * You can also optionally call `destroy` on each Game Object that is removed from the Container.
	 *
	 * @since 1.0.0
	 *
	 * @param child - The Game Object, or array of Game Objects, to be removed from the Container.
	 * @param destroyChild - Optionally call `destroy` on each child successfully removed from this Container.
	 *
	 * @return This Container instance.
	**/
	public function remove(child:MultipleOrOne<GameObject>,
			destroyChild:Bool = false):Container
	{
		var removed = ArrayUtils.remove(list, child, removeHandler);

		if (destroyChild && removed != null)
		{
			var removed = if (removed.isOne())
			{
				[removed.getOne()];
			}
			else
			{
				removed.getArray();
			}

			for (item in removed)
			{
				item.destroy();
			}
		}

		return this;
	}

	/**
	 * Removes the Game Object at the given position in this Container.
	 *
	 * You can also optionally call `destroy` on the Game Object, if one is found.
	 *
	 * @since 1.0.0
	 *
	 * @param index - The index of the Game Object to be removed.
	 * @param destroyChild - Optionally call `destroy` on the Game Object if successfully removed from this Container.
	 *
	 * @return This Container instance.
	**/
	public function removeAt(index:Int, destroyChild:Bool = false):Container
	{
		var removed = ArrayUtils.removeAt(list, index, removeHandler);

		if (destroyChild && removed != null)
		{
			removed.destroy();
		}

		return this;
	}

	/**
	 * Removes the Game Objects between the given positions in this Container.
	 *
	 * You can also optionally call `destroy` on each Game Object that is removed from the Container.
	 *
	 * @since 1.0.0
	 *
	 * @param startIndex - An optional start index to search from.
	 * @param endIndex - An optional end index to search up to (but not included)
	 * @param destroyChild - Optionally call `destroy` on each Game Object successfully removed from this Container.
	 *
	 * @return This Container instance.
	**/
	public function removeBetween(startIndex:Int = 0, ?endIndex:Int,
			destroyChild:Bool = false):Container
	{
		var removed = ArrayUtils.removeBetween(list, startIndex, endIndex, removeHandler);
		if (destroyChild)
		{
			for (item in removed)
			{
				item.destroy();
			}
		}
		return this;
	}

	/**
	 * Removes all Game Objects from this Container.
	 *
	 * You can also optionally call `destroy` on each Game Object that is removed from the Container.
	 *
	 * @since 1.0.0
	 *
	 * @param destroyChild - Optionally call `destroy` on each Game Object successfully removed from this Container.
	 *
	 * @return This Container instance.
	**/
	public function removeAll(destroyChild:Bool):Container
	{
		var removed = ArrayUtils.removeBetween(list, 0, list.length, removeHandler);
		if (destroyChild)
		{
			for (item in removed)
			{
				item.destroy();
			}
		}
		return this;
	}

	/**
	 * Brings the given Game Object to the top of this Container.
	 * This will cause it to render on-top of any other objects in the Container.
	 *
	 * @since 1.0.0
	 *
	 * @param child - The Game Object to bring to the top of the Container.
	 *
	 * @return This Container instance.
	**/
	public inline function bringToTop(child:GameObject):Container
	{
		ArrayUtils.bringToTop(list, child);
		return this;
	}

	/**
	 * Sends the given Game Object to the bottom of this Container.
	 * This will cause it to render below any other objects in the Container.
	 *
	 * @since 1.0.0
	 *
	 * @param child - The Game Object to send to the bottom of the Container.
	 *
	 * @return This Container instance.
	**/
	public inline function sendToBack(child:GameObject):Container
	{
		ArrayUtils.sendToBack(list, child);
		return this;
	}

	/**
	 * Moves the given Game Object up one place in this Container, unless it's already at the top.
	 *
	 * @since 1.0.0
	 *
	 * @param child - The Game Object to be moved in the Container.
	 *
	 * @return This Container instance.
	**/
	public inline function moveUp(child)
	{
		ArrayUtils.moveUp(list, child);
		return this;
	}

	/**
	 * Moves the given Game Object down one place in this Container, unless it's already at the bottom.
	 *
	 * @since 1.0.0
	 *
	 * @param child - The Game Object to be moved in the Container.
	 *
	 * @return This Container instance.
	**/
	public inline function moveDown(child:GameObject):Container
	{
		ArrayUtils.moveDown(list, child);
		return this;
	}

	/**
	 * Reverses the order of all Game Objects in this Container.
	 *
	 * @since 1.0.0
	 *
	 * @return This Container instance.
	**/
	public inline function reverse()
	{
		list.reverse();
		return this;
	}

	/**
	 * Shuffles the all Game Objects in this Container using the Fisher-Yates implementation.
	 *
	 * @since 1.0.0
	 *
	 * @return This Container instance.
	**/
	public inline function shuffle()
	{
		ArrayUtils.shuffle(list);
		return this;
	}

	/**
	 * Replaces a Game Object in this Container with the new Game Object.
	 * The new Game Object cannot already be a child of this Container.
	 *
	 * @since 1.0.0
	 *
	 * @param oldChild - The Game Object in this Container that will be replaced.
	 * @param newChild - The Game Object to be added to this Container.
	 * @param destroyChild - Optionally call `destroy` on the Game Object if successfully removed from this Container.
	 *
	 * @return This Container instance.
	**/
	public function replace(oldChild:GameObject, newChild:GameObject,
			destroyChild:Bool = false):Container
	{
		var moved = ArrayUtils.replace(list, oldChild, newChild);

		if (moved)
		{
			addHandler(newChild);
			removeHandler(oldChild);

			if (destroyChild)
			{
				oldChild.destroy();
			}
		}

		return this;
	}

	/**
	 * Returns `true` if the given Game Object is a direct child of this Container.
	 *
	 * This check does not scan nested Containers.
	 *
	 * @since 1.0.0
	 *
	 * @param child - The Game Object to check for within this Container.
	 *
	 * @return True if the Game Object is an immediate child of this Container, otherwise false.
	**/
	public function exists(child:GameObject):Bool
	{
		return list.indexOf(child) > -1;
	}

	/**
	 * Sets the property to the given value on all Game Objects in this Container.
	 *
	 * Optionally you can specify a start and end index. For example if this Container had 100 Game Objects,
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
	 * @return This Container instance.
	**/
	public inline function setAll<T>(propertySetter:(GameObject, T) -> Void, value:T,
			startIndex:Int = 0, ?endIndex:Int):Container
	{
		ArrayUtils.setAll(list, propertySetter, value, startIndex, endIndex);
		return this;
	}

	/**
	 * Passes all Game Objects in this Container to the given callback.
	 *
	 * A copy of the Container is made before passing each entry to your callback.
	 * This protects against the callback itself modifying the Container.
	 *
	 * If you know for sure that the callback will not change the size of this Container
	 * then you can use the more performant `Container.iterate` method instead.
	 *
	 * @since 1.0.0
	 *
	 * @param callback - The function to call.
	 *
	 * @return This Container instance.
	**/
	public inline function each(callback:(GameObject) -> Void):Container
	{
		for (item in list.copy())
		{
			callback(item);
		}
		return this;
	}

	/**
	 * Passes all Game Objects in this Container to the given callback.
	 *
	 * Only use this method when you absolutely know that the Container will not be modified during
	 * the iteration, i.e. by removing or adding to its contents.
	 *
	 * @since 1.0.0
	 *
	 * @param callback - The function to call.
	 *
	 * @return This Container instance.
	**/
	public inline function iterate(callback:(GameObject) -> Void):Container
	{
		for (item in list)
		{
			callback(item);
		}

		return this;
	}

	public inline function iterator():Iterator<GameObject>
	{
		return list.iterator();
	}

	/**
	 * Sets the scroll factor of this Container and optionally all of its children.
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
	 * @param updateChildren - Apply this scrollFactor to all Container children as well?
	 *
	 * @return This Game Object instance.
	**/
	public function setScrollFactor(x:Float, ?y:Float,
			updateChildren:Bool = null):Container
	{
		var y:Float = y != null ? y : x;

		if (updateChildren == null)
		{
			updateChildren = false;
		}

		scrollFactorX = x;
		scrollFactorY = y;

		if (updateChildren)
		{
			for (child in list)
			{
				if (!Std.is(child, IScrollFactor))
				{
					final child = (cast child : IScrollFactor);

					child.scrollFactorX = x;
					child.scrollFactorY = y;
				}
			}
		}
		return this;
	}

	/**
	 * Renders this Game Object with the WebGL Renderer to the given Camera.
	 * The object will not render if any of its renderFlags are set or it is being actively filtered out by the Camera.
	 * This method should not be called directly. It is a utility function of the Render module.
	 *
	 * @since 1.0.0
	 *
	 * @param renderer - A reference to the current active WebGL renderer.
	 * @param src - The Game Object being rendered in this call.
	 * @param interpolationPercentage - Reserved for future use and custom pipelines.
	 * @param camera - The Camera that is rendering the Game Object.
	 * @param parentMatrix - This transform matrix is defined if the game object is nested
	**/
	@:allow(phaserHaxe)
	private function renderWebGL(renderer:WebGLRenderer, src:GameObject,
			interpolationPercentage:Float, camera:Camera,
			parentMatrix:TransformMatrix):Void
	{
		throw new Error("Not Implemented");
	}

	/**
	 * Renders this Game Object with the Canvas Renderer to the given Camera.
	 * The object will not render if any of its renderFlags are set or it is being actively filtered out by the Camera.
	 * This method should not be called directly. It is a utility function of the Render module.
	 *
	 * @since 1.0.0
	 *
	 * @param renderer - A reference to the current active Canvas renderer.
	 * @param src - The Game Object being rendered in this call.
	 * @param interpolationPercentage - Reserved for future use and custom pipelines.
	 * @param camera - The Camera that is rendering the Game Object.
	 * @param parentMatrix - This transform matrix is defined if the game object is nested
	**/
	@:allow(phaserHaxe)
	private function renderCanvas(renderer:CanvasRenderer, src:GameObject,
			interpolationPercentage:Float, camera:Camera,
			parentMatrix:TransformMatrix):Void
	{
		var container = (cast src: Container);

		var children = container.list;

		if (children.length == 0)
		{
			return;
		}

		var transformMatrix = container.localTransform;

		if (parentMatrix != null)
		{
			transformMatrix.loadIdentity();
			transformMatrix.multiply(parentMatrix);
			transformMatrix.translate(container.x, container.y);
			transformMatrix.rotate(container.rotation);
			transformMatrix.scale(container.scaleX, container.scaleY);
		}
		else
		{
			transformMatrix.applyITRS(container.x, container.y, container.rotation, container.scaleX, container.scaleY);
		}

		var containerHasBlendMode = (container.blendMode != -1);

		if (!containerHasBlendMode)
		{
			//  If Container is SKIP_TEST then set blend mode to be Normal
			renderer.setBlendMode(0);
		}

		var alpha = container._alpha;
		var scrollFactorX = container.scrollFactorX;
		var scrollFactorY = container.scrollFactorY;

		for (i in 0...children.length)
		{
			var child = children[i];

			if (!child.willRender(camera))
			{
				continue;
			}

			var childAlpha = (cast child : IAlpha).alpha;
			var childScrollFactorX = (cast child : IScrollFactor).scrollFactorX;
			var childScrollFactorY = (cast child : IScrollFactor).scrollFactorY;

			if (!containerHasBlendMode && (cast child : IBlendMode).blendMode != renderer.currentBlendMode)
			{
				//  If Container doesn't have its own blend mode, then a child can have one
				renderer.setBlendMode((cast child : IBlendMode).blendMode);
			}

			//  Set parent values
			(cast child : IScrollFactor)
				.setScrollFactor(childScrollFactorX * scrollFactorX, childScrollFactorY * scrollFactorY);
			(cast child : IAlpha).setAlpha(childAlpha * alpha);

			//  Render
			(cast child : ISpriteRenderer)
				.renderCanvas(renderer, child, interpolationPercentage, camera, transformMatrix);

			//  Restore original values
			(cast child : IAlpha).setAlpha(childAlpha);
			(cast child : IScrollFactor)
				.setScrollFactor(childScrollFactorX, childScrollFactorY);
		}
	}

	/**
	 * Internal destroy handler, called as part of the destroy process.
	 *
	 * @since 1.0.0
	**/
	private override function preDestroy()
	{
		removeAll(exclusive);
		localTransform.destroy();
		tempTransformMatrix.destroy();
		list = [];
		_displayList = null;
	}
}

enum SortBy<T:GameObject>
{
	Property(p:(go:T) -> Dynamic);
	Compare(c:(a:T, b:T) -> Int);
}
