package phaserHaxe.input.keyboard.typedefs;

/**
 * @since 1.0.0
**/
typedef KeyComboConfig =
{
	/**
	 * If they press the wrong key do we reset the combo?
	 *
	 * @since 1.0.0
	**/
	public var ?resetOnWrongKey:Bool;

	/**
	 * The max delay in ms between each key press. Above this the combo is reset. 0 means disabled.
	 *
	 * @since 1.0.0
	**/
	public var ?maxKeyDelay:Int;

	/**
	 * If previously matched and they press the first key of the combo again, will it reset?
	 *
	 * @since 1.0.0
	**/
	public var ?resetOnMatch:Bool;

	/**
	 * If the combo matches, will it delete itself?
	 *
	 * @since 1.0.0
	**/
	public var ?deleteOnMatch:Bool;
};
