package phaserHaxe.display;

import phaserHaxe.gameobjects.GameObject;

final class Bounds
{
	/**
	 * Positions the Game Object so that it is centered on the given coordinates.
	 *
	 * @function Phaser.Display.Bounds.CenterOn
	 * @since 1.0.0
	 *
	 * @generic {Phaser.GameObjects.GameObject} G - [gameObject,$return]
	 *
	 * @param {Phaser.GameObjects.GameObject} gameObject - The Game Object that will be re-positioned.
	 * @param {number} x - The horizontal coordinate to position the Game Object on.
	 * @param {number} y - The vertical coordinate to position the Game Object on.
	 *
	 * @return {Phaser.GameObjects.GameObject} The Game Object that was positioned.
	**/
	public static function CenterOn(gameObject:GameObject, x:Float, y:Float)
	{
		SetCenterX(gameObject, x);

		return SetCenterY(gameObject, y);
	}

	/**
	 * Returns the bottom coordinate from the bounds of the Game Object.
	 *
	 * @function Phaser.Display.Bounds.GetBottom
	 * @since 1.0.0
	 *
	 * @param {Phaser.GameObjects.GameObject} gameObject - The Game Object to get the bounds value from.
	 *
	 * @return {number} The bottom coordinate of the bounds of the Game Object.
	 */
	public static function GetBottom(gameObject)
	{
		return (gameObject.y +
			gameObject.height) - (gameObject.height * gameObject.originY);
	}

	/**
	 * Returns the center x coordinate from the bounds of the Game Object.
	 *
	 * @function Phaser.Display.Bounds.GetCenterX
	 * @since 1.0.0
	 *
	 * @param {Phaser.GameObjects.GameObject} gameObject - The Game Object to get the bounds value from.
	 *
	 * @return {number} The center x coordinate of the bounds of the Game Object.
	 */
	public static function GetCenterX(gameObject)
	{
		return gameObject.x - (gameObject.width * gameObject.originX) +
			(gameObject.width * 0.5);
	}

	/**
	 * Returns the center y coordinate from the bounds of the Game Object.
	 *
	 * @function Phaser.Display.Bounds.GetCenterY
	 * @since 1.0.0
	 *
	 * @param {Phaser.GameObjects.GameObject} gameObject - The Game Object to get the bounds value from.
	 *
	 * @return {number} The center y coordinate of the bounds of the Game Object.
	 */
	public static function GetCenterY(gameObject)
	{
		return gameObject.y - (gameObject.height * gameObject.originY) +
			(gameObject.height * 0.5);
	}

	/**
	 * Returns the left coordinate from the bounds of the Game Object.
	 *
	 * @function Phaser.Display.Bounds.GetLeft
	 * @since 1.0.0
	 *
	 * @param {Phaser.GameObjects.GameObject} gameObject - The Game Object to get the bounds value from.
	 *
	 * @return {number} The left coordinate of the bounds of the Game Object.
	 */
	public static function GetLeft(gameObject)
	{
		return gameObject.x - (gameObject.width * gameObject.originX);
	}

	/**
	 * Returns the amount the Game Object is visually offset from its x coordinate.
	 * This is the same as `width * origin.x`.
	 * This value will only be > 0 if `origin.x` is not equal to zero.
	 *
	 * @function Phaser.Display.Bounds.GetOffsetX
	 * @since 1.0.0
	 *
	 * @param {Phaser.GameObjects.GameObject} gameObject - The Game Object to get the bounds value from.
	 *
	 * @return {number} The horizontal offset of the Game Object.
	 */
	public static function GetOffsetX(gameObject)
	{
		return gameObject.width * gameObject.originX;
	}

	/**
	 * Returns the amount the Game Object is visually offset from its y coordinate.
	 * This is the same as `width * origin.y`.
	 * This value will only be > 0 if `origin.y` is not equal to zero.
	 *
	 * @function Phaser.Display.Bounds.GetOffsetY
	 * @since 1.0.0
	 *
	 * @param {Phaser.GameObjects.GameObject} gameObject - The Game Object to get the bounds value from.
	 *
	 * @return {number} The vertical offset of the Game Object.
	 */
	public static function GetOffsetY(gameObject)
	{
		return gameObject.height * gameObject.originY;
	}

	/**
	 * Returns the right coordinate from the bounds of the Game Object.
	 *
	 * @function Phaser.Display.Bounds.GetRight
	 * @since 1.0.0
	 *
	 * @param {Phaser.GameObjects.GameObject} gameObject - The Game Object to get the bounds value from.
	 *
	 * @return {number} The right coordinate of the bounds of the Game Object.
	 */
	public static function GetRight(gameObject)
	{
		return (gameObject.x +
			gameObject.width) - (gameObject.width * gameObject.originX);
	}

	/**
	 * Returns the top coordinate from the bounds of the Game Object.
	 *
	 * @function Phaser.Display.Bounds.GetTop
	 * @since 1.0.0
	 *
	 * @param {Phaser.GameObjects.GameObject} gameObject - The Game Object to get the bounds value from.
	 *
	 * @return {number} The top coordinate of the bounds of the Game Object.
	 */
	public static function GetTop(gameObject)
	{
		return gameObject.y - (gameObject.height * gameObject.originY);
	}

	/**
	 * Positions the Game Object so that the bottom of its bounds aligns with the given coordinate.
	 *
	 * @function Phaser.Display.Bounds.SetBottom
	 * @since 1.0.0
	 *
	 * @generic {Phaser.GameObjects.GameObject} G - [gameObject,$return]
	 *
	 * @param {Phaser.GameObjects.GameObject} gameObject - The Game Object that will be re-positioned.
	 * @param {number} value - The coordinate to position the Game Object bounds on.
	 *
	 * @return {Phaser.GameObjects.GameObject} The Game Object that was positioned.
	 */
	public static function SetBottom(gameObject, value)
	{
		gameObject.y = (value - gameObject.height) +
			(gameObject.height * gameObject.originY);
		return gameObject;
	}

	/**
	 * Positions the Game Object so that the center top of its bounds aligns with the given coordinate.
	 *
	 * @function Phaser.Display.Bounds.SetCenterX
	 * @since 1.0.0
	 *
	 * @generic {Phaser.GameObjects.GameObject} G - [gameObject,$return]
	 *
	 * @param {Phaser.GameObjects.GameObject} gameObject - The Game Object that will be re-positioned.
	 * @param {number} x - The coordinate to position the Game Object bounds on.
	 *
	 * @return {Phaser.GameObjects.GameObject} The Game Object that was positioned.
	 */
	public static function SetCenterX(gameObject:GameObject, x)
	{
		var offsetX = gameObject.width * gameObject.originX;
		gameObject.x = (x + offsetX) - (gameObject.width * 0.5);
		return gameObject;
	}

	/**
	 * Positions the Game Object so that the center top of its bounds aligns with the given coordinate.
	 *
	 * @function Phaser.Display.Bounds.SetCenterY
	 * @since 1.0.0
	 *
	 * @generic {Phaser.GameObjects.GameObject} G - [gameObject,$return]
	 *
	 * @param {Phaser.GameObjects.GameObject} gameObject - The Game Object that will be re-positioned.
	 * @param {number} y - The coordinate to position the Game Object bounds on.
	 *
	 * @return {Phaser.GameObjects.GameObject} The Game Object that was positioned.
	 */
	public static function SetCenterY(gameObject, y)
	{
		var offsetY = gameObject.height * gameObject.originY;
		gameObject.y = (y + offsetY) - (gameObject.height * 0.5);
		return gameObject;
	}

	/**
	 * Positions the Game Object so that the left of its bounds aligns with the given coordinate.
	 *
	 * @function Phaser.Display.Bounds.SetLeft
	 * @since 1.0.0
	 *
	 * @generic {Phaser.GameObjects.GameObject} G - [gameObject,$return]
	 *
	 * @param {Phaser.GameObjects.GameObject} gameObject - The Game Object that will be re-positioned.
	 * @param {number} value - The coordinate to position the Game Object bounds on.
	 *
	 * @return {Phaser.GameObjects.GameObject} The Game Object that was positioned.
	 */
	public static function SetLeft(gameObject, value)
	{
		gameObject.x = value + (gameObject.width * gameObject.originX);

		return gameObject;
	}

	/**
	 * Positions the Game Object so that the left of its bounds aligns with the given coordinate.
	 *
	 * @function Phaser.Display.Bounds.SetRight
	 * @since 1.0.0
	 *
	 * @generic {Phaser.GameObjects.GameObject} G - [gameObject,$return]
	 *
	 * @param {Phaser.GameObjects.GameObject} gameObject - The Game Object that will be re-positioned.
	 * @param {number} value - The coordinate to position the Game Object bounds on.
	 *
	 * @return {Phaser.GameObjects.GameObject} The Game Object that was positioned.
	 */
	public static function SetRight(gameObject, value)
	{
		gameObject.x = (value - gameObject.width) +
			(gameObject.width * gameObject.originX);

		return gameObject;
	}

	/**
	 * Positions the Game Object so that the top of its bounds aligns with the given coordinate.
	 *
	 * @function Phaser.Display.Bounds.SetTop
	 * @since 1.0.0
	 *
	 * @generic {Phaser.GameObjects.GameObject} G - [gameObject,$return]
	 *
	 * @param {Phaser.GameObjects.GameObject} gameObject - The Game Object that will be re-positioned.
	 * @param {number} value - The coordinate to position the Game Object bounds on.
	 *
	 * @return {Phaser.GameObjects.GameObject} The Game Object that was positioned.
	 */
	public static function SetTop(gameObject, value)
	{
		gameObject.y = value + (gameObject.height * gameObject.originY);

		return gameObject;
	}
}
