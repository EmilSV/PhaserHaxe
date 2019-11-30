package phaserHaxe.loader.filetypes.typedefs;

/**
 * @since 1.0.0
**/
typedef SVGSizeConfig =
{
	/**
	 * An optional width. The SVG will be resized to this size before being rendered to a texture.
	 *
	 * @since 1.0.0
	**/
	public var ?width:Int;

	/**
	 * An optional height. The SVG will be resized to this size before being rendered to a texture.
	 *
	 * @since 1.0.0
	**/
	public var ?height:Int;

	/**
	 * An optional scale. If given it overrides the width / height properties. The SVG is scaled by the scale factor before being rendered to a texture.
	 *
	 * @since 1.0.0
	**/
	public var ?scale:Float;
};
