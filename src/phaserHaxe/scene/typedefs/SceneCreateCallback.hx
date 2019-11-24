package phaserHaxe.scene.typedefs;

/**
 * Can be defined on your own Scenes. Use it to create your game objects.
 * This method is called by the Scene Manager when the scene starts, after `init()` and `preload()`.
 * If the LoaderPlugin started after `preload()`, then this method is called only after loading is complete.
 *
 * @since 1.0.0
 *
 * @param data - Any data passed via `ScenePlugin.add()` or `ScenePlugin.start()`. Same as Scene.settings.data.
**/
typedef SceneCreateCallback = (data:Any) -> Void
