package phaserHaxe.cameras.scene2D;

import phaserHaxe.math.MathUtility;
import phaserHaxe.cameras.scene2D.typedefs.CameraZoomCallback;
import phaserHaxe.cameras.scene2D.typedefs.CameraPanCallback;
import phaserHaxe.cameras.scene2D.typedefs.CameraShakeCallback;
import phaserHaxe.utils.types.Vector1Or2;
import phaserHaxe.cameras.scene2D.typedefs.CameraFlashCallback;
import phaserHaxe.cameras.scene2D.typedefs.CameraFadeCallback;
import phaserHaxe.renderer.webgl.WebGLPipeline;
import phaserHaxe.utils.types.Union;
import phaserHaxe.display.canvas.CanvasPool;
import js.html.CanvasRenderingContext2D;
import phaserHaxe.geom.Rectangle;
import phaserHaxe.gameobjects.components.ITint;
import phaserHaxe.gameobjects.components.IFlip;
import phaserHaxe.cameras.scene2D.effects.*;
import phaserHaxe.math.Vector2;
import js.html.CanvasElement as HTMLCanvasElement;
import js.html.webgl.Texture as WebGLTexture;
import js.html.webgl.Framebuffer as WebGLFramebuffer;
import phaserHaxe.geom.RectangleUtil;

/**
 * A Camera.
 *
 * The Camera is the way in which all games are rendered in Phaser. They provide a view into your game world,
 * and can be positioned, rotated, zoomed and scrolled accordingly.
 *
 * A Camera consists of two elements: The viewport and the scroll values.
 *
 * The viewport is the physical position and size of the Camera within your game. Cameras, by default, are
 * created the same size as your game, but their position and size can be set to anything. This means if you
 * wanted to create a camera that was 320x200 in size, positioned in the bottom-right corner of your game,
 * you'd adjust the viewport to do that (using methods like `setViewport` and `setSize`).
 *
 * If you wish to change where the Camera is looking in your game, then you scroll it. You can do this
 * via the properties `scrollX` and `scrollY` or the method `setScroll`. Scrolling has no impact on the
 * viewport, and changing the viewport has no impact on the scrolling.
 *
 * By default a Camera will render all Game Objects it can see. You can change this using the `ignore` method,
 * allowing you to filter Game Objects out on a per-Camera basis.
 *
 * A Camera also has built-in special effects including Fade, Flash and Camera Shake.
 *
 * @since 1.0.0
**/
@:build(phaserHaxe.macro.Mixin.auto())
class Camera extends BaseCamera implements IFlip implements ITint
{
	/**
	 * Does this Camera allow the Game Objects it renders to receive input events?
	 *
	 * @since 1.0.0
	**/
	public var inputEnabled:Bool = true;

	/**
	 * The Camera Fade effect handler.
	 * To fade this camera see the `Camera.fade` methods.
	 *
	 * @since 1.0.0
	**/
	public var fadeEffect:Fade;

	/**
	 * The Camera Flash effect handler.
	 * To flash this camera see the `Camera.flash` method.
	 *
	 * @since 1.0.0
	**/
	public var flashEffect:Flash;

	/**
	 * The Camera Shake effect handler.
	 * To shake this camera see the `Camera.shake` method.
	 *
	 * @since 1.0.0
	**/
	public var shakeEffect:Shake;

	/**
	 * The Camera Pan effect handler.
	 * To pan this camera see the `Camera.pan` method.
	 *
	 * @since 1.0.0
	**/
	public var panEffect:Pan;

	/**
	 * The Camera Zoom effect handler.
	 * To zoom this camera see the `Camera.zoom` method.
	 *
	 * @since 1.0.0
	**/
	public var zoomEffect:Zoom;

	/**
	 * The linear interpolation value to use when following a target.
	 *
	 * Can also be set via `setLerp` or as part of the `startFollow` call.
	 *
	 * The default values of 1 means the camera will instantly snap to the target coordinates.
	 * A lower value, such as 0.1 means the camera will more slowly track the target, giving
	 * a smooth transition. You can set the horizontal and vertical values independently, and also
	 * adjust this value in real-time during your game.
	 *
	 * Be sure to keep the value between 0 and 1. A value of zero will disable tracking on that axis.
	 *
	 * @since 1.0.0
	**/
	public var lerp(default, null):Vector2 = new Vector2(1, 1);

	/**
	 * The values stored in this property are subtracted from the Camera targets position, allowing you to
	 * offset the camera from the actual target x/y coordinates by this amount.
	 * Can also be set via `setFollowOffset` or as part of the `startFollow` call.
	 *
	 * @since 1.0.0
	**/
	public var followOffset(default, null):Vector2 = new Vector2();

	/**
	 * The Camera dead zone.
	 *
	 * The deadzone is only used when the camera is following a target.
	 *
	 * It defines a rectangular region within which if the target is present, the camera will not scroll.
	 * If the target moves outside of this area, the camera will begin scrolling in order to follow it.
	 *
	 * The `lerp` values that you can set for a follower target also apply when using a deadzone.
	 *
	 * You can directly set this property to be an instance of a Rectangle. Or, you can use the
	 * `setDeadzone` method for a chainable approach.
	 *
	 * The rectangle you provide can have its dimensions adjusted dynamically, however, please
	 * note that its position is updated every frame, as it is constantly re-centered on the cameras mid point.
	 *
	 * Calling `setDeadzone` with no arguments will reset an active deadzone, as will setting this property
	 * to `null`.
	 *
	 * @since 1.0.0
	**/
	public var deadzone:Null<Rectangle> = null;

	/**
	 * Internal follow target reference.
	 *
	 * @since 1.0.0
	**/
	private var _follow:Null<{x:Float, y:Float}> = null;

	/**
	 * Is this Camera rendering directly to the canvas or to a texture?
	 *
	 * Enable rendering to texture with the method `setRenderToTexture` (just enabling this boolean won't be enough)
	 *
	 * Once enabled you can toggle it by switching this property.
	 *
	 * To properly remove a render texture you should call the `clearRenderToTexture()` method.
	 *
	 * @since 1.0.0
	**/
	public var renderToTexture:Bool = false;

	/**
	 * If this Camera has been set to render to a texture then this holds a reference
	 * to the HTML Canvas Element that the Camera is drawing to.
	 *
	 * Enable texture rendering using the method `setRenderToTexture`.
	 *
	 * This is only populated if Phaser is running with the Canvas Renderer.
	 *
	 * @since 1.0.0
	**/
	public var canvas:HTMLCanvasElement = null;

	/**
	 * If this Camera has been set to render to a texture then this holds a reference
	 * to the Rendering Context belonging to the Canvas element the Camera is drawing to.
	 *
	 * Enable texture rendering using the method `setRenderToTexture`.
	 *
	 * This is only populated if Phaser is running with the Canvas Renderer.
	 *
	 * @since 1.0.0
	**/
	public var context:CanvasRenderingContext2D = null;

	/**
	 * If this Camera has been set to render to a texture then this holds a reference
	 * to the GL Texture belonging the Camera is drawing to.
	 *
	 * Enable texture rendering using the method `setRenderToTexture`.
	 *
	 * This is only set if Phaser is running with the WebGL Renderer.
	 *
	 * @since 1.0.0
	**/
	public var glTexture:Null<WebGLTexture> = null;

	/**
	 * If this Camera has been set to render to a texture then this holds a reference
	 * to the GL Frame Buffer belonging the Camera is drawing to.
	 *
	 * Enable texture rendering using the method `setRenderToTexture`.
	 *
	 * This is only set if Phaser is running with the WebGL Renderer.
	 *
	 * @since 1.0.0
	**/
	public var framebuffer:Null<WebGLFramebuffer> = null;

	/**
	 * If this Camera has been set to render to a texture and to use a custom pipeline,
	 * then this holds a reference to the pipeline the Camera is drawing with.
	 *
	 * Enable texture rendering using the method `setRenderToTexture`.
	 *
	 * This is only set if Phaser is running with the WebGL Renderer.
	 *
	 * @since 1.0.0
	**/
	public var pipeline:Null<Any> = null;

	public function new(x:Float, y:Float, width:Int, height:Int)
	{
		super(x, y, width, height);

		this.fadeEffect = new Fade(this);

		this.flashEffect = new Flash(this);

		this.shakeEffect = new Shake(this);

		this.panEffect = new Pan(this);

		this.zoomEffect = new Zoom(this);
	}

	/**
	 * Sets the Camera to render to a texture instead of to the main canvas.
	 *
	 * The Camera will redirect all Game Objects it's asked to render to this texture.
	 *
	 * During the render sequence, the texture itself will then be rendered to the main canvas.
	 *
	 * Doing this gives you the ability to modify the texture before this happens,
	 * allowing for special effects such as Camera specific shaders, or post-processing
	 * on the texture.
	 *
	 * If running under Canvas the Camera will render to its `canvas` property.
	 *
	 * If running under WebGL the Camera will create a frame buffer, which is stored in its `framebuffer` and `glTexture` properties.
	 *
	 * If you set a camera to render to a texture then it will emit 2 events during the render loop:
	 *
	 * First, it will emit the event `prerender`. This happens right before any Game Object's are drawn to the Camera texture.
	 *
	 * Then, it will emit the event `postrender`. This happens after all Game Object's have been drawn, but right before the
	 * Camera texture is rendered to the main game canvas. It's the final point at which you can manipulate the texture before
	 * it appears in-game.
	 *
	 * You should not enable this unless you plan on actually using the texture it creates
	 * somehow, otherwise you're just doubling the work required to render your game.
	 *
	 * To temporarily disable rendering to a texture, toggle the `renderToTexture` boolean.
	 *
	 * If you no longer require the Camera to render to a texture, call the `clearRenderToTexture` method,
	 * which will delete the respective textures and free-up resources.
	 *
	 * @since 1.0.0
	 *
	 * @param pipeline - An optional WebGL Pipeline to render with, can be either a string which is the name of the pipeline, or a pipeline reference.
	 *
	 * @return This Camera instance.
	**/
	public function setRenderToTexture(?pipeline:Union<String, WebGLPipeline>):Camera
	{
		var renderer = this.scene.sys.game.renderer;
		if (renderer.gl)
		{
			this.glTexture = renderer.createTextureFromSource(null, this.width, this.height, 0);
			this.framebuffer = renderer.createFramebuffer(this.width, this.height, this.glTexture, false);
		}
		else
		{
			this.canvas = CanvasPool.create2D(this, this.width, this.height);
			this.context = this.canvas.getContext('2d');
		}
		this.renderToTexture = true;
		if (pipeline != null)
		{
			this.setPipeline(pipeline);
		}
		return this;
	}

	/**
	 * Sets the WebGL pipeline this Camera is using when rendering to a texture.
	 *
	 * You can pass either the string-based name of the pipeline, or a reference to the pipeline itself.
	 *
	 * Call this method with no arguments to clear any previously set pipeline.
	 *
	 * @since 1.0.0
	 *
	 * @param pipeline - The WebGL Pipeline to render with, can be either a string which is the name of the pipeline, or a pipeline reference. Or if left empty it will clear the pipeline.
	 *
	 * @return This Camera instance.
	**/
	public function setPipeline(?pipeline:Union<String, WebGLPipeline>):Camera
	{
		if (Std.is(pipeline, String))
		{
			var renderer = scene.sys.game.renderer;

			if (renderer.gl && renderer.hasPipeline(pipeline))
			{
				this.pipeline = renderer.getPipeline(pipeline);
			}
		}
		else
		{
			this.pipeline = pipeline;
		}

		return this;
	}

	/**
	 * If this Camera was set to render to a texture, this will clear the resources it was using and
	 * redirect it to render back to the primary Canvas again.
	 *
	 * If you only wish to temporarily disable rendering to a texture then you can toggle the
	 * property `renderToTexture` instead.
	 *
	 * @since 1.0.0
	 *
	 * @return This Camera instance.
	**/
	public function clearRenderToTexture():Camera
	{
		if (scene == null)
		{
			return this;
		}

		var renderer = this.scene.sys.game.renderer;

		if (renderer == null)
		{
			return this;
		}

		if (renderer.gl != null)
		{
			if (framebuffer != null)
			{
				renderer.deleteFramebuffer(framebuffer);
			}

			if (glTexture != null)
			{
				renderer.deleteTexture(glTexture);
			}

			framebuffer = null;
			glTexture = null;
			pipeline = null;
		}
		else
		{
			CanvasPool.remove(this);

			canvas = null;
			context = null;
		}

		renderToTexture = false;

		return this;
	}

	/**
	 * Sets the Camera dead zone.
	 *
	 * The deadzone is only used when the camera is following a target.
	 *
	 * It defines a rectangular region within which if the target is present, the camera will not scroll.
	 * If the target moves outside of this area, the camera will begin scrolling in order to follow it.
	 *
	 * The deadzone rectangle is re-positioned every frame so that it is centered on the mid-point
	 * of the camera. This allows you to use the object for additional game related checks, such as
	 * testing if an object is within it or not via a Rectangle.contains call.
	 *
	 * The `lerp` values that you can set for a follower target also apply when using a deadzone.
	 *
	 * Calling this method with no arguments will reset an active deadzone.
	 *
	 * @since 1.0.0
	 *
	 * @param width - The width of the deadzone rectangle in pixels. If not specified the deadzone is removed.
	 * @param height - The height of the deadzone rectangle in pixels.
	 *
	 * @return This Camera instance.
	**/
	public function setDeadzone(?width:Float, height:Float = 0):Camera
	{
		if (width == null)
		{
			this.deadzone = null;
		}
		else
		{
			if (deadzone != null)
			{
				deadzone.width = width;
				deadzone.height = height;
			}
			else
			{
				deadzone = new Rectangle(0, 0, width, height);
			}

			if (_follow != null)
			{
				var originX = width / 2;
				var originY = height / 2;

				var fx = _follow.x - followOffset.x;
				var fy = _follow.y - followOffset.y;

				midPoint.set(fx, fy);

				scrollX = fx - originX;
				scrollY = fy - originY;
			}

			RectangleUtil.centerOn(deadzone, midPoint.x, midPoint.y);
		}

		return this;
	}

	/**
	 * Fades the Camera in from the given color over the duration specified.
	 *
	 * @fires Phaser.Cameras.Scene2D.Events#FADE_IN_START
	 * @fires Phaser.Cameras.Scene2D.Events#FADE_IN_COMPLETE
	 * @since 1.0.0
	 *
	 * @param duration - The duration of the effect in milliseconds.
	 * @param red - The amount to fade the red channel towards. A value between 0 and 255.
	 * @param green - The amount to fade the green channel towards. A value between 0 and 255.
	 * @param blue - The amount to fade the blue channel towards. A value between 0 and 255.
	 * @param callback - This callback will be invoked every frame for the duration of the effect.
	 * It is sent two arguments: A reference to the camera and a progress amount between 0 and 1 indicating how complete the effect is.
	 * @param context - The context in which the callback is invoked.
	 *
	 * @return {Phaser.Cameras.Scene2D.Camera} This Camera instance.
	**/
	public inline function fadeIn(duration:Int = 10000, red:Int = 0, green:Int = 0,
			blue:Int = 0, ?callback:CameraFadeCallback, ?context:Any):Camera
	{
		return fadeEffect.start(false, duration, red, green, blue, true, callback,
			context);
	}

	/**
	 * Fades the Camera out to the given color over the duration specified.
	 * This is an alias for Camera.fade that forces the fade to start, regardless of existing fades.
	 *
	 * @fires Phaser.Cameras.Scene2D.Events#FADE_OUT_START
	 * @fires Phaser.Cameras.Scene2D.Events#FADE_OUT_COMPLETE
	 * @since 1.0.0
	 *
	 * @param duration - The duration of the effect in milliseconds.
	 * @param red - The amount to fade the red channel towards. A value between 0 and 255.
	 * @param green - The amount to fade the green channel towards. A value between 0 and 255.
	 * @param blue - The amount to fade the blue channel towards. A value between 0 and 255.
	 * @param callback - This callback will be invoked every frame for the duration of the effect.
	 * It is sent two arguments: A reference to the camera and a progress amount between 0 and 1 indicating how complete the effect is.
	 * @param context - The context in which the callback is invoked. Defaults to the Scene to which the Camera belongs.
	 *
	 * @return This Camera instance.
	**/
	public inline function fadeOut(duration:Int = 1000, red:Int = 0, green:Int = 0,
			blue:Int = 0, ?callback:CameraFadeCallback, ?context:Any):Camera
	{
		return fadeEffect.start(true, duration, red, green, blue, true, callback,
			context);
	}

	/**
	 * Fades the Camera from the given color to transparent over the duration specified.
	 *
	 * @fires Phaser.Cameras.Scene2D.Events#FADE_IN_START
	 * @fires Phaser.Cameras.Scene2D.Events#FADE_IN_COMPLETE
	 * @since 1.0.0
	 *
	 * @param duration - The duration of the effect in milliseconds.
	 * @param red - The amount to fade the red channel towards. A value between 0 and 255.
	 * @param green - The amount to fade the green channel towards. A value between 0 and 255.
	 * @param blue - The amount to fade the blue channel towards. A value between 0 and 255.
	 * @param force - Force the effect to start immediately, even if already running.
	 * @param callback - This callback will be invoked every frame for the duration of the effect.
	 * It is sent two arguments: A reference to the camera and a progress amount between 0 and 1 indicating how complete the effect is.
	 * @param context - The context in which the callback is invoked. Defaults to the Scene to which the Camera belongs.
	 *
	 * @return This Camera instance.
	**/
	public inline function fadeFrom(duration:Int = 1000, red:Int = 0, green:Int = 0,
			blue:Int = 0, force:Bool = false, ?callback:CameraFadeCallback,
			?context:Any):Camera
	{
		return fadeEffect.start(false, duration, red, green, blue, force, callback,
			context);
	}

	/**
	 * Fades the Camera from transparent to the given color over the duration specified.
	 *
	 * @fires Phaser.Cameras.Scene2D.Events#FADE_OUT_START
	 * @fires Phaser.Cameras.Scene2D.Events#FADE_OUT_COMPLETE
	 * @since 1.0.0
	 *
	 * @param duration - The duration of the effect in milliseconds.
	 * @param red - The amount to fade the red channel towards. A value between 0 and 255.
	 * @param green - The amount to fade the green channel towards. A value between 0 and 255.
	 * @param blue - The amount to fade the blue channel towards. A value between 0 and 255.
	 * @param force - Force the effect to start immediately, even if already running.
	 * @param callback - This callback will be invoked every frame for the duration of the effect.
	 * It is sent two arguments: A reference to the camera and a progress amount between 0 and 1 indicating how complete the effect is.
	 * @param context - The context in which the callback is invoked. Defaults to the Scene to which the Camera belongs.
	 *
	 * @return {Phaser.Cameras.Scene2D.Camera} This Camera instance.
	 */
	public inline function fade(duration:Int = 1000, red:Int = 0, green:Int = 0,
			blue:Int = 0, force:Bool = false, ?callback:CameraFadeCallback, ?context:Any)
	{
		return this.fadeEffect.start(true, duration, red, green, blue, force, callback,
			context);
	}

	/**
	 * Flashes the Camera by setting it to the given color immediately and then fading it away again quickly over the duration specified.
	 *
	 * @fires Phaser.Cameras.Scene2D.Events#FLASH_START
	 * @fires Phaser.Cameras.Scene2D.Events#FLASH_COMPLETE
	 * @since .0.0
	 *
	 * @param duration - The duration of the effect in milliseconds.
	 * @param red - The amount to fade the red channel towards. A value between 0 and 255.
	 * @param green - The amount to fade the green channel towards. A value between 0 and 255.
	 * @param blue - The amount to fade the blue channel towards. A value between 0 and 255.
	 * @param force - Force the effect to start immediately, even if already running.
	 * @param callback - This callback will be invoked every frame for the duration of the effect.
	 * It is sent two arguments: A reference to the camera and a progress amount between 0 and 1 indicating how complete the effect is.
	 * @param context - The context in which the callback is invoked. Defaults to the Scene to which the Camera belongs.
	 *
	 * @return This Camera instance.
	**/
	public inline function flash(duration:Int = 250, red:Int = 255, green:Int = 255,
			blue:Int = 255, force:Bool = false, ?callback:CameraFlashCallback,
			?context:Any):Camera
	{
		return flashEffect.start(duration, red, green, blue, force, callback, context);
	}

	/**
	 * Shakes the Camera by the given intensity over the duration specified.
	 *
	 * @fires Phaser.Cameras.Scene2D.Events#SHAKE_START
	 * @fires Phaser.Cameras.Scene2D.Events#SHAKE_COMPLETE
	 * @since 1.0.0
	 *
	 * @param duration - The duration of the effect in milliseconds.
	 * @param intensity - The intensity of the shake.
	 * @param force - Force the shake effect to start immediately, even if already running.
	 * @param callback - This callback will be invoked every frame for the duration of the effect.
	 * It is sent two arguments: A reference to the camera and a progress amount between 0 and 1 indicating how complete the effect is.
	 * @param context - The context in which the callback is invoked. Defaults to the Scene to which the Camera belongs.
	 *
	 * @return This Camera instance.
	**/
	public inline function shake(duration:Int = 250, ?intensity:Vector1Or2,
			force:Bool = false, ?callback:CameraShakeCallback, ?context:Any):Camera
	{
		return shakeEffect.start(duration, intensity, force, callback, context);
	}

	/**
	 * This effect will scroll the Camera so that the center of its viewport finishes at the given destination,
	 * over the duration and with the ease specified.
	 *
	 * @fires Phaser.Cameras.Scene2D.Events#PAN_START
	 * @fires Phaser.Cameras.Scene2D.Events#PAN_COMPLETE
	 * @since 1.0.0
	 *
	 * @param x - The destination x coordinate to scroll the center of the Camera viewport to.
	 * @param y - The destination y coordinate to scroll the center of the Camera viewport to.
	 * @param duration - The duration of the effect in milliseconds.
	 * @param ease - The ease to use for the pan. Can be any of the Phaser Easing constants or a custom function.
	 * @param force - Force the pan effect to start immediately, even if already running.
	 * @param callback - This callback will be invoked every frame for the duration of the effect.
	 * It is sent four arguments: A reference to the camera, a progress amount between 0 and 1 indicating how complete the effect is,
	 * the current camera scroll x coordinate and the current camera scroll y coordinate.
	 * @param context - The context in which the callback is invoked.
	 *
	 * @return This Camera instance.
	**/
	public inline function pan(x:Float, y:Float, duration:Int = 1000,
			?ease:Union<String, (Float) -> Float>, force:Bool = false,
			?callback:CameraPanCallback, ?context:Any):Camera
	{
		return panEffect.start(x, y, duration, ease, force, callback, context);
	}

	/**
	 * This effect will zoom the Camera to the given scale, over the duration and with the ease specified.
	 *
	 * @fires Phaser.Cameras.Scene2D.Events#ZOOM_START
	 * @fires Phaser.Cameras.Scene2D.Events#ZOOM_COMPLETE
	 * @since 1.0.0
	 *
	 * @param zoom - The target Camera zoom value.
	 * @param duration - The duration of the effect in milliseconds.
	 * @param ease - The ease to use for the pan. Can be any of the Phaser Easing constants or a custom function.
	 * @param force - Force the pan effect to start immediately, even if already running.
	 * @param callback - This callback will be invoked every frame for the duration of the effect.
	 * It is sent four arguments: A reference to the camera, a progress amount between 0 and 1 indicating how complete the effect is,
	 * the current camera scroll x coordinate and the current camera scroll y coordinate.
	 * @param context - The context in which the callback is invoked.
	 *
	 * @return This Camera instance.
	**/
	public inline function zoomTo(zoom:Float, duration:Int = 1000,
			?ease:Union<String, (Float) -> Float>, force:Bool = false,
			?callback:CameraZoomCallback, ?context:Any):Camera
	{
		return zoomEffect.start(zoom, duration, ease, force, callback, context);
	}

	/**
	 * Internal preRender step.
	 *
	 * @since 1.0.0
	 *
	 * @param resolution - The game resolution, as set in the Scale Manager.
	**/
	private function preRender(resolution:Float)
	{
		var halfWidth = width * 0.5;
		var halfHeight = height * 0.5;

		var zoom = this.zoom * resolution;

		var originX = width * this.originX;
		var originY = height * this.originY;

		var follow = this._follow;
		var deadzone = this.deadzone;

		var sx = this.scrollX;
		var sy = this.scrollY;

		if (deadzone != null)
		{
			RectangleUtil.centerOn(deadzone, this.midPoint.x, this.midPoint.y);
		}

		if (follow && !this.panEffect.isRunning)
		{
			var fx = (follow.x - this.followOffset.x);
			var fy = (follow.y - this.followOffset.y);

			if (deadzone != null)
			{
				if (fx < deadzone.x)
				{
					sx = MathUtility.linear(sx, sx - (deadzone.x - fx), this.lerp.x);
				}
				else if (fx > deadzone.right)
				{
					sx = MathUtility.linear(sx, sx + (fx - deadzone.right), this.lerp.x);
				}

				if (fy < deadzone.y)
				{
					sy = MathUtility.linear(sy, sy - (deadzone.y - fy), this.lerp.y);
				}
				else if (fy > deadzone.bottom)
				{
					sy = MathUtility.linear(sy, sy + (fy - deadzone.bottom), this.lerp.y);
				}
			}
			else
			{
				sx = MathUtility.linear(sx, fx - originX, this.lerp.x);
				sy = MathUtility.linear(sy, fy - originY, this.lerp.y);
			}
		}

		if (this.useBounds)
		{
			sx = this.clampX(sx);
			sy = this.clampY(sy);
		}

		if (this.roundPixels)
		{
			originX = Math.round(originX);
			originY = Math.round(originY);
		}

		//  Values are in pixels and not impacted by zooming the Camera
		this.scrollX = sx;
		this.scrollY = sy;

		var midX = sx + halfWidth;
		var midY = sy + halfHeight;

		//  The center of the camera, in world space, so taking zoom into account
		//  Basically the pixel value of what it's looking at in the middle of the cam
		this.midPoint.set(midX, midY);

		var displayWidth = width / zoom;
		var displayHeight = height / zoom;

		this.worldView.setTo(midX - (displayWidth / 2), midY - (displayHeight / 2), displayWidth, displayHeight);

		matrix.applyITRS(this.x + originX, this.y + originY, this.rotation, zoom, zoom);
		matrix.translate(-originX, -originY);

		this.shakeEffect.preRender();
	}

	/**
	 * Sets the linear interpolation value to use when following a target.
	 *
	 * The default values of 1 means the camera will instantly snap to the target coordinates.
	 * A lower value, such as 0.1 means the camera will more slowly track the target, giving
	 * a smooth transition. You can set the horizontal and vertical values independently, and also
	 * adjust this value in real-time during your game.
	 *
	 * Be sure to keep the value between 0 and 1. A value of zero will disable tracking on that axis.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The amount added to the horizontal linear interpolation of the follow target.
	 * @param y - The amount added to the vertical linear interpolation of the follow target.
	 *
	 * @return This Camera instance.
	**/
	public inline function setLerp(x:Float = 1, ?y:Float):Camera
	{
		lerp.set(x, y != null ? y : x);
		return this;
	}

	/**
	 * Sets the horizontal and vertical offset of the camera from its follow target.
	 * The values are subtracted from the targets position during the Cameras update step.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The horizontal offset from the camera follow target.x position.
	 * @param y - The vertical offset from the camera follow target.y position.
	 *
	 * @return This Camera instance.
	**/
	public inline function setFollowOffset(x:Float = 0, y:Float = 0):Camera
	{
		this.followOffset.set(x, y);

		return this;
	}

	/**
	 * Sets the Camera to follow a Game Object.
	 *
	 * When enabled the Camera will automatically adjust its scroll position to keep the target Game Object
	 * in its center.
	 *
	 * You can set the linear interpolation value used in the follow code.
	 * Use low lerp values (such as 0.1) to automatically smooth the camera motion.
	 *
	 * If you find you're getting a slight "jitter" effect when following an object it's probably to do with sub-pixel
	 * rendering of the targets position. This can be rounded by setting the `roundPixels` argument to `true` to
	 * force full pixel rounding rendering. Note that this can still be broken if you have specified a non-integer zoom
	 * value on the camera. So be sure to keep the camera zoom to integers.
	 *
	 * @since 1.0.0
	 *
	 * @param target - The target for the Camera to follow.
	 * @param roundPixels - Round the camera position to whole integers to avoid sub-pixel rendering?
	 * @param lerpX - A value between 0 and 1. This value specifies the amount of linear interpolation to use when horizontally tracking the target. The closer the value to 1, the faster the camera will track.
	 * @param lerpY - A value between 0 and 1. This value specifies the amount of linear interpolation to use when vertically tracking the target. The closer the value to 1, the faster the camera will track.
	 * @param offsetX - The horizontal offset from the camera follow target.x position.
	 * @param offsetY - The vertical offset from the camera follow target.y position.
	 *
	 * @return This Camera instance.
	**/
	public function startFollow(target:{x:Float, y:Float}, roundPixels:Bool = false,
			lerpX:Float = 1, ?lerpY:Float, offsetX:Float = 0, ?offsetY:Float)
	{
		var lerpY:Float = lerpY != null ? lerpY : lerpX;
		var offsetY:Float = offsetY != null ? offsetY : offsetX;

		_follow = target;

		this.roundPixels = roundPixels;

		lerpX = MathUtility.clamp(lerpX, 0, 1);
		lerpY = MathUtility.clamp(lerpY, 0, 1);

		lerp.set(lerpX, lerpY);

		followOffset.set(offsetX, offsetY);

		var originX = width / 2;
		var originY = height / 2;

		var fx = target.x - offsetX;
		var fy = target.y - offsetY;

		midPoint.set(fx, fy);

		scrollX = fx - originX;
		scrollY = fy - originY;

		if (useBounds)
		{
			scrollX = clampX(scrollX);
			scrollY = clampY(scrollY);
		}

		return this;
	}

	/**
	 * Stops a Camera from following a Game Object, if previously set via `Camera.startFollow`.
	 *
	 * @since 1.0.0
	 *
	 * @return This Camera instance.
	**/
	public function stopFollow():Camera
	{
		_follow = null;

		return this;
	}

	/**
	 * Resets any active FX, such as a fade, flash or shake. Useful to call after a fade in order to
	 * remove the fade.
	 *
	 * @since 1.0.0
	 *
	 * @return This Camera instance.
	**/
	public function resetFX():Camera
	{
		panEffect.reset();
		shakeEffect.reset();
		flashEffect.reset();
		fadeEffect.reset();

		return this;
	}

	/**
	 * Internal method called automatically by the Camera Manager.
	 *
	 * @since 1.0.0
	 *
	 * @param time - The current timestamp as generated by the Request Animation Frame or SetTimeout.
	 * @param delta - The delta time, in ms, elapsed since the last frame.
	**/
	private function update(time:Int, delta:Float):Void
	{
		if (visible)
		{
			panEffect.update(time, delta);
			zoomEffect.update(time, delta);
			shakeEffect.update(time, delta);
			flashEffect.update(time, delta);
			fadeEffect.update(time, delta);
		}
	}

	/**
	 * Destroys this Camera instance. You rarely need to call this directly.
	 *
	 * Called by the Camera Manager. If you wish to destroy a Camera please use `CameraManager.remove` as
	 * cameras are stored in a pool, ready for recycling later, and calling this directly will prevent that.
	 *
	 * @fires Phaser.Cameras.Scene2D.Events#DESTROY
	 * @since 1.0.0
	**/
	public function destroy():Void
	{
		clearRenderToTexture();
		resetFX();

		super.destroy();

		this._follow = null;

		this.deadzone = null;
	}
}
