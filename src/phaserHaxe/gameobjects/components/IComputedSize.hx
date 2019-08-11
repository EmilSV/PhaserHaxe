package phaserHaxe.gameobjects.components;

interface IComputedSize
{
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
	public function setSize(width:Float, height:Float):IComputedSize;

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
	public function setDisplaySize(width:Float, height:Float):IComputedSize;
}

final class ComputedSizeImplementation
{
	public static inline function get_displayWidth<T:IComputedSize & ITransform>(self:T):Float
	{
		return self.scaleX * self.width;
	}

	public static inline function set_displayWidth<T:IComputedSize & ITransform>(self:T,
		value:Float):Float
	{
		return self.scaleX = value / self.width;
	}

	public static inline function get_displayHeight<T:IComputedSize & ITransform>(self:T):Float
	{
		return self.scaleY * self.height;
	}

	public static inline function set_displayHeight<T:IComputedSize & ITransform>(self:T,
		value:Float):Float
	{
		return self.scaleY = value / self.height;
	}

	public static function setSize<T:IComputedSize>(self:T, width:Float, height:Float):T
	{
		self.width = width;
		self.height = height;
		return self;
	}

	public static function setDisplaySize<T:IComputedSize>(self:T, width:Float,
			height:Float):T
	{
		self.displayWidth = width;
		self.displayWidth = height;
		return self;
	}
}

final class ComputedSizeMixin implements IComputedSize implements ITransform
{
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
	public function setSize(width:Float, height:Float):ComputedSizeMixin
	{
		return cast ComputedSizeImplementation.setSize(cast this, width, height);
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
	public function setDisplaySize(width:Float, height:Float):ComputedSizeMixin
	{
		return cast ComputedSizeImplementation.setDisplaySize(cast this, width, height);
	}

	// Transform implementation
	@:phaserHaxe.mixinIgnorer
	private var _scaleX:Float;

	@:phaserHaxe.mixinIgnorer
	private var _scaleY:Float;

	@:phaserHaxe.mixinIgnorer
	private var _rotation:Float;

	@:phaserHaxe.mixinIgnorer
	public var x:Float;

	@:phaserHaxe.mixinIgnorer
	public var y:Float;

	@:phaserHaxe.mixinIgnorer
	public var z:Float;

	@:phaserHaxe.mixinIgnorer
	public var w:Float;

	@:phaserHaxe.mixinIgnorer
	public var scale(get, set):Float;

	@:phaserHaxe.mixinIgnorer
	public var scaleX(get, set):Float;

	@:phaserHaxe.mixinIgnorer
	public var scaleY(get, set):Float;

	@:phaserHaxe.mixinIgnorer
	public var angle(get, set):Float;

	@:phaserHaxe.mixinIgnorer
	public var rotation(get, set):Float;

	@:phaserHaxe.mixinIgnorer
	private inline function get_scale():Float
	{
		throw "Not Implement";
	}

	@:phaserHaxe.mixinIgnorer
	private inline function set_scale(value:Float):Float
	{
		throw "Not Implement";
	}

	@:phaserHaxe.mixinIgnorer
	private inline function get_scaleX():Float
	{
		throw "Not Implement";
	}

	@:phaserHaxe.mixinIgnorer
	private inline function set_scaleX(value:Float):Float
	{
		throw "Not Implement";
	}

	@:phaserHaxe.mixinIgnorer
	private inline function get_scaleY():Float
	{
		throw "Not Implement";
	}

	@:phaserHaxe.mixinIgnorer
	private inline function set_scaleY(value:Float):Float
	{
		throw "Not Implement";
	}

	@:phaserHaxe.mixinIgnorer
	private inline function get_angle():Float
	{
		throw "Not Implement";
	}

	@:phaserHaxe.mixinIgnorer
	private inline function set_angle(value:Float):Float
	{
		throw "Not Implement";
	}

	@:phaserHaxe.mixinIgnorer
	private inline function get_rotation():Float
	{
		throw "Not Implement";
	}

	@:phaserHaxe.mixinIgnorer
	private inline function set_rotation(value:Float):Float
	{
		throw "Not Implement";
	}

	@:phaserHaxe.mixinIgnorer
	public function setPosition(x:Float = 0, ?y:Float, z:Float = 0,
			w:Float = 0):ITransform
	{
		throw "Not Implement";
	}

	@:phaserHaxe.mixinIgnorer
	public function setRandomPosition(x:Float = 0, y:Float = 0, ?width:Float,
			?height:Float):ITransform
	{
		throw "Not Implement";
	}

	@:phaserHaxe.mixinIgnorer
	public function setRotation(radians:Float = 0):ITransform
	{
		throw "Not Implement";
	}

	@:phaserHaxe.mixinIgnorer
	public function setAngle(degrees:Float = 0):ITransform
	{
		throw "Not Implement";
	}

	@:phaserHaxe.mixinIgnorer
	public function setScale(x:Float = 1, ?y:Float):ITransform
	{
		throw "Not Implement";
	}

	@:phaserHaxe.mixinIgnorer
	public function setX(value:Float = 0):ITransform
	{
		throw "Not Implement";
	}

	@:phaserHaxe.mixinIgnorer
	public function setY(value:Float = 0):ITransform
	{
		throw "Not Implement";
	}

	@:phaserHaxe.mixinIgnorer
	public function setZ(value:Float = 0):ITransform
	{
		throw "Not Implement";
	}

	@:phaserHaxe.mixinIgnorer
	public function setW(value:Float = 0):ITransform
	{
		throw "Not Implement";
	}

	@:phaserHaxe.mixinIgnorer
	public function getLocalTransformMatrix(?tempMatrix:TransformMatrix):TransformMatrix
	{
		throw "Not Implement";
	}

	@:phaserHaxe.mixinIgnorer
	public function getWorldTransformMatrix(?tempMatrix:TransformMatrix,
			?parentMatrix:TransformMatrix):TransformMatrix
	{
		throw "Not Implement";
	}
}
