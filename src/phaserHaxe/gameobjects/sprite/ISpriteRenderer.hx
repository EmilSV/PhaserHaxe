package phaserHaxe.gameobjects.sprite;

import phaserHaxe.renderer.webgl.WebGLRenderer;
import phaserHaxe.cameras.scene2D.Camera;
import phaserHaxe.renderer.canvas.CanvasRenderer;
import phaserHaxe.gameobjects.components.TransformMatrix;

interface ISpriteRenderer
{
	/**
	 * Renders this Game Object with the Canvas Renderer to the given Camera.
	 * The object will not render if any of its renderFlags are set or it is being actively filtered out by the Camera.
	 * This method should not be called directly. It is a utility function of the Render module.
	 *
	 * @since 1.0.0
	 * @private
	 *
	 * @param renderer - A reference to the current active Canvas renderer.
	 * @param src - The Game Object being rendered in this call.
	 * @param interpolationPercentage - Reserved for future use and custom pipelines.
	 * @param camera - The Camera that is rendering the Game Object.
	 * @param parentMatrix - This transform matrix is defined if the game object is nested
	**/
	private function renderCanvas(renderer:CanvasRenderer, src:GameObject,
		interpolationPercentage:Float, camera:Camera, parentMatrix:TransformMatrix):Void;

	/**
	 * Renders this Game Object with the WebGL Renderer to the given Camera.
	 * The object will not render if any of its renderFlags are set or it is being actively filtered out by the Camera.
	 * This method should not be called directly. It is a utility function of the Render module.
	 *
	 * @since 1.0.0
	 * @private
	 *
	 * @param renderer - A reference to the current active WebGL renderer.
	 * @param src - The Game Object being rendered in this call.
	 * @param interpolationPercentage - Reserved for future use and custom pipelines.
	 * @param camera - The Camera that is rendering the Game Object.
	 * @param parentMatrix - This transform matrix is defined if the game object is nested
	**/
	private function renderWebGL(renderer:WebGLRenderer, src:GameObject,
		interpolationPercentage:Float, camera:Camera, parentMatrix:TransformMatrix):Void;
}