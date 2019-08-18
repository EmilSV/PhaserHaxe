package phaserHaxe.core;

/**
 * @since 1.0.0
**/
@:structInit
final class BannerConfig
{
	/**
	 * Omit Phaser's name and version from the banner.
	 *
	 * @since 1.0.0
	**/
	public var hidePhaser:Bool = false;

	/**
	 * The color of the banner text.
	 *
	 * @since 1.0.0
	**/
	public var text:String = "#ffffff";

	/**
	 * The background colors of the banner.
	 *
	 * @since 1.0.0
	**/
	public var background:Array<String> = null;
}
