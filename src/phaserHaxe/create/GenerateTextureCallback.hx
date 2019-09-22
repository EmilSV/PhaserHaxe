package phaserHaxe.create;

import js.html.CanvasElement as HTMLCanvasElement;
import js.html.CanvasRenderingContext2D;

/**
 * @since 1.0.0
 *
 * @param canvas - [description]
 * @param context - [description]
**/
typedef GenerateTextureCallback = (canvas:HTMLCanvasElement,
	context:CanvasRenderingContext2D) -> Void;
