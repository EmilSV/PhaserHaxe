package phaserHaxe.core;

import phaserHaxe.utils.types.StringOrInt;
import phaserHaxe.utils.types.Union;
import phaserHaxe.scale.ZoomType;
import phaserHaxe.scale.ScaleModeType;
import phaserHaxe.scale.CenterType;

#if js
import js.html.HtmlElement;
#else
typedef HtmlElement = Dynamic;
#end

/***
 * @since 1.0.0
**/
typedef ScaleConfig =
{
	/**
	 * The base width of your game. Can be an integer or a string: '100%'. If a string it will only work if you have set a parent element that has a size.
	 *
	 * @since 1.0.0
	**/
	public var ?width:StringOrInt;

	/**
	 * The base height of your game. Can be an integer or a string: '100%'. If a string it will only work if you have set a parent element that has a size.
	 *
	 * @since 1.0.0
	**/
	public var ?height:StringOrInt;

	/**
	 * The zoom value of the game canvas.
	 *
	 * @since 1.0.0
	**/
	public var ?zoom:ZoomType;

	/**
	 * The rendering resolution of the canvas. This is reserved for future use and is currently ignored.
	 *
	 * @since 1.0.0
	**/
	public var ?resolution:Float;

	/**
	 * The DOM element that will contain the game canvas, or its `id`. If undefined, or if the named element doesn't exist, the game canvas is inserted directly into the document body. If `null` no parent will be used and you are responsible for adding the canvas to your environment.
	 *
	 * @since 1.0.0
	**/
	public var ?parent:Union<HtmlElement, String>;

	/**
	 * Is the Scale Manager allowed to adjust the CSS height property of the parent and/or document body to be 100%?
	 *
	 * @since 1.0.0
	**/
	public var ?expandParent:Bool;

	/**
	 * The scale mode.
	 *
	 * @since 1.0.0
	**/
	public var ?mode:ScaleModeType;

	/**
	 * The minimum width and height the canvas can be scaled down to.
	 *
	 * @since 1.0.0
	**/
	public var ?min:WidthHeight;

	/**
	 * The maximum width the canvas can be scaled up to.
	 *
	 * @since 1.0.0
	**/
	public var ?max:WidthHeight;

	/**
	 * Automatically round the display and style sizes of the canvas. This can help with performance in lower-powered devices.
	 *
	 * @since 1.0.0
	**/
	public var ?autoRound:Bool;

	/**
	 * Automatically center the canvas within the parent?
	 *
	 * @since 1.0.0
	**/
	public var ?autoCenter:CenterType;

	/**
	 * How many ms should elapse before checking if the browser size has changed?
	 *
	 * @since 1.0.0
	**/
	public var ?resizeInterval:Int;

	/**
	 * The DOM element that will be sent into full screen mode, or its `id`. If undefined Phaser will create its own div and insert the canvas into it when entering fullscreen mode.
	 *
	 * @since 1.0.0
	**/
	public var ?fullscreenTarget:Union<HtmlElement, String>;
}
