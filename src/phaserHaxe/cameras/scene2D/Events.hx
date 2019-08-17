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
	 * @event Phaser.Cameras.Scene2D.Events#FADE_IN_START
	 * @since 3.3.0
	 *
	 * @param {Phaser.Cameras.Scene2D.Camera} camera - The camera that the effect began on.
	 * @param {Phaser.Cameras.Scene2D.Effects.Fade} effect - A reference to the effect instance.
	 * @param {integer} duration - The duration of the effect.
	 * @param {integer} red - The red color channel value.
	 * @param {integer} green - The green color channel value.
	 * @param {integer} blue - The blue color channel value.
	 */
	var FADE_IN_START = "camerafadeinstart";

	var FADE_OUT_COMPLETE = "";

	/**
	 * The Camera Fade Out Start Event.
	 *
	 * This event is dispatched by a Camera instance when the Fade Out Effect starts.
	 *
	 * Listen to it from a Camera instance using `Camera.on('camerafadeoutstart', listener)`.
	 *
	 * @event Phaser.Cameras.Scene2D.Events#FADE_OUT_START
	 * @since 3.3.0
	 *
	 * @param {Phaser.Cameras.Scene2D.Camera} camera - The camera that the effect began on.
	 * @param {Phaser.Cameras.Scene2D.Effects.Fade} effect - A reference to the effect instance.
	 * @param {integer} duration - The duration of the effect.
	 * @param {integer} red - The red color channel value.
	 * @param {integer} green - The green color channel value.
	 * @param {integer} blue - The blue color channel value.
	 */
	var FADE_OUT_START = "camerafadeoutstart";

	var FLASH_COMPLETE = "";
	var FLASH_START = "";
	var PAN_COMPLETE = "";
	var PAN_START = "";
	var POST_RENDER = "";
	var PRE_RENDER = "";
	var SHAKE_COMPLETE = "";
	var SHAKE_START = "";

	/**
	 * The Camera Zoom Complete Event.
	 *
	 * This event is dispatched by a Camera instance when the Zoom Effect completes.
	 *
	 * @event Phaser.Cameras.Scene2D.Events#ZOOM_COMPLETE
	 * @since 3.3.0
	 *
	 * @param {Phaser.Cameras.Scene2D.Camera} camera - The camera that the effect began on.
	 * @param {Phaser.Cameras.Scene2D.Effects.Zoom} effect - A reference to the effect instance.
	 */
	var ZOOM_COMPLETE = "camerazoomcomplete";

	/**
	 * The Camera Zoom Start Event.
	 *
	 * This event is dispatched by a Camera instance when the Zoom Effect starts.
	 *
	 * @event Phaser.Cameras.Scene2D.Events#ZOOM_START
	 * @since 3.3.0
	 *
	 * @param {Phaser.Cameras.Scene2D.Camera} camera - The camera that the effect began on.
	 * @param {Phaser.Cameras.Scene2D.Effects.Zoom} effect - A reference to the effect instance.
	 * @param {integer} duration - The duration of the effect.
	 * @param {number} zoom - The destination zoom value.
	 */
	var ZOOM_START = "camerazoomstart";
}
