package phaserHaxe.gameobjects.bitmaptext;

import phaserHaxe.renderer.canvas.CanvasRenderer;
import phaserHaxe.gameobjects.components.TransformMatrix;
import phaserHaxe.cameras.scene2D.Camera;
import phaserHaxe.renderer.webgl.WebGLRenderer;
import phaserHaxe.gameobjects.bitmaptext.typedefs.DisplayCallbackConfig;
import phaserHaxe.utils.MultipleOrOne;

/**
 * BitmapText objects work by taking a texture file and an XML or JSON file that describes the font structure.
 *
 * During rendering for each letter of the text is rendered to the display, proportionally spaced out and aligned to
 * match the font structure.
 *
 * Dynamic Bitmap Text objects are different from Static Bitmap Text in that they invoke a callback for each
 * letter being rendered during the render pass. This callback allows you to manipulate the properties of
 * each letter being rendered, such as its position, scale or tint, allowing you to create interesting effects
 * like jiggling text, which can't be done with Static text. This means that Dynamic Text takes more processing
 * time, so only use them if you require the callback ability they have.
 *
 * BitmapText objects are less flexible than Text objects, in that they have less features such as shadows, fills and the ability
 * to use Web Fonts, however you trade this flexibility for rendering speed. You can also create visually compelling BitmapTexts by
 * processing the font texture in an image editor, applying fills and any other effects required.
 *
 * To create multi-line text insert \r, \n or \r\n escape codes into the text string.
 *
 * To create a BitmapText data files you need a 3rd party app such as:
 *
 * BMFont (Windows, free): http://www.angelcode.com/products/bmfont/
 * Glyph Designer (OS X, commercial): http://www.71squared.com/en/glyphdesigner
 * Littera (Web-based, free): http://kvazars.com/littera/
 *
 * For most use cases it is recommended to use XML. If you wish to use JSON, the formatting should be equal to the result of
 * converting a valid XML file through the popular X2JS library. An online tool for conversion can be found here: http://codebeautify.org/xmltojson
 *
 * @since 1.0.0
**/
class DynamicBitmapText extends BitmapText
{
	/**
	 * The horizontal scroll position of the Bitmap Text.
	 *
	 * @since 1.0.0
	**/
	public var scrollX:Float = 0;

	/**
	 * The vertical scroll position of the Bitmap Text.
	 *
	 * @since 1.0.0
	**/
	public var scrollY:Float = 0;

	/**
	 * The crop width of the Bitmap Text.
	 *
	 * @since 1.0.0
	**/
	public var cropWidth:Float = 0;

	/**
	 * The crop height of the Bitmap Text.
	 *
	 * @since 1.0.0
	**/
	public var cropHeight:Float = 0;

	/**
	 * A callback that alters how each character of the Bitmap Text is rendered.
	 *
	 * @since 1.0.0
	**/
	public var displayCallback:DisplayCallback;

	/**
	 * The data object that is populated during rendering, then passed to the displayCallback.
	 * You should modify this object then return it back from the callback. It's updated values
	 * will be used to render the specific glyph.
	 *
	 * Please note that if you need a reference to this object locally in your game code then you
	 * should shallow copy it, as it's updated and re-used for every glyph in the text.
	 *
	 * @since 1.0.0
	**/
	public var callbackData:DisplayCallbackConfig;

	/**
	 * @param scene - The Scene to which this Game Object belongs. It can only belong to one Scene at any given time.
	 * @param x - The x coordinate of this Game Object in world space.
	 * @param y - The y coordinate of this Game Object in world space.
	 * @param font - The key of the font to use from the Bitmap Font cache.
	 * @param text - The string, or array of strings, to be set as the content of this Bitmap Text.
	 * @param size - The font size of this Bitmap Text.
	 * @param align - The alignment of the text in a multi-line BitmapText object.
	 *
	 * @since 1.0.0
	**/
	public function new(scene:Scene, x:Float, y:Float, font:String,
			?text:MultipleOrOne<String>, ?size:Float, align:Int = 0)
	{
		super(scene, x, y, font, text, size, align);

		this.type = 'DynamicBitmapText';

		this.callbackData = {
			parent: this,
			color: 0,
			tint: {
				topLeft: 0,
				topRight: 0,
				bottomLeft: 0,
				bottomRight: 0
			},
			index: 0,
			charCode: 0,
			x: 0,
			y: 0,
			scale: 0,
			rotation: 0,
			data: 0
		};
	}

	private override function renderWebGL(renderer:WebGLRenderer, src:GameObject,
			interpolationPercentage:Float, camera:Camera, parentMatrix:TransformMatrix)
	{
		DynamicBitmapTextRender.dynamicBitmapTextWebGLRenderer(renderer, cast src, interpolationPercentage, camera, parentMatrix);
	}

	private override function renderCanvas(renderer:CanvasRenderer, src:GameObject,
			interpolationPercentage:Float, camera:Camera,
			parentMatrix:TransformMatrix):Void
	{
		DynamicBitmapTextRender.dynamicBitmapTextCanvasRenderer(renderer, cast src, interpolationPercentage, camera, parentMatrix);
	}

	/**
	 * Set the crop size of this Bitmap Text.
	 *
	 * @since 1.0.0
	 *
	 * @param width - The width of the crop.
	 * @param height - The height of the crop.
	 *
	 * @return This Game Object.
	**/
	public function setSize(width:Float, height:Float):DynamicBitmapText
	{
		cropWidth = width;
		cropHeight = height;

		return this;
	}

	/**
	 * Set a callback that alters how each character of the Bitmap Text is rendered.
	 *
	 * The callback receives a {@link Phaser.Types.GameObjects.BitmapText.DisplayCallbackConfig} object that contains information about the character that's
	 * about to be rendered.
	 *
	 * It should return an object with `x`, `y`, `scale` and `rotation` properties that will be used instead of the
	 * usual values when rendering.
	 *
	 * @since 1.0.0
	 *
	 * @param callback - The display callback to set.
	 *
	 * @return This Game Object.
	**/
	public function setDisplayCallback(callback:DisplayCallback):DynamicBitmapText
	{
		displayCallback = callback;
		return this;
	}

	/**
	 * Set the horizontal scroll position of this Bitmap Text.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The horizontal scroll position to set.
	 *
	 * @return This Game Object.
	**/
	public function setScrollX(value:Float):DynamicBitmapText
	{
		scrollX = value;
		return this;
	}

	/**
	 * Set the vertical scroll position of this Bitmap Text.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The vertical scroll position to set.
	 *
	 * @return This Game Object.
	**/
	public function setScrollY(value:Float):DynamicBitmapText
	{
		scrollY = value;
		return this;
	}
}
