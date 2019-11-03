package phaserHaxe.cameras.scene2D;

import phaserHaxe.scene.Systems;

class CameraManager
{
	/**
	 * The Scene that owns the Camera Manager plugin.
	 *
	 * @since 1.0.0
	**/
	public var scene:Scene;

	/**
	 * A reference to the Scene.Systems handler for the Scene that owns the Camera Manager.
	 *
	 * @since 1.0.0
	**/
	public var systems:Systems;

	/**
	 * All Cameras created by, or added to, this Camera Manager, will have their `roundPixels`
	 * property set to match this value. By default it is set to match the value set in the
	 * game configuration, but can be changed at any point. Equally, individual cameras can
	 * also be changed as needed.
	 *
	 * @since 1.0.0
	**/
	public var roundPixels:Bool;

	/**
	 * An Array of the Camera objects being managed by this Camera Manager.
	 * The Cameras are updated and rendered in the same order in which they appear in this array.
	 * Do not directly add or remove entries to this array. However, you can move the contents
	 * around the array should you wish to adjust the display order.
	 *
	 * @since 1.0.0
	**/
	public var cameras:Array<Camera> = [];

	/**
	 * A handy reference to the 'main' camera. By default this is the first Camera the
	 * Camera Manager creates. You can also set it directly, or use the `makeMain` argument
	 * in the `add` and `addExisting` methods. It allows you to access it from your game:
	 *
	 * ```haxe
	 * var cam = cameras.main;
	 * ```
	 *
	 * Also see the properties `camera1`, `camera2` and so on.
	 *
	 * @since 1.0.0
	**/
	public var main:Camera;

	/**
	 * A default un-transformed Camera that doesn't exist on the camera list and doesn't
	 * count towards the total number of cameras being managed. It exists for other
	 * systems, as well as your own code, should they require a basic un-transformed
	 * camera instance from which to calculate a view matrix.
	 *
	 * @since 1.0.0
	**/
	public var defaultCamera:Camera;
}
