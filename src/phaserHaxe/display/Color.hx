package phaserHaxe.display;

import phaserHaxe.Compatibility.toIntSafe as toIntSafe;
import phaserHaxe.math.MathInt;
import phaserHaxe.display.HSVColorObject;
import phaserHaxe.utils.types.Union;
import phaserHaxe.utils.Utils;
import phaserHaxe.utils.types.Union3;

/**
 * The Color class holds a single color value and allows for easy modification and reading of it.
 *
 * @since 1.0.0
**/
class Color
{
	/**
	 * The internal red color value.
	 *
	 * @since 1.0.0
	**/
	public var r(default, null):Int = 0;

	/**
	 * The internal green color value.
	 *
	 * @since 1.0.0
	**/
	public var g(default, null):Int = 0;

	/**
	 * The internal blue color value.
	 *
	 * @since 1.0.0
	**/
	public var b(default, null):Int = 0;

	/**
	 * The internal alpha color value.
	 *
	 * @since 1.0.0
	**/
	public var a(default, null):Int = 255;

	/**
	 * The hue color value. A number between 0 and 1.
	 * This is the base color.
	 *
	 * @since 1.0.0
	**/
	private var _h:Float = 0;

	/**
	 * The saturation color value. A number between 0 and 1.
	 * This controls how much of the hue will be in the final color, where 1 is fully saturated and 0 will give you white.
	 *
	 * @since 1.0.0
	**/
	private var _s:Float = 0;

	/**
	 * The lightness color value. A number between 0 and 1.
	 * This controls how dark the color is. Where 1 is as bright as possible and 0 is black.
	 *
	 * @since 1.0.0
	**/
	private var _v:Float = 0;

	/**
	 * Is this color update locked?
	 *
	 * @since 1.0.0
	**/
	private var _locked:Bool = false;

	/**
	 * An array containing the calculated color values for WebGL use.
	 *
	 * @since 1.0.0
	**/
	public var gl:Array<Float> = [0, 0, 0, 1];

	/**
	 * Pre-calculated internal color value.
	 *
	 * @since 1.0.0
	**/
	private var _color:Float = 0;

	/**
	 * Pre-calculated internal color32 value.
	 *
	 * @since 1.0.0
	**/
	private var _color32:Float = 0;

	/**
	 * Pre-calculated internal color rgb string value.
	 *
	 * @since 1.0.0
	**/
	private var _rgba:String = '';

	/**
	 * The color of this Color component, not including the alpha channel.
	 *
	 * @since 1.0.0
	**/
	public var color(get, never):Float;

	/**
	 * The color of this Color component, including the alpha channel.
	 *
	 * @since 1.0.0
	**/
	public var color32(get, never):Float;

	/**
	 * The color of this Color component as a string which can be used in CSS color values
	 *
	 * @since 1.0.0
	**/
	public var rgba(get, never):String;

	/**
	 * The red color value, normalized to the range 0 to 1.
	 *
	 * @since 1.0.0
	**/
	public var redGL(get, set):Float;

	/**
	 * The green color value, normalized to the range 0 to 1.
	 *
	 * @since 1.0.0
	**/
	public var greenGL(get, set):Float;

	/**
	 * The blue color value, normalized to the range 0 to 1.
	 *
	 * @since 1.0.0
	**/
	public var blueGL(get, set):Float;

	/**
	 * The alpha color value, normalized to the range 0 to 1.
	 *
	 * @since 1.0.0
	**/
	public var alphaGL(get, set):Float;

	/**
	 * The red color value, normalized to the range 0 to 255.
	 *
	 * @since 1.0.0
	**/
	public var red(get, set):Int;

	/**
	 * The green color value, normalized to the range 0 to 255.
	 *
	 * @since 1.0.0
	**/
	public var green(get, set):Int;

	/**
	 * The blue color value, normalized to the range 0 to 255.
	 *
	 * @since 1.0.0
	**/
	public var blue(get, set):Int;

	/**
	 * The alpha color value, normalized to the range 0 to 255.
	 *
	 * @since 1.0.0
	**/
	public var alpha(get, set):Int;

	/**
	 * The green color value, normalized to the range 0 to 255.
	 *
	 * @since 1.0.0
	**/
	public var h(get, set):Float;

	/**
	 * The blue color value, normalized to the range 0 to 255.
	 *
	 * @since 1.0.0
	**/
	public var s(get, set):Float;

	/**
	 * The alpha color value, normalized to the range 0 to 255.
	 *
	 * @since 1.0.0
	**/
	public var v(get, set):Float;

	public function new(red:Int = 0, green:Int = 0, blue:Int = 0, alpha:Int = 0)
	{
		r = red;
		g = green;
		b = blue;
		a = alpha;
	}

	private inline function get_color():Float
	{
		return _color;
	}

	private inline function get_color32():Float
	{
		return _color32;
	}

	private inline function get_rgba():String
	{
		return _rgba;
	}

	private inline function get_redGL():Float
	{
		return gl[0];
	}

	private inline function set_redGL(value:Float):Float
	{
		gl[0] = Math.min(Math.abs(value), 1);

		r = Math.floor(this.gl[0] * 255);

		update(true);

		return gl[0];
	}

	private inline function get_greenGL():Float
	{
		return gl[1];
	}

	private inline function set_greenGL(value:Float):Float
	{
		gl[1] = Math.min(Math.abs(value), 1);

		g = Math.floor(this.gl[1] * 255);

		update(true);

		return gl[1];
	}

	private inline function get_blueGL():Float
	{
		return gl[2];
	}

	private inline function set_blueGL(value:Float):Float
	{
		gl[2] = Math.min(Math.abs(value), 1);

		b = Math.floor(gl[2] * 255);

		update(true);

		return gl[2];
	}

	private inline function get_alphaGL():Float
	{
		return gl[3];
	}

	private inline function set_alphaGL(value:Float):Float
	{
		gl[3] = Math.min(Math.abs(value), 1);

		a = Math.floor(gl[3] * 255);

		update();

		return gl[3];
	}

	private inline function get_red():Int
	{
		return r;
	}

	private inline function set_red(value:Int):Int
	{
		value = Math.floor(Math.abs(value));

		r = value < 255 ? value : 255;

		gl[0] = value / 255;

		update(true);

		return r;
	}

	private inline function get_green():Int
	{
		return g;
	}

	private inline function set_green(value:Int):Int
	{
		value = Math.floor(Math.abs(value));

		g = MathInt.min(value, 255);

		gl[1] = value / 255;

		update(true);

		return g;
	}

	private inline function get_blue():Int
	{
		return b;
	}

	private inline function set_blue(value:Int):Int
	{
		value = Math.floor(Math.abs(value));

		b = MathInt.min(value, 255);

		gl[2] = value / 255;

		update(true);

		return b;
	}

	private inline function get_alpha():Int
	{
		return a;
	}

	private inline function set_alpha(value:Int):Int
	{
		value = Math.floor(Math.abs(value));

		a = MathInt.min(value, 255);

		gl[3] = value / 255;

		update();

		return a;
	}

	private inline function get_h():Float
	{
		return _h;
	}

	private inline function set_h(value:Float):Float
	{
		_h = value;
		hsvToRGB(value, _s, _v, this);
		return _h;
	}

	private inline function get_s():Float
	{
		return _s;
	}

	private inline function set_s(value:Float):Float
	{
		_s = value;
		hsvToRGB(_h, value, _v, this);
		return _s;
	}

	private inline function get_v():Float
	{
		return _v;
	}

	private inline function set_v(value:Float):Float
	{
		_v = value;
		hsvToRGB(_h, _s, value, this);
		return _v;
	}

	/**
	 * TODO: needs some testing as this is total rewrite
	 *
	 * Converts a hex string into a Phaser Color object.
	 *
	 * The hex string can supplied as `'#0033ff'` or the short-hand format of `'#03f'`; it can begin with an optional "#" or "0x", or be unprefixed.
	 *
	 * An alpha channel is _not_ supported.
	 *
	 * @since 1.0.0
	 *
	 * @param hex - The hex color value to convert, such as `#0033ff` or the short-hand format: `#03f`.
	 *
	 * @return A Color object populated by the values of the given string.
	**/
	public static function hexStringToColor(hex:String):Color
	{
		var color = new Color();

		inline function decimal(n:Int):Int
		{
			return Utils.charterCodeHexToInt(n);
		}

		var startIndex:Int = 0;
		if (hex.charCodeAt(0) == "#".code)
		{
			startIndex = 1;
		}
		if (hex.charCodeAt(0) == "0".code && (hex.charCodeAt(1) == "x".code || hex.charCodeAt(1) == "X".code))
		{
			startIndex = 2;
		}

		if ((hex.length - startIndex) == 3)
		{
			var r = decimal(hex.charCodeAt(0 + startIndex)) * 17;
			var g = decimal(hex.charCodeAt(1 + startIndex)) * 17;
			var b = decimal(hex.charCodeAt(2 + startIndex)) * 17;
			color.setTo(r, g, b);
		}
		else
		{
			var r = decimal(hex.charCodeAt(0 + startIndex)) * 16 +
				decimal(hex.charCodeAt(1 + startIndex));

			var g = decimal(hex.charCodeAt(2 + startIndex)) * 16 +
				decimal(hex.charCodeAt(3 + startIndex));

			var b = decimal(hex.charCodeAt(4 + startIndex)) * 16 +
				decimal(hex.charCodeAt(5 + startIndex));

			color.setTo(r, g, b);
		}
		return color;
	}

	/**
	 * Converts the given color value into an instance of a Color object.
	 *
	 * @since 1.0.0
	 *
	 * @param input - The color value to convert into a Color object.
	 *
	 * @return A Color object.
	**/
	public static function integerToColor(input:Int):Color
	{
		var rgb = integerToRGB(input);

		return new Color(rgb.r, rgb.g, rgb.b, rgb.a);
	}

	/**
	 * Converts a CSS 'web' string into a Phaser Color object.
	 *
	 * The web string can be in the format `'rgb(r,g,b)'` or `'rgba(r,g,b,a)'` where r/g/b are in the range [0..255] and a is in the range [0..1].
	 *
	 * @since 1.0.0
	 *
	 * @param rgb - The CSS format color string, using the `rgb` or `rgba` format.
	 *
	 * @return A Color object.
	**/
	public static function rgbStringToColor(rgb)
	{
		var color = new Color();

		var result = (~/^rgba?\(\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*(?:,\s*(\d+(?:\.\d+)?))?\s*\)$/)
			.split(rgb.toLowerCase());

		if (result != null)
		{
			var r = Std.parseInt(result[1]);
			var g = Std.parseInt(result[2]);
			var b = Std.parseInt(result[3]);
			var a = (result[4] != null) ? Std.parseFloat(result[4]) : 1;

			color.setTo(r, g, b, Std.int(a * 255));
		}

		return color;
	}

	/**
	 * Converts the given source color value into an instance of a Color class.
	 * The value can be either a string, prefixed with `rgb` or a hex string, a number or an Object.
	 *
	 * @since 1.0.0
	 *
	 * @param input - The source color value to convert.
	 *
	 * @return A Color object.
	**/
	public static function valueToColor(input:Union3<String, Int, InputColorObject>)
	{
		if (Std.is(input, String))
		{
			if ((cast input : String).substr(0, 3).toLowerCase() == 'rgb')
			{
				return rgbStringToColor(cast input);
			}
			else
			{
				return hexStringToColor(cast input);
			}
		}
		else if (Std.is(input, String))
		{
			return integerToColor(cast input);
		}
		else
		{
			return objectToColor(cast input);
		}
	}

	/**
	 * Converts an object containing `r`, `g`, `b` and `a` properties into a Color class instance.
	 *
	 * @since 1.0.0
	 *
	 * @param input - An object containing `r`, `g`, `b` and `a` properties in the range 0 to 255.
	 *
	 * @return A Color object.
	**/
	public static function objectToColor(input:InputColorObject)
	{
		return new Color(input.r, input.g, input.b, input.a);
	}

	/**
	 * Return the component parts of a color as an Object with the properties alpha, red, green, blue.
	 *
	 * Alpha will only be set if it exists in the given color (0xAARRGGBB)
	 *
	 * @since 1.0.0
	 *
	 * @param input - The color value to convert into a Color object.
	 *
	 * @return An object with the red, green and blue values set in the r, g and b properties.
	**/
	public static function integerToRGB(input:Int):ColorObject
	{
		return if (input > 16777215)
		{
			//  The color value has an alpha component
			{
				a: input >>> 24,
				r: input >> 16 & 0xFF,
				g: input >> 8 & 0xFF,
				b: input & 0xFF
			};
		}
		else
		{
			{
				a: 255,
				r: input >> 16 & 0xFF,
				g: input >> 8 & 0xFF,
				b: input & 0xFF
			};
		}
	}

	/**
	 * Given 3 separate color values this will return an integer representation of it.
	 *
	 * @since 1.0.0
	 *
	 * @param red - The red color value. A number between 0 and 255.
	 * @param green - The green color value. A number between 0 and 255.
	 * @param blue - The blue color value. A number between 0 and 255.
	 *
	 * @return The combined color value.
	**/
	public static function getColor(red:Int, green:Int, blue:Int):Int
	{
		return red << 16 | green << 8 | blue;
	}

	/**
	 * Given an alpha and 3 color values this will return an integer representation of it.
	 *
	 * @since 1.0.0
	 *
	 * @param red - The red color value. A number between 0 and 255.
	 * @param green - The green color value. A number between 0 and 255.
	 * @param blue - The blue color value. A number between 0 and 255.
	 * @param alpha - The alpha color value. A number between 0 and 255.
	 *
	 * @return The combined color value.
	**/
	public static function getColor32(red:Int, green:Int, blue:Int, alpha:Int):Int
	{
		return alpha << 24 | red << 16 | green << 8 | blue;
	}

	/**
	 * Given an alpha and 3 color values this will return an integer representation of it.
	 *
	 * @since 1.0.0
	 *
	 * @param red - The red color value. A number between 0 and 255.
	 * @param green - The green color value. A number between 0 and 255.
	 * @param blue - The blue color value. A number between 0 and 255.
	 * @param alpha - The alpha color value. A number between 0 and 255.
	 *
	 * @return The combined color value.
	**/
	public static function rgbToHSV<T:Union<HSVColorObject, Color>>(r:Float, g:Float,
			b:Float, out:T):T
	{
		r /= 255;
		g /= 255;
		b /= 255;

		var min = Math.min(Math.min(r, g), b);
		var max = Math.max(Math.max(r, g), b);
		var d = max - min;

		// achromatic by default
		var h:Float = 0.0;
		var s:Float = (max == 0) ? 0 : d / max;
		var v:Float = max;

		if (max != min)
		{
			if (max == r)
			{
				h = (g - b) / d + ((g < b) ? 6 : 0);
			}
			else if (max == g)
			{
				h = (b - r) / d + 2;
			}
			else if (max == b)
			{
				h = (r - g) / d + 4;
			}

			h /= 6;
		}

		if (Std.is(out, Color))
		{
			var outColor = (cast out : Color);
			outColor._h = h;
			outColor._s = s;
			outColor._v = v;
			return cast outColor;
		}
		else
		{
			var outHSVColorObject = (cast out : HSVColorObject);
			outHSVColorObject.h = h;
			outHSVColorObject.s = s;
			outHSVColorObject.v = v;
			return cast outHSVColorObject;
		}

		return out;
	}

	/**
	 * Converts an HSV (hue, saturation and value) color value to RGB.
	 * Conversion formula from http://en.wikipedia.org/wiki/HSL_color_space.
	 * Assumes HSV values are contained in the set [0, 1].
	 * Based on code by Michael Jackson (https://github.com/mjijackson)
	 *
	 * @since 1.0.0
	 *
	 * @param h - The hue, in the range 0 - 1. This is the base color.
	 * @param s - The saturation, in the range 0 - 1. This controls how much of the hue will be in the final color, where 1 is fully saturated and 0 will give you white.
	 * @param v - The value, in the range 0 - 1. This controls how dark the color is. Where 1 is as bright as possible and 0 is black.
	 * @param out - A Color object to store the results in.
	 *
	 * @return An object with the red, green and blue values set in the r, g and b properties.
	**/
	public static function hsvToRGB<T:Union<ColorObject, Color>>(h:Float, s:Float = 1,
			v:Float = 1, out:T):T
	{
		var i = Math.floor(h * 6);
		var f = h * 6 - i;

		var p = Math.floor((v * (1 - s)) * 255);
		var q = Math.floor((v * (1 - f * s)) * 255);
		var t = Math.floor((v * (1 - (1 - f) * s)) * 255);

		v *= 255;
		var v:Int = Math.floor(v);

		var r = v;
		var g = v;
		var b = v;

		var c = i % 6;

		if (c == 0)
		{
			g = t;
			b = p;
		}
		else if (c == 1)
		{
			r = q;
			b = p;
		}
		else if (c == 2)
		{
			r = p;
			b = t;
		}
		else if (c == 3)
		{
			r = p;
			g = q;
		}
		else if (c == 4)
		{
			r = t;
			g = p;
		}
		else if (c == 5)
		{
			g = p;
			b = q;
		}

		if (Std.is(out, Color))
		{
			var outColor = (cast out : Color);
			var alpha = (cast outColor.alpha);
			return cast outColor.setTo(r, g, b, alpha, false);
		}
		else
		{
			var outColorObject:ColorObject = cast out;

			outColorObject.r = r;
			outColorObject.g = g;
			outColorObject.b = b;
			outColorObject.color = getColor(r, g, b);

			return out;
		}
	}

	/**
	 * Converts an HSV (hue, saturation and value) color value to RGB.
	 * Conversion formula from http://en.wikipedia.org/wiki/HSL_color_space.
	 * Assumes HSV values are contained in the set [0, 1].
	 * Based on code by Michael Jackson (https://github.com/mjijackson)
	 *
	 * @since 1.0.0
	 *
	 * @param h - The hue, in the range 0 - 1. This is the base color.
	 * @param s - The saturation, in the range 0 - 1. This controls how much of the hue will be in the final color, where 1 is fully saturated and 0 will give you white.
	 * @param v - The value, in the range 0 - 1. This controls how dark the color is. Where 1 is as bright as possible and 0 is black.
	 *
	 * @return An object with the red, green and blue values set in the r, g and b properties.
	**/
	public static inline function createRGBFromHSV(h:Float, s:Float = 1,
			v:Float = 1):ColorObject
	{
		return hsvToRGB(h, s, v, ({
			r: 0,
			g: 0,
			b: 0,
			color: 0
		} : ColorObject));
	}

	/**
	 * Sets this color to be transparent. Sets all values to zero.
	 *
	 * @since 1.0.0
	 *
	 * @return This Color object.
	**/
	public function transparent():Color
	{
		_locked = true;

		red = 0;
		green = 0;
		blue = 0;
		alpha = 0;

		_locked = false;

		return update(true);
	}

	/**
	 * Sets the color of this Color component.
	 *
	 * @since 1.0.0
	 *
	 * @param red - The red color value. A number between 0 and 255.
	 * @param green - The green color value. A number between 0 and 255.
	 * @param blue - The blue color value. A number between 0 and 255.
	 * @param alpha - The alpha value. A number between 0 and 255.
	 * @param updateHSV - Update the HSV values after setting the RGB values?
	 *
	 * @return This Color object.
	**/
	public function setTo(red:Int, green:Int, blue:Int, alpha:Int = 255,
			updateHSV:Bool = true)
	{
		_locked = true;

		this.red = red;
		this.green = green;
		this.blue = blue;
		this.alpha = alpha;

		_locked = false;

		return update(updateHSV);
	}

	/**
	 * Sets the red, green, blue and alpha GL values of this Color component.
	 *
	 * @since 1.0.0
	 *
	 * @param red - The red color value. A number between 0 and 1.
	 * @param green - The green color value. A number between 0 and 1.
	 * @param blue - The blue color value. A number between 0 and 1.
	 * @param alpha - The alpha value. A number between 0 and 1.
	 *
	 * @return This Color object.
	**/
	public function setGLTo(red:Float, green:Float, blue:Float, alpha:Float = 1.0):Color
	{
		_locked = true;

		redGL = red;
		greenGL = green;
		blueGL = blue;
		alphaGL = alpha;

		_locked = false;

		return update(true);
	}

	/**
	 * Sets the color based on the color object given.
	 *
	 * @since 1.0.0
	 *
	 * @param color - An object containing `r`, `g`, `b` and optionally `a` values in the range 0 to 255.
	 *
	 * @return This Color object.
	**/
	public function setFromRGB(color:InputColorObject)
	{
		_locked = true;

		red = color.r;
		green = color.g;
		blue = color.b;

		if (a != null)
		{
			alpha = color.a;
		}

		_locked = false;

		return update(true);
	}

	/**
	 * Sets the color based on the hue, saturation and lightness values given.
	 *
	 * @since 1.0.0
	 *
	 * @param h - The hue, in the range 0 - 1. This is the base color.
	 * @param s - The saturation, in the range 0 - 1. This controls how much of the hue will be in the final color, where 1 is fully saturated and 0 will give you white.
	 * @param v - The value, in the range 0 - 1. This controls how dark the color is. Where 1 is as bright as possible and 0 is black.
	 *
	 * @return This Color object.
	**/
	public function setFromHSV(h:Float, s:Float, v:Float)
	{
		return hsvToRGB(h, s, v, this);
	}

	/**
	 * Updates the internal cache values.
	 *
	 * @since 1.0.0
	 *
	 * @return This Color object.
	**/
	public function update(updateHSV:Bool = false):Color
	{
		if (_locked)
		{
			return this;
		}

		#if js
		var r = (cast this.r : Int);
		var g = (cast this.g : Int);
		var b = (cast this.b : Int);
		var a = (cast this.a : Int);
		#else
		var r = toIntSafe(this.r);
		var g = toIntSafe(this.g);
		var b = toIntSafe(this.b);
		var a = toIntSafe(this.a);
		#end

		this._color = getColor(r, g, b);
		this._color32 = getColor32(r, g, b, a);
		this._rgba = 'rgba(' + r + ',' + g + ',' + b + ',' + (a / 255) + ')';
		if (updateHSV)
		{
			rgbToHSV(r, g, b, this);
		}
		return this;
	}

	/**
	 * Updates the internal hsv cache values.
	 *
	 * @since 1.0.0
	 *
	 * @return This Color object.
	**/
	public function updateHSV()
	{
		var r = this.r;
		var g = this.g;
		var b = this.b;

		rgbToHSV(r, g, b, this);
	}

	/**
	 * Returns a new Color component using the values from this one.
	 *
	 * @since 1.0.0
	 *
	 * @return A new Color object.
	**/
	public function clone():Color
	{
		return new Color(r, g, b, a);
	}

	/**
	 * Sets this Color object to be grayscaled based on the shade value given.
	 *
	 * @since 1.0.0
	 *
	 * @param shade - A value between 0 and 255.
	 *
	 * @return This Color object.
	**/
	public function gray(shade:Int):Color
	{
		return setTo(shade, shade, shade);
	}

	/**
	 * Sets this Color object to be a random color between the `min` and `max` values given.
	 *
	 * @since 1.0.0
	 *
	 * @param min - The minimum random color value. Between 0 and 255.
	 * @param max - The maximum random color value. Between 0 and 255.
	 *
	 * @return This Color object.
	**/
	public function random(min:Int = 0, max:Int = 255):Color
	{
		var r = Math.floor(min + Math.random() * (max - min));
		var g = Math.floor(min + Math.random() * (max - min));
		var b = Math.floor(min + Math.random() * (max - min));
		return setTo(r, g, b);
	}

	/**
	 * Sets this Color object to be a random grayscale color between the `min` and `max` values given.
	 *
	 * @since 1.0.0
	 *
	 * @param min - The minimum random color value. Between 0 and 255.
	 * @param max - The maximum random color value. Between 0 and 255.
	 *
	 * @return This Color object.
	**/
	public function randomGray(min:Int = 0, max:Int = 255):Color
	{
		var s = Math.floor(min + Math.random() * (max - min));

		return setTo(s, s, s);
	}

	/**
	 * Increase the saturation of this Color by the percentage amount given.
	 * The saturation is the amount of the base color in the hue.
	 *
	 * @since 1.0.0
	 *
	 * @param amount - The percentage amount to change this color by. A value between 0 and 100.
	 *
	 * @return This Color object.
	**/
	public function saturate(amount:Int):Color
	{
		s += amount / 100;
		return this;
	}

	/**
	 * Decrease the saturation of this Color by the percentage amount given.
	 * The saturation is the amount of the base color in the hue.
	 *
	 * @since 1.0.0
	 *
	 * @param amount - The percentage amount to change this color by. A value between 0 and 100.
	 *
	 * @return This Color object.
	**/
	public function desaturate(amount:Int):Color
	{
		s -= amount / 100;
		return this;
	}

	/**
	 * Increase the lightness of this Color by the percentage amount given.
	 *
	 * @since 1.0.0
	 *
	 * @param amount - The percentage amount to change this color by. A value between 0 and 100.
	 *
	 * @return This Color object.
	 */
	public function lighten(amount:Int):Color
	{
		v += amount / 100;
		return this;
	}

	/**
	 * Decrease the lightness of this Color by the percentage amount given.
	 *
	 * @since 1.0.0
	 *
	 * @param amount - The percentage amount to change this color by. A value between 0 and 100.
	 *
	 * @return This Color object.
	**/
	public function darken(amount:Int):Color
	{
		v -= amount / 100;
		return this;
	}

	/**
	 * Brighten this Color by the percentage amount given.
	 *
	 * @since 1.0.0
	 *
	 * @param amount - The percentage amount to change this color by. A value between 0 and 100.
	 *
	 * @return This Color object.
	**/
	public function brighten(amount)
	{
		var r = this.r;
		var g = this.g;
		var b = this.b;

		r = MathInt.max(0, MathInt.min(255, r - Math.round(255 * -(amount / 100))));
		g = MathInt.max(0, MathInt.min(255, g - Math.round(255 * -(amount / 100))));
		b = MathInt.max(0, MathInt.min(255, b - Math.round(255 * -(amount / 100))));

		return setTo(r, g, b);
	}
}
