package phaserHaxe.gameobjects.components;

import phaserHaxe.math.MathConst as MATH_CONST;
import phaserHaxe.math.Angle.wrap as wrapAngle;
import phaserHaxe.math.Angle.wrapDegrees as wrapAngleDegrees;

/**
 * Provides methods used for getting and setting the position, scale and rotation of a Game Object.
 *
 * @since 1.0.0
**/
@:allow(phaserHaxe.gameobjects.components.TransformImplementation)
@:phaserHaxe.Mixin(phaserHaxe.gameobjects.components.ITransform.TransformMixin)
interface ITransform
{
	/**
	 * Private internal value. Holds the horizontal scale value.
	 *
	 * @default 1
	 * @since 1.0.0
	**/
	private var _scaleX:Float;

	/**
	 * Private internal value. Holds the vertical scale value.
	 *
	 * @default 1
	 * @since 1.0.0
	**/
	private var _scaleY:Float;

	/**
	 * Private internal value. Holds the rotation value in radians.
	 *
	 * @default 0
	 * @since 1.0.0
	**/
	private var _rotation:Float;

	/**
	 * The x position of this Game Object.
	 *
	 * @default 0
	 * @since 1.0.0
	**/
	public var x:Float;

	/**
	 * The y position of this Game Object.
	 *
	 * @default 0
	 * @since 1.0.0
	**/
	public var y:Float;

	/**
	 * The z position of this Game Object.
	 * Note: Do not use this value to set the z-index, instead see the `depth` property.
	 *
	 * @default 0
	 * @since 1.0.0
	**/
	public var z:Float;

	/**
	 * The w position of this Game Object.
	 *
	 * @default 0
	 * @since 1.0.0
	**/
	public var w:Float;

	/**
	 * This is a special setter that allows you to set both the horizontal and vertical scale of this Game Object
	 * to the same value, at the same time. When reading this value the result returned is `(scaleX + scaleY) / 2`.
	 *
	 * Use of this property implies you wish the horizontal and vertical scales to be equal to each other. If this
	 * isn't the case, use the `scaleX` or `scaleY` properties instead.
	 *
	 * @since 1.0.0
	**/
	public var scale(get, set):Float;

	/**
	 * The horizontal scale of this Game Object.
	 *
	 * @since 1.0.0
	**/
	public var scaleX(get, set):Float;

	/**
	 * The vertical scale of this Game Object.
	 *
	 * @since 1.0.0
	**/
	public var scaleY(get, set):Float;

	/**
	 * The angle of this Game Object as expressed in degrees.
	 *
	 * Where 0 is to the right, 90 is down, 180 is left.
	 *
	 * If you prefer to work in radians, see the `rotation` property instead.
	 *
	 * @since 1.0.0
	**/
	public var angle(get, set):Float;

	/**
	 * The angle of this Game Object in radians.
	 *
	 * If you prefer to work in degrees, see the `angle` property instead.
	 *
	 * @since 1.0.0
	**/
	public var rotation(get, set):Float;

	/**
	 * Sets the position of this Game Object.
	 *
	 * @method Phaser.GameObjects.Components.Transform#setPosition
	 * @since 3.0.0
	 *
	 * @param x - The x position of this Game Object.
	 * @param y - The y position of this Game Object. If not set it will use the `x` value.
	 * @param z - The z position of this Game Object.
	 * @param w - The w position of this Game Object.
	 *
	 * @return This Transform instance.
	**/
	public function setPosition(x:Float = 0, ?y:Float, z:Float = 0,
		w:Float = 0):ITransform;

	/**
	 * Sets the position of this Game Object to be a random position within the confines of
	 * the given area.
	 *
	 * If no area is specified a random position between 0 x 0 and the game width x height is used instead.
	 *
	 * The position does not factor in the size of this Game Object, meaning that only the origin is
	 * guaranteed to be within the area.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The x position of the top-left of the random area.
	 * @param y - The y position of the top-left of the random area.
	 * @param width - The width of the random area.
	 * @param height - The height of the random area.
	 *
	 * @return This Transform instance.
	**/
	public function setRandomPosition(x:Float = 0, y:Float = 0, ?width:Float,
		?height:Float):ITransform;

	/**
	 * Sets the rotation of this Game Object.
	 *
	 * @since 1.0.0
	 *
	 * @param radians - The rotation of this Game Object, in radians.
	 *
	 * @return This Transform instance.
	**/
	public function setRotation(radians:Float = 0):ITransform;

	/**
	 * Sets the angle of this Game Object.
	 *
	 * @since 1.0.0
	 *
	 * @param degrees - The rotation of this Game Object, in degrees.
	 *
	 * @return This Transform instance.
	**/
	public function setAngle(degrees:Float = 0):ITransform;

	/**
	 * Sets the scale of this Game Object.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The horizontal scale of this Game Object.
	 * @param y - The vertical scale of this Game Object. If not set it will use the `x` value.
	 *
	 * @return This Transform instance.
	**/
	public function setScale(x:Float = 1, ?y:Float):ITransform;

	/**
	 * Sets the x position of this Game Object.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The x position of this Game Object.
	 *
	 * @return This Transform instance.
	**/
	public function setX(value:Float = 0):ITransform;

	/**
	 * Sets the y position of this Game Object.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The y position of this Game Object.
	 *
	 * @return This Transform instance.
	**/
	public function setY(value:Float = 0):ITransform;

	/**
	 * Sets the z position of this Game Object.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The z position of this Game Object.
	 *
	 * @return This Transform instance.
	**/
	public function setZ(value:Float = 0):ITransform;

	/**
	 * Sets the w position of this Game Object.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The w position of this Game Object.
	 *
	 * @return This Transform instance.
	**/
	public function setW(value:Float = 0):ITransform;

	/**
	 * Gets the local transform matrix for this Game Object.
	 *
	 * @since 1.0.0
	 *
	 * @param tempMatrix - The matrix to populate with the values from this Game Object.
	 *
	 * @return The populated Transform Matrix.
	**/
	public function getLocalTransformMatrix(?tempMatrix:TransformMatrix):TransformMatrix;

	/**
	 * Gets the world transform matrix for this Game Object, factoring in any parent Containers.
	 *
	 * @since 1.0.0
	 *
	 * @param tempMatrix - The matrix to populate with the values from this Game Object.
	 * @param parentMatrix - A temporary matrix to hold parent values during the calculations.
	 *
	 * @return The populated Transform Matrix.
	**/
	public function getWorldTransformMatrix(?tempMatrix:TransformMatrix,
		?parentMatrix:TransformMatrix):TransformMatrix;
}

final class TransformImplementation
{
	//  global bitmask flag for GameObject.renderMask (used by Scale)
	private static inline var _FLAG = 4;

	public static inline function get_scale<T:ITransform>(self:T):Float
	{
		return (self._scaleX + self._scaleY) / 2;
	}

	public static inline function set_scale<T:ITransform>(self:T, value:Float):Float
	{
		self._scaleX = value;
		self._scaleY = value;

		if (Std.is(self, GameObject))
		{
			if (value == 0)
			{
				(cast self : GameObject).renderFlags &= ~_FLAG;
			}
			else
			{
				(cast self : GameObject).renderFlags |= _FLAG;
			}
		}

		return value;
	}

	public static inline function get_scaleX<T:ITransform>(self:T):Float
	{
		return self._scaleX;
	}

	public static inline function set_scaleX<T:ITransform>(self:T, value:Float):Float
	{
		if (Std.is(self, GameObject))
		{
			if (value == 0)
			{
				(cast self : GameObject).renderFlags &= ~_FLAG;
			}
			else
			{
				(cast self : GameObject).renderFlags |= _FLAG;
			}
		}

		return self._scaleX = value;
	}

	public static inline function get_scaleY<T:ITransform>(self:T):Float
	{
		return self._scaleY;
	}

	public static inline function set_scaleY<T:ITransform>(self:T, value:Float):Float
	{
		self._scaleY = value;
		if (Std.is(self, GameObject))
		{
			if (self._scaleY == 0)
			{
				(cast self : GameObject).renderFlags &= ~_FLAG;
			}
			else
			{
				(cast self : GameObject).renderFlags |= _FLAG;
			}
		}

		return self._scaleY;
	}

	public static inline function get_angle<T:ITransform>(self:T):Float
	{
		return wrapAngleDegrees(self._rotation * MATH_CONST.RAD_TO_DEG);
	}

	public static inline function set_angle<T:ITransform>(self:T, value:Float):Float
	{
		return self._rotation = wrapAngleDegrees(value) * MATH_CONST.DEG_TO_RAD;
	}

	public static inline function get_rotation<T:ITransform>(self:T):Float
	{
		return self._rotation;
	}

	public static inline function set_rotation<T:ITransform>(self:T, value:Float):Float
	{
		return self._rotation = wrapAngle(value);
	}

	public static inline function setPosition<T:ITransform>(self:T, x:Float = 0,
			?y:Float, z:Float = 0, w:Float = 0):T
	{
		self.x = x;
		self.y = y != null ? y : x;
		self.z = z;
		self.w = w;

		return self;
	}

	public static inline function setRandomPosition<T:ITransform>(self:T, x:Float = 0,
			y:Float = 0, ?width:Float, ?height:Float):T
	{
		if (Std.is(self, GameObject))
		{
			if (width == null)
			{
				width = (cast self : GameObject).scene.sys.scale.width;
			}
			if (height == null)
			{
				height = (cast self : GameObject).scene.sys.scale.height;
			}
		}

		self.x = x + (Math.random() * width);
		self.y = y + (Math.random() * height);
		return self;
	}

	public static inline function setAngle<T:ITransform>(self:T, degrees:Float = 0):T
	{
		self.angle = degrees;
		return self;
	}

	public static inline function setRotation<T:ITransform>(self:T, radians:Float = 0):T
	{
		self.rotation = radians;
		return self;
	}

	public static inline function setScale<T:ITransform>(self:T, x:Float = 1, ?y:Float):T
	{
		self.scaleX = x;
		self.scaleY = y != null ? y : x;
		return self;
	}

	public static inline function setX<T:ITransform>(self:T, value:Float = 0):T
	{
		self.x = value;
		return self;
	}

	public static inline function setY<T:ITransform>(self:T, value:Float = 0):T
	{
		self.y = value;
		return self;
	}

	public static inline function setZ<T:ITransform>(self:T, value:Float = 0):T
	{
		self.z = value;
		return self;
	}

	public static inline function setW<T:ITransform>(self:T, value:Float = 0):T
	{
		self.w = value;
		return self;
	}

	public static inline function getLocalTransformMatrix<T:ITransform>(self:T,
			?tempMatrix:TransformMatrix):TransformMatrix
	{
		if (tempMatrix == null)
		{
			tempMatrix = new TransformMatrix();
		}

		return
			tempMatrix.applyITRS(self.x, self.y, self._rotation, self._scaleX, self._scaleY);
	}

	public static inline function getWorldTransformMatrix<T:ITransform>(self:T,
			?tempMatrix:TransformMatrix, ?parentMatrix:TransformMatrix):TransformMatrix
	{
		final go = cast(self, GameObject);

		if (tempMatrix == null)
		{
			tempMatrix = new TransformMatrix();
		}
		if (parentMatrix == null)
		{
			parentMatrix = new TransformMatrix();
		}

		var parent:ITransform = go.parentContainer;

		if (parent == null)
		{
			return self.getLocalTransformMatrix(tempMatrix);
		}

		tempMatrix.applyITRS(self.x, self.y, self._rotation, self._scaleX, self._scaleY);

		while (parent != null)
		{
			parentMatrix.applyITRS(parent.x, parent.y, parent._rotation, parent._scaleX, parent._scaleY);

			parentMatrix.multiply(tempMatrix, tempMatrix);

			parent = (cast parent : GameObject).parentContainer;
		}

		return tempMatrix;
	}
}

final class TransformMixin extends GameObject implements ITransform
{
	/**
	 * Private internal value. Holds the horizontal scale value.
	 *
	 * @since 1.0.0
	**/
	private var _scaleX:Float = 1;

	/**
	 * Private internal value. Holds the vertical scale value.
	 *
	 * @since 1.0.0
	**/
	private var _scaleY:Float = 1;

	/**
	 * Private internal value. Holds the rotation value in radians.
	 *
	 * @since 1.0.0
	**/
	private var _rotation:Float = 0;

	/**
	 * The x position of this Game Object.
	 *
	 * @since 1.0.0
	**/
	public var x:Float = 0;

	/**
	 * The y position of this Game Object.
	 *
	 * @since 1.0.0
	**/
	public var y:Float = 0;

	/**
	 * The z position of this Game Object.
	 * Note: Do not use this value to set the z-index, instead see the `depth` property.
	 *
	 * @since 1.0.0
	**/
	public var z:Float = 0;

	/**
	 * The w position of this Game Object.
	 *
	 * @since 1.0.0
	**/
	public var w:Float = 0;

	/**
	 * This is a special setter that allows you to set both the horizontal and vertical scale of this Game Object
	 * to the same value, at the same time. When reading this value the result returned is `(scaleX + scaleY) / 2`.
	 *
	 * Use of this property implies you wish the horizontal and vertical scales to be equal to each other. If this
	 * isn't the case, use the `scaleX` or `scaleY` properties instead.
	 *
	 * @since 1.0.0
	**/
	public var scale(get, set):Float;

	/**
	 * The horizontal scale of this Game Object.
	 *
	 * @since 1.0.0
	**/
	public var scaleX(get, set):Float;

	/**
	 * The vertical scale of this Game Object.
	 *
	 * @since 1.0.0
	**/
	public var scaleY(get, set):Float;

	/**
	 * The angle of this Game Object as expressed in degrees.
	 *
	 * Where 0 is to the right, 90 is down, 180 is left.
	 *
	 * If you prefer to work in radians, see the `rotation` property instead.
	 *
	 * @since 1.0.0
	**/
	public var angle(get, set):Float;

	/**
	 * The angle of this Game Object in radians.
	 *
	 * If you prefer to work in degrees, see the `angle` property instead.
	 *
	 * @since 1.0.0
	**/
	public var rotation(get, set):Float;

	private inline function get_scale():Float
	{
		return TransformImplementation.get_scale(this);
	}

	private inline function set_scale(value:Float):Float
	{
		return TransformImplementation.set_scale(cast this, value);
	}

	private inline function get_scaleX():Float
	{
		return TransformImplementation.get_scaleX(cast this);
	}

	private inline function set_scaleX(value:Float):Float
	{
		return TransformImplementation.set_scaleX(cast this, value);
	}

	private inline function get_scaleY():Float
	{
		return TransformImplementation.get_scaleY(cast this);
	}

	private inline function set_scaleY(value:Float):Float
	{
		return TransformImplementation.set_scaleY(cast this, value);
	}

	private inline function get_angle():Float
	{
		return TransformImplementation.get_angle(cast this);
	}

	private inline function set_angle(value:Float):Float
	{
		return TransformImplementation.set_angle(cast this, value);
	}

	private inline function get_rotation():Float
	{
		return TransformImplementation.get_rotation(cast this);
	}

	private inline function set_rotation(value:Float):Float
	{
		return TransformImplementation.set_rotation(cast this, value);
	}

	/**
	 * Sets the position of this Game Object.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The x position of this Game Object.
	 * @param y - The y position of this Game Object. If not set it will use the `x` value.
	 * @param z - The z position of this Game Object.
	 * @param w - The w position of this Game Object.
	 *
	 * @return This Transform instance.
	**/
	public function setPosition(x:Float = 0, ?y:Float, z:Float = 0,
			w:Float = 0):TransformMixin
	{
		return cast TransformImplementation.setPosition(cast this, x, y, z, w);
	}

	/**
	 * Sets the position of this Game Object to be a random position within the confines of
	 * the given area.
	 *
	 * If no area is specified a random position between 0 x 0 and the game width x height is used instead.
	 *
	 * The position does not factor in the size of this Game Object, meaning that only the origin is
	 * guaranteed to be within the area.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The x position of the top-left of the random area.
	 * @param y - The y position of the top-left of the random area.
	 * @param width - The width of the random area.
	 * @param height - The height of the random area.
	 *
	 * @return This Transform instance.
	**/
	public function setRandomPosition(x:Float = 0, y:Float = 0, ?width:Float,
			?height:Float):TransformMixin
	{
		return
			cast TransformImplementation.setRandomPosition(cast this, x, y, width, height);
	}

	/**
	 * Sets the rotation of this Game Object.
	 *
	 * @since 1.0.0
	 *
	 * @param radians - The rotation of this Game Object, in radians.
	 *
	 * @return This Transform instance.
	**/
	public function setRotation(radians:Float = 0):TransformMixin
	{
		return cast TransformImplementation.setRotation(cast this, radians);
	}

	/**
	 * Sets the angle of this Game Object.
	 *
	 * @since 1.0.0
	 *
	 * @param degrees - The rotation of this Game Object, in degrees.
	 *
	 * @return This Transform instance.
	**/
	public function setAngle(degrees:Float = 0):TransformMixin
	{
		return TransformImplementation.setAngle(this, degrees);
	}

	/**
	 * Sets the scale of this Game Object.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The horizontal scale of this Game Object.
	 * @param y - The vertical scale of this Game Object. If not set it will use the `x` value.
	 *
	 * @return This Transform instance.
	**/
	public function setScale(x:Float = 1, ?y:Float):TransformMixin
	{
		return cast TransformImplementation.setScale(cast this, x, y);
	}

	/**
	 * Sets the x position of this Game Object.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The x position of this Game Object.
	 *
	 * @return This Transform instance.
	**/
	public function setX(value:Float = 0):TransformMixin
	{
		return cast TransformImplementation.setX(cast this, value);
	}

	/**
	 * Sets the y position of this Game Object.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The y position of this Game Object.
	 *
	 * @return This Transform instance.
	**/
	public function setY(value:Float = 0):TransformMixin
	{
		return cast TransformImplementation.setY(cast this, value);
	}

	/**
	 * Sets the z position of this Game Object.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The z position of this Game Object.
	 *
	 * @return This Transform instance.
	**/
	public function setZ(value:Float = 0):TransformMixin
	{
		return cast TransformImplementation.setZ(cast this, value);
	}

	/**
	 * Sets the w position of this Game Object.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The w position of this Game Object.
	 *
	 * @return This Transform instance.
	**/
	public function setW(value:Float = 0):TransformMixin
	{
		return cast TransformImplementation.setW(cast this, value);
	}

	/**
	 * Gets the local transform matrix for this Game Object.
	 *
	 * @since 1.0.0
	 *
	 * @param tempMatrix - The matrix to populate with the values from this Game Object.
	 *
	 * @return The populated Transform Matrix.
	**/
	public function getLocalTransformMatrix(?tempMatrix:TransformMatrix):TransformMatrix
	{
		return TransformImplementation.getLocalTransformMatrix(cast this, tempMatrix);
	}

	/**
	 * Gets the world transform matrix for this Game Object, factoring in any parent Containers.
	 *
	 * @since 1.0.0
	 *
	 * @param tempMatrix - The matrix to populate with the values from this Game Object.
	 * @param parentMatrix - A temporary matrix to hold parent values during the calculations.
	 *
	 * @return The populated Transform Matrix.
	**/
	public function getWorldTransformMatrix(?tempMatrix:TransformMatrix,
			?parentMatrix:TransformMatrix):TransformMatrix
	{
		return
			TransformImplementation.getWorldTransformMatrix(cast this, tempMatrix, parentMatrix);
	}
}
