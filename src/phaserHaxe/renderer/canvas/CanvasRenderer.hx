// package phaserHaxe.renderer.canvas;

// import phaserHaxe.Const;

// class CanvasRenderer
// {
// 	/**
// 	 * The Phaser Game instance that owns this renderer.
// 	 *
// 	 * @since 1.0.0
// 	**/
// 	public var game:Game;

// 	/**
// 	 * A constant which allows the renderer to be easily identified as a Canvas Renderer.
// 	 *
// 	 * @since 1.0.0
// 	**/
// 	public var type:Int = Const.CANVAS;

// 	/**
// 	 * The total number of Game Objects which were rendered in a frame.
// 	 *
// 	 * @since 1.0.0
// 	**/
// 	public var drawCount:Int = 0;

// 	/**
// 	 * The width of the canvas being rendered to.
// 	 *
// 	 * @since 1.0.0
// 	**/
// 	public var width:Int = 0;

// 	/**
// 	 * The height of the canvas being rendered to.
// 	 *
// 	 * @since 1.0.0
// 	**/
// 	public var height:Int = 0;

// 	/**
// 	 * The local configuration settings of the CanvasRenderer.
// 	 *
// 	 * @since 1.0.0
// 	**/
// 	public var config = {
// 		clearBeforeRender: game.config.clearBeforeRender,
// 		backgroundColor: game.config.backgroundColor,
// 		resolution: game.config.resolution,
// 		antialias: game.config.antialias,
// 		roundPixels: game.config.roundPixels
// 	};

// 	/**
// 	 * The scale mode which should be used by the CanvasRenderer.
// 	 *
// 	 * @since 1.0.0
// 	**/
// 	public var scaleMode = (game.config.antialias) ? ScaleModes.LINEAR : ScaleModes.NEAREST;

// 	/**
// 	 * The canvas element which the Game uses.
// 	 *
// 	 * @name Phaser.Renderer.Canvas.CanvasRenderer#gameCanvas
// 	 * @type {HTMLCanvasElement}
// 	 * @since 3.0.0
// 	 */
// 	this.gameCanvas = game.canvas;
// 	var contextOptions = {
// 		alpha: game.config.transparent,
// 		desynchronized: game.config.desynchronized
// 	};
// 	/**
// 	 * The canvas context used to render all Cameras in all Scenes during the game loop.
// 	 *
// 	 * @name Phaser.Renderer.Canvas.CanvasRenderer#gameContext
// 	 * @type {CanvasRenderingContext2D}
// 	 * @since 3.0.0
// 	 */
// 	this.gameContext = (this.game.config.context) ? this.game.config.context : this.gameCanvas.getContext('2d', contextOptions);
// 	/**
// 	 * The canvas context currently used by the CanvasRenderer for all rendering operations.
// 	 *
// 	 * @name Phaser.Renderer.Canvas.CanvasRenderer#currentContext
// 	 * @type {CanvasRenderingContext2D}
// 	 * @since 3.0.0
// 	 */
// 	this.currentContext = this.gameContext;
// 	/**
// 	 * The blend modes supported by the Canvas Renderer.
// 	 *
// 	 * This object maps the {@link Phaser.BlendModes} to canvas compositing operations.
// 	 *
// 	 * @name Phaser.Renderer.Canvas.CanvasRenderer#blendModes
// 	 * @type {array}
// 	 * @since 3.0.0
// 	 */
// 	this.blendModes = GetBlendModes();
// 	// image-rendering: optimizeSpeed;
// 	// image-rendering: pixelated;
// 	/**
// 	 * The scale mode currently in use by the Canvas Renderer.
// 	 *
// 	 * @name Phaser.Renderer.Canvas.CanvasRenderer#currentScaleMode
// 	 * @type {number}
// 	 * @default 0
// 	 * @since 3.0.0
// 	 */
// 	this.currentScaleMode = 0;
// 	/**
// 	 * Details about the currently scheduled snapshot.
// 	 *
// 	 * If a non-null `callback` is set in this object, a snapshot of the canvas will be taken after the current frame is fully rendered.
// 	 *
// 	 * @name Phaser.Renderer.Canvas.CanvasRenderer#snapshotState
// 	 * @type {Phaser.Types.Renderer.Snapshot.SnapshotState}
// 	 * @since 3.16.0
// 	 */
// 	this.snapshotState = {
// 		x: 0,
// 		y: 0,
// 		width: 1,
// 		height: 1,
// 		getPixel: false,
// 		callback: null,
// 		type: 'image/png',
// 		encoder: 0.92
// 	};
// 	/**
// 	 * A temporary Transform Matrix, re-used internally during batching.
// 	 *
// 	 * @name Phaser.Renderer.Canvas.CanvasRenderer#_tempMatrix1
// 	 * @private
// 	 * @type {Phaser.GameObjects.Components.TransformMatrix}
// 	 * @since 3.12.0
// 	 */
// 	this._tempMatrix1 = new TransformMatrix();
// 	/**
// 	 * A temporary Transform Matrix, re-used internally during batching.
// 	 *
// 	 * @name Phaser.Renderer.Canvas.CanvasRenderer#_tempMatrix2
// 	 * @private
// 	 * @type {Phaser.GameObjects.Components.TransformMatrix}
// 	 * @since 3.12.0
// 	 */
// 	this._tempMatrix2 = new TransformMatrix();
// 	/**
// 	 * A temporary Transform Matrix, re-used internally during batching.
// 	 *
// 	 * @name Phaser.Renderer.Canvas.CanvasRenderer#_tempMatrix3
// 	 * @private
// 	 * @type {Phaser.GameObjects.Components.TransformMatrix}
// 	 * @since 3.12.0
// 	 */
// 	this._tempMatrix3 = new TransformMatrix();
// 	/**
// 	 * A temporary Transform Matrix, re-used internally during batching.
// 	 *
// 	 * @name Phaser.Renderer.Canvas.CanvasRenderer#_tempMatrix4
// 	 * @private
// 	 * @type {Phaser.GameObjects.Components.TransformMatrix}
// 	 * @since 3.12.0
// 	 */
// 	this._tempMatrix4 = new TransformMatrix();
// }
