package phaserHaxe.scene.typedefs;

/**
 * Can be defined on your own Scenes.
 * This method is called by the Scene Manager when the scene starts, before `preload()` and `create()`.
 *
 * @since 1.0.0
 *
 * @param data - Any data passed via `ScenePlugin.add()` or `ScenePlugin.start()`. Same as Scene.settings.data.
**/
typedef SceneInitCallback = (data:Any) -> Void;
