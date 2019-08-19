package phaserHaxe.physics.arcade;

/**
 * @since 1.0.0
**/
@:structInit
class CheckCollisionObject
{
	/**
	 * Will bodies collide with the top side of the world bounds?
	 * @since 1.0.0
	**/
	public var up:Bool;

	/**
	 *  Will bodies collide with the bottom side of the world bounds?
	 * @since 1.0.0
	**/
	public var down:Bool;

	/**
	 * Will bodies collide with the left side of the world bounds?
	**/
	public var left:Bool;

	/**
		*Will bodies collide with the right side of the world bounds?
		* @since 1.0.0
	**/
	public var right:Bool;
}
