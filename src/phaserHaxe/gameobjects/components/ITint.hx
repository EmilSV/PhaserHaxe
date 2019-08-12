package phaserHaxe.gameobjects.components;

@:allow(phaserHaxe.gameobjects.components.TintImplantation)
interface ITint
{
	/**
	 * Private internal value. Holds the top-left tint value.
	 *
	 * @default 16777215
	 * @since 1.0.0
	**/
	private var _tintTL:Int;

	/**
	 * Private internal value. Holds the top-right tint value.
	 *
	 * @default 16777215
	 * @since 1.0.0
	**/
	private var _tintTR:Int;

	/**
	 * Private internal value. Holds the bottom-left tint value.
	 *
	 * @default 16777215
	 * @since 1.0.0
	**/
	private var _tintBL:Int;

	/**
	 * Private internal value. Holds the bottom-right tint value.
	 *
	 * @default 16777215
	 * @since 1.0.0
	**/
	private var _tintBR:Int;

	/**
	 * Private internal value. Holds if the Game Object is tinted or not.
	 *
	 * @default false
	 * @since 1.0.0
	**/
	private var _isTinted:Bool;

	/**
	 * Fill or additive?
	 *
	 * @default false
	 * @since 1.0.0
	**/
	public var tintFill:Bool;

	/**
	 * Clears all tint values associated with this Game Object.
	 *
	 * Immediately sets the color values back to 0xffffff and the tint type to 'additive',
	 * which results in no visible change to the texture.
	 *
	 * @webglOnly
	 * @since 1.0.0
	 *
	 * @return This Game Object instance.
	**/
	public function clearTint():ITint;

	/**
	 * Sets an additive tint on this Game Object.
	 *
	 * The tint works by taking the pixel color values from the Game Objects texture, and then
	 * multiplying it by the color value of the tint. You can provide either one color value,
	 * in which case the whole Game Object will be tinted in that color. Or you can provide a color
	 * per corner. The colors are blended together across the extent of the Game Object.
	 *
	 * To modify the tint color once set, either call this method again with new values or use the
	 * `tint` property to set all colors at once. Or, use the properties `tintTopLeft`, `tintTopRight,
	 * `tintBottomLeft` and `tintBottomRight` to set the corner color values independently.
	 *
	 * To remove a tint call `clearTint`.
	 *
	 * To swap this from being an additive tint to a fill based tint set the property `tintFill` to `true`.
	 *
	 * @webglOnly
	 * @since 1.0.0
	 *
	 * @param topLeft - The tint being applied to the top-left of the Game Object. If no other values are given this value is applied evenly, tinting the whole Game Object.
	 * @param topRight - The tint being applied to the top-right of the Game Object.
	 * @param bottomLeft - The tint being applied to the bottom-left of the Game Object.
	 * @param bottomRight - The tint being applied to the bottom-right of the Game Object.
	 *
	 * @return This Game Object instance.
	**/
	public function setTint(topLeft:Int = 0xffffff, ?topRight:Int, ?bottomLeft:Int,
		?bottomRight:Int):ITint;

	/**
	 * Sets a fill-based tint on this Game Object.
	 *
	 * Unlike an additive tint, a fill-tint literally replaces the pixel colors from the texture
	 * with those in the tint. You can use this for effects such as making a player flash 'white'
	 * if hit by something. You can provide either one color value, in which case the whole
	 * Game Object will be rendered in that color. Or you can provide a color per corner. The colors
	 * are blended together across the extent of the Game Object.
	 *
	 * To modify the tint color once set, either call this method again with new values or use the
	 * `tint` property to set all colors at once. Or, use the properties `tintTopLeft`, `tintTopRight,
	 * `tintBottomLeft` and `tintBottomRight` to set the corner color values independently.
	 *
	 * To remove a tint call `clearTint`.
	 *
	 * To swap this from being a fill-tint to an additive tint set the property `tintFill` to `false`.
	 *
	 * @webglOnly
	 * @since 1.0.0
	 *
	 * @param topLeft - The tint being applied to the top-left of the Game Object. If not other values are given this value is applied evenly, tinting the whole Game Object.
	 * @param topRight - The tint being applied to the top-right of the Game Object.
	 * @param bottomLeft - The tint being applied to the bottom-left of the Game Object.
	 * @param bottomRight - The tint being applied to the bottom-right of the Game Object.
	 *
	 * @return This Game Object instance.
	**/
	public function setTintFill(topLeft:Int = 0xffffff, ?topRight:Int, ?bottomLeft:Int,
		?bottomRight:Int):ITint;

	/**
	 * The tint value being applied to the top-left of the Game Object.
	 * This value is interpolated from the corner to the center of the Game Object.
	 *
	 * @webglOnly
	 * @since 1.0.0
	**/
	public var tintTopLeft(get, set):Int;

	/**
	 * The tint value being applied to the top-right of the Game Object.
	 * This value is interpolated from the corner to the center of the Game Object.
	 *
	 * @webglOnly
	 * @since 1.0.0
	**/
	public var tintTopRight(get, set):Int;

	/**
	 * The tint value being applied to the bottom-left of the Game Object.
	 * This value is interpolated from the corner to the center of the Game Object.
	 *
	 * @webglOnly
	 * @since 1.0.0
	**/
	public var tintBottomLeft(get, set):Int;

	/**
	 * The tint value being applied to the bottom-right of the Game Object.
	 * This value is interpolated from the corner to the center of the Game Object.
	 *
	 * @name Phaser.GameObjects.Components.Tint#tintBottomRight
	 * @type {integer}
	 * @webglOnly
	 * @since 1.0.0
	**/
	public var tintBottomRight(get, set):Int;

	/**
	 * The tint value being applied to the whole of the Game Object.
	 * This property is a setter-only. Use the properties `tintTopLeft` etc to read the current tint value.
	 *
	 * @webglOnly
	 * @since 1.0.0
	**/
	public var tint(never, set):Int;

	/**
	 * Does this Game Object have a tint applied to it or not?
	 *
	 * @webglOnly
	 * @since 1.0.0
	***/
	public var isTinted(get, never):Bool;
}

final class TintImplantation
{
	private static function GetColor(value:Int)
	{
		return (value >> 16) + (value & 0xff00) + ((value & 0xff) << 16);
	}

	public static inline function clearTint<T:ITint>(self:T):T
	{
		self.setTint(0xffffff);
		self._isTinted = false;

		return self;
	}

	public static inline function setTint<T:ITint>(self:T, topLeft:Int = 0xffffff,
			?topRight:Int, ?bottomLeft:Int, ?bottomRight:Int):T
	{
		if (topLeft == null)
		{
			topLeft = 0xffffff;
		}

		if (topRight == null)
		{
			topRight = topLeft;
			bottomLeft = topLeft;
			bottomRight = topLeft;
		}

		self._tintTL = GetColor(topLeft);
		self._tintTR = GetColor(topRight);
		self._tintBL = GetColor(bottomLeft);
		self._tintBR = GetColor(bottomRight);

		self._isTinted = true;

		self.tintFill = false;

		return self;
	}

	public static inline function setTintFill<T:ITint>(self:T, topLeft:Int = 0xffffff,
			?topRight:Int, ?bottomLeft:Int, ?bottomRight:Int):T
	{
		self.setTint(topLeft, topRight, bottomLeft, bottomRight);

		self.tintFill = true;
		return self;
	}

	public static inline function get_tintTopLeft<T:ITint>(self:T):Int
	{
		return self._tintTL;
	}

	public static inline function set_tintTopLeft<T:ITint>(self:T, value:Int):Int
	{
		self._tintTL = GetColor(value);
		self._isTinted = true;
		return value;
	}

	public static inline function get_tintTopRight<T:ITint>(self:T):Int
	{
		return self._tintTR;
	}

	public static inline function set_tintTopRight<T:ITint>(self:T, value:Int):Int
	{
		self._tintTR = GetColor(value);
		self._isTinted = true;
		return value;
	}

	public static inline function get_tintBottomLeft<T:ITint>(self:T):Int
	{
		return self._tintBL;
	}

	public static inline function set_tintBottomLeft<T:ITint>(self:T, value:Int):Int
	{
		self._tintBL = GetColor(value);
		self._isTinted = true;
		return value;
	}

	public static inline function get_tintBottomRight<T:ITint>(self:T):Int
	{
		return self._tintBR;
	}

	public static inline function set_tintBottomRight<T:ITint>(self:T, value:Int):Int
	{
		self._tintBR = GetColor(value);
		self._isTinted = true;
		return value;
	}

	public static inline function set_tint<T:ITint>(self:T, value:Int):Int
	{
		self.setTint(value, value, value, value);
		return value;
	}

	public static inline function get_isTinted<T:ITint>(self:T):Bool
	{
		return self._isTinted;
	}
}

final class TintMixin implements ITint
{
	/**
	 * Private internal value. Holds the top-left tint value.
	 *
	 * @since 1.0.0
	**/
	private var _tintTL:Int = 16777215;

	/**
	 * Private internal value. Holds the top-right tint value.
	 *
	 * @since 1.0.0
	**/
	private var _tintTR:Int = 16777215;

	/**
	 * Private internal value. Holds the bottom-left tint value.
	 *
	 * @since 1.0.0
	**/
	private var _tintBL:Int = 16777215;

	/**
	 * Private internal value. Holds the bottom-right tint value.
	 *
	 * @since 1.0.0
	**/
	private var _tintBR:Int = 16777215;

	/**
	 * Private internal value. Holds if the Game Object is tinted or not.
	 *
	 * @since 1.0.0
	**/
	private var _isTinted:Bool = false;

	/**
	 * Fill or additive?
	 *
	 * @since 1.0.0
	**/
	public var tintFill:Bool = false;

	/**
	 * Clears all tint values associated with this Game Object.
	 *
	 * Immediately sets the color values back to 0xffffff and the tint type to 'additive',
	 * which results in no visible change to the texture.
	 *
	 * @webglOnly
	 * @since 1.0.0
	 *
	 * @return This Game Object instance.
	**/
	public function clearTint():TintMixin
	{
		return TintImplantation.clearTint(this);
	}

	/**
	 * Sets an additive tint on this Game Object.
	 *
	 * The tint works by taking the pixel color values from the Game Objects texture, and then
	 * multiplying it by the color value of the tint. You can provide either one color value,
	 * in which case the whole Game Object will be tinted in that color. Or you can provide a color
	 * per corner. The colors are blended together across the extent of the Game Object.
	 *
	 * To modify the tint color once set, either call this method again with new values or use the
	 * `tint` property to set all colors at once. Or, use the properties `tintTopLeft`, `tintTopRight,
	 * `tintBottomLeft` and `tintBottomRight` to set the corner color values independently.
	 *
	 * To remove a tint call `clearTint`.
	 *
	 * To swap this from being an additive tint to a fill based tint set the property `tintFill` to `true`.
	 *
	 * @webglOnly
	 * @since 1.0.0
	 *
	 * @param topLeft - The tint being applied to the top-left of the Game Object. If no other values are given this value is applied evenly, tinting the whole Game Object.
	 * @param topRight - The tint being applied to the top-right of the Game Object.
	 * @param bottomLeft - The tint being applied to the bottom-left of the Game Object.
	 * @param bottomRight - The tint being applied to the bottom-right of the Game Object.
	 *
	 * @return This Game Object instance.
	**/
	public function setTint(topLeft:Int = 0xffffff, ?topRight:Int, ?bottomLeft:Int,
			?bottomRight:Int):TintMixin
	{
		return TintImplantation.setTint(this, topLeft, topRight, bottomLeft, bottomRight);
	}

	/**
	 * Sets a fill-based tint on this Game Object.
	 *
	 * Unlike an additive tint, a fill-tint literally replaces the pixel colors from the texture
	 * with those in the tint. You can use this for effects such as making a player flash 'white'
	 * if hit by something. You can provide either one color value, in which case the whole
	 * Game Object will be rendered in that color. Or you can provide a color per corner. The colors
	 * are blended together across the extent of the Game Object.
	 *
	 * To modify the tint color once set, either call this method again with new values or use the
	 * `tint` property to set all colors at once. Or, use the properties `tintTopLeft`, `tintTopRight,
	 * `tintBottomLeft` and `tintBottomRight` to set the corner color values independently.
	 *
	 * To remove a tint call `clearTint`.
	 *
	 * To swap this from being a fill-tint to an additive tint set the property `tintFill` to `false`.
	 *
	 * @webglOnly
	 * @since 1.0.0
	 *
	 * @param topLeft - The tint being applied to the top-left of the Game Object. If not other values are given this value is applied evenly, tinting the whole Game Object.
	 * @param topRight - The tint being applied to the top-right of the Game Object.
	 * @param bottomLeft - The tint being applied to the bottom-left of the Game Object.
	 * @param bottomRight - The tint being applied to the bottom-right of the Game Object.
	 *
	 * @return This Game Object instance.
	**/
	public function setTintFill(topLeft:Int = 0xffffff, ?topRight:Int, ?bottomLeft:Int,
			?bottomRight:Int):TintMixin
	{
		return
			TintImplantation.setTintFill(this, topLeft, topRight, bottomLeft, bottomRight);
	}

	/**
	 * The tint value being applied to the top-left of the Game Object.
	 * This value is interpolated from the corner to the center of the Game Object.
	 *
	 * @webglOnly
	 * @since 1.0.0
	**/
	public var tintTopLeft(get, set):Int;

	/**
	 * The tint value being applied to the top-right of the Game Object.
	 * This value is interpolated from the corner to the center of the Game Object.
	 *
	 * @webglOnly
	 * @since 1.0.0
	**/
	public var tintTopRight(get, set):Int;

	/**
	 * The tint value being applied to the bottom-left of the Game Object.
	 * This value is interpolated from the corner to the center of the Game Object.
	 *
	 * @webglOnly
	 * @since 1.0.0
	**/
	public var tintBottomLeft(get, set):Int;

	/**
	 * The tint value being applied to the bottom-right of the Game Object.
	 * This value is interpolated from the corner to the center of the Game Object.
	 *
	 * @name Phaser.GameObjects.Components.Tint#tintBottomRight
	 * @type {integer}
	 * @webglOnly
	 * @since 1.0.0
	**/
	public var tintBottomRight(get, set):Int;

	/**
	 * The tint value being applied to the whole of the Game Object.
	 * This property is a setter-only. Use the properties `tintTopLeft` etc to read the current tint value.
	 *
	 * @webglOnly
	 * @since 1.0.0
	**/
	public var tint(never, set):Int;

	/**
	 * Does this Game Object have a tint applied to it or not?
	 *
	 * @webglOnly
	 * @since 1.0.0
	***/
	public var isTinted(get, never):Bool;

	private function get_tintTopLeft():Int
	{
		return TintImplantation.get_tintTopLeft(this);
	}

	private function set_tintTopLeft(value:Int):Int
	{
		return TintImplantation.set_tintTopLeft(this, value);
	}

	private function get_tintTopRight():Int
	{
		return TintImplantation.get_tintTopRight(this);
	}

	private function set_tintTopRight(value:Int):Int
	{
		return TintImplantation.set_tintTopRight(this, value);
	}

	private function get_tintBottomLeft():Int
	{
		return TintImplantation.get_tintBottomLeft(this);
	}

	private function set_tintBottomLeft(value:Int):Int
	{
		return TintImplantation.set_tintBottomLeft(this, value);
	}

	private function get_tintBottomRight():Int
	{
		return TintImplantation.get_tintBottomRight(this);
	}

	private function set_tintBottomRight(value:Int):Int
	{
		return TintImplantation.set_tintBottomRight(this, value);
	}

	private function set_tint(value:Int):Int
	{
		return TintImplantation.set_tint(this, value);
	}

	private function get_isTinted():Bool
	{
		return TintImplantation.get_isTinted(this);
	}
}
