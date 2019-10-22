package phaserHaxe.gameobjects.bitmaptext.typedefs;

import phaserHaxe.gameobjects.bitmaptext.DynamicBitmapText;

/**
 *
 * @since 1.0.0
**/
typedef DisplayCallbackConfig =
{
	/**
	 * The Dynamic Bitmap Text object that owns this character being rendered.
	 *
	 * @since 1.0.0
	**/
	public var parent:DynamicBitmapText;

	/**
	 * The tint of the character being rendered. Always zero in Canvas.
	 *
	 * @since 1.0.0
	**/
	public var tint:TintConfig;

	/**
	 * The index of the character being rendered.
	 *
	 * @since 1.0.0
	**/
	public var index:Float;

	/**
	 * The character code of the character being rendered.
	 *
	 * @since 1.0.0
	**/
	public var charCode:Int;

	/**
	 * The x position of the character being rendered.
	 *
	 * @since 1.0.0
	**/
	public var x:Float;

	/**
	 * The y position of the character being rendered.
	 *
	 * @since 1.0.0
	**/
	public var y:Float;

	/**
	 * The scale of the character being rendered.
	 *
	 * @since 1.0.0
	**/
	public var scale:Float;

	/**
	 * The rotation of the character being rendered.
	 *
	 * @since 1.0.0
	**/
	public var rotation:Float;

	public var color:Int;

	/**
	 * Custom data stored with the character being rendered.
	 *
	 * @since 1.0.0
	**/
	public var data:Dynamic;
};


