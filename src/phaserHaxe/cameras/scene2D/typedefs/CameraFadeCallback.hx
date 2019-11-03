package phaserHaxe.cameras.scene2D.typedefs;

/**
 * @since 1.0.0
 *
 * @param camera - The camera on which the effect is running.
 * @param progress - The progress of the effect. A value between 0 and 1.
**/
typedef CameraFadeCallback = (camera:Camera, progress:Float) -> Void;
