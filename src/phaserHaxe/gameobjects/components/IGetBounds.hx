package phaserHaxe.gameobjects.components;

import phaserHaxe.math.Vector2;
import phaserHaxe.geom.Rectangle;
import phaserHaxe.math.MathUtility.rotateAround as rotateAround;

interface IGetBounds
{
	/**
	 * Processes the bounds output vector before returning it.
	 *
	 * @since 1.0.0
	 *
	 * @param output - An object to store the values in. If not provided a new Vector2 will be created.
	 * @param includeParent - If this Game Object has a parent Container, include it (and all other ancestors) in the resulting vector?
	 *
	 * @return The values stored in the output object.
	**/
	public function prepareBoundsOutput(?output:Vector2,
		includeParent:Bool = false):Vector2;

	/**
	 * Gets the center coordinate of this Game Object, regardless of origin.
	 * The returned point is calculated in local space and does not factor in any parent containers
	 *
	 * @since 1.0.0
	 *
	 * @param output - An object to store the values in. If not provided a new Vector2 will be created.
	 *
	 * @return The values stored in the output object.
	**/
	public function getCenter(?output:Vector2):Vector2;

	/**
	 * Gets the top-left corner coordinate of this Game Object, regardless of origin.
	 * The returned point is calculated in local space and does not factor in any parent containers
	 *
	 * @since 1.0.0
	 *
	 * @param output - An object to store the values in. If not provided a new Vector2 will be created.
	 * @param includeParent - If this Game Object has a parent Container, include it (and all other ancestors) in the resulting vector?
	 *
	 * @return The values stored in the output object.
	**/
	public function getTopLeft(?output:Vector2, includeParent:Bool = false):Vector2;

	/**
	 * Gets the top-center coordinate of this Game Object, regardless of origin.
	 * The returned point is calculated in local space and does not factor in any parent containers
	 *
	 * @since 1.0.0
	 *
	 * @param output - An object to store the values in. If not provided a new Vector2 will be created.
	 * @param includeParent - If this Game Object has a parent Container, include it (and all other ancestors) in the resulting vector?
	 *
	 * @return The values stored in the output object.
	**/
	public function getTopCenter(?output:Vector2, includeParent:Bool = false):Vector2;

	/**
	 * Gets the top-right corner coordinate of this Game Object, regardless of origin.
	 * The returned point is calculated in local space and does not factor in any parent containers
	 *
	 * @since 1.0.0
	 *
	 * @param output - An object to store the values in. If not provided a new Vector2 will be created.
	 * @param includeParent - If this Game Object has a parent Container, include it (and all other ancestors) in the resulting vector?
	 *
	 * @return The values stored in the output object.
	**/
	public function getTopRight(?output:Vector2, includeParent:Bool = false):Vector2;

	/**
	 * Gets the left-center coordinate of this Game Object, regardless of origin.
	 * The returned point is calculated in local space and does not factor in any parent containers
	 *
	 * @since 1.0.0
	 *
	 * @param output - An object to store the values in. If not provided a new Vector2 will be created.
	 * @param includeParent - If this Game Object has a parent Container, include it (and all other ancestors) in the resulting vector?
	 *
	 * @return The values stored in the output object.
	**/
	public function getLeftCenter(?output:Vector2, includeParent:Bool = false):Vector2;

	/**
	 * Gets the right-center coordinate of this Game Object, regardless of origin.
	 * The returned point is calculated in local space and does not factor in any parent containers
	 *
	 * @since 1.0.0
	 *
	 * @param output - An object to store the values in. If not provided a new Vector2 will be created.
	 * @param includeParent - If this Game Object has a parent Container, include it (and all other ancestors) in the resulting vector?
	 *
	 * @return The values stored in the output object.
	**/
	public function getRightCenter(?output:Vector2, includeParent:Bool = false):Vector2;

	/**
	 * Gets the bottom-left corner coordinate of this Game Object, regardless of origin.
	 * The returned point is calculated in local space and does not factor in any parent containers
	 *
	 * @since 1.0.0
	 *
	 * @param output - An object to store the values in. If not provided a new Vector2 will be created.
	 * @param includeParent - If this Game Object has a parent Container, include it (and all other ancestors) in the resulting vector?
	 *
	 * @return The values stored in the output object.
	**/
	public function getBottomLeft(?output:Vector2, includeParent:Bool = false):Vector2;

	/**
	 * Gets the bottom-center coordinate of this Game Object, regardless of origin.
	 * The returned point is calculated in local space and does not factor in any parent containers
	 *
	 * @since 1.0.0
	 *
	 * @param output - An object to store the values in. If not provided a new Vector2 will be created.
	 * @param includeParent - If this Game Object has a parent Container, include it (and all other ancestors) in the resulting vector?
	 *
	 * @return The values stored in the output object.
	**/
	public function getBottomCenter(?output:Vector2, includeParent:Bool = false):Vector2;

	/**
	 * Gets the bottom-right corner coordinate of this Game Object, regardless of origin.
	 * The returned point is calculated in local space and does not factor in any parent containers
	 *
	 * @since 1.0.0
	 *
	 * @param output - An object to store the values in. If not provided a new Vector2 will be created.
	 * @param includeParent - If this Game Object has a parent Container, include it (and all other ancestors) in the resulting vector?
	 *
	 * @return The values stored in the output object.
	**/
	public function getBottomRight(?output:Vector2, includeParent:Bool = false):Vector2;

	/**
	 * Gets the bounds of this Game Object, regardless of origin.
	 * The values are stored and returned in a Rectangle, or Rectangle-like, object.
	 *
	 * @since 1.0.0
	 *
	 * @param output - An object to store the values in. If not provided a new Rectangle will be created.
	 *
	 * @return The values stored in the output object.
	**/
	public function getBounds(?output:Rectangle):Rectangle;
}

final class GetBoundsImplementation
{
	private static final tempVector = new Vector2();

	/**
	 * Processes the bounds output vector before returning it.
	 *
	 * @since 1.0.0
	 *
	 * @param output - An object to store the values in. If not provided a new Vector2 will be created.
	 * @param includeParent - If this Game Object has a parent Container, include it (and all other ancestors) in the resulting vector?
	 *
	 * @return The values stored in the output object.
	**/
	public static inline function prepareBoundsOutput<T:ITransform & GameObject>(self:T,
			?output:Vector2, includeParent:Bool = false):Vector2
	{
		if (output != null)
		{
			output = new Vector2();
		}

		if (self.rotation != 0)
		{
			rotateAround(output, self.x, self.y, self.rotation);
		}

		if (includeParent && self.parentContainer != null)
		{
			var parentMatrix:TransformMatrix = self.parentContainer.getBoundsTransformMatrix();

			parentMatrix.transformPoint(output.x, output.y, output);
		}
		return output;
	}

	/**
	 * Gets the center coordinate of this Game Object, regardless of origin.
	 * The returned point is calculated in local space and does not factor in any parent containers
	 *
	 * @since 1.0.0
	 *
	 * @param output - An object to store the values in. If not provided a new Vector2 will be created.
	 *
	 * @return The values stored in the output object.
	**/
	public static inline function getCenter<T:ITransform & GameObject & ISize & IOrigin>(self:T,
		?output:Vector2):Vector2
	{
		if (output == null)
		{
			output = new Vector2();
		}

		output.x = self.x - (self.displayWidth * self.originX) + (self.displayWidth / 2);
		output.y = self.y - (self.displayHeight * self.originY) +
			(self.displayHeight / 2);

		return output;
	}

	/**
	 * Gets the top-left corner coordinate of this Game Object, regardless of origin.
	 * The returned point is calculated in local space and does not factor in any parent containers
	 *
	 * @since 1.0.0
	 *
	 * @param output - An object to store the values in. If not provided a new Vector2 will be created.
	 * @param includeParent - If this Game Object has a parent Container, include it (and all other ancestors) in the resulting vector?
	 *
	 * @return The values stored in the output object.
	**/
	public static inline function getTopLeft<T:IGetBounds & ITransform & ISize & IOrigin>(self:T,
		?output:Vector2, includeParent:Bool = false):Vector2
	{
		if (output != null)
		{
			output = new Vector2();
		}

		output.x = self.x - (self.displayWidth * self.originX);
		output.y = self.y - (self.displayHeight * self.originY);

		return self.prepareBoundsOutput(output, includeParent);
	}

	/**
	 * Gets the top-center coordinate of this Game Object, regardless of origin.
	 * The returned point is calculated in local space and does not factor in any parent containers
	 *
	 * @since 1.0.0
	 *
	 * @param output - An object to store the values in. If not provided a new Vector2 will be created.
	 * @param includeParent - If this Game Object has a parent Container, include it (and all other ancestors) in the resulting vector?
	 *
	 * @return The values stored in the output object.
	**/
	public static inline function getTopCenter<T:IGetBounds & ITransform & ISize & IOrigin>(self:T,
		?output:Vector2, includeParent:Bool = false):Vector2
	{
		if (output != null)
		{
			output = new Vector2();
		}

		output.x = (self.x - (self.displayWidth * self.originX)) +
			(self.displayWidth / 2);
		output.y = self.y - (self.displayHeight * self.originY);

		return self.prepareBoundsOutput(output, includeParent);
	}

	/**
	 * Gets the top-right corner coordinate of this Game Object, regardless of origin.
	 * The returned point is calculated in local space and does not factor in any parent containers
	 *
	 * @since 1.0.0
	 *
	 * @param output - An object to store the values in. If not provided a new Vector2 will be created.
	 * @param includeParent - If this Game Object has a parent Container, include it (and all other ancestors) in the resulting vector?
	 *
	 * @return The values stored in the output object.
	**/
	public static inline function getTopRight<T:IGetBounds & ITransform & ISize & IOrigin>(self:T,
		?output:Vector2, includeParent:Bool = false):Vector2
	{
		if (output != null)
		{
			output = new Vector2();
		}

		output.x = (self.x - (self.displayWidth * self.originX)) + self.displayWidth;
		output.y = self.y - (self.displayHeight * self.originY);

		return self.prepareBoundsOutput(output, includeParent);
	}

	/**
	 * Gets the left-center coordinate of this Game Object, regardless of origin.
	 * The returned point is calculated in local space and does not factor in any parent containers
	 *
	 * @since 1.0.0
	 *
	 * @param output - An object to store the values in. If not provided a new Vector2 will be created.
	 * @param includeParent - If this Game Object has a parent Container, include it (and all other ancestors) in the resulting vector?
	 *
	 * @return The values stored in the output object.
	**/
	public static inline function getLeftCenter<T:IGetBounds & ITransform & ISize & IOrigin>(self:T,
		?output:Vector2, includeParent:Bool = false):Vector2
	{
		if (output != null)
		{
			output = new Vector2();
		}

		output.x = self.x - (self.displayWidth * self.originX);
		output.y = (self.y - (self.displayHeight * self.originY)) +
			(self.displayHeight / 2);

		return self.prepareBoundsOutput(output, includeParent);
	}

	/**
	 * Gets the right-center coordinate of this Game Object, regardless of origin.
	 * The returned point is calculated in local space and does not factor in any parent containers
	 *
	 * @since 1.0.0
	 *
	 * @param output - An object to store the values in. If not provided a new Vector2 will be created.
	 * @param includeParent - If this Game Object has a parent Container, include it (and all other ancestors) in the resulting vector?
	 *
	 * @return The values stored in the output object.
	**/
	public static inline function getRightCenter<T:IGetBounds & ITransform & ISize & IOrigin>(self:T,
		?output:Vector2, includeParent:Bool = false):Vector2
	{
		if (output != null)
		{
			output = new Vector2();
		}

		output.x = (self.x - (self.displayWidth * self.originX)) + self.displayWidth;
		output.y = (self.y - (self.displayHeight * self.originY)) +
			(self.displayHeight / 2);

		return self.prepareBoundsOutput(output, includeParent);
	}

	/**
	 * Gets the bottom-left corner coordinate of this Game Object, regardless of origin.
	 * The returned point is calculated in local space and does not factor in any parent containers
	 *
	 * @since 1.0.0
	 *
	 * @param output - An object to store the values in. If not provided a new Vector2 will be created.
	 * @param includeParent - If this Game Object has a parent Container, include it (and all other ancestors) in the resulting vector?
	 *
	 * @return The values stored in the output object.
	**/
	public static inline function getBottomLeft<T:IGetBounds & ITransform & ISize & IOrigin>(self:T,
		?output:Vector2, includeParent:Bool = false):Vector2
	{
		if (output != null)
		{
			output = new Vector2();
		}

		output.x = self.x - (self.displayWidth * self.originX);
		output.y = (self.y - (self.displayHeight * self.originY)) + self.displayHeight;

		return self.prepareBoundsOutput(output, includeParent);
	}

	/**
	 * Gets the bottom-center coordinate of this Game Object, regardless of origin.
	 * The returned point is calculated in local space and does not factor in any parent containers
	 *
	 * @since 1.0.0
	 *
	 * @param output - An object to store the values in. If not provided a new Vector2 will be created.
	 * @param includeParent - If this Game Object has a parent Container, include it (and all other ancestors) in the resulting vector?
	 *
	 * @return The values stored in the output object.
	**/
	public static inline function getBottomCenter<T:IGetBounds & ITransform & ISize & IOrigin>(self:T,
		?output:Vector2, includeParent:Bool = false):Vector2
	{
		if (output != null)
		{
			output = new Vector2();
		}

		output.x = (self.x - (self.displayWidth * self.originX)) +
			(self.displayWidth / 2);
		output.y = (self.y - (self.displayHeight * self.originY)) + self.displayHeight;

		return self.prepareBoundsOutput(output, includeParent);
	}

	/**
	 * Gets the bottom-right corner coordinate of this Game Object, regardless of origin.
	 * The returned point is calculated in local space and does not factor in any parent containers
	 *
	 * @since 1.0.0
	 *
	 * @param output - An object to store the values in. If not provided a new Vector2 will be created.
	 * @param includeParent - If this Game Object has a parent Container, include it (and all other ancestors) in the resulting vector?
	 *
	 * @return The values stored in the output object.
	**/
	public static inline function getBottomRight<T:IGetBounds & ITransform & ISize & IOrigin>(self:T,
		?output:Vector2, includeParent:Bool = false):Vector2
	{
		if (output != null)
		{
			output = new Vector2();
		}

		output.x = (self.x - (self.displayWidth * self.originX)) + self.displayWidth;
		output.y = (self.y - (self.displayHeight * self.originY)) + self.displayHeight;

		return self.prepareBoundsOutput(output, includeParent);
	}

	/**
	 * Gets the bounds of this Game Object, regardless of origin.
	 * The values are stored and returned in a Rectangle, or Rectangle-like, object.
	 *
	 * @since 1.0.0
	 *
	 * @param output - An object to store the values in. If not provided a new Rectangle will be created.
	 *
	 * @return The values stored in the output object.
	**/
	public static inline function getBounds<T:GameObject & IGetBounds & ITransform & ISize & IOrigin>(self:T,
		?output:Rectangle):Rectangle
	{
		if (output == null)
		{
			output = new Rectangle();
		}

		//  We can use the output object to temporarily store the x/y coords in:

		var tlX, tlY, trX, trY, blX, blY, brX, brY;

		// Instead of doing a check if parent container is
		// defined per corner we only do it once.
		if (self.parentContainer != null)
		{
			var parentMatrix:TransformMatrix = self.parentContainer.getBoundsTransformMatrix();

			self.getTopLeft(tempVector);
			parentMatrix.transformPoint(tempVector.x, tempVector.y, tempVector);

			tlX = tempVector.x;
			tlY = tempVector.y;

			self.getTopRight(tempVector);
			parentMatrix.transformPoint(tempVector.x, tempVector.y, tempVector);

			trX = tempVector.x;
			trY = tempVector.y;

			self.getBottomLeft(tempVector);
			parentMatrix.transformPoint(tempVector.x, tempVector.y, tempVector);

			blX = tempVector.x;
			blY = tempVector.y;

			self.getBottomRight(tempVector);
			parentMatrix.transformPoint(tempVector.x, tempVector.y, tempVector);

			brX = tempVector.x;
			brY = tempVector.y;
		}
		else
		{
			self.getTopLeft(tempVector);

			tlX = tempVector.x;
			tlY = tempVector.y;

			self.getTopRight(tempVector);

			trX = tempVector.x;
			trY = tempVector.y;

			self.getBottomLeft(tempVector);

			blX = tempVector.x;
			blY = tempVector.y;

			self.getBottomRight(tempVector);

			brX = tempVector.x;
			brY = tempVector.y;
		}

		output.x = Math.min(Math.min(Math.min(tlX, trX), blX), brX);
		output.y = Math.min(Math.min(Math.min(tlY, trY), blY), brY);
		output.width = Math.max(Math.max(Math.max(tlX, trX), blX), brX) - output.x;
		output.height = Math.max(Math.max(Math.max(tlY, trY), blY), brY) - output.y;

		return output;
	}
}

final class GetBoundsMixin implements IGetBounds implements ITransform implements ISize
		implements IOrigin extends GameObject
{
	/**
	 * Processes the bounds output vector before returning it.
	 *
	 * @since 1.0.0
	 *
	 * @param output - An object to store the values in. If not provided a new Vector2 will be created.
	 * @param includeParent - If this Game Object has a parent Container, include it (and all other ancestors) in the resulting vector?
	 *
	 * @return The values stored in the output object.
	**/
	public function prepareBoundsOutput(?output:Vector2,
			includeParent:Bool = false):Vector2
	{
		return GetBoundsImplementation.prepareBoundsOutput(this, output, includeParent);
	}

	/**
	 * Gets the center coordinate of this Game Object, regardless of origin.
	 * The returned point is calculated in local space and does not factor in any parent containers
	 *
	 * @since 1.0.0
	 *
	 * @param output - An object to store the values in. If not provided a new Vector2 will be created.
	 *
	 * @return The values stored in the output object.
	**/
	public function getCenter(?output:Vector2):Vector2
	{
		return GetBoundsImplementation.getCenter(this, output);
	}

	/**
	 * Gets the top-left corner coordinate of this Game Object, regardless of origin.
	 * The returned point is calculated in local space and does not factor in any parent containers
	 *
	 * @since 1.0.0
	 *
	 * @param output - An object to store the values in. If not provided a new Vector2 will be created.
	 * @param includeParent - If this Game Object has a parent Container, include it (and all other ancestors) in the resulting vector?
	 *
	 * @return The values stored in the output object.
	**/
	public function getTopLeft(?output:Vector2, includeParent:Bool = false):Vector2
	{
		return GetBoundsImplementation.getTopLeft(this, output, includeParent);
	}

	/**
	 * Gets the top-center coordinate of this Game Object, regardless of origin.
	 * The returned point is calculated in local space and does not factor in any parent containers
	 *
	 * @since 1.0.0
	 *
	 * @param output - An object to store the values in. If not provided a new Vector2 will be created.
	 * @param includeParent - If this Game Object has a parent Container, include it (and all other ancestors) in the resulting vector?
	 *
	 * @return The values stored in the output object.
	**/
	public function getTopCenter(?output:Vector2, includeParent:Bool = false):Vector2
	{
		return GetBoundsImplementation.getTopCenter(this, output, includeParent);
	}

	/**
	 * Gets the top-right corner coordinate of this Game Object, regardless of origin.
	 * The returned point is calculated in local space and does not factor in any parent containers
	 *
	 * @since 1.0.0
	 *
	 * @param output - An object to store the values in. If not provided a new Vector2 will be created.
	 * @param includeParent - If this Game Object has a parent Container, include it (and all other ancestors) in the resulting vector?
	 *
	 * @return The values stored in the output object.
	**/
	public function getTopRight(?output:Vector2, includeParent:Bool = false):Vector2
	{
		return GetBoundsImplementation.getTopRight(this, output, includeParent);
	}

	/**
	 * Gets the left-center coordinate of this Game Object, regardless of origin.
	 * The returned point is calculated in local space and does not factor in any parent containers
	 *
	 * @since 1.0.0
	 *
	 * @param output - An object to store the values in. If not provided a new Vector2 will be created.
	 * @param includeParent - If this Game Object has a parent Container, include it (and all other ancestors) in the resulting vector?
	 *
	 * @return The values stored in the output object.
	**/
	public function getLeftCenter(?output:Vector2, includeParent:Bool = false):Vector2
	{
		return GetBoundsImplementation.getLeftCenter(this, output, includeParent);
	}

	/**
	 * Gets the right-center coordinate of this Game Object, regardless of origin.
	 * The returned point is calculated in local space and does not factor in any parent containers
	 *
	 * @since 1.0.0
	 *
	 * @param output - An object to store the values in. If not provided a new Vector2 will be created.
	 * @param includeParent - If this Game Object has a parent Container, include it (and all other ancestors) in the resulting vector?
	 *
	 * @return The values stored in the output object.
	**/
	public function getRightCenter(?output:Vector2, includeParent:Bool = false):Vector2
	{
		return GetBoundsImplementation.getRightCenter(this, output, includeParent);
	}

	/**
	 * Gets the bottom-left corner coordinate of this Game Object, regardless of origin.
	 * The returned point is calculated in local space and does not factor in any parent containers
	 *
	 * @since 1.0.0
	 *
	 * @param output - An object to store the values in. If not provided a new Vector2 will be created.
	 * @param includeParent - If this Game Object has a parent Container, include it (and all other ancestors) in the resulting vector?
	 *
	 * @return The values stored in the output object.
	**/
	public function getBottomLeft(?output:Vector2, includeParent:Bool = false):Vector2
	{
		return GetBoundsImplementation.getBottomLeft(this, output, includeParent);
	}

	/**
	 * Gets the bottom-center coordinate of this Game Object, regardless of origin.
	 * The returned point is calculated in local space and does not factor in any parent containers
	 *
	 * @since 1.0.0
	 *
	 * @param output - An object to store the values in. If not provided a new Vector2 will be created.
	 * @param includeParent - If this Game Object has a parent Container, include it (and all other ancestors) in the resulting vector?
	 *
	 * @return The values stored in the output object.
	**/
	public function getBottomCenter(?output:Vector2, includeParent:Bool = false):Vector2
	{
		return GetBoundsImplementation.getBottomCenter(this, output, includeParent);
	}

	/**
	 * Gets the bottom-right corner coordinate of this Game Object, regardless of origin.
	 * The returned point is calculated in local space and does not factor in any parent containers
	 *
	 * @since 1.0.0
	 *
	 * @param output - An object to store the values in. If not provided a new Vector2 will be created.
	 * @param includeParent - If this Game Object has a parent Container, include it (and all other ancestors) in the resulting vector?
	 *
	 * @return The values stored in the output object.
	**/
	public function getBottomRight(?output:Vector2, includeParent:Bool = false):Vector2
	{
		return GetBoundsImplementation.getBottomRight(this, output, includeParent);
	}

	/**
	 * Gets the bounds of this Game Object, regardless of origin.
	 * The values are stored and returned in a Rectangle, or Rectangle-like, object.
	 *
	 * @since 1.0.0
	 *
	 * @param output - An object to store the values in. If not provided a new Rectangle will be created.
	 *
	 * @return The values stored in the output object.
	**/
	public function getBounds(?output:Rectangle):Rectangle
	{
		return GetBoundsImplementation.getBounds(this, output);
	}

	@:phaserHaxe.mixinIgnore
	private var _scaleX:Float = 1;

	@:phaserHaxe.mixinIgnore
	private var _scaleY:Float = 1;

	@:phaserHaxe.mixinIgnore
	private var _rotation:Float = 0;

	@:phaserHaxe.mixinIgnore
	public var x:Float = 0;

	@:phaserHaxe.mixinIgnore
	public var y:Float = 0;

	@:phaserHaxe.mixinIgnore
	public var z:Float = 0;

	@:phaserHaxe.mixinIgnore
	public var w:Float = 0;

	@:phaserHaxe.mixinIgnore
	public var scale(get, set):Float;

	@:phaserHaxe.mixinIgnore
	public var scaleX(get, set):Float;

	@:phaserHaxe.mixinIgnore
	public var scaleY(get, set):Float;

	@:phaserHaxe.mixinIgnore
	public var angle(get, set):Float;

	@:phaserHaxe.mixinIgnore
	public var rotation(get, set):Float;

	@:phaserHaxe.mixinIgnore
	private inline function get_scale():Float
		throw "Not Implemented";

	@:phaserHaxe.mixinIgnore
	private inline function set_scale(value:Float):Float
		throw "Not Implemented";

	@:phaserHaxe.mixinIgnore
	private inline function get_scaleX():Float
		throw "Not Implemented";

	@:phaserHaxe.mixinIgnore
	private inline function set_scaleX(value:Float):Float
		throw "Not Implemented";

	@:phaserHaxe.mixinIgnore
	private inline function get_scaleY():Float
		throw "Not Implemented";

	@:phaserHaxe.mixinIgnore
	private inline function set_scaleY(value:Float):Float
		throw "Not Implemented";

	@:phaserHaxe.mixinIgnore
	private inline function get_angle():Float
		throw "Not Implemented";

	@:phaserHaxe.mixinIgnore
	private inline function set_angle(value:Float):Float
		throw "Not Implemented";

	@:phaserHaxe.mixinIgnore
	private inline function get_rotation():Float
		throw "Not Implemented";

	@:phaserHaxe.mixinIgnore
	private inline function set_rotation(value:Float):Float
		throw "Not Implemented";

	@:phaserHaxe.mixinIgnore
	public function setPosition(x:Float = 0, ?y:Float, z:Float = 0,
			w:Float = 0):GetBoundsMixin
		throw "Not Implemented";

	@:phaserHaxe.mixinIgnore
	public function setRandomPosition(x:Float = 0, y:Float = 0, ?width:Float,
			?height:Float):GetBoundsMixin
		throw "Not Implemented";

	@:phaserHaxe.mixinIgnore
	public function setRotation(radians:Float = 0):GetBoundsMixin
		throw "Not Implemented";

	@:phaserHaxe.mixinIgnore
	public function setAngle(degrees:Float = 0):GetBoundsMixin
		throw "Not Implemented";

	@:phaserHaxe.mixinIgnore
	public function setScale(x:Float = 1, ?y:Float):GetBoundsMixin
		throw "Not Implemented";

	@:phaserHaxe.mixinIgnore
	public function setX(value:Float = 0):GetBoundsMixin
		throw "Not Implemented";

	@:phaserHaxe.mixinIgnore
	public function setY(value:Float = 0):GetBoundsMixin
		throw "Not Implemented";

	@:phaserHaxe.mixinIgnore
	public function setZ(value:Float = 0):GetBoundsMixin
		throw "Not Implemented";

	@:phaserHaxe.mixinIgnore
	public function setW(value:Float = 0):GetBoundsMixin
		throw "Not Implemented";

	@:phaserHaxe.mixinIgnore
	public function getLocalTransformMatrix(?tempMatrix:TransformMatrix):TransformMatrix
		throw "Not Implemented";

	@:phaserHaxe.mixinIgnore
	public function getWorldTransformMatrix(?tempMatrix:TransformMatrix,
			?parentMatrix:TransformMatrix):TransformMatrix
		throw "Not Implemented";

	@:phaserHaxe.mixinIgnore
	private var _sizeComponent:Bool;

	@:phaserHaxe.mixinIgnore
	public var width:Float;

	@:phaserHaxe.mixinIgnore
	public var height:Float;

	@:phaserHaxe.mixinIgnore
	public var displayWidth(get, set):Float;

	@:phaserHaxe.mixinIgnore
	public var displayHeight(get, set):Float;

	@:phaserHaxe.mixinIgnore
	private function get_displayWidth():Float
		throw "Not Implemented";

	@:phaserHaxe.mixinIgnore
	private function set_displayWidth(value:Float):Float
		throw "Not Implemented";

	@:phaserHaxe.mixinIgnore
	private function get_displayHeight():Float
		throw "Not Implemented";

	@:phaserHaxe.mixinIgnore
	private function set_displayHeight(value:Float):Float
		throw "Not Implemented";

	@:phaserHaxe.mixinIgnore
	public function setSize(width:Float, height:Float):GetBoundsMixin
		throw "Not Implemented";

	@:phaserHaxe.mixinIgnore
	public function setDisplaySize(width:Float, height:Float):GetBoundsMixin
		throw "Not Implemented";

	@:phaserHaxe.mixinIgnore
	private var _originComponent:Bool;

	@:phaserHaxe.mixinIgnore
	public var originX:Float;
	@:phaserHaxe.mixinIgnore
	public var originY:Float;

	@:phaserHaxe.mixinIgnore
	private var _displayOriginX:Float;
	@:phaserHaxe.mixinIgnore
	private var _displayOriginY:Float;

	@:phaserHaxe.mixinIgnore
	public var displayOriginX(get, set):Float;
	@:phaserHaxe.mixinIgnore
	public var displayOriginY(get, set):Float;

	@:phaserHaxe.mixinIgnore
	private function get_displayOriginX():Float
		throw "Not Implemented";

	@:phaserHaxe.mixinIgnore
	private function set_displayOriginX(value:Float):Float
		throw "Not Implemented";

	@:phaserHaxe.mixinIgnore
	private function get_displayOriginY():Float
		throw "Not Implemented";

	@:phaserHaxe.mixinIgnore
	private function set_displayOriginY(value:Float):Float
		throw "Not Implemented";

	@:phaserHaxe.mixinIgnore
	public function setOrigin(x:Float = 0.5, ?y:Float):GetBoundsMixin
		throw "Not Implemented";

	@:phaserHaxe.mixinIgnore
	public function setOriginFromFrame():GetBoundsMixin
		throw "Not Implemented";

	@:phaserHaxe.mixinIgnore
	public function setDisplayOrigin(x:Float = 0, ?y:Float):GetBoundsMixin
		throw "Not Implemented";

	@:phaserHaxe.mixinIgnore
	public function updateDisplayOrigin():GetBoundsMixin
		throw "Not Implemented";
}
