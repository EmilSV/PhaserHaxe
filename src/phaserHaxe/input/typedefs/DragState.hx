package phaserHaxe.input.typedefs;

/**
 * @since 1.0.0
**/
enum abstract DragState(Int) from Int to Int
{
	/**
	 * Not being dragged
	 *
	 * @since 1.0.0
	**/
	var NO_DRAG = 0;

	/**
	 * Being checked for drag
	 *
	 * @since 1.0.0
	**/
	var CHECKED_DRAG = 1;

	/**
	 * Being actively dragged
	 *
	 * @since 1.0.0
	**/
	var ACTIVELY_DRAG = 2;
}
