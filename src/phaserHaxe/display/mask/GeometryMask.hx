package phaserHaxe.display.mask;

import phaserHaxe.renderer.canvas.CanvasRenderer;
import phaserHaxe.gameobjects.GameObject;
import phaserHaxe.cameras.scene2D.Camera;
import phaserHaxe.renderer.webgl.WebGLRenderer;
import phaserHaxe.gameobjects.Graphics;

/**
 * A Geometry Mask can be applied to a Game Object to hide any pixels of it which don't intersect
 * a visible pixel from the geometry mask. The mask is essentially a clipping path which can only
 * make a masked pixel fully visible or fully invisible without changing its alpha (opacity).
 *
 * A Geometry Mask uses a Graphics Game Object to determine which pixels of the masked Game Object(s)
 * should be clipped. For any given point of a masked Game Object's texture, the pixel will only be displayed
 * if the Graphics Game Object of the Geometry Mask has a visible pixel at the same position. The color and
 * alpha of the pixel from the Geometry Mask do not matter.
 *
 * The Geometry Mask's location matches the location of its Graphics object, not the location of the masked objects.
 * Moving or transforming the underlying Graphics object will change the mask (and affect the visibility
 * of any masked objects), whereas moving or transforming a masked object will not affect the mask.
 * You can think of the Geometry Mask (or rather, of its Graphics object) as an invisible curtain placed
 * in front of all masked objects which has its own visual properties and, naturally, respects the camera's
 * visual properties, but isn't affected by and doesn't follow the masked objects by itself.
 *
 * @since 1.0.0
**/
class GeometryMask extends Mask
{
	/**
	 * The Graphics object which describes the Geometry Mask.
	 *
	 * @since 1.0.0
	**/
	public var geometryMask:Graphics;

	/**
	 * Similar to the BitmapMasks invertAlpha setting this to true will then hide all pixels
	 * drawn to the Geometry Mask.
	 *
	 * @since 1.0.0
	**/
	public var invertAlpha:Bool = false;

	/**
	 * Is this mask a stencil mask?
	 *
	 * @since 1.0.0
	**/
	public final isStencil:Bool = true;

	/**
	 * The current stencil level.
	 *
	 * @since 1.0.0
	**/
	private var level:Int = 0;

	/**
	 * @since 1.0.0
	 *
	 * @param scene - This parameter is not used.
	 * @param graphicsGeometry - The Graphics Game Object to use for the Geometry Mask. Doesn't have to be in the Display List.
	**/
	public function new(scene:Scene, graphicsGeometry:Graphics)
	{
		super();
		throw "Not Implemented";
	}

	/**
	 * Sets a new Graphics object for the Geometry Mask.
	 *
	 * @since 1.0.0
	 *
	 * @param graphicsGeometry - The Graphics object which will be used for the Geometry Mask.
	 *
	 * @return This Geometry Mask
	**/
	public function setShape(graphicsGeometry:Graphics):GeometryMask
	{
		throw "Not Implemented";
	}

	/**
	 * Sets the `invertAlpha` property of this Geometry Mask.
	 * Inverting the alpha essentially flips the way the mask works.
	 *
	 * @since 1.0.0
	 *
	 * @param value - Invert the alpha of this mask?
	 *
	 * @return This Geometry Mask
	**/
	public function setInvertAlpha(value:Bool = true):GeometryMask
	{
		throw "Not Implemented";
	}

	/**
	 * Renders the Geometry Mask's underlying Graphics object to the OpenGL stencil buffer and enables the stencil test, which clips rendered pixels according to the mask.
	 *
	 * @since 1.0.0
	 *
	 * @param renderer - The WebGL Renderer instance to draw to.
	 * @param child - The Game Object being rendered.
	 * @param camera - The camera the Game Object is being rendered through.
	**/
	public override function preRenderWebGL(renderer:WebGLRenderer, child:GameObject,
			camera:Camera)
	{
		throw "Not Implemented";
	}

	/**
	 * Renders the Geometry Mask's underlying Graphics object to the OpenGL stencil buffer and enables the stencil test, which clips rendered pixels according to the mask.
	 *
	 * @since 1.0.0
	 *
	 * @param renderer - The WebGL Renderer instance to draw to.
	 * @param camera - The camera the Game Object is being rendered through.
	 * @param inc - Is this an INCR stencil or a DECR stencil?
	**/
	public function applyStencil(renderer:WebGLRenderer, camera:Camera, inc:Bool)
	{
		throw "Not Implemented";
	}

	/**
	 * Sets the clipping path of a 2D canvas context to the Geometry Mask's underlying Graphics object.
	 *
	 * @since 1.0.0
	 *
	 * @param renderer - The Canvas Renderer instance to set the clipping path on.
	 * @param mask - The Game Object being rendered.
	 * @param camera - The camera the Game Object is being rendered through.
	**/
	public override function preRenderCanvas(renderer:CanvasRenderer, mask:GameObject,
			camera:Camera)
	{
		throw "Not Implemented";
	}

	/**
	 * Restore the canvas context's previous clipping path, thus turning off the mask for it.
	 *
	 * @since 1.0.0
	 *
	 * @param renderer - The Canvas Renderer instance being restored.
	 */
	public override function postRenderCanvas(renderer:CanvasRenderer)
	{
		renderer.currentContext.restore();
	}

	/**
	 * Destroys this GeometryMask and nulls any references it holds.
	 *
	 * Note that if a Game Object is currently using this mask it will _not_ automatically detect you have destroyed it,
	 * so be sure to call `clearMask` on any Game Object using it, before destroying it.
	 *
	 * @since 1.0.0
	**/
	public override function destroy()
	{
		this.geometryMask = null;
	}
}
