package phaserHaxe.display.mask;

import phaserHaxe.cameras.scene2D.Camera;
import phaserHaxe.renderer.canvas.CanvasRenderer;
import phaserHaxe.renderer.webgl.WebGLRenderer;
import phaserHaxe.gameobjects.GameObject;
#if js
import js.html.webgl.Framebuffer as WebGLFramebuffer;
import js.html.webgl.Texture as WebGLTexture;
#end

#if js
/**
 * A Bitmap Mask combines the alpha (opacity) of a masked pixel with the alpha of another pixel.
 * Unlike the Geometry Mask, which is a clipping path, a Bitmap Mask behaves like an alpha mask,
 * not a clipping path. It is only available when using the WebGL Renderer.
 *
 * A Bitmap Mask can use any Game Object to determine the alpha of each pixel of the masked Game Object(s).
 * For any given point of a masked Game Object's texture, the pixel's alpha will be multiplied by the alpha
 * of the pixel at the same position in the Bitmap Mask's Game Object. The color of the pixel from the
 * Bitmap Mask doesn't matter.
 *
 * For example, if a pure blue pixel with an alpha of 0.95 is masked with a pure red pixel with an
 * alpha of 0.5, the resulting pixel will be pure blue with an alpha of 0.475. Naturally, this means
 * that a pixel in the mask with an alpha of 0 will hide the corresponding pixel in all masked Game Objects
 *  A pixel with an alpha of 1 in the masked Game Object will receive the same alpha as the
 * corresponding pixel in the mask.
 *
 * The Bitmap Mask's location matches the location of its Game Object, not the location of the
 * masked objects. Moving or transforming the underlying Game Object will change the mask
 * (and affect the visibility of any masked objects), whereas moving or transforming a masked object
 * will not affect the mask.
 *
 * The Bitmap Mask will not render its Game Object by itself. If the Game Object is not in a
 * Scene's display list, it will only be used for the mask and its full texture will not be directly
 * visible. Adding the underlying Game Object to a Scene will not cause any problems - it will
 * render as a normal Game Object and will also serve as a mask.
 *
 * @since 1.0.0
**/
class BitmapMask extends Mask
{
	/**
	 * A reference to either the Canvas or WebGL Renderer that this Mask is using.
	 *
	 * @since 1.0.0
	**/
	public var renderer:Either<CanvasRenderer, WebGLRenderer>;

	/**
	 * A renderable Game Object that uses a texture, such as a Sprite.
	 *
	 * @since 1.0.0
	**/
	public var bitmapMask:GameObject;

	/**
	 * The texture used for the mask's framebuffer.
	 *
	 * @since 1.0.0
	**/
	public var maskText:WebGLTexture = null;

	/**
	 * The texture used for the main framebuffer.
	 *
	 * @since 1.0.0
	**/
	public var mainTexture:WebGLTexture = null;

	/**
	 * Whether the Bitmap Mask is dirty and needs to be updated.
	 *
	 * @since 1.0.0
	**/
	public var dirty:Bool = true;

	/**
	 * The framebuffer to which a masked Game Object is rendered.
	 *
	 * @since 1.0.0
	**/
	public var mainFramebuffer:WebGLFramebuffer;

	/**
	 * The framebuffer to which the Bitmap Mask's masking Game Object is rendered.
	 *
	 * @since 1.0.0
	**/
	public var maskFramebuffer:WebGLFramebuffer;

	/**
	 * The previous framebuffer set in the renderer before this one was enabled.
	 *
	 * @since 1.0.0
	**/
	public var prevFramebuffer:WebGLFramebuffer;

	/**
	 * Whether to invert the masks alpha.
	 *
	 * If `true`, the alpha of the masking pixel will be inverted before it's multiplied with the masked pixel. Essentially, this means that a masked area will be visible only if the corresponding area in the mask is invisible.
	 *
	 * @since 1.0.0
	**/
	public var invertAlpha:Bool = false;

	/**
	 * Is this mask a stencil mask?
	 *
	 * @since 1.0.0
	**/
	public final isStencil:Bool = false;

	public function new(scene:Scene, renderable:GameObject)
	{
		super();
		throw "Not Implemented";
	}

	public function setBitmap(renderable:GameObject)
	{
		throw "Not Implemented";
	}

	public override function preRenderWebGL(renderer:Either<CanvasRenderer,
		WebGLRenderer>, maskedObject:GameObject,
			camera:Camera)
	{
		throw "Not Implemented";
	}

	public override function postRenderWebGL(renderer:Either<CanvasRenderer,
		WebGLRenderer>, camera:Camera)
	{
		throw "Not Implemented";
	}

	public override function preRenderCanvas(renderer:Either<CanvasRenderer,
		WebGLRenderer>, maskedObject:GameObject,
			camera:Camera)
	{
		throw "Not Implemented";
	}

	public override function postRenderCanvas(renderer:Either<CanvasRenderer,
		WebGLRenderer>)
	{
		throw "Not Implemented";
	}

	public override function destroy()
	{
		throw "Not Implemented";
	}
}
#else

/**
 * A Bitmap Mask combines the alpha (opacity) of a masked pixel with the alpha of another pixel.
 * Unlike the Geometry Mask, which is a clipping path, a Bitmap Mask behaves like an alpha mask,
 * not a clipping path. It is only available when using the WebGL Renderer.
 *
 * A Bitmap Mask can use any Game Object to determine the alpha of each pixel of the masked Game Object(s).
 * For any given point of a masked Game Object's texture, the pixel's alpha will be multiplied by the alpha
 * of the pixel at the same position in the Bitmap Mask's Game Object. The color of the pixel from the
 * Bitmap Mask doesn't matter.
 *
 * For example, if a pure blue pixel with an alpha of 0.95 is masked with a pure red pixel with an
 * alpha of 0.5, the resulting pixel will be pure blue with an alpha of 0.475. Naturally, this means
 * that a pixel in the mask with an alpha of 0 will hide the corresponding pixel in all masked Game Objects
 *  A pixel with an alpha of 1 in the masked Game Object will receive the same alpha as the
 * corresponding pixel in the mask.
 *
 * The Bitmap Mask's location matches the location of its Game Object, not the location of the
 * masked objects. Moving or transforming the underlying Game Object will change the mask
 * (and affect the visibility of any masked objects), whereas moving or transforming a masked object
 * will not affect the mask.
 *
 * The Bitmap Mask will not render its Game Object by itself. If the Game Object is not in a
 * Scene's display list, it will only be used for the mask and its full texture will not be directly
 * visible. Adding the underlying Game Object to a Scene will not cause any problems - it will
 * render as a normal Game Object and will also serve as a mask.
 *
 * @since 1.0.0
**/
class BitmapMask extends Mask
{
	/**
	 * A reference to either the Canvas or WebGL Renderer that this Mask is using.
	 *
	 * @since 1.0.0
	**/
	public var renderer:Either<CanvasRenderer, WebGLRenderer>;

	/**
	 * A renderable Game Object that uses a texture, such as a Sprite.
	 *
	 * @since 1.0.0
	**/
	public var bitmapMask:GameObject;

	/**
	 * The texture used for the mask's framebuffer.
	 *
	 * @since 1.0.0
	**/
	public var maskText:Dynamic = null;

	/**
	 * The texture used for the main framebuffer.
	 *
	 * @since 1.0.0
	**/
	public var mainTexture:Dynamic = null;

	/**
	 * Whether the Bitmap Mask is dirty and needs to be updated.
	 *
	 * @since 1.0.0
	**/
	public var dirty:Bool = true;

	/**
	 * The framebuffer to which a masked Game Object is rendered.
	 *
	 * @since 1.0.0
	**/
	public var mainFramebuffer:Dynamic;

	/**
	 * The framebuffer to which the Bitmap Mask's masking Game Object is rendered.
	 *
	 * @since 1.0.0
	**/
	public var maskFramebuffer:Dynamic;

	/**
	 * The previous framebuffer set in the renderer before this one was enabled.
	 *
	 * @since 1.0.0
	**/
	public var prevFramebuffer:Dynamic;

	/**
	 * Whether to invert the masks alpha.
	 *
	 * If `true`, the alpha of the masking pixel will be inverted before it's multiplied with the masked pixel. Essentially, this means that a masked area will be visible only if the corresponding area in the mask is invisible.
	 *
	 * @since 1.0.0
	**/
	public var invertAlpha:Bool = false;

	/**
	 * Is this mask a stencil mask?
	 *
	 * @since 1.0.0
	**/
	public final isStencil:Bool = false;

	public function new(scene:Scene, renderable:GameObject)
	{
		super();
		throw "Not Implemented";
	}

	public function setBitmap(renderable:GameObject)
	{
		throw "Not Implemented";
	}

	public override function preRenderWebGL(renderer:Either<CanvasRenderer,
		WebGLRenderer>, maskedObject:GameObject,
			camera:Camera)
	{
		throw "Not Implemented";
	}

	public override function postRenderWebGL(renderer:Either<CanvasRenderer,
		WebGLRenderer>, camera:Camera)
	{
		throw "Not Implemented";
	}

	public override function preRenderCanvas(renderer:Either<CanvasRenderer,
		WebGLRenderer>, maskedObject:GameObject,
			camera:Camera)
	{
		throw "Not Implemented";
	}

	public override function postRenderCanvas(renderer:Either<CanvasRenderer,
		WebGLRenderer>)
	{
		throw "Not Implemented";
	}

	public override function destroy()
	{
		throw "Not Implemented";
	}
}
#end
