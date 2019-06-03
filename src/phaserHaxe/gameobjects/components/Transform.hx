package phaserHaxe.gameobjects.components;

#if eval
import haxe.macro.Context;
import haxe.macro.Expr;
#end

@:allow(phaserHaxe.gameobjects.components.TransformImplementaion)
interface ITransform
{
	/**
	 * Private internal value. Holds the horizontal scale value.
	 *
	 * @since 1.0.0
	**/
	private var _scaleX:Float;

	/**
	 * Private internal value. Holds the vertical scale value.
	 *
	 * @since 1.0.0
	**/
	private var _scaleY:Float;

	/**
	 * Private internal value. Holds the rotation value in radians.
	 *
	 * @since 1.0.0
	**/
	private var _rotation:Float;

	/**
	 * The x position of this Game Object.
	 *
	 * @since 1.0.0
	**/
	public var x:Float;

	/**
	 * The y position of this Game Object.
	 *
	 * @since 1.0.0
	**/
	public var y:Float;

	/**
	 * The z position of this Game Object.
	 * Note: Do not use this value to set the z-index, instead see the `depth` property.
	 *
	 * @since 1.0.0
	**/
	public var z:Float;

	/**
	 * The w position of this Game Object.
	 *
	 * @since 1.0.0
	**/
	public var w:Float;

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

	// /**
	//  * Sets the position of this Game Object to be a random position within the confines of
	//  * the given area.
	//  *
	//  * If no area is specified a random position between 0 x 0 and the game width x height is used instead.
	//  *
	//  * The position does not factor in the size of this Game Object, meaning that only the origin is
	//  * guaranteed to be within the area.
	//  *
	//  * @since 1.0.0
	//  *
	//  * @param x - The x position of the top-left of the random area.
	//  * @param y - The y position of the top-left of the random area.
	//  * @param width - The width of the random area.
	//  * @param height - The height of the random area.
	//  *
	//  * @return This Transfrom instance.
	// **/
	// public function setRandomPosition(x:Float = 0, y:Float = 0, ?width:Float,
	// 	height:Float):ITransform;
	// /**
	//  * Sets the rotation of this Game Object.
	//  *
	//  * @since 1.0.0
	//  *
	//  * @param radians - The rotation of this Game Object, in radians.
	//  *
	//  * @return This Transfrom instance.
	// **/
	// public function setRotation(radians:Float = 0):ITransform;
	// /**
	//  * Sets the angle of this Game Object.
	//  *
	//  * @since 1.0.0
	//  *
	//  * @param degrees - The rotation of this Game Object, in degrees.
	//  *
	//  * @return This Transform instance.
	// **/
	// public function setAngle(radians:Float = 0):ITransform;
	// /**
	//  * Sets the scale of this Game Object.
	//  *
	//  * @since 1.0.0
	//  *
	//  * @param x - The horizontal scale of this Game Object.
	//  * @param y - The vertical scale of this Game Object. If not set it will use the `x` value.
	//  *
	//  * @return This Transfrom instance.
	// **/
	// public function setScale(x:Float = 1, ?y:Float):ITransform;
	// /**
	//  * Sets the x position of this Game Object.
	//  *
	//  * @since 1.0.0
	//  *
	//  * @param value - The x position of this Game Object.
	//  *
	//  * @return This Transform instance.
	// **/
	// public function setX(value:Float = 0):ITransform;
	// /**
	//  * Sets the y position of this Game Object.
	//  *
	//  * @since 1.0.0
	//  *
	//  * @param value - The y position of this Game Object.
	//  *
	//  * @return This Transform instance.
	// **/
	// public function setY(value:Float = 0):ITransform;
	// /**
	//  * Sets the z position of this Game Object.
	//  *
	//  * @since 1.0.0
	//  *
	//  * @param value - The z position of this Game Object.
	//  *
	//  * @return This Transform instance.
	// **/
	// public function setZ(value:Float = 0):ITransform;
	// /**
	//  * Sets the w position of this Game Object.
	//  *
	//  * @since 1.0.0
	//  *
	//  * @param value - The w position of this Game Object.
	//  *
	//  * @return This Transform instance.
	// **/
	// public function setW(value:Float = 0):ITransform;
	// /**
	//  * Gets the local transform matrix for this Game Object.
	//  *
	//  * @method Phaser.GameObjects.Components.Transform#getLocalTransformMatrix
	//  * @since 1.0.0
	//  *
	//  * @param {Phaser.GameObjects.Components.TransformMatrix} [tempMatrix] - The matrix to populate with the values from this Game Object.
	//  *
	//  * @return {Phaser.GameObjects.Components.TransformMatrix} The populated Transform Matrix.
	// **/
	// public function getLocalTransformMatrix(?tempMatrix:TransformMatrix):TransformMatrix;
	// /**
	//  * Gets the world transform matrix for this Game Object, factoring in any parent Containers.
	//  *
	//  * @since 1.0.0
	//  *
	//  * @param tempMatrix - The matrix to populate with the values from this Game Object.
	//  * @param parentMatrix - A temporary matrix to hold parent values during the calculations.
	//  *
	//  * @return The populated Transform Matrix.
	// **/
	// public function getWorldTransformMatrix(?tempMatrix:TransformMatrix,
	// 	?parentMatrix:TransformMatrix):TransformMatrix;
}

final class TransformImplementaion
{
	//  global bitmask flag for GameObject.renderMask (used by Scale)
	private static inline var _FLAG = 4;

	@:generic
	public static inline function get_scaleX<T:ITransform>(self:T):Float
	{
		return self._scaleX;
	}

	@:generic
	public static inline function set_scaleX<T:ITransform>(self:T, value:Float):Float
	{
		self._scaleX = value;

		if (self._scaleX == 0)
		{
			/* TODO: finish TransformImplementaion
				// self.renderFlags &= ~_FLAG;
			 */
		}
		else
		{
			/* TODO: finish TransformImplementaion
				self.renderFlags |= _FLAG;
			 */
		}

		return self._scaleX;
	}

	@:generic
	public static inline function get_scaleY<T:ITransform>(self:T):Float
	{
		return self._scaleY;
	}

	@:generic
	public static inline function set_scaleY<T:ITransform>(self:T, value:Float):Float
	{
		self._scaleY = value;

		if (self._scaleY == 0)
		{
			/* TODO: finish TransformImplementaion
				self.renderFlags &= ~_FLAG;
			 */
		}
		else
		{
			/* TODO: finish TransformImplementaion
				self.renderFlags |= _FLAG;
			 */
		}

		return self._scaleY;
	}

	@:generic
	public static inline function get_angle<T:ITransform>(self:T):Float
	{
		/* TODO: finish TransformImplementaion
			return WrapAngleDegrees(this._rotation * MATH_CONST.RAD_TO_DEG);
		 */
		return self._rotation;
	}

	@:generic
	public static inline function set_angle<T:ITransform>(self:T, value:Float):Float
	{
		/* TODO: finish TransformImplementaion
			this.rotation = WrapAngleDegrees(value) * MATH_CONST.DEG_TO_RAD;
		 */
		return self._rotation;
	}

	@:generic
	public static inline function get_rotation<T:ITransform>(self:T):Float
	{
		return self._rotation;
	}

	@:generic
	public static inline function set_rotation<T:ITransform>(self:T, value:Float):Float
	{
		/* TODO: finish TransformImplementaion
			this._rotation = WrapAngle(value);
		 */
		return self._rotation = value;
	}

	@:generic
	public static inline function setPosition<T:ITransform>(self:T, x:Float = 0,
			?y:Float, z:Float = 0, w:Float = 0):T
	{
		self.x = x;
		self.y = y != null ? y : x;
		self.z = z;
		self.w = w;

		return self;
	}

	@:generic
	public static inline function setRandomPosition<T:ITransform>(self:T, x:Float = 0,
			y:Float = 0, ?width:Float, ?height:Float):T
	{
		if (width == null)
		{
			/* TODO: finish TransformImplementaion
				width = self.scene.sys.scale.width;
			 */
		}
		if (height == null)
		{
			/* TODO: finish TransformImplementaion
				height = self.scene.sys.scale.height;
			 */
		}

		self.x = x + (Math.random() * width);
		self.y = y + (Math.random() * height);
		return self;
	}

	@:generic
	public static inline function setAngle<T:ITransform>(self:T, degrees:Float = 0):T
	{
		self.angle = degrees;
		return self;
	}

	@:generic
	public static inline function setScale<T:ITransform>(self:T, x:Float = 1, ?y:Float):T
	{
		self.scaleX = x;
		self.scaleY = y != null ? y : x;
		return self;
	}

	@:generic
	public static inline function setX<T:ITransform>(self:T, value:Float = 0):T
	{
		self.x = value;
		return self;
	}

	@:generic
	public static inline function setY<T:ITransform>(self:T, value:Float = 0):T
	{
		self.y = value;
		return self;
	}

	@:generic
	public static inline function setZ<T:ITransform>(self:T, value:Float = 0):T
	{
		self.z = value;
		return self;
	}

	@:generic
	public static inline function setW<T:ITransform>(self:T, value:Float = 0):T
	{
		self.w = value;
		return self;
	}

	@:generic
	public static inline function getLocalTransformMatrix<T:ITransform>(self:T,
			?tempMatrix:TransformMatrix):TransformMatrix
	{
		if (tempMatrix == null)
		{
			/* TODO: finish TransformImplementaion
				tempMatrix = new TransformMatrix();
			 */
		}

		return
			tempMatrix.applyITRS(self.x, self.y, self._rotation, self._scaleX, self._scaleY);
	}

	@:generic
	public static inline function getWorldTransformMatrix<T:ITransform>(self:T,
			?tempMatrix:TransformMatrix, ?parentMatrix:TransformMatrix):TransformMatrix
	{
		if (tempMatrix == null)
		{
			/* TODO: finish TransformImplementaion
				tempMatrix = new TransformMatrix();
			 */
		}
		if (parentMatrix == null)
		{
			/* TODO: finish TransformImplementaion
				parentMatrix = new TransformMatrix();
			 */
		}

		var parent:Dynamic = (self : Dynamic).parentContainer;

		// if (parent == null)
		// {
		// 	return self.getLocalTransformMatrix(tempMatrix);
		// }

		tempMatrix.applyITRS(self.x, self.y, self._rotation, self._scaleX, self._scaleY);

		while (parent != null)
		{
			parentMatrix.applyITRS(parent.x, parent.y, parent._rotation, parent._scaleX, parent._scaleY);

			parentMatrix.multiply(tempMatrix, tempMatrix);

			parent = parent.parentContainer;
		}

		return tempMatrix;
	}
}

#if eval
final class TransformBuilder
{
	public static function build():Array<Field>
	{
		// get existing fields from the context from where build() is called
		final fields = Context.getBuildFields();
		final pos = Context.currentPos();
		final buildType = Context.toComplexType(Context.getLocalType());

		function addFeild(newFeild:Field)
		{
			for (feild in fields)
			{
				if (feild.name == newFeild.name)
				{
					return;
				}
			}

			fields.push(newFeild);
		}

		addFeild({
			name: "_scaleX",
			doc: "Private internal value. Holds the horizontal scale value.",
			access: [Access.APrivate],
			kind: FieldType.FVar(macro:Float, macro 1),
			pos: pos,
		});
		addFeild({
			name: "_scaleY",
			doc: "Private internal value. Holds the vertical scale value.",
			access: [Access.APrivate],
			kind: FieldType.FVar(macro:Float, macro 1),
			pos: pos,
		});
		addFeild({
			name: "_rotation",
			doc: "Private internal value. Holds the rotation value in radians.",
			access: [Access.APrivate],
			kind: FieldType.FVar(macro:Float, macro 1),
			pos: pos,
		});

		addFeild({
			name: "x",
			doc: "The x position of this Game Object.",
			access: [Access.APublic],
			kind: FieldType.FVar(macro:Float, macro 0),
			pos: pos,
		});
		addFeild({
			name: "y",
			doc: "The y position of this Game Object.",
			access: [Access.APublic],
			kind: FieldType.FVar(macro:Float, macro 0),
			pos: pos,
		});
		addFeild({
			name: "z",
			doc: "The z position of this Game Object.
            Note: Do not use this value to set the z-index, instead see the `depth` property.",
			access: [Access.APublic],
			kind: FieldType.FVar(macro:Float, macro 0),
			pos: pos,
		});
		addFeild({
			name: "w",
			doc: "The w position of this Game Object.",
			access: [Access.APublic],
			kind: FieldType.FVar(macro:Float, macro 0),
			pos: pos,
		});

		addFeild({
			name: "scaleX",
			doc: "The horizontal scale of this Game Object.",
			access: [Access.APublic],
			kind: FieldType.FProp("get", "set", macro:Float),
			pos: pos,
		});
		addFeild({
			name: "get_scaleX",
			access: [Access.APrivate, Access.AInline],
			kind: FieldType.FFun({
				args: [],
				ret: macro:Float,
				expr: macro return
					phaserHaxe.gameobjects.components.TransformImplementaion.get_scaleX(this),
			}),
			pos: pos,
		});
		addFeild({
			name: "set_scaleX",
			access: [Access.APrivate, Access.AInline],
			kind: FieldType.FFun({
				args: [
					{
						name: "value",
						type: macro:Float,
					}
				],
				ret: macro:Float,
				expr: macro return
					phaserHaxe.gameobjects.components.TransformImplementaion.set_scaleX(this, value),
			}),
			pos: pos,
		});

		addFeild({
			name: "scaleY",
			doc: "The vertical scale of this Game Object. @since 1.0.0",
			access: [Access.APublic],
			kind: FieldType.FProp("get", "set", macro:Float),
			pos: pos,
		});
		addFeild({
			name: "get_scaleY",
			access: [Access.APrivate, Access.AInline],
			kind: FieldType.FFun({
				args: [],
				ret: macro:Float,
				expr: macro return
					phaserHaxe.gameobjects.components.TransformImplementaion.get_scaleY(this),
			}),
			pos: pos,
		});
		addFeild({
			name: "set_scaleY",
			access: [Access.APrivate, Access.AInline],
			kind: FieldType.FFun({
				args: [
					{
						name: "value",
						type: macro:Float,
					}
				],
				ret: macro:Float,
				expr: macro return
					phaserHaxe.gameobjects.components.TransformImplementaion.set_scaleY(this, value),
			}),
			pos: pos,
		});

		addFeild({
			name: "angle",

			doc: "The angle of this Game Object as expressed in degrees.
			
			Where 0 is to the right, 90 is down, 180 is left.
			
			If you prefer to work in radians, see the `rotation` property instead.
			
			@since 1.0.0",

			access: [Access.APublic],
			kind: FieldType.FProp("get", "set", macro:Float),
			pos: pos,
		});
		addFeild({
			name: "get_angle",
			access: [Access.APrivate, Access.AInline],
			kind: FieldType.FFun({
				args: [],
				ret: macro:Float,
				expr: macro return
					phaserHaxe.gameobjects.components.TransformImplementaion.get_angle(this),
			}),
			pos: pos,
		});
		addFeild({
			name: "set_angle",
			access: [Access.APrivate, Access.AInline],
			kind: FieldType.FFun({
				args: [
					{
						name: "value",
						type: macro:Float,
					}
				],
				ret: macro:Float,
				expr: macro return
					phaserHaxe.gameobjects.components.TransformImplementaion.set_angle(this, value),
			}),
			pos: pos,
		});

		addFeild({
			name: "rotation",

			doc: "The angle of this Game Object in radians.
			
			If you prefer to work in degrees, see the `angle` property instead.
			
			@since 1.0.0",

			access: [Access.APublic],
			kind: FieldType.FProp("get", "set", macro:Float),
			pos: pos,
		});
		addFeild({
			name: "get_rotation",
			access: [Access.APrivate, Access.AInline],
			kind: FieldType.FFun({
				args: [],
				ret: macro:Float,
				expr: macro return
					phaserHaxe.gameobjects.components.TransformImplementaion.get_rotation(this),
			}),
			pos: pos,
		});
		addFeild({
			name: "set_rotation",
			access: [Access.APrivate, Access.AInline],
			kind: FieldType.FFun({
				args: [
					{
						name: "value",
						type: macro:Float,
					}
				],
				ret: macro:Float,
				expr: macro return
					phaserHaxe.gameobjects.components.TransformImplementaion.set_rotation(this, value),
			}),
			pos: pos,
		});

		addFeild({
			name: "setPosition",
			access: [Access.APublic],
			kind: FieldType.FFun({
				args: [
					{
						name: "x",
						type: macro:Float,
						value: macro 0
					},
					{
						name: "y",
						type: macro:Float,
						opt: true
					},
					{
						name: "z",
						type: macro:Float,
						value: macro 0
					},
					{
						name: "w",
						type: macro:Float,
						value: macro 0
					}
				],
				ret: buildType,
				expr: macro return
					phaserHaxe.gameobjects.components.TransformImplementaion.setPosition(this, x, y, z, w),
			}),
			pos: pos,
		});

		return fields;
	}
}
#end
