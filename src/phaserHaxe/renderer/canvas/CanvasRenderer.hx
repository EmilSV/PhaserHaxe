package phaserHaxe.renderer.canvas;

import js.html.CanvasRenderingContext2D;
import js.html.CanvasElement;
import phaserHaxe.display.Color;
import phaserHaxe.Const;
import phaserHaxe.renderer.Snapshot.SnapshotState;
import phaserHaxe.gameobjects.components.TransformMatrix;
import phaserHaxe.scale.Events as ScaleEvents;
import phaserHaxe.s

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

	/**
	 * The local configuration settings of the CanvasRenderer.
	 *
	 * @since 1.0.0
	**/
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

	/**
	 * Details about the currently scheduled snapshot.
	 *
	 * If a non-null `callback` is set in this object, a snapshot of the canvas will be taken after the current frame is fully rendered.
	 *
	 * @since 1.0.0
	**/
	public var snapshotState:SnapshotState;

	/**
	 * A temporary Transform Matrix, re-used internally during batching.
	 *
	 * @since 1.0.0
	**/
	private var _tempMatrix1:TransformMatrix;

	/**
	 * A temporary Transform Matrix, re-used internally during batching.
	 *
	 * @since 1.0.0
	**/
	private var _tempMatrix2:TransformMatrix;

	/**
	 * A temporary Transform Matrix, re-used internally during batching.
	 *
	 * @since 1.0.0
	**/
	private var _tempMatrix3:TransformMatrix;

	/**
	 * A temporary Transform Matrix, re-used internally during batching.
	 *
	 * @since 1.0.0
	**/
	private var _tempMatrix4:TransformMatrix;

	public function new(game:Game)
	{
		this.game = game;

		config = {
			clearBeforeRender: game.config.clearBeforeRender,
			backgroundColor: game.config.backgroundColor,
			resolution: game.config.resolution,
			antialias: game.config.antialias,
			roundPixels: game.config.roundPixels
		};

		scaleMode = (game.config.antialias) ? ScaleModes.LINEAR : ScaleModes.NEAREST;

		gameCanvas = game.canvas;

		var contextOptions = {
			alpha: game.config.transparent,
			desynchronized: game.config.desynchronized
		};

		gameContext = (game.config.context) ? game.config.context : gameCanvas.getContext('2d', contextOptions);

		currentContext = gameContext;

		blendModes = Canvas.getBlendModes();

		currentScaleMode = 0;

		snapshotState = {
			x: 0,
			y: 0,
			width: 1,
			height: 1,
			getPixel: false,
			callback: null,
			type: "image/png",
			encoder: 0.92
		};

		_tempMatrix1 = new TransformMatrix();
		_tempMatrix2 = new TransformMatrix();
		_tempMatrix3 = new TransformMatrix();
		_tempMatrix4 = new TransformMatrix();
	}

	/**
	 * Prepares the game canvas for rendering.
	 *
	 * @since 1.0.0
	**/
	public function init()
	{
		this.game.scale.on(ScaleEvents.RESIZE, this.onResize, this);

		var baseSize = this.game.scale.baseSize;

		this.resize(baseSize.width, baseSize.height);
	}

	/**
	 * The event handler that manages the `resize` event dispatched by the Scale Manager.
	 *
	 * @method Phaser.Renderer.Canvas.CanvasRenderer#onResize
	 * @since 3.16.0
	 *
	 * @param {Phaser.Structs.Size} gameSize - The default Game Size object. This is the un-modified game dimensions.
	 * @param {Phaser.Structs.Size} baseSize - The base Size object. The game dimensions multiplied by the resolution. The canvas width / height values match this.
	 * @param {Phaser.Structs.Size} displaySize - The display Size object. The size of the canvas style width / height attributes.
	 * @param {number} [resolution] - The Scale Manager resolution setting.
	 */
	public function onResize(gameSize, baseSize)
	{
		//  Has the underlying canvas size changed?
		if (baseSize.width != = this.width || baseSize.height != = this.height)
		{
			this.resize(baseSize.width, baseSize.height);
		}
	},}
