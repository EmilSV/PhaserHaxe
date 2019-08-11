package phaserHaxe.gameobjects.components;

import phaserHaxe.math.MathUtility.clamp as clamp;

/**
 * Provides methods used for setting the alpha properties of a Game Object.
 *
 * @since 1.0.0
**/
@:allow(phaserHaxe.gameobjects.components.AlphaImplantation)
interface IAlpha
{
	/**
	 * Private internal value. Holds the global alpha value.
	 *
	 * @since 1.0.0
	**/
	private var _alpha:Float;

	/**
	 * Private internal value. Holds the top-left alpha value.
	 *
	 * @since 1.0.0
	**/
	private var _alphaTL:Float;

	/**
	 * Private internal value. Holds the top-right alpha value.
	 *
	 * @since 1.0.0
	**/
	private var _alphaTR:Float;

	/**
	 * Private internal value. Holds the bottom-left alpha value.
	 *
	 * @since 1.0.0
	**/
	private var _alphaBL:Float;

	/**
	 * Private internal value. Holds the bottom-right alpha value.
	 *
	 * @since 1.0.0
	**/
	private var _alphaBR:Float;

	/**
	 * Clears all alpha values associated with this Game Object.
	 *
	 * Immediately sets the alpha levels back to 1 (fully opaque).
	 *
	 * @since 1.0.0
	 *
	 * @return This Game Object instance.
	**/
	public function clearAlpha():IAlpha;

	/**
	 * Set the Alpha level of this Game Object. The alpha controls the opacity of the Game Object as it renders.
	 * Alpha values are provided as a float between 0, fully transparent, and 1, fully opaque.
	 *
	 * If your game is running under WebGL you can optionally specify four different alpha values, each of which
	 * correspond to the four corners of the Game Object. Under Canvas only the `topLeft` value given is used.
	 *
	 * @since 1.0.0
	 *
	 * @param topLeft - The alpha value used for the top-left of the Game Object. If this is the only value given it's applied across the whole Game Object.
	 * @param topRight - The alpha value used for the top-right of the Game Object. WebGL only.
	 * @param bottomLeft - The alpha value used for the bottom-left of the Game Object. WebGL only.
	 * @param bottomRight - The alpha value used for the bottom-right of the Game Object. WebGL only.
	 *
	 * @return This Game Object instance.
	**/
	public function setAlpha(topLeft:Float = 1, ?topRight:Float, ?bottomLeft:Float,
		?bottomRight:Float):IAlpha;

	/**
	 * The alpha value of the Game Object.
	 *
	 * This is a global value, impacting the entire Game Object, not just a region of it.
	 *
	 * @since 1.0.0
	**/
	public var alpha(get, set):Float;

	/**
	 * The alpha value starting from the top-left of the Game Object.
	 * This value is interpolated from the corner to the center of the Game Object.
	 *
	 * @name Phaser.GameObjects.Components.Alpha#alphaTopLeft
	 * @type {number}
	 * @webglOnly
	 * @since 1.0.0
	**/
	public var alphaTopLeft(get, set):Float;

	/**
	 * The alpha value starting from the top-right of the Game Object.
	 * This value is interpolated from the corner to the center of the Game Object.
	 *
	 * @webglOnly
	 * @since 1.0.0
	**/
	public var alphaTopRight(get, set):Float;

	/**
	 * The alpha value starting from the bottom-left of the Game Object.
	 * This value is interpolated from the corner to the center of the Game Object.
	 *
	 * @webglOnly
	 * @since 1.0.0
	**/
	public var alphaBottomLeft(get, set):Float;

	/**
	 * The alpha value starting from the bottom-right of the Game Object.
	 * This value is interpolated from the corner to the center of the Game Object.
	 *
	 * @webglOnly
	 * @since 1.0.0
	**/
	public var alphaBottomRight(get, set):Float;
}

final class AlphaImplantation
{
	private static inline var _FLAG = 2;

	public inline static function clearAlpha<T:IAlpha>(self:T):T
	{
		self.setAlpha(1);
		return self;
	}

	public inline static function setAlpha<T:IAlpha>(self:T, topLeft:Float,
			?topRight:Float, ?bottomLeft:Float, ?bottomRight:Float):T
	{
		//  Treat as if there is only one alpha value for the whole Game Object
		if (topRight == null)
		{
			self.alpha = topLeft;
		}
		else
		{
			self._alphaTL = clamp(topLeft, 0, 1);
			self._alphaTR = clamp(topRight, 0, 1);
			self._alphaBL = clamp(bottomLeft, 0, 1);
			self._alphaBR = clamp(bottomRight, 0, 1);
		}

		return self;
	}

	public static inline function get_alpha<T:IAlpha>(self:T):Float
	{
		return self._alpha;
	}

	public static inline function set_alpha<T:IAlpha & GameObject>(self:T,
			value:Float):Float
	{
		final v = clamp(value, 0, 1);

		self._alpha = v;
		self._alphaTL = v;
		self._alphaTR = v;
		self._alphaBL = v;
		self._alphaBR = v;

		if (v == 0)
		{
			self.renderFlags &= ~_FLAG;
		}
		else
		{
			self.renderFlags |= _FLAG;
		}

		return v;
	}

	public static inline function get_alphaTopLeft<T:IAlpha>(self:T):Float
	{
		return self._alphaTL;
	}

	public static inline function set_alphaTopLeft<T:IAlpha & GameObject>(self:T,
			value:Float):Float
	{
		final v = clamp(value, 0, 1);
		self._alphaTL = v;

		if (v != 0)
		{
			self.renderFlags |= _FLAG;
		}

		return v;
	}

	public static inline function get_alphaTopRight<T:IAlpha>(self:T):Float
	{
		return self._alphaTR;
	}

	public static inline function set_alphaTopRight<T:IAlpha & GameObject>(self:T,
			value:Float):Float
	{
		final v = clamp(value, 0, 1);

		self._alphaTR = v;

		if (v != 0)
		{
			self.renderFlags |= _FLAG;
		}

		return v;
	}

	public static inline function get_alphaBottomLeft<T:IAlpha>(self:T):Float
	{
		return self._alphaBL;
	}

	public static inline function set_alphaBottomLeft<T:IAlpha & GameObject>(self:T,
			value:Float):Float
	{
		final v = clamp(value, 0, 1);

		self._alphaBL = v;

		if (v != 0)
		{
			self.renderFlags |= _FLAG;
		}

		return v;
	}

	public static inline function get_alphaBottomRight<T:IAlpha>(self:T):Float
	{
		return self._alphaBR;
	}

	public static inline function set_alphaBottomRight<T:IAlpha & GameObject>(self:T,
			value:Float):Float
	{
		final v = clamp(value, 0, 1);

		self._alphaBR = v;

		if (v != 0)
		{
			self.renderFlags |= _FLAG;
		}

		return v;
	}
}

final class AlphaMixin extends GameObject implements IAlpha
{
	/**
	 * Private internal value. Holds the global alpha value.
	 *
	 * @since 1.0.0
	**/
	private var _alpha:Float = 1;

	/**
	 * Private internal value. Holds the top-left alpha value.
	 *
	 * @since 1.0.0
	**/
	private var _alphaTL:Float = 1;

	/**
	 * Private internal value. Holds the top-right alpha value.
	 *
	 * @since 1.0.0
	**/
	private var _alphaTR:Float = 1;

	/**
	 * Private internal value. Holds the bottom-left alpha value.
	 *
	 * @since 1.0.0
	**/
	private var _alphaBL:Float = 1;

	/**
	 * Private internal value. Holds the bottom-right alpha value.
	 *
	 * @since 1.0.0
	**/
	private var _alphaBR:Float = 1;

	private inline function get_alphaTopLeft():Float
	{
		return AlphaImplantation.get_alphaTopLeft(cast this);
	}

	private inline function set_alphaTopLeft(value:Float):Float
	{
		return AlphaImplantation.set_alphaTopLeft(this, value);
	}

	private inline function get_alphaTopRight():Float
	{
		return AlphaImplantation.get_alphaTopRight(this);
	}

	private inline function set_alphaTopRight(value:Float):Float
	{
		return AlphaImplantation.set_alphaTopRight(this, value);
	}

	private inline function get_alpha():Float
	{
		return AlphaImplantation.get_alpha(cast this);
	}

	private inline function set_alpha(value:Float):Float
	{
		return AlphaImplantation.set_alpha(this, value);
	}

	private inline function get_alphaBottomLeft():Float
	{
		return AlphaImplantation.get_alphaBottomLeft(cast this);
	}

	private inline function set_alphaBottomLeft(value:Float):Float
	{
		return AlphaImplantation.set_alphaBottomLeft(this, value);
	}

	private inline function get_alphaBottomRight():Float
	{
		return AlphaImplantation.get_alphaBottomRight(this);
	}

	private inline function set_alphaBottomRight(value:Float):Float
	{
		return AlphaImplantation.set_alphaBottomRight(this, value);
	}

	/**
	 * Clears all alpha values associated with this Game Object.
	 *
	 * Immediately sets the alpha levels back to 1 (fully opaque).
	 *
	 * @since 1.0.0
	 *
	 * @return This Game Object instance.
	**/
	public function clearAlpha():AlphaMixin
	{
		return cast AlphaImplantation.clearAlpha(cast this);
	}

	/**
	 * Set the Alpha level of this Game Object. The alpha controls the opacity of the Game Object as it renders.
	 * Alpha values are provided as a float between 0, fully transparent, and 1, fully opaque.
	 *
	 * If your game is running under WebGL you can optionally specify four different alpha values, each of which
	 * correspond to the four corners of the Game Object. Under Canvas only the `topLeft` value given is used.
	 *
	 * @since 1.0.0
	 *
	 * @param topLeft - The alpha value used for the top-left of the Game Object. If this is the only value given it's applied across the whole Game Object.
	 * @param topRight - The alpha value used for the top-right of the Game Object. WebGL only.
	 * @param bottomLeft - The alpha value used for the bottom-left of the Game Object. WebGL only.
	 * @param bottomRight - The alpha value used for the bottom-right of the Game Object. WebGL only.
	 *
	 * @return This Game Object instance.
	**/
	public function setAlpha(topLeft:Float = 1, ?topRight:Float, ?bottomLeft:Float,
			?bottomRight:Float):AlphaMixin
	{
		return
			AlphaImplantation.setAlpha(this, topLeft, topRight, bottomLeft, bottomRight);
	}

	/**
	 * The alpha value of the Game Object.
	 *
	 * This is a global value, impacting the entire Game Object, not just a region of it.
	 *
	 * @since 1.0.0
	**/
	public var alpha(get, set):Float;

	/**
	 * The alpha value starting from the top-left of the Game Object.
	 * This value is interpolated from the corner to the center of the Game Object.
	 *
	 * @name Phaser.GameObjects.Components.Alpha#alphaTopLeft
	 * @type {number}
	 * @webglOnly
	 * @since 1.0.0
	**/
	public var alphaTopLeft(get, set):Float;

	/**
	 * The alpha value starting from the top-right of the Game Object.
	 * This value is interpolated from the corner to the center of the Game Object.
	 *
	 * @webglOnly
	 * @since 1.0.0
	**/
	public var alphaTopRight(get, set):Float;

	/**
	 * The alpha value starting from the bottom-left of the Game Object.
	 * This value is interpolated from the corner to the center of the Game Object.
	 *
	 * @webglOnly
	 * @since 1.0.0
	**/
	public var alphaBottomLeft(get, set):Float;

	/**
	 * The alpha value starting from the bottom-right of the Game Object.
	 * This value is interpolated from the corner to the center of the Game Object.
	 *
	 * @webglOnly
	 * @since 1.0.0
	**/
	public var alphaBottomRight(get, set):Float;
}
