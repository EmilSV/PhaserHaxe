package phaserHaxe.core;

#if js
import js.html.webgl.PowerPreference;
#end

#if js
/**
 * @since 1.0.0
**/
@:structInit
typedef RenderConfig =
{
	/**
	 * When set to `true`, WebGL uses linear interpolation to draw scaled or rotated textures, giving a smooth appearance. When set to `false`, WebGL uses nearest-neighbor interpolation, giving a crisper appearance. `false` also disables antialiasing of the game canvas itself, if the browser supports it, when the game canvas is scaled.
	 *
	 * @since 1.0.0
	**/
	public var ?antialias:Bool;

	/**
	 * When set to `true` it will create a desynchronized context for both 2D and WebGL. See https://developers.google.com/web/updates/2019/05/desynchronized for details.
	 *
	 * @since 1.0.0
	**/
	public var ?desynchronized:Bool;

	/**
	 * Sets `antialias` and `roundPixels` to true. This is the best setting for pixel-art games.
	 *
	 * @since 1.0.0
	**/
	public var ?pixelArt:Bool;

	/**
	 * Draw texture-based Game Objects at only whole-integer positions. Game Objects without textures, like Graphics, ignore this property.
	 *
	 * @since 1.0.0
	**/
	public var ?roundPixels:Bool;

	/**
	 * Whether the game canvas will be transparent. Boolean that indicates if the canvas contains an alpha channel. If set to false, the browser now knows that the backdrop is always opaque, which can speed up drawing of transparent content and images.
	 *
	 * @since 1.0.0
	**/
	public var ?transparent:Bool;

	/**
	 * Whether the game canvas will be cleared between each rendering frame.
	 *
	 * @since 1.0.0
	**/
	public var ?clearBeforeRender:Bool;

	/**
	 * In WebGL mode, the drawing buffer contains colors with pre-multiplied alpha.
	 *
	 * @since 1.0.0
	**/
	public var ?premultipliedAlpha:Bool;

	/**
	 * Let the browser abort creating a WebGL context if it judges performance would be unacceptable.
	 *
	 * @since 1.0.0
	**/
	public var ?failIfMajorPerformanceCaveat:Bool;

	/**
	 * HIGH_PERFORMANCE , LOW_POWER or DEFAULT. A hint to the browser on how much device power the game might use.
	 *
	 * @since 1.0.0
	**/
	public var ?powerPreference:PowerPreference;

	/**
	 * The default WebGL batch size.
	 *
	 * @since 1.0.0
	**/
	public var ?batchSize:Int;

	/**
		*The maximum number of lights allowed to be visible within range of a single Camera in the LightManager.
		*
		* @since 1.0.0
	**/
	public var ?maxLights:Int;
}
#else
#end
