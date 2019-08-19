package phaserHaxe.physics.arcade;

import phaserHaxe.math.Vector2;

/**
 * @since 1.0.0
**/
@:structInit
final class ArcadeWorldConfig
{
	/**
	 * Sets {@link phaserHaxe.physics.arcade.World.fps}.
	 *
	 * @since 1.0.0
	**/
	public var fps:Float = 60;

	/**
	 * Sets {@link phaserHaxe.physics.arcade.World.timeScale}.
	 *
	 * @since 1.0.0
	**/
	public var timeScale:Float = 1;

	/**
	 * Sets {@link phaserHaxe.physics.arcade.World.gravity}.
	 *
	 * @since 1.0.0
	**/
	public var gravity:Null<Vector2> = null;

	/**
	 * Sets {@link phaserHaxe.physics.arcade.World.bounds bounds.x}.
	 *
	 * @since 1.0.0
	**/
	public var x:Float = 0;

	/**
	 * Sets {@link phaserHaxe.physics.arcade.World.bounds bounds.y}.
	 *
	 * @since 1.0.0
	**/
	public var y:Float = 0;

	/**
	 * Sets {@link phaserHaxe.physics.arcade.World.bounds bounds.width}.
	 *
	 * @since 1.0.0
	**/
	public var width:Float = 0;

	/**
	 * Sets {@link phaserHaxe.physics.arcade.bounds bounds.height}.
	 *
	 * @since 1.0.0
	**/
	public var height:Float = 4;

	/**
	 * Sets {@link phaserHaxe.physics.arcade.checkCollision}.
	 *
	**/
	public var checkCollision:Null<CheckCollisionObject> = null;

	/**
	 * Sets {@link phaserHaxe.physics.arcade.OVERLAP_BIAS}.
	 *
	 * @since 1.0.0
	**/
	public var overlapBias:Float = 4;

	/**
	 * Sets {@link phaserHaxe.physics.arcade.TILE_BIAS}.
	 *
	 * @since 1.0.0
	**/
	public var tileBias:Float = 16;

	/**
	 * Sets {@link phaserHaxe.physics.arcade.forceX}.
	 *
	 * @since 1.0.0
	**/
	public var forceX:Bool = false;

	/**
	 * Sets {@link phaserHaxe.physics.arcade.isPaused}.
	 *
	 * @since 1.0.0
	**/
	public var isPaused:Bool = false;

	/**
	 * Sets {@link phaserHaxe.physics.arcade.debug}.
	 *
	 * @since 1.0.0
	**/
	public var debug:Bool = false;

	/**
	 * Sets {@link phaserHaxe.physics.arcade.defaults debugShowBody}.
	 *
	 * @since 1.0.0
	**/
	public var debugShowBody:Bool = true;

	/**
	 * Sets {@link phaserHaxe.physics.arcade.defaults debugShowStaticBody}.
	 *
	 * @since 1.0.0
	**/
	public var debugShowStaticBody:Bool = true;

	/**
	 * Sets {@link phaserHaxe.physics.arcade.defaults debugShowStaticBody}.
	 *
	 * @since 1.0.0
	**/
	public var debugShowVelocity:Bool = true;

	/**
	 * Sets {@link phaserHaxe.physics.arcade.defaults debugBodyColor}.
	 *
	 * @since 1.0.0
	**/
	public var debugBodyColor:Int = 0x0000ff;

	/**
	 * Sets {@link phaserHaxe.physics.arcade.defaults debugStaticBodyColor}.
	 *
	 * @since 1.0.0
	**/
	public var debugStaticBodyColor:Int = 0x0000ff;

	/**
	 * Sets {@link phaserHaxe.physics.arcade.defaults debugVelocityColor}
	 *
	 * @since 1.0.0
	**/
	public var debugVelocityColor:Int = 0x00ff00;

	/**
	 * Sets {@link phaserHaxe.physics.arcade.maxEntries}.
	 *
	 * @since 1.0.0
	**/
	public var maxEntries:Int = 16;

	/**
	 * Sets {@link phaserHaxe.physics.arcade.useTree}.
	 *
	 * @since 1.0.0
	**/
	public var useTree:Bool = true;
}
