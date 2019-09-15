package phaserHaxe.textures;

import phaserHaxe.math.Pow2;
import js.html.webgl.Texture as WebGLTexture;
import js.html.CanvasElement as HTMLCanvasElement;
import js.Syntax as JsSyntax;
import phaserHaxe.renderer.ScaleModes;
import js.html.ImageElement as HTMLImageElement;
import phaserHaxe.gameobjects.RenderTexture;
import phaserHaxe.renderer.Renderer;
import phaserHaxe.textures.FilterMode;

abstract DataSource(Dynamic) from WebGLTexture from HTMLCanvasElement
	from HTMLImageElement from RenderTexture {}

/**
 * A Texture Source is the encapsulation of the actual source data for a Texture.
 * This is typically an Image Element, loaded from the file system or network, or a Canvas Element.
 *
 * A Texture can contain multiple Texture Sources, which only happens when a multi-atlas is loaded.
 *
 * @since 1.0.0
 *
**/
class TextureSource
{
	/**
	 * The Texture this TextureSource belongs to.
	 *
	 * @since 1.0.0
	**/
	public var renderer:Renderer;

	/**
	 * The Texture this TextureSource belongs to.
	 *
	 * @since 1.0.0
	**/
	public var texture:Texture;

	/**
	 * The source of the image data.
	 * This is either an Image Element, a Canvas Element, a RenderTexture or a WebGLTexture.
	 *
	 * @since 1.0.0
	**/
	public var source:DataSource;

	/**
	 * The image data.
	 * This is either an Image element or a Canvas element.
	 *
	 * @since 1.0.0
	**/
	public var image:Either<HTMLImageElement, HTMLCanvasElement>;

	/**
	 * Currently un-used.
	 *
	 * @since 1.0.0
	**/
	public var compressionAlgorithm:Null<Int> = null;

	/**
	 * The resolution of the source image.
	 *
	 * @since 1.0.0
	**/
	public var resolution:Float = 1;

	/**
	 * The width of the source image. If not specified in the constructor it will check
	 * the `naturalWidth` and then `width` properties of the source image.
	 *
	 * @since 1.0.0
	**/
	public var width:Int;

	/**
	 * The height of the source image. If not specified in the constructor it will check
	 * the `naturalHeight` and then `height` properties of the source image.
	 *
	 * @since 1.0.0
	**/
	public var height:Int;

	/**
	 * The Scale Mode the image will use when rendering.
	 * Either Linear or Nearest.
	 *
	 * @since 1.0.0
	**/
	public var scaleMode:ScaleModes = DEFAULT;

	/**
	 * Is the source image a Canvas Element?
	 *
	 * @since 1.0.0
	**/
	public var isCanvas:Bool;

	/**
	 * Is the source image a Render Texture?
	 *
	 * @since 1.0.0
	**/
	public var isRenderTexture:Bool;

	/**
	 * Is the source image a WebGLTexture?
	 *
	 * @since 1.0.0
	**/
	public var isGLTexture:Bool;

	/**
	 * Are the source image dimensions a power of two?
	 *
	 * @since 1.0.0
	**/
	public var isPowerOf2:Bool;

	/**
	 * The WebGL Texture of the source image. If this TextureSource is driven from a WebGLTexture
	 * already, then this is a reference to that WebGLTexture.
	 *
	 * @since 1.0.0
	**/
	public var glTexture:WebGLTexture;

	/**
	 * @param texture - The Texture this TextureSource belongs to.
	 * @param source - The source image data.
	 * @param width - Optional width of the source image. If not given it's derived from the source itself.
	 * @param height - Optional height of the source image. If not given it's derived from the source itself.
	**/
	public function new(texture:Texture, source:DataSource, ?width:Int, ?height:Int)
	{
		var game:Game = texture.manager.game;

		this.renderer = game.renderer;

		this.texture = texture;

		this.source = source;

		this.image = cast source;

		this.compressionAlgorithm = null;

		this.resolution = 1;

		final source:Dynamic = source;

		this.width = if (width != null)
		{
			width;
		}
		else if (source.naturalWidth != null)
		{
			source.naturalWidth;
		}
		else if (source.width != null)
		{
			source.width;
		}
		else
		{
			0;
		}

		this.height = if (height != null)
		{
			height;
		}
		else if (source.naturalHeight != null)
		{
			source.naturalHeight;
		}
		else if (source.height != null)
		{
			source.height;
		}
		else
		{
			0;
		}

		scaleMode = DEFAULT;

		this.isCanvas = JsSyntax.instanceof(source, HTMLCanvasElement);

		this.isRenderTexture = JsSyntax.strictEq(source.type, "RenderTexture");

		this.isGLTexture = JsSyntax.instanceof(source, WebGLTexture);

		this.isPowerOf2 = Pow2.isSizePowerOfTwo(width, height);

		this.glTexture = null;

		this.init(game);
	}

	/**
	 * Creates a WebGL Texture, if required, and sets the Texture filter mode.
	 *
	 * @since 1.0.0
	 *
	 * @param game - A reference to the Phaser Game instance.
	**/
	public function init(game:Game):Void
	{
		throw "Not Implemented";
	}

	/**
	 * Sets the Filter Mode for this Texture.
	 *
	 * The mode can be either Linear, the default, or Nearest.
	 *
	 * For pixel-art you should use Nearest.
	 *
	 * @since 1.0.0
	 *
	 * @param filterMode - The Filter Mode.
	**/
	public function setFilter(filterMode:FilterMode):Void
	{
		throw "Not Implemented";
	}

	/**
	 * If this TextureSource is backed by a Canvas and is running under WebGL,
	 * it updates the WebGLTexture using the canvas data.
	 *
	 * @since 1.0.0
	**/
	public function update():Void
	{
		throw "Not Implemented";
	}

	/**
	 * Destroys this Texture Source and nulls the references.
	 *
	 * @since 1.0.0
	**/
	public function destroy()
	{
		throw "Not Implemented";
	}
}
