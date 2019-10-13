package phaserHaxe.gameobjects.bitmaptext;

import phaserHaxe.utils.MultipleOrOne;
import phaserHaxe.gameobjects.components.*;
import phaserHaxe.gameobjects.bitmaptext.typedefs.BitmapFontData;
import phaserHaxe.gameobjects.bitmaptext.typedefs.BitmapTextSize;

@:build(phaserHaxe.macro.Mixin.auto())
class BitmapText extends GameObject implements IAlpha implements IBlendMode
		implements IDepth implements IMask implements IOrigin implements IPipeline
		implements IScrollFactor implements ITexture implements ITint
		implements ITransform implements IVisible
{
	public var font:String;

	public var fontData:BitmapFontData;

	private var _text:String = "";

	private var _fontSize:Float;

	private var _letterSpacing:Float = 0;

	private var _align:Alignment;

	private var _bounds:BitmapTextSize;

	private var _dirty:Bool = false;

	/**
	 * Controls the alignment of each line of text in this BitmapText object.
	 *
	 * Only has any effect when this BitmapText contains multiple lines of text, split with carriage-returns.
	 * Has no effect with single-lines of text.
	 *
	 * See the methods `setLeftAlign`, `setCenterAlign` and `setRightAlign`.
	 *
	 * 0 = Left aligned (default)
	 * 1 = Middle aligned
	 * 2 = Right aligned
	 *
	 * The alignment position is based on the longest line of text.
	 *
	 * @since 1.0.0
	**/
	public var align(get, set):Alignment;

	/**
	 * @param scene - The Scene to which this Game Object belongs. It can only belong to one Scene at any given time.
	 * @param x - The x coordinate of this Game Object in world space.
	 * @param y - The y coordinate of this Game Object in world space.
	 * @param font - The key of the font to use from the Bitmap Font cache.
	 * @param text - The string, or array of strings, to be set as the content of this Bitmap Text.
	 * @param size - The font size of this Bitmap Text.
	 * @param align - The alignment of the text in a multi-line BitmapText object.
	**/
	public function new(scene:Scene, x:Float, y:Float, font:String,
			?text:MultipleOrOne<String>, ?size:Float, ?align:Alignment = 0)
	{
		super(scene, "BitmapText");

		this.font = font;

		var entry = this.scene.sys.cache.bitmapFont.get(font);

		this.fontData = entry.data;

		this._text = '';

		this._fontSize = size != null ? size : this.fontData.size;

		this._align = align;

		this._bounds = null; // GetBitmapTextSize(this, false, this._bounds);

		this._dirty = false;
	}

	private inline function set_align(value:Alignment):Alignment
	{
		_dirty = true;
		return _align = value;
	}

	private inline function get_align():Alignment
	{
		return _align;
	}

	private inline function set_text(value:String):String
	{
		setText(value);
		return value;
	}

	private inline function get_text():String
	{
		return _text;
	}

	private inline function set_fontSize(value:Float):Float
	{
		_dirty = true;
		return _fontSize = value;
	}

	private inline function get_fontSize():Float
	{
		return _fontSize;
	}

	/**
	 * Set the lines of text in this BitmapText to be left-aligned.
	 * This only has any effect if this BitmapText contains more than one line of text.
	 *
	 * @since 1.0.0
	 *
	 * @return This BitmapText Object.
	**/
	public function setLeftAlign():BitmapText
	{
		_align = LEFT;

		_dirty = true;

		return this;
	}

	/**
	 * Set the lines of text in this BitmapText to be center-aligned.
	 * This only has any effect if this BitmapText contains more than one line of text.
	 *
	 * @since 1.0.0
	 *
	 * @return This BitmapText Object.
	**/
	public function setCenterAlign():BitmapText
	{
		_align = CENTER;

		_dirty = true;

		return this;
	}

	/**
	 * Set the lines of text in this BitmapText to be right-aligned.
	 * This only has any effect if this BitmapText contains more than one line of text.
	 *
	 * @since 1.0.0
	 *
	 * @return This BitmapText Object.
	**/
	public function setRightAlign():BitmapText
	{
		_align = RIGHT;

		_dirty = true;

		return this;
	}

	/**
	 * Set the font size of this Bitmap Text.
	 *
	 * @since 1.0.0
	 *
	 * @param size - The font size to set.
	 *
	 * @return This BitmapText Object.
	**/
	public function setFontSize(size:Float):BitmapText
	{
		_fontSize = size;

		_dirty = true;

		return this;
	}

	/**
	 * Sets the letter spacing between each character of this Bitmap Text.
	 * Can be a positive value to increase the space, or negative to reduce it.
	 * Spacing is applied after the kerning values have been set.
	 *
	 * @since 1.0.0
	 *
	 * @param spacing - The amount of horizontal space to add between each character.
	 *
	 * @return This BitmapText Object.
	**/
	public function setLetterSpacing(spacing:Float = 0):BitmapText
	{
		_letterSpacing = spacing;

		_dirty = true;

		return this;
	}

	/**
	 * Set the textual content of this BitmapText.
	 *
	 * An array of strings will be converted into multi-line text. Use the align methods to change multi-line alignment.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The string, or array of strings, to be set as the content of this BitmapText.
	 *
	 * @return This BitmapText Object.
	**/
	public function setText(value:MultipleOrOne<String> = "")
	{
		if (value == null)
		{
			value = '';
		}

		if (value.isArray())
		{
			value = (value.getArray()).join('\n');
		}

		var value = value.getOne();

		if (value != _text)
		{
			_text = value.toString();

			_dirty = true;

			updateDisplayOrigin();
		}

		return this;
	}
}

enum abstract Alignment(Int) from Int to Int
{
	/**
	 * Left align the text characters in a multi-line BitmapText object.
	 *
	 * @since 1.0.0
	**/
	var LEFT = 0;

	/**
	 * Center align the text characters in a multi-line BitmapText object.
	 *
	 * @since 1.0.0
	**/
	var CENTER = 1;

	/**
	 * Right align the text characters in a multi-line BitmapText object.
	 *
	 * @since 1.0.0
	**/
	var RIGHT = 1;
}
