package phaserHaxe.scene.typedefs;

import haxe.Constraints.Function;

/**
 * @since 1.0.0
**/
typedef CreateSceneFromObjectConfig =
{
	/**
	 * The scene's init callback.
	 *
	 * @since 1.0.0
	**/
	public var ?init:SceneInitCallback;

	/**
	 * The scene's preload callback.
	 *
	 * @since 1.0.0
	**/
	public var ?preload:SceneInitCallback;

	/**
	 * The scene's create callback.
	 *
	 * @since 1.0.0
	**/
	public var ?create:SceneInitCallback;

	/**
	 * The scene's update callback. See {@link Phaser.Scene#update}.
	 *
	 * @since 1.0.0
	**/
	public var ?update:Function;
};
