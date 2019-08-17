package phaserHaxe.cameras.scene2D;

enum abstract Events(String) to String
{
	/**
	 * The Destroy Camera Event.
	 *
	 * This event is dispatched by a Camera instance when it is destroyed by the Camera Manager.
	 *
	 * @event phaserHaxe.cameras.scene2D.DESTROY
	 * @since 1.0.0
	 *
	 * @param camera - The camera that was destroyed.
	**/
	var DESTROY = "cameradestroy";

	/**
	 * The Camera Fade In Complete Event.
	 *
	 * This event is dispatched by a Camera instance when the Fade In Effect completes.
	 *
	 * Listen to it from a Camera instance using `Camera.on('camerafadeincomplete', listener)`.
	 *
	 * @event phaserHaxe.cameras.scene2D.FADE_IN_COMPLETE
	 * @since 1.0.0
	 *
	 * @param camera - The camera that the effect began on.
	 * @param effect - A reference to the effect instance.
	**/
	var FADE_IN_COMPLETE = "camerafadeincomplete";

	/**
	 * The Camera Fade In Start Event.
	 *
	 * This event is dispatched by a Camera instance when the Fade In Effect starts.
	 *
	 * Listen to it from a Camera instance using `Camera.on('camerafadeinstart', listener)`.
	 *
	 * @event phaserHaxe.cameras.scene2D.ADE_IN_START
	 * @since 1.0.0
	 *
	 * @param camera - The camera that the effect began on.
	 * @param effect - A reference to the effect instance.
	 * @param duration - The duration of the effect.
	 * @param red - The red color channel value.
	 * @param green - The green color channel value.
	 * @param blue - The blue color channel value.
	 */
	var FADE_IN_START = "camerafadeinstart";

	/**
	 * The Camera Fade Out Complete Event.
	 *
	 * This event is dispatched by a Camera instance when the Fade Out Effect completes.
	 *
	 * Listen to it from a Camera instance using `Camera.on('camerafadeoutcomplete', listener)`.
	 *
	 * @event phaserHaxe.cameras.scene2D.FADE_OUT_COMPLETE
	 * @since 1.0.0
	 *
	 * @param camera - The camera that the effect began on.
	 * @param effect - A reference to the effect instance.
	 */
	var FADE_OUT_COMPLETE = "camerafadeoutcomplete";

	/**
	 * The Camera Fade Out Start Event.
	 *
	 * This event is dispatched by a Camera instance when the Fade Out Effect starts.
	 *
	 * Listen to it from a Camera instance using `Camera.on('camerafadeoutstart', listener)`.
	 *
	 * @event phaserHaxe.cameras.scene2D.FADE_OUT_START
	 * @since 1.0.0
	 *
	 * @param camera - The camera that the effect began on.
	 * @param effect - A reference to the effect instance.
	 * @param duration - The duration of the effect.
	 * @param red - The red color channel value.
	 * @param green - The green color channel value.
	 * @param blue - The blue color channel value.
	 */
	var FADE_OUT_START = "camerafadeoutstart";

	/**
	 * The Camera Flash Complete Event.
	 *
	 * This event is dispatched by a Camera instance when the Flash Effect completes.
	 *
	 * @event phaserHaxe.cameras.scene2D.FLASH_COMPLETE
	 * @since 1.0.0
	 *
	 * @param camera - The camera that the effect began on.
	 * @param effect - A reference to the effect instance.
	**/
	var FLASH_COMPLETE = "cameraflashcomplete";

	/**
	 * The Camera Flash Start Event.
	 *
	 * This event is dispatched by a Camera instance when the Flash Effect starts.
	 *
	 * @event phaserHaxe.cameras.scene2D.FLASH_START
	 * @since 1.0.0
	 *
	 * @param camera - The camera that the effect began on.
	 * @param effect - A reference to the effect instance.
	 * @param duration - The duration of the effect.
	 * @param red - The red color channel value.
	 * @param green - The green color channel value.
	 * @param blue - The blue color channel value.
	**/
	var FLASH_START = "cameraflashstart";

	/**
	 * The Camera Pan Complete Event.
	 *
	 * This event is dispatched by a Camera instance when the Pan Effect completes.
	 *
	 * @event phaserHaxe.cameras.scene2D.PAN_COMPLETE
	 * @since 1.0.0
	 *
	 * @param camera - The camera that the effect began on.
	 * @param effect - A reference to the effect instance.
	**/
	var PAN_COMPLETE = "camerapancomplete";

	/**
	 * The Camera Pan Start Event.
	 *
	 * This event is dispatched by a Camera instance when the Pan Effect starts.
	 *
	 * @event phaserHaxe.cameras.scene2D.PAN_START
	 * @since 1.0.0
	 *
	 * @param camera - The camera that the effect began on.
	 * @param effect - A reference to the effect instance.
	 * @param duration - The duration of the effect.
	 * @param x - The destination scroll x coordinate.
	 * @param y - The destination scroll y coordinate.
	**/
	var PAN_START = "camerapanstart";

	/**
	 * The Camera Post-Render Event.
	 *
	 * This event is dispatched by a Camera instance after is has finished rendering.
	 * It is only dispatched if the Camera is rendering to a texture.
	 *
	 * Listen to it from a Camera instance using: `camera.on('postrender', listener)`.
	 *
	 * @event phaserHaxe.cameras.scene2D.POST_RENDER
	 * @since 1.0.0
	 *
	 * @param camera - The camera that has finished rendering to a texture.
	**/
	var POST_RENDER = "postrender";

	/**
	 * The Camera Pre-Render Event.
	 *
	 * This event is dispatched by a Camera instance when it is about to render.
	 * It is only dispatched if the Camera is rendering to a texture.
	 *
	 * Listen to it from a Camera instance using: `camera.on('prerender', listener)`.
	 *
	 * @event phaserHaxe.cameras.scene2D.PRE_RENDER
	 * @since 1.0.0
	 *
	 * @param camera - The camera that is about to render to a texture.
	**/
	var PRE_RENDER = "prerender";

	/**
	 * The Camera Shake Complete Event.
	 *
	 * This event is dispatched by a Camera instance when the Shake Effect completes.
	 *
	 * @event phaserHaxe.cameras.scene2D.SHAKE_COMPLETE
	 * @since 1.0.0
	 *
	 * @param camera - The camera that the effect began on.
	 * @param effect - A reference to the effect instance.
	**/
	var SHAKE_COMPLETE = "camerashakecomplete";

	/**
	 * The Camera Shake Start Event.
	 *
	 * This event is dispatched by a Camera instance when the Shake Effect starts.
	 *
	 * @event phaserHaxe.cameras.scene2D.SHAKE_START
	 * @since 1.0.0
	 *
	 * @param camera - The camera that the effect began on.
	 * @param effect - A reference to the effect instance.
	 * @param duration - The duration of the effect.
	 * @param intensity - The intensity of the effect.
	**/
	var SHAKE_START = "camerashakestart";

	/**
	 * The Camera Zoom Complete Event.
	 *
	 * This event is dispatched by a Camera instance when the Zoom Effect completes.
	 *
	 * @event phaserHaxe.cameras.scene2D.ZOOM_COMPLETE
	 * @since 1.0.0
	 *
	 * @param camera - The camera that the effect began on.
	 * @param effect - A reference to the effect instance.
	 */
	var ZOOM_COMPLETE = "camerazoomcomplete";

	/**
	 * The Camera Zoom Start Event.
	 *
	 * This event is dispatched by a Camera instance when the Zoom Effect starts.
	 *
	 * @event phaserHaxe.cameras.scene2D.ZOOM_START
	 * @since 1.0.0
	 *
	 * @param camera - The camera that the effect began on.
	 * @param effect - A reference to the effect instance.
	 * @param duration - The duration of the effect.
	 * @param zoom - The destination zoom value.
	**/
	var ZOOM_START = "camerazoomstart";
}
