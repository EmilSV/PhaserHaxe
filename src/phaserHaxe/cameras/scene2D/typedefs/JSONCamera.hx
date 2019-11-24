package phaserHaxe.cameras.scene2D.typedefs;

/**
 * @since 1.0.0
**/
typedef JSONCamera =
{
	/**
	 * The name of the camera
	 *
	 * @since 1.0.0
	**/
	public var ?name:String;

	/**
	 * The horizontal position of camera
	 *
	 * @since 1.0.0
	**/
	public var ?x:Int;

	/**
	 * The vertical position of camera
	 *
	 * @since 1.0.0
	**/
	public var ?y:Int;

	/**
	 * The width size of camera
	 *
	 * @since 1.0.0
	**/
	public var ?width:Int;

	/**
	 * The height size of camera
	 *
	 * @since 1.0.0
	**/
	public var ?height:Int;

	/**
	 * The zoom of camera
	 *
	 * @since 1.0.0
	**/
	public var ?zoom:Float;

	/**
	 * The rotation of camera
	 *
	 * @since 1.0.0
	**/
	public var ?rotation:Float;

	/**
	 * The round pixels st status of camera
	 *
	 * @since 1.0.0
	**/
	public var ?roundPixels:Bool;

	/**
	 * The horizontal scroll of camera
	 *
	 * @since 1.0.0
	**/
	public var ?scrollX:Float;

	/**
	 * The vertical scroll of camera
	 *
	 * @since 1.0.0
	**/
	public var ?scrollY:Float;

	/**
	 * @since 1.0.0
	**/
	public var ?visible:Bool;

	/**
	 * The background color of camera
	 *
	 * @since 1.0.0
	**/
	public var ?backgroundColor:String;

	/**
	 * The bounds of camera
	 *
	 * @since 1.0.0
	**/
	public var ?bounds:
		{
			?x:Int,
			?y:Int,
			?width:Int,
			?height:Int
		};
};
