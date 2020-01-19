package phaserHaxe.loader.filetypes.typedefs;

typedef ImageFrameConfig =
{
	/**
	 * The width of the frame in pixels.
	**/
	public var frameWidth:Int;

	/**
	 * The height of the frame in pixels. Uses the `frameWidth` value if not provided.
	**/
	public var ?frameHeight:Int;

	/**
	 * The first frame to start parsing from.
	**/
	public var ?startFrame:Int;

	/**
	 * The frame to stop parsing at. If not provided it will calculate the value based on the image and frame dimensions.
	**/
	public var ?endFrame:Int;

	/**
	 * The margin in the image. This is the space around the edge of the frames.
	**/
	public var ?margin:Int;

	/**
	 * The spacing between each frame in the image.
	**/
	public var ?spacing:Int;
};
