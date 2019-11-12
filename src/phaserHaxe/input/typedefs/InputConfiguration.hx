package phaserHaxe.input.typedefs;

/**
 * @since 1.0.0
**/
typedef InputConfiguration =
{
	/**
	 * The object / shape to use as the Hit Area.
	 * If not given it will try to create a Rectangle based on the texture frame.
	 *
	 * @since 1.0.0
	**/
	public var ?hitArea:Any;

	/**
	 * The callback that determines if the pointer is within the Hit Area shape or not.
	 *
	 * @since 1.0.0
	**/
	public var ?hitAreaCallback:HitAreaCallback;

	/**
	 * If `true` the Interactive Object will be set to be draggable and emit drag events.
	 *
	 * @since 1.0.0
	**/
	public var ?draggable:Bool;

	/**
	 * If `true` the Interactive Object will be set to be a drop zone for draggable objects.
	 *
	 * @since 1.0.0
	**/
	public var ?dropZone:Bool;

	/**
	 * If `true` the Interactive Object will set the `pointer` hand cursor when a pointer is over it.
	 * This is a short-cut for setting `cursor: 'pointer'`.
	 *
	 * @since 1.0.0
	**/
	public var ?useHandCursor:Bool;

	/**
	 * The CSS string to be used when the cursor is over this Interactive Object.
	 *
	 * @since 1.0.0
	**/
	public var ?cursor:String;

	/**
	 * If `true` the a pixel perfect function will be set for the hit area callback.
	 * Only works with texture based Game Objects.
	 *
	 * @since 1.0.0
	**/
	public var ?pixelPerfect:Bool;

	/**
	 * If `pixelPerfect` is set, this is the alpha tolerance threshold value used in the callback.
	 *
	 * @since 1.0.0
	**/
	public var ?alphaTolerance:Int;
};
