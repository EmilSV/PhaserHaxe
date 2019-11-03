package phaserHaxe.renderer.canvas;

import phaserHaxe.gameobjects.components.IScrollFactor;
import phaserHaxe.gameobjects.components.IAlpha;
import js.html.CanvasRenderingContext2D;
import phaserHaxe.gameobjects.GameObject;
import phaserHaxe.cameras.scene2D.Camera;
import phaserHaxe.gameobjects.components.TransformMatrix;

@:forward
abstract Utils(CanvasUtils) {}

final class CanvasUtils
{
	/**
	 * Takes a reference to the Canvas Renderer, a Canvas Rendering Context, a Game Object, a Camera and a parent matrix
	 * and then performs the following steps:
	 *
	 * 1. Checks the alpha of the source combined with the Camera alpha. If 0 or less it aborts.
	 * 2. Takes the Camera and Game Object matrix and multiplies them, combined with the parent matrix if given.
	 * 3. Sets the blend mode of the context to be that used by the Game Object.
	 * 4. Sets the alpha value of the context to be that used by the Game Object combined with the Camera.
	 * 5. Saves the context state.
	 * 6. Sets the final matrix values into the context via setTransform.
	 * 7. If Renderer.antialias, or the frame.source.scaleMode is set, then imageSmoothingEnabled is set.
	 *
	 * This function is only meant to be used internally. Most of the Canvas Renderer classes use it.
	 *
	 * @since 1.0.0
	 *
	 * @param renderer - A reference to the current active Canvas renderer.
	 * @param ctx - The canvas context to set the transform on.
	 * @param src - The Game Object being rendered. Can be any type that extends the base class.
	 * @param camera - The Camera that is rendering the Game Object.
	 * @param parentMatrix - A parent transform matrix to apply to the Game Object before rendering.
	 *
	 * @return `true` if the Game Object context was set, otherwise `false`.
	**/
	public static function setTransform(renderer:CanvasRenderer,
			ctx:CanvasRenderingContext2D, src:GameObject, camera:Camera,
			?parentMatrix:TransformMatrix):Bool
	{
		var src:Dynamic = src;

		var alpha = camera.alpha * src.alpha;

		if (alpha <= 0)
		{
			//  Nothing to see, so don't waste time calculating stuff
			return false;
		}

		var camMatrix = renderer._tempMatrix1.copyFrom(camera.matrix);
		var gameObjectMatrix = renderer._tempMatrix2.applyITRS(src.x, src.y, src.rotation, src.scaleX, src.scaleY);
		var calcMatrix = renderer._tempMatrix3;

		if (parentMatrix != null)
		{
			//  Multiply the camera by the parent matrix
			camMatrix.multiplyWithOffset(parentMatrix, -camera.scrollX * src.scrollFactorX, -camera.scrollY * src.scrollFactorY);

			//  Undo the camera scroll
			gameObjectMatrix.e = src.x;
			gameObjectMatrix.f = src.y;

			//  Multiply by the Sprite matrix, store result in calcMatrix
			camMatrix.multiply(gameObjectMatrix, calcMatrix);
		}
		else
		{
			gameObjectMatrix.e -= camera.scrollX * src.scrollFactorX;
			gameObjectMatrix.f -= camera.scrollY * src.scrollFactorY;

			//  Multiply by the Sprite matrix, store result in calcMatrix
			camMatrix.multiply(gameObjectMatrix, calcMatrix);
		}

		//  Blend Mode
		ctx.globalCompositeOperation = renderer.blendModes[src.blendMode];

		//  Alpha
		ctx.globalAlpha = alpha;

		ctx.save();

		calcMatrix.setToContext(ctx);

		ctx.imageSmoothingEnabled = !(!renderer.antialias || (src.frame != null && src.frame.source.scaleMode));

		return true;
	}
}
