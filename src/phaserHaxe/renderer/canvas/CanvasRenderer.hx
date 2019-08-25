package phaserHaxe.renderer.canvas;

import phaserHaxe.display.canvas.Smoothing;
import phaserHaxe.structs.Size;
import js.html.CanvasRenderingContext2D;
import js.html.CanvasElement;
import phaserHaxe.display.Color;
import phaserHaxe.Const;
import phaserHaxe.renderer.Snapshot.SnapshotState;
import phaserHaxe.gameobjects.components.TransformMatrix;
import phaserHaxe.scale.Events as ScaleEvents;
import phaserHaxe.renderer.Snapshot;
import phaserHaxe.math.MathInt;

@:structInit
final class CanvasRendererConfig
{
	public var clearBeforeRender:Bool;
	public var backgroundColor:Color;
	public var resolution:Float;
	public var antialias:Bool;
	public var roundPixels:Bool;
	public var transparent:Bool = false;
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
	 * @since 1.0.0
	 *
	 * @param gameSize - The default Game Size object. This is the un-modified game dimensions.
	 * @param baseSize - The base Size object. The game dimensions multiplied by the resolution. The canvas width / height values match this.
	 * @param displaySize - The display Size object. The size of the canvas style width / height attributes.
	 * @param resolution - The Scale Manager resolution setting.
	 */
	public function onResize(gameSize:Size, baseSize:Size):Void
	{
		//  Has the underlying canvas size changed?
		if (baseSize.width != width || baseSize.height != height)
		{
			resize(baseSize.width, baseSize.height);
		}
	}

	/**
	 * Resize the main game canvas.
	 *
	 * @method Phaser.Renderer.Canvas.CanvasRenderer#resize
	 * @since 3.0.0
	 *
	 * @param width - The new width of the renderer.
	 * @param height - The new height of the renderer.
	**/
	public function resize(width:Float, height:Float)
	{
		this.width = Std.int(width);
		this.height = Std.int(height);

		//  Resizing a canvas will reset imageSmoothingEnabled (and probably other properties)
		if (scaleMode == ScaleModes.NEAREST)
		{
			Smoothing.disable(gameContext);
		}
	}

	/**
	 * Resets the transformation matrix of the current context to the identity matrix, thus resetting any transformation.
	 *
	 * @since 1.0.0
	**/
	public function resetTransform():Void
	{
		currentContext.setTransform(1, 0, 0, 1, 0, 0);
	}

	/**
	 * Sets the blend mode (compositing operation) of the current context.
	 *
	 * @since 1.0.0
	 *
	 * @param blendMode - The new blend mode which should be used.
	 *
	 * @return This CanvasRenderer object.
	**/
	public function setBlendMode(blendMode:String):CanvasRenderer
	{
		currentContext.globalCompositeOperation = blendMode;
		return this;
	}

	/**
	 * Changes the Canvas Rendering Context that all draw operations are performed against.
	 *
	 * @since 1.0.0
	 *
	 * @param ctx - The new Canvas Rendering Context to draw everything to. Leave empty to reset to the Game Canvas.
	 *
	 * @return The Canvas Renderer instance.
	**/
	public function setContext(?ctx:CanvasRenderingContext2D):CanvasRenderer
	{
		currentContext = (ctx != null) ? ctx : gameContext;
		return this;
	}

	/**
	 * Sets the global alpha of the current context.
	 *
	 * @since 1.0.0
	 *
	 * @param alpha - The new alpha to use, where 0 is fully transparent and 1 is fully opaque.
	 *
	 * @return This CanvasRenderer object.
	**/
	public function setAlpha(alpha:Float):CanvasRenderer
	{
		currentContext.globalAlpha = alpha;
		return this;
	}

	/**
	 * Called at the start of the render loop.
	 *
	 * @since 1.0.0
	**/
	public function preRender():Void
	{
		var ctx = this.gameContext;
		var config = this.config;
		var width = this.width;
		var height = this.height;
		ctx.globalAlpha = 1;
		ctx.globalCompositeOperation = 'source-over';
		ctx.setTransform(1, 0, 0, 1, 0, 0);
		if (config.clearBeforeRender)
		{
			ctx.clearRect(0, 0, width, height);
		}
		if (!config.transparent)
		{
			ctx.fillStyle = config.backgroundColor.rgba;
			ctx.fillRect(0, 0, width, height);
		}
		ctx.save();
		drawCount = 0;
	}

	/**
	 * Restores the game context's global settings and takes a snapshot if one is scheduled.
	 *
	 * The post-render step happens after all Cameras in all Scenes have been rendered.
	 *
	 * @since 1.0.0
	**/
	public function postRender()
	{
		var ctx = this.gameContext;

		ctx.restore();

		var state = this.snapshotState;

		if (state.callback != null)
		{
			SnapShoot.canvas(this.gameCanvas, state);

			state.callback = null;
		}
	}

	/**
	 * Takes a snapshot of the given area of the given canvas.
	 *
	 * Unlike the other snapshot methods, this one is processed immediately and doesn't wait for the next render.
	 *
	 * Snapshots work by creating an Image object from the canvas data, this is a blocking process, which gets
	 * more expensive the larger the canvas size gets, so please be careful how you employ this in your game.
	 *
	 * @method Phaser.Renderer.Canvas.CanvasRenderer#snapshotCanvas
	 * @since 3.19.0
	 *
	 * @param {HTMLCanvasElement} canvas - The canvas to grab from.
	 * @param {Phaser.Types.Renderer.Snapshot.SnapshotCallback} callback - The Function to invoke after the snapshot image is created.
	 * @param {boolean} [getPixel=false] - Grab a single pixel as a Color object, or an area as an Image object?
	 * @param {integer} [x=0] - The x coordinate to grab from.
	 * @param {integer} [y=0] - The y coordinate to grab from.
	 * @param {integer} [width=canvas.width] - The width of the area to grab.
	 * @param {integer} [height=canvas.height] - The height of the area to grab.
	 * @param {string} [type='image/png'] - The format of the image to create, usually `image/png` or `image/jpeg`.
	 * @param {number} [encoderOptions=0.92] - The image quality, between 0 and 1. Used for image formats with lossy compression, such as `image/jpeg`.
	 *
	 * @return {this} This Canvas Renderer.
	**/
	function snapshotCanvas(canvas:CanvasElement, callback:SnapShootCallback,
			getPixel:Bool = false, x:Int = 0, y:Int = 0, ?width:Int, ?height:Int,
			type:String = 'image/png', encoderOptions:Float = 0.92)
	{
		this.snapshotArea(x, y, width, height, callback, type, encoderOptions);

		var state = this.snapshotState;

		state.getPixel = getPixel;

		SnapShoot.canvas(this.gameCanvas, state);

		state.callback = null;

		return this;
	}

	/**
	 * Schedules a snapshot of the given area of the game viewport to be taken after the current frame is rendered.
	 *
	 * To capture the whole game viewport see the `snapshot` method. To capture a specific pixel, see `snapshotPixel`.
	 *
	 * Only one snapshot can be active _per frame_. If you have already called `snapshotPixel`, for example, then
	 * calling this method will override it.
	 *
	 * Snapshots work by creating an Image object from the canvas data, this is a blocking process, which gets
	 * more expensive the larger the canvas size gets, so please be careful how you employ this in your game.
	 *
	 * @method Phaser.Renderer.Canvas.CanvasRenderer#snapshotArea
	 * @since 3.16.0
	 *
	 * @param {integer} x - The x coordinate to grab from.
	 * @param {integer} y - The y coordinate to grab from.
	 * @param {integer} width - The width of the area to grab.
	 * @param {integer} height - The height of the area to grab.
	 * @param {Phaser.Types.Renderer.Snapshot.SnapshotCallback} callback - The Function to invoke after the snapshot image is created.
	 * @param {string} [type='image/png'] - The format of the image to create, usually `image/png` or `image/jpeg`.
	 * @param {number} [encoderOptions=0.92] - The image quality, between 0 and 1. Used for image formats with lossy compression, such as `image/jpeg`.
	 *
	 * @return {this} This WebGL Renderer.
	**/
	public function snapshotArea(x, y, width, height, callback, type, encoderOptions)
	{
		var state = this.snapshotState;

		state.callback = callback;
		state.type = type;
		state.encoder = encoderOptions;
		state.getPixel = false;
		state.x = x;
		state.y = y;
		state.width = MathInt.min(width, this.gameCanvas.width);
		state.height = MathInt.min(height, this.gameCanvas.height);

		return this;
	}
}
