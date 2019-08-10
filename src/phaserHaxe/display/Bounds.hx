package phaserHaxe.display;

import phaserHaxe.gameobjects.components.ICSize;
import phaserHaxe.gameobjects.components.ICTransform;
import phaserHaxe.gameobjects.components.ICOrigin;

final class Bounds
{
	/**
	 * Positions the Game Object so that it is centered on the given coordinates.
	 *
	 * @since 1.0.0
	 *
	 * @param gameObject - The Game Object that will be re-positioned.
	 * @param x - The horizontal coordinate to position the Game Object on.
	 * @param y - The vertical coordinate to position the Game Object on.
	 *
	 * @return The Game Object that was positioned.
	**/
	public static inline function centerOn<G:ICTransform & ICSize & ICOrigin>(gameObject:G,
		x:Float, y:Float):G
	{
		setCenterX(gameObject, x);

		return setCenterY(gameObject, y);
	}

	/**
	 * Returns the bottom coordinate from the bounds of the Game Object.
	 *
	 * @since 1.0.0
	 *
	 * @param gameObject - The Game Object to get the bounds value from.
	 *
	 * @return The bottom coordinate of the bounds of the Game Object.
	**/
	@:pure
	public static inline function getBottom<G:ICTransform & ICSize & ICOrigin>(gameObject:G):Float
	{
		return (gameObject.y +
			gameObject.height) - (gameObject.height * gameObject.originY);
	}

	/**
	 * Returns the center x coordinate from the bounds of the Game Object.
	 *
	 * @since 1.0.0
	 *
	 * @param gameObject - The Game Object to get the bounds value from.
	 *
	 * @return The center x coordinate of the bounds of the Game Object.
	**/
	@:pure
	public static inline function getCenterX<G:ICTransform & ICSize & ICOrigin>(gameObject:G):Float
	{
		return gameObject.x - (gameObject.width * gameObject.originX) +
			(gameObject.width * 0.5);
	}

	/**
	 * Returns the center y coordinate from the bounds of the Game Object.
	 *
	 * @since 1.0.0
	 *
	 * @param gameObject - The Game Object to get the bounds value from.
	 *
	 * @return The center y coordinate of the bounds of the Game Object.
	**/
	@:pure
	public static inline function getCenterY<G:ICTransform & ICSize & ICOrigin>(gameObject:G):Float
	{
		return gameObject.y - (gameObject.height * gameObject.originY) +
			(gameObject.height * 0.5);
	}

	/**
	 * Returns the left coordinate from the bounds of the Game Object.
	 *
	 * @since 1.0.0
	 *
	 * @param gameObject - The Game Object to get the bounds value from.
	 *
	 * @return The left coordinate of the bounds of the Game Object.
	**/
	@:pure
	public static inline function getLeft<G:ICTransform & ICSize & ICOrigin>(gameObject:G):Float
	{
		return gameObject.x - (gameObject.width * gameObject.originX);
	}

	/**
	 * Returns the amount the Game Object is visually offset from its x coordinate.
	 * This is the same as `width * origin.x`.
	 * This value will only be > 0 if `origin.x` is not equal to zero.
	 *
	 * @since 1.0.0
	 *
	 * @param gameObject - The Game Object to get the bounds value from.
	 *
	 * @return The horizontal offset of the Game Object.
	**/
	@:pure
	public static inline function getOffsetX<G:ICSize & ICOrigin>(gameObject:G):Float
	{
		return gameObject.width * gameObject.originX;
	}

	/**
	 * Returns the amount the Game Object is visually offset from its y coordinate.
	 * This is the same as `width * origin.y`.
	 * This value will only be > 0 if `origin.y` is not equal to zero.
	 *
	 * @since 1.0.0
	 *
	 * @param gameObject - The Game Object to get the bounds value from.
	 *
	 * @return The vertical offset of the Game Object.
	**/
	@:pure
	public static function getOffsetY<G:ICSize & ICOrigin>(gameObject:G):Float
	{
		return gameObject.height * gameObject.originY;
	}

	/**
	 * Returns the right coordinate from the bounds of the Game Object.
	 *
	 * @since 1.0.0
	 *
	 * @param gameObject - The Game Object to get the bounds value from.
	 *
	 * @return The right coordinate of the bounds of the Game Object.
	**/
	@:pure
	public static function getRight<G:ICSize & ICTransform & ICOrigin>(gameObject:G):Float
	{
		return (gameObject.x +
			gameObject.width) - (gameObject.width * gameObject.originX);
	}

	/**
	 * Returns the top coordinate from the bounds of the Game Object.
	 *
	 * @since 1.0.0
	 *
	 * @param gameObject - The Game Object to get the bounds value from.
	 *
	 * @return The top coordinate of the bounds of the Game Object.
	**/
	@:pure
	public static inline function getTop<G:ICSize & ICTransform & ICOrigin>(gameObject:G):Float
	{
		return gameObject.y - (gameObject.height * gameObject.originY);
	}

	/**
	 * Positions the Game Object so that the bottom of its bounds aligns with the given coordinate.
	 *
	 * @since 1.0.0
	 *
	 * @param gameObject - The Game Object that will be re-positioned.
	 * @param value - The coordinate to position the Game Object bounds on.
	 *
	 * @return The Game Object that was positioned.
	**/
	@:pure
	public static function setBottom<G:ICSize & ICTransform & ICOrigin>(gameObject:G,
			value:Float):G
	{
		gameObject.y = (value - gameObject.height) +
			(gameObject.height * gameObject.originY);
		return gameObject;
	}

	/**
	 * Positions the Game Object so that the center top of its bounds aligns with the given coordinate.
	 *
	 * @since 1.0.0
	 *
	 * @param gameObject - The Game Object that will be re-positioned.
	 * @param  x - The coordinate to position the Game Object bounds on.
	 *
	 * @return The Game Object that was positioned.
	**/
	public static function setCenterX<G:ICSize & ICTransform & ICOrigin>(gameObject:G,
			x:Float):G
	{
		var offsetX = gameObject.width * gameObject.originX;
		gameObject.x = (x + offsetX) - (gameObject.width * 0.5);
		return gameObject;
	}

	/**
	 * Positions the Game Object so that the center top of its bounds aligns with the given coordinate.
	 *
	 * @since 1.0.0
	 *
	 * @param gameObject - The Game Object that will be re-positioned.
	 * @param  y - The coordinate to position the Game Object bounds on.
	 *
	 * @return The Game Object that was positioned.
	**/
	public static function setCenterY<G:ICSize & ICTransform & ICOrigin>(gameObject:G,
			y:Float):G
	{
		var offsetY = gameObject.height * gameObject.originY;
		gameObject.y = (y + offsetY) - (gameObject.height * 0.5);
		return gameObject;
	}

	/**
	 * Positions the Game Object so that the left of its bounds aligns with the given coordinate.
	 *
	 * @since 1.0.0
	 *
	 * @param gameObject - The Game Object that will be re-positioned.
	 * @param value - The coordinate to position the Game Object bounds on.
	 *
	 * @return The Game Object that was positioned.
	**/
	public static function setLeft<G:ICSize & ICTransform & ICOrigin>(gameObject:G,
			value:Float):G
	{
		gameObject.x = value + (gameObject.width * gameObject.originX);
		return gameObject;
	}

	/**
	 * Positions the Game Object so that the left of its bounds aligns with the given coordinate.
	 *
	 * @since 1.0.0
	 *
	 * @param gameObject - The Game Object that will be re-positioned.
	 * @param value - The coordinate to position the Game Object bounds on.
	 *
	 * @return The Game Object that was positioned.
	**/
	public static function setRight<G:ICSize & ICTransform & ICOrigin>(gameObject:G,
			value:Float):G
	{
		gameObject.x = (value - gameObject.width) +
			(gameObject.width * gameObject.originX);

		return gameObject;
	}

	/**
	 * Positions the Game Object so that the top of its bounds aligns with the given coordinate.
	 *
	 * @since 1.0.0
	 *
	 * @param gameObject - The Game Object that will be re-positioned.
	 * @param value - The coordinate to position the Game Object bounds on.
	 *
	 * @return The Game Object that was positioned.
	**/
	public static function setTop<G:ICSize & ICTransform & ICOrigin>(gameObject:G,
			value:Float):G
	{
		gameObject.y = value + (gameObject.height * gameObject.originY);
		return gameObject;
	}
}
