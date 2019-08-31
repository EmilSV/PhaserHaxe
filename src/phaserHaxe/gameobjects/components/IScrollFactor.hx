package phaserHaxe.gameobjects.components;

/**
 * Provides methods used for getting and setting the Scroll Factor of a Game Object.
 *
 * @since 1.0.0
**/
@:phaserHaxe.Mixin(phaserHaxe.gameobjects.components.IScrollFactor.ScrollFactorMixin)
interface IScrollFactor
{
	/**
	 * The horizontal scroll factor of this Game Object.
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
	 * @default 1
	 * @since 1.0.0
	**/
	public var scrollFactorX:Float;

	/**
	 * The vertical scroll factor of this Game Object.
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
	 * @default 1
	 * @since 1.0.0
	**/
	public var scrollFactorY:Float;

	/**
	 * Sets the scroll factor of this Game Object.
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
	 *
	 * @return This Game Object instance.
	**/
	public function setScrollFactor(x:Float, ?y:Float):IScrollFactor;
}

final class ScrollFactorImplementation
{
	public static inline function setScrollFactor<T:IScrollFactor>(self:T, x:Float,
			?y:Float):T
	{
		final y:Float = y != null ? y : x;

		self.scrollFactorX = x;
		self.scrollFactorY = y;

		return self;
	}
}

final class ScrollFactorMixin extends GameObject implements IScrollFactor
{
	/**
	 * The horizontal scroll factor of this Game Object.
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
	**/
	public var scrollFactorX:Float = 1;

	/**
	 * The vertical scroll factor of this Game Object.
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
	**/
	public var scrollFactorY:Float = 1;

	/**
	 * Sets the scroll factor of this Game Object.
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
	 *
	 * @return This Game Object instance.
	**/
	public function setScrollFactor(x:Float, ?y:Float):ScrollFactorMixin
	{
		return ScrollFactorImplementation.setScrollFactor(this, x, y);
	}
}
