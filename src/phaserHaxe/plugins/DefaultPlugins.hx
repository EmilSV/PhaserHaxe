package phaserHaxe.plugins;

final class DefaultPlugins
{
	/**
	 * These are the Global Managers that are created by the Phaser.Game instance.
	 * They are referenced from Scene.Systems so that plugins can use them.
	 *
	 * @since 1.0.0
	**/
	public static final global = ['game', 'anims', 'cache', 'plugins', 'registry', 'scale', 'sound', 'textures'];

	/**
	 * These are the core plugins that are installed into every Scene.Systems instance, no matter what.
	 * They are optionally exposed in the Scene as well (see the InjectionMap for details)
	 *
	 * They are created in the order in which they appear in this array and EventEmitter is always first.
	 *
	 * @since 1.0.0
	**/
	public static final coreScene = [
		'EventEmitter',
		'CameraManager',
		'GameObjectCreator',
		'GameObjectFactory',
		'ScenePlugin',
		'DisplayList',
		'UpdateList'
	];

	/**
	 * These plugins are created in Scene.Systems in addition to the CoreScenePlugins.
	 *
	 * You can elect not to have these plugins by either creating a DefaultPlugins object as part
	 * of the Game Config, by creating a Plugins object as part of a Scene Config, or by modifying this array
	 * and building your own bundle.
	 *
	 * They are optionally exposed in the Scene as well (see the InjectionMap for details)
	 *
	 * They are always created in the order in which they appear in the array.
	 *
	 * @since 1.0.0
	**/
	public static final defaultScene = [
		'Clock',
		'DataManagerPlugin',
		'InputPlugin',
		'Loader',
		'TweenManager',
		'LightsPlugin'
	];
}
