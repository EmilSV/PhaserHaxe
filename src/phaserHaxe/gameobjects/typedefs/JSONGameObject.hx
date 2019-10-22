package phaserHaxe.gameobjects.typedefs;

import phaserHaxe.renderer.BlendModes;
import phaserHaxe.utils.StringOrInt;

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

/**
 * @typedef {object} Phaser.Types.GameObjects.JSONGameObject
 * @since 3.0.0
 *
 * @property {string} name - The name of this Game Object.
 * @property {string} type - A textual representation of this Game Object, i.e. `sprite`.
 * @property {number} x - The x position of this Game Object.
 * @property {number} y - The y position of this Game Object.
 * @property {object} scale - The scale of this Game Object
 * @property {number} scale.x - The horizontal scale of this Game Object.
 * @property {number} scale.y - The vertical scale of this Game Object.
 * @property {object} origin - The origin of this Game Object.
 * @property {number} origin.x - The horizontal origin of this Game Object.
 * @property {number} origin.y - The vertical origin of this Game Object.
 * @property {boolean} flipX - The horizontally flipped state of the Game Object.
 * @property {boolean} flipY - The vertically flipped state of the Game Object.
 * @property {number} rotation - The angle of this Game Object in radians.
 * @property {number} alpha - The alpha value of the Game Object.
 * @property {boolean} visible - The visible state of the Game Object.
 * @property {integer} scaleMode - The Scale Mode being used by this Game Object.
 * @property {(integer|string)} blendMode - Sets the Blend Mode being used by this Game Object.
 * @property {string} textureKey - The texture key of this Game Object.
 * @property {string} frameKey - The frame key of this Game Object.
 * @property {object} data - The data of this Game Object.
 */
