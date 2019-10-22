package phaserHaxe.gameobjects.bitmaptext;

import phaserHaxe.gameobjects.bitmaptext.typedefs.DisplayCallbackConfig;
import phaserHaxe.utils.MultipleOrOne;

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
}
