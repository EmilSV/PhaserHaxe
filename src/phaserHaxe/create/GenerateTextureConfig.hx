package phaserHaxe.create;

import phaserHaxe.create.Palette;
import js.html.CanvasElement as HTMLCanvasElement;
import phaserHaxe.create.GenerateTextureCallback;

/**
 * @since 1.0.0
**/
typedef GenerateTextureConfig =
{
	/**
	 * [description]
	 *
	 * @since 1.0.0
	**/
	var ?data:Array<Dynamic>;

	/**
	 * [description]
	 *
	 * @since 1.0.0
	**/
	var ?canvas:HTMLCanvasElement;

	/**
	 * [description]
	 *
	 * @since 1.0.0
	**/
	var ?palette:Palette;

	/**
	 * The width of each 'pixel' in the generated texture.
	 *
	 * @since 1.0.0
	**/
	var ?pixelWidth:Float;

	/**
	 * The height of each 'pixel' in the generated texture.
	 *
	 * @since 1.0.0
	**/
	var ?pixelHeight:Float;

	/**
	 * [description]
	 *
	 * @since 1.0.0
	**/
	var ?resizeCanvas:Bool;

	/**
	 * [description]
	 *
	 * @since 1.0.0
	**/
	var ?clearCanvas:Bool;

	/**
	 * [description]
	 *
	 * @since 1.0.0
	**/
	var ?preRender:GenerateTextureCallback;

	/**
	 * [description]
	 *
	 * @since 1.0.0
	**/
	var ?postRender:GenerateTextureCallback;
};
