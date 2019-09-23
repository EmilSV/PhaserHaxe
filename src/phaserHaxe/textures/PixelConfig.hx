package phaserHaxe.textures;

/**
 * An object containing the position and color data for a single pixel in a CanvasTexture.
 *
 * @since 1.0.0
**/
@:structInit
final class PixelConfig
{
	/**
	 * The x-coordinate of the pixel.
	 *
	 * @since 1.0.0
	**/
	public var x:Int;

	/**
	 * The y-coordinate of the pixel.
	 *
	 * @since 1.0.0
	**/
	public var y:Int;

	/**
	 * The color of the pixel, not including the alpha channel.
	 *
	 * @since 1.0.0
	**/
	public var color:Int;

	/**
	 * The alpha of the pixel, between 0 and 1.
	 *
	 * @since 1.0.0
	**/
	public var alpha:Float;

	public function new(x:Int, y:Int, color:Int, alpha:Float)
	{
		this.x = x;
		this.y = y;
		this.color = color;
		this.alpha = alpha;
	}
}
