package phaserHaxe.scene.typedefs;

/**
 * Can be defined on your own Scenes. Use it to load assets.
 * This method is called by the Scene Manager, after `init()` and before `create()`, only if the Scene has a LoaderPlugin.
 * After this method completes, if the LoaderPlugin's queue isn't empty, the LoaderPlugin will start automatically.
 *
 * @since 1.0.0
**/
typedef ScenePreloadCallback = () -> Void;
