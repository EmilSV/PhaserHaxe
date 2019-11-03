package phaserHaxe.cameras.scene2D.typedefs;

/**
 * @since 1.0.0
 *
 * @param camera - The camera on which the effect is running.
 * @param progress - The progress of the effect. A value between 0 and 1.
 * @param x - The Camera's new scrollX coordinate.
 * @param y - The Camera's new scrollY coordinate.
**/
typedef CameraPanCallback = (camera:Camera, progress:Float, x:Float, y:Float) -> Void;
