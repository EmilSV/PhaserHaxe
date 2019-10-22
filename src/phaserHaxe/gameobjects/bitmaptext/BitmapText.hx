package phaserHaxe.gameobjects.bitmaptext;

import phaserHaxe.cameras.scene2D.Camera;
import phaserHaxe.renderer.canvas.CanvasRenderer;
import phaserHaxe.renderer.webgl.WebGLRenderer;
import phaserHaxe.gameobjects.bitmaptext.typedefs.BitmapFontCharacterData;
import phaserHaxe.textures.Frame;
import phaserHaxe.gameobjects.bitmaptext.typedefs.JSONBitmapText;
import phaserHaxe.math.MathConst;
import phaserHaxe.utils.MultipleOrOne;
import phaserHaxe.gameobjects.components.*;
import phaserHaxe.gameobjects.bitmaptext.typedefs.BitmapFontData;
import phaserHaxe.gameobjects.bitmaptext.typedefs.BitmapTextSize;

@:build(phaserHaxe.macro.Mixin.auto())
class BitmapText extends GameObject implements IAlpha implements IBlendMode
		implements IDepth implements IMask implements IOrigin implements IPipeline
		implements IScrollFactor implements ITexture implements ITint
		implements ITransform implements IVisible implements ICustomRenderer
{
	public var font:String;

	public var fontData:BitmapFontData;

	private var _text:String = "";

	private var _fontSize:Float;

	private var _letterSpacing:Float = 0;

	@:allow(phaserHaxe.gameobjects.bitmaptext)
	private var _align:Alignment;

	@:allow(phaserHaxe.gameobjects.bitmaptext)
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
	 * The text that this Bitmap Text object displays.
	 *
	 * You can also use the method `setText` if you want a chainable way to change the text content.
	 *
	 * @since 1.0.0
	**/
	public var text(get, set):String;

	/**
	 * The font size of this Bitmap Text.
	 *
	 * You can also use the method `setFontSize` if you want a chainable way to change the font size.
	 *
	 * @since 1.0.0
	**/
	public var fontSize(get, set):Float;

	/**
	 * Adds / Removes spacing between characters.
	 *
	 * Can be a negative or positive number.
	 *
	 * You can also use the method `setLetterSpacing` if you want a chainable way to change the letter spacing.
	 *
	 * @since 1.0.0
	**/
	public var letterSpacing(get, set):Float;

	/**
	 * The width of this Bitmap Text.
	 *
	 * @since 1.0.0
	**/
	public var width(get, never):Float;

	/**
	 * The height of this bitmap text.
	 *
	 * @since 1.0.0
	**/
	public var height(get, never):Float;

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

	private inline function set_letterSpacing(value:Float):Float
	{
		_dirty = true;
		return _letterSpacing = value;
	}

	private inline function get_letterSpacing():Float
	{
		return _letterSpacing;
	}

	private inline function get_width():Float
	{
		getTextBounds(false);
		return _bounds.global.width;
	}

	private inline function get_height():Float
	{
		getTextBounds(false);
		return _bounds.global.width;
	}

	private function renderWebGL(renderer:WebGLRenderer, src:GameObject,
			interpolationPercentage:Float, camera:Camera,
			parentMatrix:TransformMatrix):Void
	{
		BitmapTextRender.bitmapTextWebGLRenderer(this, renderer, cast src, interpolationPercentage, camera, parentMatrix);
	}

	private function renderCanvas(renderer:CanvasRenderer, src:GameObject,
			interpolationPercentage:Float, camera:Camera,
			parentMatrix:TransformMatrix):Void
	{
		BitmapTextRender.bitmapTextCanvasRenderer(renderer, cast src, interpolationPercentage, camera, parentMatrix);
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
			value = value.getArray().join('\n');
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

	/**
	 * Calculate the bounds of this Bitmap Text.
	 *
	 * An object is returned that contains the position, width and height of the Bitmap Text in local and global
	 * contexts.
	 *
	 * Local size is based on just the font size and a [0, 0] position.
	 *
	 * Global size takes into account the Game Object's scale, world position and display origin.
	 *
	 * Also in the object is data regarding the length of each line, should this be a multi-line BitmapText.
	 *
	 * @since 1.0.0
	 *
	 * @param round - Whether to round the results to the nearest integer.
	 *
	 * @return Phaser. An object that describes the size of this Bitmap Text.
	**/
	public function getTextBounds(round:Bool = false):BitmapTextSize
	{
		//  local = The BitmapText based on fontSize and 0x0 coords
		//  global = The BitmapText, taking into account scale and world position
		//  lines = The BitmapText line data

		if (_dirty)
		{
			getBitmapTextSize(this, round, _bounds);
		}

		return _bounds;
	}

	/**
	 * Changes the font this BitmapText is using to render.
	 *
	 * The new texture is loaded and applied to the BitmapText. The existing test, size and alignment are preserved,
	 * unless overridden via the arguments.
	 *
	 * @since 1.0.0
	 *
	 * @param key - The key of the font to use from the Bitmap Font cache.
	 * @param size - The font size of this Bitmap Text. If not specified the current size will be used.
	 * @param align - The alignment of the text in a multi-line BitmapText object. If not specified the current alignment will be used.
	 *
	 * @return This BitmapText Object.
	**/
	public function setFont(key:String, ?size:Float, align:Alignment = LEFT):BitmapText
	{
		final size:Float = size == null ? _fontSize : size;

		if (key != font)
		{
			var entry = scene.sys.cache.bitmapFont.get(key);

			if (entry != null)
			{
				font = key;
				fontData = entry.data;
				_fontSize = size;
				_align = align;

				setTexture(entry.texture, entry.frame);

				getBitmapTextSize(this, false, this._bounds);
			}
		}

		return this;
	}

	/**
	 * Build a JSON representation of this Bitmap Text.
	 *
	 * @since 1.0.0
	 *
	 * @return A JSON representation of this Bitmap Text.
	**/
	public override function toJSON():JSONBitmapText
	{
		var out = Components.toJSON(this);

		//  Extra data is added here

		var data = {
			font: this.font,
			text: this.text,
			fontSize: this.fontSize,
			letterSpacing: this.letterSpacing,
			align: this.align
		};

		out.data = data;

		return out;
	}

	/**
		* Calculate the position, width and height of a BitmapText Game Object.
		*
		* Returns a BitmapTextSize object that contains global and local variants of the Game Objects x and y coordinates and
		* its width and height.
		*
		* The global position and size take into account the Game Object's position and scale.
		*
		* The local position and size just takes into account the font data.
		*
		b* @since 1.0.0
		*
		* @param src - The BitmapText to calculate the position, width and height of.
		* @param round - Whether to round the results to the nearest integer.
		* @param out - Optional object to store the results in, to save constant object creation.
		*
		* @return The calculated position, width and height of the BitmapText.
	**/
	private static function getBitmapTextSize(src:BitmapText, round:Bool = false,
			?out:BitmapTextSize):BitmapTextSize
	{
		if (out == null)
		{
			out = {
				local: {
					x: 0,
					y: 0,
					width: 0,
					height: 0
				},
				global: {
					x: 0,
					y: 0,
					width: 0,
					height: 0
				},
				lines: {
					shortest: 0,
					longest: 0,
					lengths: null
				}
			};
		}

		var text = src.text;
		var textLength = text.length;

		var bx = MathConst.FLOAT_MAX;
		var by = MathConst.FLOAT_MAX;
		var bw:Float = 0;
		var bh:Float = 0;

		var chars = src.fontData.chars;
		var lineHeight = src.fontData.lineHeight;
		var letterSpacing = src.letterSpacing;

		var xAdvance:Float = 0;
		var yAdvance:Float = 0;

		var charCode = 0;

		var glyph = null;

		var x:Float = 0;
		var y:Float = 0;

		var scale = (src.fontSize / src.fontData.size);
		var sx = scale * src.scaleX;
		var sy = scale * src.scaleY;

		var lastGlyph = null;
		var lastCharCode = 0;
		var lineWidths = [];
		var shortestLine = MathConst.FLOAT_MAX;
		var longestLine:Float = 0;
		var currentLine = 0;
		var currentLineWidth:Float = 0;

		for (i in 0...textLength)
		{
			charCode = text.charCodeAt(i);

			if (charCode == 10)
			{
				xAdvance = 0;
				yAdvance += lineHeight;
				lastGlyph = null;

				lineWidths[currentLine] = currentLineWidth;

				if (currentLineWidth > longestLine)
				{
					longestLine = currentLineWidth;
				}

				if (currentLineWidth < shortestLine)
				{
					shortestLine = currentLineWidth;
				}

				currentLine++;
				currentLineWidth = 0;
				continue;
			}

			glyph = chars[charCode];

			if (glyph == null)
			{
				continue;
			}

			x = xAdvance;
			y = yAdvance;

			if (lastGlyph != null)
			{
				var kerningOffset = glyph.kerning[lastCharCode];
				x += (kerningOffset != null) ? kerningOffset : 0;
			}

			if (bx > x)
			{
				bx = x;
			}

			if (by > y)
			{
				by = y;
			}

			var gw = x + glyph.xAdvance;
			var gh = y + lineHeight;

			if (bw < gw)
			{
				bw = gw;
			}

			if (bh < gh)
			{
				bh = gh;
			}

			xAdvance += glyph.xAdvance + letterSpacing;
			lastGlyph = glyph;
			lastCharCode = charCode;
			currentLineWidth = gw * scale;
		}

		lineWidths[currentLine] = currentLineWidth;

		if (currentLineWidth > longestLine)
		{
			longestLine = currentLineWidth;
		}

		if (currentLineWidth < shortestLine)
		{
			shortestLine = currentLineWidth;
		}

		var local = out.local;
		var global = out.global;
		var lines = out.lines;

		local.x = bx * scale;
		local.y = by * scale;
		local.width = bw * scale;
		local.height = bh * scale;

		global.x = (src.x - src.displayOriginX) + (bx * sx);
		global.y = (src.y - src.displayOriginY) + (by * sy);
		global.width = bw * sx;
		global.height = bh * sy;

		lines.shortest = shortestLine;
		lines.longest = longestLine;
		lines.lengths = lineWidths;

		if (round)
		{
			local.x = Math.round(local.x);
			local.y = Math.round(local.y);
			local.width = Math.round(local.width);
			local.height = Math.round(local.height);

			global.x = Math.round(global.x);
			global.y = Math.round(global.y);
			global.width = Math.round(global.width);
			global.height = Math.round(global.height);

			lines.shortest = Math.round(shortestLine);
			lines.longest = Math.round(longestLine);
		}

		return out;
	}

	/**
	 * Parse an XML Bitmap Font from an Atlas.
	 *
	 * Adds the parsed Bitmap Font data to the cache with the `fontName` key.
	 *
	 * @since 1.0.0
	 *
	 * @param scene - The Scene to parse the Bitmap Font for.
	 * @param fontName - The key of the font to add to the Bitmap Font cache.
	 * @param textureKey - The key of the BitmapFont's texture.
	 * @param frameKey - The key of the BitmapFont texture's frame.
	 * @param xmlKey - The key of the XML data of the font to parse.
	 * @param xSpacing - The x-axis spacing to add between each letter.
	 * @param ySpacing - The y-axis spacing to add to the line height.
	 *
	 * @return Whether the parsing was successful or not.
	 */
	public function parseFromAtlas(scene:Scene, fontName:String, textureKey:String,
			frameKey:String, xmlKey:String, xSpacing:Int = 0, ySpacing:Int = 0):Bool
	{
		var frame:Frame = scene.sys.textures.getFrame(textureKey, frameKey);
		var xml:Xml = scene.sys.cache.xml.get(xmlKey);

		if (frame != null && xml != null)
		{
			var data = parseXMLBitmapFont(xml, xSpacing, ySpacing, frame);

			scene.sys.cache.bitmapFont.add(fontName, {
				data: data,
				texture: textureKey,
				frame: frameKey
			});

			return true;
		}
		else
		{
			return false;
		}
	}

	/**
	 * Parse an XML font to Bitmap Font data for the Bitmap Font cache.
	 *
	 * @since 1.0.0
	 *
	 * @param xml - The XML Document to parse the font from.
	 * @param xSpacing - The x-axis spacing to add between each letter.
	 * @param ySpacing - The y-axis spacing to add to the line height.
	 * @param frame - The texture frame to take into account while parsing.
	 *
	 * @return The parsed Bitmap Font data.
	**/
	public static function parseXMLBitmapFont(xml:Xml, xSpacing:Int = 0,
			ySpacing:Int = 0, ?frame:Frame):BitmapFontData
	{
		inline function firstElementNamed(xml:Xml, name:String):Null<Xml>
		{
			var foundChild = null;

			for (child in xml)
			{
				if (child.nodeType == Element && child.nodeName == name)
				{
					foundChild = child;
					break;
				}
			}

			return foundChild;
		}

		inline function getValue(node:Xml, attribute:String):Int
		{
			return Std.parseInt(node.get(attribute));
		}

		var info = firstElementNamed(xml, "info");
		var common = firstElementNamed(xml, "common");

		var data:BitmapFontData = {
			font: info.get("face"),
			size: getValue(info, "size"),
			lineHeight: getValue(common, "lineHeight") + ySpacing,
			chars: new Map()
		};

		var adjustForTrim = (frame != null && frame.trimmed);

		var top;
		var left;

		if (adjustForTrim)
		{
			top = frame.height;
			left = frame.width;
		}
		else
		{
			top = 0;
			left = 0;
		}

		for (node in xml)
		{
			if (node.nodeType != Element && node.nodeName != "char")
			{
				continue;
			}

			var charCode = getValue(node, 'id');
			var gx = getValue(node, 'x');
			var gy = getValue(node, 'y');
			var gw = getValue(node, 'width');
			var gh = getValue(node, 'height');

			//  Handle frame trim issues

			if (adjustForTrim)
			{
				if (gx < left)
				{
					left = gx;
				}

				if (gy < top)
				{
					top = gy;
				}
			}

			data.chars[charCode] = ({
				x: gx,
				y: gy,
				width: gw,
				height: gh,
				centerX: Math.floor(gw / 2),
				centerY: Math.floor(gh / 2),
				xOffset: getValue(node, "xoffset"),
				yOffset: getValue(node, "yoffset"),
				xAdvance: getValue(node, "xadvance") + xSpacing,
				data: {},
				kerning: new Map()
			} : BitmapFontCharacterData);
		}

		if (adjustForTrim && top != 0 && left != 0)
		{
			//  Now we know the top and left coordinates of the glyphs in the original data
			//  so we can work out how much to adjust the glyphs by

			for (glyph in data.chars)
			{
				glyph.x -= frame.x;
				glyph.y -= frame.y;
			}
		}

		for (kern in xml)
		{
			if (kern.nodeType != Element && kern.nodeName != "kerning")
			{
				continue;
			}

			var first = getValue(kern, "first");
			var second = getValue(kern, "second");
			var amount = getValue(kern, "amount");

			data.chars[second].kerning[first] = amount;
		}

		return data;
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
