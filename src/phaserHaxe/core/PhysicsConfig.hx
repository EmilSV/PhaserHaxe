package phaserHaxe.core;

import phaserHaxe.physics.arcade.ArcadeWorldConfig;

final class PhysicsConfig
{
	/**
	 * The default physics system. It will be started for each scene.
	 * Phaser provides 'arcade', 'impact', and 'matter'.
	 *
	 * @since 1.0.0
	**/
	public var defaultPhysics:String;

	/**
	 * Arcade Physics configuration.
	 *
	 * @since 1.0.0
	**/
	public var arcade:ArcadeWorldConfig;

	/**
	 * Impact Physics configuration.
	 *
	 * @since 1.0.0
	**/
	public var impact:Dynamic;

	/**
	 * Matter Physics configuration.
	 *
	 * @since 1.0.0
	**/
	public var matter:Dynamic;
}
