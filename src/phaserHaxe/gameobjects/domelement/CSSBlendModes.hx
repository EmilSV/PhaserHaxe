package phaserHaxe.gameobjects.domelement;

import haxe.ds.ReadOnlyArray;

/**
 * Phaser Blend Modes to CSS Blend Modes Map.
 *
 * @since 1.0.0
**/
final class CSSBlendModes
{
	public static final values:ReadOnlyArray<String> = [
		"normal", "multiply", "multiply", "screen", "overlay", "darken", "lighten",
		"color-dodge", "color-burn", "hard-light", "soft-light", "difference",
		"exclusion", "hue", "saturation", "color", "luminosity"
	];
}
