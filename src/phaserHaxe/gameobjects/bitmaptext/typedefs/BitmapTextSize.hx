package phaserHaxe.gameobjects.bitmaptext.typedefs;

/**
 *
 * @since 1.0.0
**/
typedef BitmapTextSize =
{
	/**
	 * The position and size of the BitmapText,
	 * taking into account the position and scale of the Game Object.
	 *
	 * @since 1.0.0
	**/
	public var global:GlobalBitmapTextSize;

	/**
	 * The position and size of the BitmapText,
	 * taking just the font size into account.
	 *
	 * @since 1.0.0
	**/
	public var local:LocalBitmapTextSize;

	public var ?lines:
		{
			shortest:Float,
			longest:Float,
			lengths:Dynamic
		};
};
