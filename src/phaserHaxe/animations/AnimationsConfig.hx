package phaserHaxe.animations;

/**
 *
 * @since 1.0.0
**/
typedef AnimationsConfig =
{
	/**
	 * An array of all Animations added to the Animation Manager.
	 *
	 * @since 1.0.0
	**/
	public var ?anims:Null<Array<JSONAnimation>>;

	/**
	 * The global time scale of the Animation Manager.
	 *
	 * @since 1.0.0
	**/
	public var ?globalTimeScale:Float;
}
