package phaserHaxe.renderer.canvas;

import js.html.CanvasRenderingContext2D;
import js.html.CanvasElement;
import phaserHaxe.display.Color;
import phaserHaxe.Const;

@:structInit
final class CanvasRendererConfig
{
	public var clearBeforeRender:Bool;
	public var backgroundColor:Color;
	public var resolution:Float;
	public var antialias:Bool;
	public var roundPixels:Bool;
}

class CanvasRenderer
{
	/**
	 * The Phaser Game instance that owns this renderer.
	 *
	 * @since 1.0.0
	**/
	public var game:Game;

	/**
	 * A constant which allows the renderer to be easily identified as a Canvas Renderer.
	 *
	 * @since 1.0.0
	**/
	public var type:Int = Const.CANVAS;

	/**
	 * The total number of Game Objects which were rendered in a frame.
	 *
	 * @since 1.0.0
	**/
	public var drawCount:Int = 0;

	/**
	 * The width of the canvas being rendered to.
	 *
	 * @since 1.0.0
	**/
	public var width:Int = 0;

	/**
	 * The height of the canvas being rendered to.
	 *
	 * @since 1.0.0
	**/
	public var height:Int = 0;

	public var config:CanvasRendererConfig;

	/**
	 * The scale mode which should be used by the CanvasRenderer.
	 *
	 * @since 1.0.0
	**/
	public var scaleMode:Int;

	/**
	 * The canvas element which the Game uses.
	 *
	 * @since 1.0.0
	**/
	public var gameCanvas:CanvasElement;

	/**
	 * The canvas context used to render all Cameras in all Scenes during the game loop.
	 *
	 * @since 1.0.0
	**/
	public var gameContext:CanvasRenderingContext2D;

	/**
	 * The canvas context currently used by the CanvasRenderer for all rendering operations.
	 *
	 * @since 1.0.0
	**/
	public var currentContext:CanvasRenderingContext2D;

	/**
	 * The blend modes supported by the Canvas Renderer.
	 *
	 * This object maps the {@link Phaser.BlendModes} to canvas compositing operations.
	 *
	 * @since 1.0.0
	**/
	public var blendModes:BlendModeMap;

	/**
	 * The scale mode currently in use by the Canvas Renderer.
	 *
	 * @since 1.0.0
	**/
	public var currentScaleMode:Int;

	public var snapshotState

	public function new(game:Game) {}
}
	