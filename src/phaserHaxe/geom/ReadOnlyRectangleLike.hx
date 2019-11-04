package phaserHaxe.geom;

/**
 * a object with a x and y component.
 *
 * @since 1.0.0
**/
typedef ReadOnlyRectangleLike =
{
	/**
	 * The x component of this object.
	 *
	 * @since 1.0.0
	**/
	var x(default, never):Float;

	/**
	 * The y component of this object.
	 *
	 * @since 1.0.0
	**/
	var y(default, never):Float;

	/**
	 * The height of the Rectangle, i.e. the distance
	 * between its top side (defined by `y`) and its bottom side.
	 *
	 * @since 1.0.0
	**/
	var width(default, never):Float;

	/**
	 * The height of the Rectangle, i.e. the distance
	 * between its top side (defined by `y`) and its bottom side.
	 *
	 * @since 1.0.0
	**/
	var height(default, never):Float;
}
