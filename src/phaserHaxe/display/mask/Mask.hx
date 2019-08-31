package phaserHaxe.display.mask;

import phaserHaxe.renderer.webgl.WebGLRenderer;
import phaserHaxe.cameras.scene2D.Camera;
import phaserHaxe.renderer.canvas.CanvasRenderer;
import phaserHaxe.gameobjects.GameObject;

class Mask
{
	private function new() {}

	/**
	 * Prepares the WebGL Renderer to render a Game Object with this mask applied.
	 *
	 * This renders the masking Game Object to the mask framebuffer and switches to the main framebuffer so that the masked Game Object will be rendered to it instead of being rendered directly to the frame.
	 *
	 * @method Phaser.Display.Masks.BitmapMask#preRenderWebGL
	 * @since 1.0.0
	 *
	 * @param renderer - The WebGL Renderer to prepare.
	 * @param maskedObject - The masked Game Object which will be drawn.
	 * @param camera - The Camera to render to.
	**/
	public function preRenderWebGL(renderer:WebGLRenderer, maskedObject:GameObject,
		camera:Camera):Void {}

	/**
	 * Finalizes rendering of a masked Game Object.
	 *
	 * This resets the previously bound framebuffer and switches the WebGL Renderer to the Bitmap Mask Pipeline, which uses a special fragment shader to apply the masking effect.
	 *
	 * @since 1.0.0
	 *
	 * @param renderer - The WebGL Renderer to clean up.
	**/
	public function postRenderWebGL(renderer:WebGLRenderer, camera:Camera):Void {}

	/**
	 * This is a NOOP method. Bitmap Masks are not supported by the Canvas Renderer.
	 *
	 * @since 1.0.0
	 *
	 * @param renderer - The Canvas Renderer which would be rendered to.
	 * @param mask - The masked Game Object which would be rendered.
	 * @param camera - The Camera to render to.
	**/
	public function preRenderCanvas(renderer:CanvasRenderer, mask:GameObject,
		camera:Camera):Void {}

	/**
	 * This is a NOOP method. Bitmap Masks are not supported by the Canvas Renderer.
	 *
	 * @since 1.0.0
	 *
	 * @param renderer - The Canvas Renderer which would be rendered to.
	**/
	public function postRenderCanvas(renderer:CanvasRenderer):Void {}

	/**
	 * Destroys this BitmapMask and nulls any references it holds.
	 *
	 * Note that if a Game Object is currently using this mask it will _not_ automatically detect you have destroyed it,
	 * so be sure to call `clearMask` on any Game Object using it, before destroying it.
	 *
	 * @since 1.0.0
	**/
	public function destroy():Void {}
}
