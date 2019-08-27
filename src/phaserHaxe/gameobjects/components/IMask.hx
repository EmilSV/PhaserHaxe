package phaserHaxe.gameobjects.components;

import phaserHaxe.display.mask.GeometryMask;
import phaserHaxe.display.mask.BitMask;

/**
 * Provides methods used for getting and setting the mask of a Game Object.
 *
 * @since 1.0.0
**/
// @:phaserHaxe.Mixin(phaserHaxe.gameobjects.components.IMask.)
interface IMask
{
	/**
	 * The Mask this Game Object is using during render.
	 *
	 * @since 1.0.0
	**/
	public var mask:Either<BitMask, GeometryMask>;

	/**
	 * Sets the mask that this Game Object will use to render with.
	 *
	 * The mask must have been previously created and can be either a GeometryMask or a BitmapMask.
	 * Note: Bitmap Masks only work on WebGL. Geometry Masks work on both WebGL and Canvas.
	 *
	 * If a mask is already set on this Game Object it will be immediately replaced.
	 *
	 * Masks are positioned in global space and are not relative to the Game Object to which they
	 * are applied. The reason for this is that multiple Game Objects can all share the same mask.
	 *
	 * Masks have no impact on physics or input detection. They are purely a rendering component
	 * that allows you to limit what is visible during the render pass.
	 *
	 * @since 1.0.0
	 *
	 * @param mask - The mask this Game Object will use when rendering.
	 *
	 * @return This Game Object instance.
	**/
	public function setMask(mask:Either<BitMask, GeometryMask>):IMask;

	/**
	 * Clears the mask that this Game Object was using.
	 *
	 * @since 1.0.0
	 *
	 * @param destroyMask - Destroy the mask before clearing it?
	 *
	 * @return This Game Object instance.
	**/
	function clearMask(destroyMask:Bool = false):IMask;

	/**
	 * Creates and returns a Bitmap Mask. This mask can be used by any Game Object,
	 * including this one.
	 *
	 * To create the mask you need to pass in a reference to a renderable Game Object.
	 * A renderable Game Object is one that uses a texture to render with, such as an
	 * Image, Sprite, Render Texture or BitmapText.
	 *
	 * If you do not provide a renderable object, and this Game Object has a texture,
	 * it will use itself as the object. This means you can call this method to create
	 * a Bitmap Mask from any renderable Game Object.
	 *
	 * @since 1.0.0
	 *
	 * @param renderable - A renderable Game Object that uses a texture, such as a Sprite.
	 *
	 * @return This Bitmap Mask that was created.
	**/
	public function createBitmapMask(?renderable:GameObject):BitMask;

	/**
	 * Creates and returns a Geometry Mask. This mask can be used by any Game Object,
	 * including this one.
	 *
	 * To create the mask you need to pass in a reference to a Graphics Game Object.
	 *
	 * If you do not provide a graphics object, and this Game Object is an instance
	 * of a Graphics object, then it will use itself to create the mask.
	 *
	 * This means you can call this method to create a Geometry Mask from any Graphics Game Object.
	 *
	 * @since 1.0.0
	 *
	 * @param graphics - A Graphics Game Object. The geometry within it will be used as the mask.
	 *
	 * @return This Geometry Mask that was created.
	**/
	public function createGeometryMask(?graphics:Graphics):GeometryMask;
}

final class MaskImplementation
{
	//public static function setMask<T:IMask>(self:T,) {}
}
