package phaserHaxe.renderer;

enum abstract BlendModes(Int) from Int to Int
{
	/**
	 * Skips the Blend Mode check in the renderer.
	 *
	 * @since 1.0.0
	**/
	var SKIP_CHECK = -1;

	/**
	 * Normal blend mode. For Canvas and WebGL.
	 * This is the default setting and draws new shapes on top of the existing canvas content.
	 *
	 * @since 1.0.0
	**/
	var NORMAL = 0;

	/**
	 * Add blend mode. For Canvas and WebGL.
	 * Where both shapes overlap the color is determined by adding color values.
	 *
	 * @since 1.0.0
	**/
	var ADD = 1;

	/**
	 * Multiply blend mode. For Canvas and WebGL.
	 * The pixels are of the top layer are multiplied with the corresponding pixel of the bottom layer. A darker picture is the result.
	 *
	 * @since 1.0.0
	**/
	var MULTIPLY = 2;

	/**
	 * Screen blend mode. For Canvas and WebGL.
	 * The pixels are inverted; multiplied; and inverted again. A lighter picture is the result (opposite of multiply)
	 *
	 * @since 1.0.0
	**/
	var SCREEN = 3;

	/**
	 * Overlay blend mode. For Canvas only.
	 * A combination of multiply and screen. Dark parts on the base layer become darker; and light parts become lighter.
	 *
	 * @since 1.0.0
	**/
	var OVERLAY = 4;

	/**
	 * Darken blend mode. For Canvas only.
	 * Retains the darkest pixels of both layers.
	 *
	 * @since 1.0.0
	**/
	var DARKEN = 5;

	/**
	 * Lighten blend mode. For Canvas only.
	 * Retains the lightest pixels of both layers.
	 *
	 * @since 1.0.0
	**/
	var LIGHTEN = 6;

	/**
	 * Color Dodge blend mode. For Canvas only.
	 * Divides the bottom layer by the inverted top layer.
	 *
	 * @since 1.0.0
	**/
	var COLOR_DODGE = 7;

	/**
	 * Color Burn blend mode. For Canvas only.
	 * Divides the inverted bottom layer by the top layer; and then inverts the result.
	 *
	 * @since 1.0.0
	**/
	var COLOR_BURN = 8;

	/**
	 * Hard Light blend mode. For Canvas only.
	 * A combination of multiply and screen like overlay; but with top and bottom layer swapped.
	 *
	 * @since 1.0.0
	**/
	var HARD_LIGHT = 9;

	/**
	 * Soft Light blend mode. For Canvas only.
	 * A softer version of hard-light. Pure black or white does not result in pure black or white.
	 *
	 * @since 1.0.0
	**/
	var SOFT_LIGHT = 10;

	/**
	 * Difference blend mode. For Canvas only.
	 * Subtracts the bottom layer from the top layer or the other way round to always get a positive value.
	 *
	 * @since 1.0.0
	**/
	var DIFFERENCE = 11;

	/**
	 * Exclusion blend mode. For Canvas only.
	 * Like difference; but with lower contrast.
	 *
	 * @since 1.0.0
	**/
	var EXCLUSION = 12;

	/**
	 * Hue blend mode. For Canvas only.
	 * Preserves the luma and chroma of the bottom layer; while adopting the hue of the top layer.
	 *
	 * @since 1.0.0
	**/
	var HUE = 13;

	/**
	 * Saturation blend mode. For Canvas only.
	 * Preserves the luma and hue of the bottom layer; while adopting the chroma of the top layer.
	 *
	 * @since 1.0.0
	**/
	var SATURATION = 14;

	/**
	 * Color blend mode. For Canvas only.
	 * Preserves the luma of the bottom layer; while adopting the hue and chroma of the top layer.
	 *
	 * @since 1.0.0
	**/
	var COLOR = 15;

	/**
	 * Luminosity blend mode. For Canvas only.
	 * Preserves the hue and chroma of the bottom layer; while adopting the luma of the top layer.
	 *
	 * @since 1.0.0
	**/
	var LUMINOSITY = 16;

	/**
	 * Alpha erase blend mode. For Canvas and WebGL.
	 *
	 * @since 1.0.0
	**/
	var ERASE = 17;

	/**
	 * Source-in blend mode. For Canvas only.
	 * The new shape is drawn only where both the new shape and the destination canvas overlap. Everything else is made transparent.
	 *
	 * @since 1.0.0
	**/
	var SOURCE_IN = 18;

	/**
	 * Source-out blend mode. For Canvas only.
	 * The new shape is drawn where it doesn't overlap the existing canvas content.
	 *
	 * @since 1.0.0
	**/
	var SOURCE_OUT = 19;

	/**
	 * Source-out blend mode. For Canvas only.
	 * The new shape is only drawn where it overlaps the existing canvas content.
	 *
	 * @since 1.0.0
	**/
	var SOURCE_ATOP = 20;

	/**
	 * Destination-over blend mode. For Canvas only.
	 * New shapes are drawn behind the existing canvas content.
	 *
	 * @since 1.0.0
	**/
	var DESTINATION_OVER = 21;

	/**
	 * Destination-in blend mode. For Canvas only.
	 * The existing canvas content is kept where both the new shape and existing canvas content overlap. Everything else is made transparent.
	 *
	 * @since 1.0.0
	**/
	var DESTINATION_IN = 22;

	/**
	 * Destination-out blend mode. For Canvas only.
	 * The existing content is kept where it doesn't overlap the new shape.
	 *
	 * @since 1.0.0
	**/
	var DESTINATION_OUT = 23;

	/**
	 * Destination-out blend mode. For Canvas only.
	 * The existing canvas is only kept where it overlaps the new shape. The new shape is drawn behind the canvas content.
	 *
	 * @since 1.0.0
	**/
	var DESTINATION_ATOP = 24;

	/**
	 * Lighten blend mode. For Canvas only.
	 * Where both shapes overlap the color is determined by adding color values.
	 *
	 * @since 1.0.0
	**/
	var LIGHTER = 25;

	/**
	 * Copy blend mode. For Canvas only.
	 * Only the new shape is shown.
	 *
	 * @since 1.0.0
	**/
	var COPY = 26;

	/**
	 * Xor blend mode. For Canvas only.
	 * Shapes are made transparent where both overlap and drawn normal everywhere else.
	 *
	 * @since 1.0.0
	**/
	var XOR = 27;
}
