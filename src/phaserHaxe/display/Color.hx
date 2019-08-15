package phaserHaxe.display;

import phaserHaxe.Compatibility.toIntSafe as toIntSafe;
import phaserHaxe.display.HSVColorObject;
import phaserHaxe.Either;

// Todo: rest of color
@:allow(phaserHaxe.display.InputColorObject)
class Color
{
	/**
	 * The internal red color value.
	 *
	 * @since 1.0.0
	**/
	public var r(default, null):Float = 0;

	/**
	 * The internal green color value.
	 *
	 * @since 1.0.0
	**/
	public var g(default, null):Float = 0;

	/**
	 * The internal blue color value.
	 *
	 * @since 1.0.0
	**/
	public var b(default, null):Float = 0;

	/**
	 * The internal alpha color value.
	 *
	 * @since 1.0.0
	**/
	public var a(default, null):Float = 255;

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
	public var red(get, set):Float;

	/**
	 * The green color value, normalized to the range 0 to 255.
	 *
	 * @since 1.0.0
	**/
	public var green(get, set):Float;

	/**
	 * The blue color value, normalized to the range 0 to 255.
	 *
	 * @since 1.0.0
	**/
	public var blue(get, set):Float;

	/**
	 * The alpha color value, normalized to the range 0 to 255.
	 *
	 * @since 1.0.0
	**/
	public var alpha(get, set):Float;

	public function new(red:Float = 0, green:Float = 0, blue:Float = 0, alpha:Float = 0)
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

	private inline function get_red():Float
	{
		return r;
	}

	private inline function set_red(value:Float):Float
	{
		value = Math.floor(Math.abs(value));

		r = Math.min(value, 255);

		gl[0] = value / 255;

		update(true);

		return r;
	}

	private inline function get_green():Float
	{
		return g;
	}

	private inline function set_green(value:Float):Float
	{
		value = Math.floor(Math.abs(value));

		this.g = Math.min(value, 255);

		this.gl[1] = value / 255;

		this.update(true);

		return g;
	}

	private inline function get_blue():Float
	{
		return b;
	}

	private inline function set_blue(value:Float):Float
	{
		value = Math.floor(Math.abs(value));

		this.b = Math.min(value, 255);

		this.gl[2] = value / 255;

		this.update(true);

		return b;
	}

	private inline function get_alpha():Float
	{
		return a;
	}

	private inline function set_alpha(value:Float):Float
	{
		value = Math.floor(Math.abs(value));

		this.a = Math.min(value, 255);

		this.gl[3] = value / 255;

		this.update();

		return a;
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
	public static function rgbToHSV<T:Either<HSVColorObject, Color>>(r:Float, g:Float,
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

	public static function hsvToRGB<T:Either<ColorObject, Color>>(h:Float, s:Float = 1,
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
}
