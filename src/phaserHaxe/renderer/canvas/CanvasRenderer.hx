package phaserHaxe.renderer.canvas;

import phaserHaxe.gameobjects.sprite.Sprite;
import phaserHaxe.gameobjects.GameObject;
import phaserHaxe.textures.Frame;
import phaserHaxe.cameras.scene2D.Camera;
import phaserHaxe.display.canvas.Smoothing;
import phaserHaxe.structs.Size;
import phaserHaxe.display.Color;
import phaserHaxe.Const;
import phaserHaxe.renderer.Snapshot.SnapshotState;
import phaserHaxe.gameobjects.components.TransformMatrix;
import phaserHaxe.scale.Events as ScaleEvents;
import phaserHaxe.renderer.Snapshot;
import phaserHaxe.math.MathInt;
#if js
import js.html.CanvasRenderingContext2D;
import js.html.CanvasElement;
#end

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

#if js
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
	 * Renders the Scene to the given Camera.
	 *
	 * @since 1.0.0
	 *
	 * @param scene - The Scene to render.
	 * @param children - The Game Objects within the Scene to be rendered.
	 * @param interpolationPercentage - The interpolation percentage to apply. Currently unused.
	 * @param camera - The Scene Camera to render with.
	**/
	public function render(scene:Scene, children, interpolationPercentage, camera)
	{
		// var list = children.list;
		// var childCount = list.length;
		// var cx = camera._cx;
		// var cy = camera._cy;
		// var cw = camera._cw;
		// var ch = camera._ch;
		// var ctx = (camera.renderToTexture) ? camera.context : scene.sys.context;
		// //  Save context pre-clip
		// ctx.save();
		// if (this.game.scene.customViewports)
		// {
		// 	ctx.beginPath();
		// 	ctx.rect(cx, cy, cw, ch);
		// 	ctx.clip();
		// }
		// this.currentContext = ctx;
		// var mask = camera.mask;
		// if (mask)
		// {
		// 	mask.preRenderCanvas(this, null, camera._maskCamera);
		// }
		// if (!camera.transparent)
		// {
		// 	ctx.fillStyle = camera.backgroundColor.rgba;
		// 	ctx.fillRect(cx, cy, cw, ch);
		// }
		// ctx.globalAlpha = camera.alpha;
		// ctx.globalCompositeOperation = 'source-over';
		// this.drawCount += list.length;
		// if (camera.renderToTexture)
		// {
		// 	camera.emit(CameraEvents.PRE_RENDER, camera);
		// }
		// camera.matrix.copyToContext(ctx);

		// for (i in 0...childCount)
		// {
		// 	var child = list[i];
		// 	if (!child.willRender(camera))
		// 	{
		// 		continue;
		// 	}
		// 	if (child.mask)
		// 	{
		// 		child.mask.preRenderCanvas(this, child, camera);
		// 	}
		// 	child.renderCanvas(this, child, interpolationPercentage, camera);
		// 	if (child.mask)
		// 	{
		// 		child.mask.postRenderCanvas(this, child, camera);
		// 	}
		// }

		// ctx.setTransform(1, 0, 0, 1, 0, 0);
		// ctx.globalCompositeOperation = 'source-over';
		// ctx.globalAlpha = 1;
		// camera.flashEffect.postRenderCanvas(ctx);
		// camera.fadeEffect.postRenderCanvas(ctx);
		// camera.dirty = false;
		// if (mask)
		// {
		// 	mask.postRenderCanvas(this);
		// }
		// //  Restore pre-clip context
		// ctx.restore();
		// if (camera.renderToTexture)
		// {
		// 	camera.emit(CameraEvents.POST_RENDER, camera);
		// 	scene.sys.context.drawImage(camera.canvas, cx, cy);
		// }
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
	 * @since 1.0.0
	 *
	 * @param canvas - The canvas to grab from.
	 * @param callback - The Function to invoke after the snapshot image is created.
	 * @param getPixel - Grab a single pixel as a Color object, or an area as an Image object?
	 * @param x - The x coordinate to grab from.
	 * @param y - The y coordinate to grab from.
	 * @param width - The width of the area to grab.
	 * @param height - The height of the area to grab.
	 * @param type - The format of the image to create, usually `image/png` or `image/jpeg`.
	 * @param encoderOptions - The image quality, between 0 and 1. Used for image formats with lossy compression, such as `image/jpeg`.
	 *
	 * @return This Canvas Renderer.
	**/
	public function snapshotCanvas(canvas:CanvasElement, callback:SnapShootCallback,
			getPixel:Bool = false, x:Int = 0, y:Int = 0, ?width:Int, ?height:Int,
			type:String = 'image/png', encoderOptions:Float = 0.92)
	{
		snapshotArea(x, y, width, height, callback, type, encoderOptions);

		var state = this.snapshotState;

		state.getPixel = getPixel;

		SnapShoot.canvas(gameCanvas, state);

		state.callback = null;

		return this;
	}

	/**
	 * Schedules a snapshot of the entire game viewport to be taken after the current frame is rendered.
	 *
	 * To capture a specific area see the `snapshotArea` method. To capture a specific pixel, see `snapshotPixel`.
	 *
	 * Only one snapshot can be active _per frame_. If you have already called `snapshotPixel`, for example, then
	 * calling this method will override it.
	 *
	 * Snapshots work by creating an Image object from the canvas data, this is a blocking process, which gets
	 * more expensive the larger the canvas size gets, so please be careful how you employ this in your game.
	 *
	 * @since 1.0.0
	 *
	 * @param callback - The Function to invoke after the snapshot image is created.
	 * @param type - The format of the image to create, usually `image/png` or `image/jpeg`.
	 * @param encoderOptions - The image quality, between 0 and 1. Used for image formats with lossy compression, such as `image/jpeg`.
	 *
	 * @return This WebGL Renderer.
	**/
	public function snapshot(callback:SnapShootCallback, type:String = "image/png",
			encoderOptions:Float = 0.92)
	{
		return snapshotArea(0, 0, gameCanvas.width, gameCanvas.height, callback, type,
			encoderOptions);
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
	 * @since 1.0.0
	 *
	 * @param x - The x coordinate to grab from.
	 * @param y - The y coordinate to grab from.
	 * @param width - The width of the area to grab.
	 * @param height - The height of the area to grab.
	 * @param callback - The Function to invoke after the snapshot image is created.
	 * @param type - The format of the image to create, usually `image/png` or `image/jpeg`.
	 * @param encoderOptions - The image quality, between 0 and 1. Used for image formats with lossy compression, such as `image/jpeg`.
	 *
	 * @return This WebGL Renderer.
	**/
	public function snapshotArea(x:Int, y:Int, width:Int, height:Int,
			callback:SnapShootCallback, type:String = "image/png",
			encoderOptions:Float = 0.92):CanvasRenderer
	{
		var state = this.snapshotState;

		state.callback = callback;
		state.type = type;
		state.encoder = encoderOptions;
		state.getPixel = false;
		state.x = x;
		state.y = y;
		state.width = MathInt.min(width, gameCanvas.width);
		state.height = MathInt.min(height, gameCanvas.height);

		return this;
	}

	/**
	 * Schedules a snapshot of the given pixel from the game viewport to be taken after the current frame is rendered.
	 *
	 * To capture the whole game viewport see the `snapshot` method. To capture a specific area, see `snapshotArea`.
	 *
	 * Only one snapshot can be active _per frame_. If you have already called `snapshotArea`, for example, then
	 * calling this method will override it.
	 *
	 * Unlike the other two snapshot methods, this one will return a `Color` object containing the color data for
	 * the requested pixel. It doesn't need to create an internal Canvas or Image object, so is a lot faster to execute,
	 * using less memory.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The x coordinate of the pixel to get.
	 * @param y - The y coordinate of the pixel to get.
	 * @param callback - The Function to invoke after the snapshot pixel data is extracted.
	 *
	 * @return This WebGL Renderer.
	**/
	public function snapshotPixel(x:Int, y:Int, callback:SnapShootCallback)
	{
		this.snapshotArea(x, y, 1, 1, callback);
		this.snapshotState.getPixel = true;
		return this;
	}

	/**
	 * Takes a Sprite Game Object, or any object that extends it, and draws it to the current context.
	 *
	 * @since 1.0.0
	 *
	 * @param sprite - The texture based Game Object to draw.
	 * @param frame - The frame to draw, doesn't have to be that owned by the Game Object.
	 * @param camera - The Camera to use for the rendering transform.
	 * @param parentTransformMatrix - The transform matrix of the parent container, if set.
	 */
	public function batchSprite(sprite:Sprite, frame:Frame, camera:Camera,
			?parentTransformMatrix:TransformMatrix)
	{
		var alpha = camera.alpha * sprite.alpha;

		if (alpha == 0)
		{
			//  Nothing to see, so abort early
			return;
		}

		var ctx = this.currentContext;

		var camMatrix = this._tempMatrix1;
		var spriteMatrix = this._tempMatrix2;
		var calcMatrix = this._tempMatrix3;

		var cd = frame.canvasData;

		var frameX = cd.x;
		var frameY = cd.y;
		var frameWidth:Float = frame.cutWidth;
		var frameHeight:Float = frame.cutHeight;
		var customPivot = frame.customPivot;

		var res = frame.source.resolution;

		var displayOriginX = sprite.displayOriginX;
		var displayOriginY = sprite.displayOriginY;

		var x:Float = -displayOriginX + frame.x;
		var y:Float = -displayOriginY + frame.y;

		if (sprite.isCropped)
		{
			var crop = sprite._crop;

			if (crop.flipX != sprite.flipX || crop.flipY != sprite.flipY)
			{
				frame.updateCropUVs(cast crop, sprite.flipX, sprite.flipY);
			}

			frameWidth = crop.cw;
			frameHeight = crop.ch;

			frameX = crop.cx;
			frameY = crop.cy;

			x = -displayOriginX + crop.x;
			y = -displayOriginY + crop.y;

			if (sprite.flipX)
			{
				if (x >= 0)
				{
					x = -(x + frameWidth);
				}
				else if (x < 0)
				{
					x = (Math.abs(x) - frameWidth);
				}
			}

			if (sprite.flipY)
			{
				if (y >= 0)
				{
					y = -(y + frameHeight);
				}
				else if (y < 0)
				{
					y = (Math.abs(y) - frameHeight);
				}
			}
		}

		var flipX = 1;
		var flipY = 1;

		if (sprite.flipX)
		{
			if (!customPivot)
			{
				x += (-frame.realWidth + (displayOriginX * 2));
			}

			flipX = -1;
		}

		//  Auto-invert the flipY if this is coming from a GLTexture
		if (sprite.flipY)
		{
			if (!customPivot)
			{
				y += (-frame.realHeight + (displayOriginY * 2));
			}

			flipY = -1;
		}

		spriteMatrix.applyITRS(sprite.x, sprite.y, sprite.rotation, sprite.scaleX * flipX, sprite.scaleY * flipY);

		camMatrix.copyFrom(camera.matrix);

		if (parentTransformMatrix != null)
		{
			//  Multiply the camera by the parent matrix
			camMatrix.multiplyWithOffset(parentTransformMatrix, -camera.scrollX * sprite.scrollFactorX, -camera.scrollY * sprite.scrollFactorY);

			//  Undo the camera scroll
			spriteMatrix.e = sprite.x;
			spriteMatrix.f = sprite.y;

			//  Multiply by the Sprite matrix, store result in calcMatrix
			camMatrix.multiply(spriteMatrix, calcMatrix);
		}
		else
		{
			spriteMatrix.e -= camera.scrollX * sprite.scrollFactorX;
			spriteMatrix.f -= camera.scrollY * sprite.scrollFactorY;

			//  Multiply by the Sprite matrix, store result in calcMatrix
			camMatrix.multiply(spriteMatrix, calcMatrix);
		}
		ctx.save();

		calcMatrix.setToContext(ctx);

		ctx.globalCompositeOperation = this.blendModes[sprite.blendMode];

		ctx.globalAlpha = alpha;

		ctx.drawImage(cast frame.source.image, frameX, frameY, frameWidth, frameHeight,
			x, y, frameWidth / res, frameHeight / res);

		ctx.restore();
	}

	/**
	 * Destroys all object references in the Canvas Renderer.
	 *
	 * @since 1.0.0
	**/
	public function destroy():Void
	{
		this.gameCanvas = null;
		this.gameContext = null;

		this.game = null;
	}
}
#else
@:forward()
abstract CanvasRenderer(Dynamic)
{
	public function new(game:Game)
	{
		this = null;
	}
}
#end
