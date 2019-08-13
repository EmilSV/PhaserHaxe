package phaserHaxe.gameobjects.components;

import phaserHaxe.renderer.BlendModes;

/**
 * Provides methods used for setting the blend mode of a Game Object.
 * Should be applied as a mixin and not used directly.
 *
 * @since 1.0.0
**/
@:allow(phaserHaxe.gameobjects.components.BlendModeImplantation)
interface IBlendMode
{
	/**
	 * Private internal value. Holds the current blend mode.
	 *
	 * @since 1.0.0
	**/
	private var _blendMode:BlendModes;

	/**
	 * Sets the Blend Mode being used by this Game Object.
	 *
	 * This can be a const, such as `Phaser.BlendModes.SCREEN`, or an integer, such as 4 (for Overlay)
	 *
	 * Under WebGL only the following Blend Modes are available:
	 *
	 * * ADD
	 * * MULTIPLY
	 * * SCREEN
	 * * ERASE
	 *
	 * Canvas has more available depending on browser support.
	 *
	 * You can also create your own custom Blend Modes in WebGL.
	 *
	 * Blend modes have different effects under Canvas and WebGL, and from browser to browser, depending
	 * on support. Blend Modes also cause a WebGL batch flush should it encounter a new blend mode. For these
	 * reasons try to be careful about the construction of your Scene and the frequency of which blend modes
	 * are used.
	 *
	 * @since 1.0.0
	**/
	public var blendMode(get, set):BlendModes;

	/**
	 * Sets the Blend Mode being used by this Game Object.
	 *
	 * This can be a const, such as `Phaser.BlendModes.SCREEN`, or an integer, such as 4 (for Overlay)
	 *
	 * Under WebGL only the following Blend Modes are available:
	 *
	 * * ADD
	 * * MULTIPLY
	 * * SCREEN
	 * * ERASE (only works when rendering to a framebuffer, like a Render Texture)
	 *
	 * Canvas has more available depending on browser support.
	 *
	 * You can also create your own custom Blend Modes in WebGL.
	 *
	 * Blend modes have different effects under Canvas and WebGL, and from browser to browser, depending
	 * on support. Blend Modes also cause a WebGL batch flush should it encounter a new blend mode. For these
	 * reasons try to be careful about the construction of your Scene and the frequency in which blend modes
	 * are used.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The BlendMode value.
	 *
	 * @return This Game Object instance.
	**/
	public function setBlendMode(value:BlendModes):IBlendMode;
}

final class BlendModeImplantation
{
	public static inline function get_blendMode<T:IBlendMode>(self:T):BlendModes
	{
		return self._blendMode;
	}

	public static inline function set_blendMode<T:IBlendMode>(self:T,
			value:BlendModes):BlendModes
	{
		self.blendMode = value;

		value = Compatibility.forceIntValue(value);
		if ((value : Int) >= -1)
		{
			self._blendMode = value;
		}

		return self._blendMode;
	}

	public static inline function setBlendMode<T:IBlendMode>(self:T, value:BlendModes):T
	{
		self.blendMode = value;
		return self;
	}
}

class BlendModeMixin implements IBlendMode
{
	/**
	 * Private internal value. Holds the current blend mode.
	 *
	 * @since 1.0.0
	**/
	private var _blendMode:BlendModes;

	/**
	 * Sets the Blend Mode being used by this Game Object.
	 *
	 * This can be a const, such as `Phaser.BlendModes.SCREEN`, or an integer, such as 4 (for Overlay)
	 *
	 * Under WebGL only the following Blend Modes are available:
	 *
	 * * ADD
	 * * MULTIPLY
	 * * SCREEN
	 * * ERASE
	 *
	 * Canvas has more available depending on browser support.
	 *
	 * You can also create your own custom Blend Modes in WebGL.
	 *
	 * Blend modes have different effects under Canvas and WebGL, and from browser to browser, depending
	 * on support. Blend Modes also cause a WebGL batch flush should it encounter a new blend mode. For these
	 * reasons try to be careful about the construction of your Scene and the frequency of which blend modes
	 * are used.
	 *
	 * @since 1.0.0
	**/
	public var blendMode(get, set):BlendModes;

	private inline function get_blendMode():BlendModes
	{
		return BlendModeImplantation.get_blendMode(this);
	}

	private inline function set_blendMode(value:BlendModes):BlendModes
	{
		return BlendModeImplantation.set_blendMode(this, value);
	}

	/**
	 * Sets the Blend Mode being used by this Game Object.
	 *
	 * This can be a const, such as `Phaser.BlendModes.SCREEN`, or an integer, such as 4 (for Overlay)
	 *
	 * Under WebGL only the following Blend Modes are available:
	 *
	 * * ADD
	 * * MULTIPLY
	 * * SCREEN
	 * * ERASE (only works when rendering to a framebuffer, like a Render Texture)
	 *
	 * Canvas has more available depending on browser support.
	 *
	 * You can also create your own custom Blend Modes in WebGL.
	 *
	 * Blend modes have different effects under Canvas and WebGL, and from browser to browser, depending
	 * on support. Blend Modes also cause a WebGL batch flush should it encounter a new blend mode. For these
	 * reasons try to be careful about the construction of your Scene and the frequency in which blend modes
	 * are used.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The BlendMode value.
	 *
	 * @return This Game Object instance.
	**/
	public function setBlendMode(value:BlendModes):BlendModeMixin
	{
		return BlendModeImplantation.setBlendMode(this, value);
	}
}
