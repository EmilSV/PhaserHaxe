package phaserHaxe.gameobjects.components;

import phaserHaxe.math.Vector2;
import phaserHaxe.geom.Rectangle;

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
	 * @return {(Phaser.Math.Vector2|object)} The values stored in the output object.
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
	function getTopCenter(?output:Vector2, includeParent:Bool = false):Vector2;

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
	function getTopRight(?output:Vector2, includeParent:Bool = false):Vector2;

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
	function getLeftCenter(?output:Vector2, includeParent:Bool = false):Vector2;

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
	function getRightCenter(?output:Vector2, includeParent:Bool = false):Vector2;

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
	function getBottomLeft(?output:Vector2, includeParent:Bool = false):Vector2;

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
	function getBottomCenter(?output:Vector2, includeParent:Bool = false):Vector2;

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
	function getBottomRight(?output:Vector2, includeParent:Bool = false):Vector2;

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
	function getBounds(?output:Rectangle):Rectangle;
}
