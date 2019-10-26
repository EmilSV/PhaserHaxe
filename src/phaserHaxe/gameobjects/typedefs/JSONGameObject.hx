package phaserHaxe.gameobjects.typedefs;

import phaserHaxe.renderer.BlendModes;

/**
 * @since 1.0.0
**/
typedef JSONGameObject =
{
	/**
	 * The name of this Game Object.
	 *
	 * @since 1.0.0
	**/
	public var name:String;

	/**
	 * A textual representation of this Game Object, i.e. `sprite`.
	 *
	 * @since 1.0.0
	**/
	public var type:String;

	/**
	 * The x position of this Game Object.
	 *
	 * @since 1.0.0
	**/
	public var ?x:Float;

	/**
	 * The y position of this Game Object.
	 *
	 * @since 1.0.0
	**/
	public var ?y:Float;

	public var ?depth:Float;

	/**
	 * The scale of this Game Object
	 *
	 * @since 1.0.0
	**/
	public var ?scale:
		{
			/**
			 * The horizontal scale of this Game Object.
			 *
			 * @since 1.0.0
			**/
			public var x:Float;

			/**
			 * The vertical scale of this Game Object.
			 *
			 * @since 1.0.0
			**/
			public var y:Float;
		};

	/**
	 * The origin of this Game Object.
	 *
	 * @since 1.0.0
	**/
	public var ?origin:
		{
			/**
			 * The horizontal origin of this Game Object.
			 *
			 * @since 1.0.0
			**/
			public var x:Float;

			/**
			 * The vertical origin of this Game Object.
			 *
			 * @since 1.0.0
			**/
			public var y:Float;
		};

	/**
	 * The horizontally flipped state of the Game Object.
	 *
	 * @since 1.0.0
	**/
	public var ?flipX:Bool;

	/**
	 * The vertically flipped state of the Game Object.
	 *
	 * @since 1.0.0
	**/
	public var ?flipY:Bool;

	/**
	 * The angle of this Game Object in radians.
	 *
	 * @since 1.0.0
	**/
	public var ?rotation:Float;

	/**
	 * The alpha value of the Game Object.
	 *
	 * @since 1.0.0
	**/
	public var ?alpha:Float;

	/**
	 * The visible state of the Game Object.
	 *
	 * @since 1.0.0
	**/
	public var ?visible:Bool;

	/**
	 * The Scale Mode being used by this Game Object.
	 *
	 * @since 1.0.0
	**/
	public var ?scaleMode:Float;

	/**
	 * Sets the Blend Mode being used by this Game Object.
	 *
	 * @since 1.0.0
	**/
	public var ?blendMode:BlendModes;

	/**
	 * The texture key of this Game Object.
	 *
	 * @since 1.0.0
	**/
	public var ?textureKey:String;

	/**
	 * The frame key of this Game Object.
	 *
	 * @since 1.0.0
	**/
	public var ?frameKey:String;

	/**
	 * The data of this Game Object.
	 *
	 * @since 1.0.0
	**/
	public var ?data:Dynamic;
};
