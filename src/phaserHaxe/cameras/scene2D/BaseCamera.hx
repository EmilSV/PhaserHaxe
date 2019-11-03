package phaserHaxe.cameras.scene2D;

import phaserHaxe.display.InputColorObject;
import phaserHaxe.math.MathUtility;
import phaserHaxe.gameobjects.group.Group;
import phaserHaxe.utils.types.MultipleOrOne;
import phaserHaxe.gameobjects.components.IOrigin;
import phaserHaxe.gameobjects.components.IScrollFactor;
import phaserHaxe.gameobjects.components.ITransform;
import phaserHaxe.gameobjects.components.ISize;
import phaserHaxe.gameobjects.RenderFlags;
import phaserHaxe.gameobjects.IHaveRenderFlags;
import phaserHaxe.display.mask.Mask;
import phaserHaxe.gameobjects.GameObject;
import phaserHaxe.display.Color;
import phaserHaxe.gameobjects.components.IAlpha;
import phaserHaxe.gameobjects.components.IVisible;
import phaserHaxe.scene.SceneManager;
import phaserHaxe.scale.ScaleManager;
import phaserHaxe.geom.Rectangle;
import phaserHaxe.gameobjects.components.TransformMatrix;
import phaserHaxe.math.Vector2;
import phaserHaxe.utils.types.Union3;

/**
 * A Base Camera class.
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
 * The Base Camera is extended by the Camera class, which adds in special effects including Fade,
 * Flash and Camera Shake, as well as the ability to follow Game Objects.
 *
 * The Base Camera was introduced in Phaser 3.12. It was split off from the Camera class, to allow
 * you to isolate special effects as needed. Therefore the 'since' values for properties of this class relate
 * to when they were added to the Camera class.
 *
 * @since 1.0.0
 *
**/
@:build(phaserHaxe.macro.Mixin.auto())
class BaseCamera extends EventEmitter implements IAlpha implements IVisible
		implements IHaveRenderFlags
{
	@:noCompletion
	public var renderFlags:RenderFlags = 15;

	/**
	 * A reference to the Scene this camera belongs to.
	 *
	 * @since 1.0.0
	**/
	public var scene:Scene;

	/**
	 * A reference to the Game Scene Manager.
	 *
	 * @since 1.0.0
	**/
	public var sceneManager:SceneManager;

	/**
	 * A reference to the Game Scale Manager.
	 *
	 * @since 1.0.0
	**/
	public var scaleManager:ScaleManager;

	/**
	 * A reference to the Scene's Camera Manager to which this Camera belongs.
	 *
	 * @since 1.0.0
	**/
	public var cameraManager:CameraManager;

	/**
	 * The Camera ID. Assigned by the Camera Manager and used to handle camera exclusion.
	 * This value is a bitmask.
	 *
	 * @since 1.0.0
	**/
	public var id:Int = 0;

	/**
	 * The name of the Camera. This is left empty for your own use.
	 *
	 * @since 1.0.0
	**/
	public var name = '';

	/**
	 * This property is un-used in v3.16.
	 *
	 * The resolution of the Game, used in most Camera calculations.
	 *
	 * @deprecated
	 * @since 1.0.0
	**/
	public var resolution:Float = 1;

	/**
	 * Should this camera round its pixel values to integers?
	 *
	 * @since 1.0.0
	**/
	public var roundPixels:Bool = false;

	/**
	 * Is this Camera visible or not?
	 *
	 * A visible camera will render and perform input tests.
	 * An invisible camera will not render anything and will skip input tests.
	 *
	 * @since 1.0.0
	**/
	public var visible(get, set):Bool;

	/**
	 * Is this Camera using a bounds to restrict scrolling movement?
	 *
	 * Set this property along with the bounds via `Camera.setBounds`.
	 *
	 * @since 1.0.0
	**/
	public var useBounds:Bool = false;

	/**
	 * The World View is a Rectangle that defines the area of the 'world' the Camera is currently looking at.
	 * This factors in the Camera viewport size, zoom and scroll position and is updated in the Camera preRender step.
	 * If you have enabled Camera bounds the worldview will be clamped to those bounds accordingly.
	 * You can use it for culling or intersection checks.
	 *
	 * @since 1.0.0
	**/
	public final worldView = new Rectangle();

	/**
	 * Is this Camera dirty?
	 *
	 * A dirty Camera has had either its viewport size, bounds, scroll, rotation or zoom levels changed since the last frame.
	 *
	 * This flag is cleared during the `postRenderCamera` method of the renderer.
	 *
	 * @since 1.0.0
	**/
	public var dirty:Bool = true;

	/**
	 * The x position of the Camera viewport, relative to the top-left of the game canvas.
	 * The viewport is the area into which the camera renders.
	 * To adjust the position the camera is looking at in the game world, see the `scrollX` value.
	 *
	 * @since 1.0.0
	**/
	public var _x:Float;

	/**
	 * The y position of the Camera, relative to the top-left of the game canvas.
	 * The viewport is the area into which the camera renders.
	 * To adjust the position the camera is looking at in the game world, see the `scrollY` value.
	 *
	 * @since 1.0.0
	**/
	public var _y:Float;

	/**
	 * Internal Camera X value multiplied by the resolution.
	 *
	 * @since 1.0.0
	**/
	@:allow(phaserHaxe)
	private var _cx:Float = 0;

	/**
	 * Internal Camera Y value multiplied by the resolution.
	 *
	 * @since 1.0.0
	**/
	@:allow(phaserHaxe)
	private var _cy:Float = 0;

	/**
	 * Internal Camera Width value multiplied by the resolution.
	 *
	 * @since 1.0.0
	**/
	@:allow(phaserHaxe)
	private var _cw:Float = 0;

	/**
	 * Internal Camera Height value multiplied by the resolution.
	 *
	 * @since 1.0.0
	**/
	@:allow(phaserHaxe)
	private var _ch:Float = 0;

	/**
	 * The width of the Camera viewport, in pixels.
	 *
	 * The viewport is the area into which the Camera renders. Setting the viewport does
	 * not restrict where the Camera can scroll to.
	 *
	 * @since 1.0.0
	**/
	private var _width:Int;

	/**
	 * The height of the Camera viewport, in pixels.
	 *
	 * The viewport is the area into which the Camera renders. Setting the viewport does
	 * not restrict where the Camera can scroll to.
	 *
	 * @since 1.0.0
	**/
	private var _height:Int;

	/**
	 * The bounds the camera is restrained to during scrolling.
	 *
	 * @since 1.0.0
	**/
	private var _bounds = new Rectangle();

	/**
	 * The horizontal scroll position of this Camera.
	 *
	 * Change this value to cause the Camera to scroll around your Scene.
	 *
	 * Alternatively, setting the Camera to follow a Game Object, via the `startFollow` method,
	 * will automatically adjust the Camera scroll values accordingly.
	 *
	 * You can set the bounds within which the Camera can scroll via the `setBounds` method.
	 *
	 * @since 1.0.0
	**/
	private var _scrollX:Float = 0;

	/**
	 * The vertical scroll position of this Camera.
	 *
	 * Change this value to cause the Camera to scroll around your Scene.
	 *
	 * Alternatively, setting the Camera to follow a Game Object, via the `startFollow` method,
	 * will automatically adjust the Camera scroll values accordingly.
	 *
	 * You can set the bounds within which the Camera can scroll via the `setBounds` method.
	 *
	 * @since 1.0.0
	**/
	private var _scrollY:Float = 0;

	/**
	 * The Camera zoom value. Change this value to zoom in, or out of, a Scene.
	 *
	 * A value of 0.5 would zoom the Camera out, so you can now see twice as much
	 * of the Scene as before. A value of 2 would zoom the Camera in, so every pixel
	 * now takes up 2 pixels when rendered.
	 *
	 * Set to 1 to return to the default zoom level.
	 *
	 * Be careful to never set this value to zero.
	 *
	 * @since 1.0.0
	**/
	public var _zoom:Float = 1;

	/**
	 * The rotation of the Camera in radians.
	 *
	 * Camera rotation always takes place based on the Camera viewport. By default, rotation happens
	 * in the center of the viewport. You can adjust this with the `originX` and `originY` properties.
	 *
	 * Rotation influences the rendering of _all_ Game Objects visible by this Camera. However, it does not
	 * rotate the Camera viewport itself, which always remains an axis-aligned rectangle.
	 *
	 * @since 1.0.0
	**/
	public var _rotation:Float = 0;

	/**
	 * A local transform matrix used for internal calculations.
	 *
	 * @since 1.0.0
	**/
	public var matrix = new TransformMatrix();

	/**
	 * Does this Camera have a transparent background?
	 *
	 * @since 1.0.0
	**/
	public var transparent:Bool = true;

	/**
	 * The background color of this Camera. Only used if `transparent` is `false`.
	 *
	 * @since 1.0.0
	**/
	public var backgroundColor:Color = new Color(0, 0, 0, 0);

	/**
	 * The Camera alpha value. Setting this property impacts every single object that this Camera
	 * renders. You can either set the property directly, i.e. via a Tween, to fade a Camera in or out,
	 * or via the chainable `setAlpha` method instead.
	 *
	 * @since 1.0.0
	**/
	public var alpha(get, set):Float;

	/**
	 * Should the camera cull Game Objects before checking them for input hit tests?
	 * In some special cases it may be beneficial to disable public var
	 *
	 * @since 1.0.0
	**/
	public var disableCull:Bool = false;

	/**
	 * A temporary array of culled objects.
	 *
	 * @since 1.0.0
	**/
	private var culledObjects:Array<GameObject> = [];

	/**
	 * The mid-point of the Camera in 'world' coordinates.
	 *
	 * Use it to obtain exactly where in the world the center of the camera is currently looking.
	 *
	 * This value is updated in the preRender method, after the scroll values and follower
	 * have been processed.
	 *
	 * @readonly
	 * @since 1.0.0
	**/
	public var midPoint(default, null):Vector2;

	/**
	 * The horizontal origin of rotation for this Camera.
	 *
	 * By default the camera rotates around the center of the viewport.
	 *
	 * Changing the origin allows you to adjust the point in the viewport from which rotation happens.
	 * A value of 0 would rotate from the top-left of the viewport. A value of 1 from the bottom right.
	 *
	 * See `setOrigin` to set both origins in a single, chainable call.
	 *
	 * @since 1.0.0
	**/
	public var originX:Float = 0.5;

	/**
	 * The vertical origin of rotation for this Camera.
	 *
	 * By default the camera rotates around the center of the viewport.
	 *
	 * Changing the origin allows you to adjust the point in the viewport from which rotation happens.
	 * A value of 0 would rotate from the top-left of the viewport. A value of 1 from the bottom right.
	 *
	 * See `setOrigin` to set both origins in a single, chainable call.
	 *
	 * @since 1.0.0
	**/
	public var originY:Float = 0.5;

	/**
	 * Does this Camera have a custom viewport?
	 *
	 * @since 1.0.0
	**/
	private var _customViewport:Bool = false;

	/**
	 * The Mask this Camera is using during render.
	 * Set the mask using the `setMask` method. Remove the mask using the `clearMask` method.
	 *
	 * @since 1.0.0
	**/
	public var mask:Mask = null;

	/**
	 * The Camera that this Camera uses for translation during masking.
	 *
	 * If the mask is fixed in position this will be a reference to
	 * the CameraManager.default instance. Otherwise, it'll be a reference
	 * to itself.
	 *
	 * @since 1.0.0
	**/
	private var _maskCamera:BaseCamera = null;

	/**
	 * The x position of the Camera viewport, relative to the top-left of the game canvas.
	 * The viewport is the area into which the camera renders.
	 * To adjust the position the camera is looking at in the game world, see the `scrollX` value.
	 *
	 * @since 1.0.0
	**/
	public var x(get, set):Float;

	/**
	 * The y position of the Camera viewport, relative to the top-left of the game canvas.
	 * The viewport is the area into which the camera renders.
	 * To adjust the position the camera is looking at in the game world, see the `scrollY` value.
	 *
	 * @since 1.0.0
	**/
	public var y(get, set):Float;

	/**
	 * The width of the Camera viewport, in pixels.
	 *
	 * The viewport is the area into which the Camera renders. Setting the viewport does
	 * not restrict where the Camera can scroll to.
	 *
	 * @since 1.0.0
	**/
	public var width(get, set):Int;

	/**
	 * The height of the Camera viewport, in pixels.
	 *
	 * The viewport is the area into which the Camera renders. Setting the viewport does
	 * not restrict where the Camera can scroll to.
	 *
	 * @since 1.0.0
	**/
	public var height(get, set):Int;

	/**
	 * The horizontal scroll position of this Camera.
	 *
	 * Change this value to cause the Camera to scroll around your Scene.
	 *
	 * Alternatively, setting the Camera to follow a Game Object, via the `startFollow` method,
	 * will automatically adjust the Camera scroll values accordingly.
	 *
	 * You can set the bounds within which the Camera can scroll via the `setBounds` method.
	 *
	 * @since 1.0.0
	**/
	public var scrollX(get, set):Float;

	/**
	 * The vertical scroll position of this Camera.
	 *
	 * Change this value to cause the Camera to scroll around your Scene.
	 *
	 * Alternatively, setting the Camera to follow a Game Object, via the `startFollow` method,
	 * will automatically adjust the Camera scroll values accordingly.
	 *
	 * You can set the bounds within which the Camera can scroll via the `setBounds` method.
	 *
	 * @since 1.0.0
	**/
	public var scrollY(get, set):Float;

	/**
	 * The Camera zoom value. Change this value to zoom in, or out of, a Scene.
	 *
	 * A value of 0.5 would zoom the Camera out, so you can now see twice as much
	 * of the Scene as before. A value of 2 would zoom the Camera in, so every pixel
	 * now takes up 2 pixels when rendered.
	 *
	 * Set to 1 to return to the default zoom level.
	 *
	 * Be careful to never set this value to zero.
	 *
	 * @since 1.0.0
	**/
	public var zoom(get, set):Float;

	/**
	 * The rotation of the Camera in radians.
	 *
	 * Camera rotation always takes place based on the Camera viewport. By default, rotation happens
	 * in the center of the viewport. You can adjust this with the `originX` and `originY` properties.
	 *
	 * Rotation influences the rendering of _all_ Game Objects visible by this Camera. However, it does not
	 * rotate the Camera viewport itself, which always remains an axis-aligned rectangle.
	 *
	 * @since 1.0.0
	**/
	public var rotation(get, set):Float;

	/**
	 * The horizontal position of the center of the Camera's viewport, relative to the left of the game canvas.
	 *
	 * @since 1.0.0
	**/
	public var centerX(get, never):Float;

	/**
	 * The vertical position of the center of the Camera's viewport, relative to the top of the game canvas.
	 *
	 * @since 1.0.0
	**/
	public var centerY(get, never):Float;

	/**
	 * The displayed width of the camera viewport, factoring in the camera zoom level.
	 *
	 * If a camera has a viewport width of 800 and a zoom of 0.5 then its display width
	 * would be 1600, as it's displaying twice as many pixels as zoom level 1.
	 *
	 * Equally, a camera with a width of 800 and zoom of 2 would have a display width
	 * of 400 pixels.
	 *
	 * @since 1.0.0
	**/
	public var displayWidth(get, never):Float;

	/**
	 * The displayed height of the camera viewport, factoring in the camera zoom level.
	 *
	 * If a camera has a viewport height of 600 and a zoom of 0.5 then its display height
	 * would be 1200, as it's displaying twice as many pixels as zoom level 1.
	 *
	 * Equally, a camera with a height of 600 and zoom of 2 would have a display height
	 * of 300 pixels.
	 *
	 * @since 1.0.0
	**/
	public var displayHeight(get, never):Float;

	/**
	 * @param  x - The x position of the Camera, relative to the top-left of the game canvas.
	 * @param y - The y position of the Camera, relative to the top-left of the game canvas.
	 * @param width - The width of the Camera, in pixels.
	 * @param height - The height of the Camera, in pixels.
	**/
	public function new(x:Float, y:Float, width:Int, height:Int)
	{
		super();

		_x = x;
		_y = y;
		_width = width;
		_height = height;

		midPoint = new Vector2(width / 2, height / 2);
	}

	private inline function get_x():Float
	{
		return _x;
	}

	private inline function set_x(value:Float):Float
	{
		_x = value;
		_cx = value * resolution;
		// this.updateSystem();
		return _x;
	}

	private inline function get_y():Float
	{
		return _y;
	}

	private inline function set_y(value:Float):Float
	{
		_y = value;
		_cy = value * resolution;
		// this.updateSystem();
		return _y;
	}

	private inline function get_width():Int
	{
		return _width;
	}

	private inline function set_width(value:Int):Int
	{
		this._width = value;
		this._cw = value * this.resolution;
		// this.updateSystem();
		return _width;
	}

	private inline function get_height():Int
	{
		return _height;
	}

	private inline function set_height(value:Int):Int
	{
		this._height = value;
		this._ch = value * this.resolution;
		// this.updateSystem();
		return _height;
	}

	private inline function get_scrollX():Float
	{
		return _scrollX;
	}

	private inline function set_scrollX(value:Float):Float
	{
		_scrollX = value;
		dirty = true;
		return _scrollX;
	}

	private inline function get_scrollY():Float
	{
		return _scrollY;
	}

	private inline function set_scrollY(value:Float):Float
	{
		this._scrollY = value;
		this.dirty = true;
		return _scrollY;
	}

	private inline function get_zoom():Float
	{
		return _zoom;
	}

	private inline function set_zoom(value:Float):Float
	{
		_zoom = value;
		dirty = true;
		return _zoom;
	}

	private inline function get_rotation():Float
	{
		return _rotation;
	}

	private inline function set_rotation(value:Float):Float
	{
		_rotation = value;
		dirty = true;
		return _rotation;
	}

	private inline function get_centerX():Float
	{
		return x + (0.5 * width);
	}

	private inline function get_centerY():Float
	{
		return y + (0.5 * height);
	}

	private inline function get_displayWidth():Float
	{
		return width / zoom;
	}

	private inline function get_displayHeight():Float
	{
		return height / zoom;
	}

	/**
	 * Set the Alpha level of this Camera. The alpha controls the opacity of the Camera as it renders.
	 * Alpha values are provided as a float between 0, fully transparent, and 1, fully opaque.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The Camera alpha value.
	 *
	 * @return This Camera instance.
	**/
	public function setAlpha(value:Float = 1, ?topRight:Float, ?bottomLeft:Float,
			?bottomRight:Float):BaseCamera
	{
		return AlphaImplantation.setAlpha(this, value, topRight, bottomLeft, bottomRight);
	}

	/**
	 * Sets the rotation origin of this Camera.
	 *
	 * The values are given in the range 0 to 1 and are only used when calculating Camera rotation.
	 *
	 * By default the camera rotates around the center of the viewport.
	 *
	 * Changing the origin allows you to adjust the point in the viewport from which rotation happens.
	 * A value of 0 would rotate from the top-left of the viewport. A value of 1 from the bottom right.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The horizontal origin value.
	 * @param y - The vertical origin value. If not defined it will be set to the value of `x`.
	 *
	 * @return This Camera instance.
	**/
	public function setOrigin(x:Float = 0.5, ?y:Float):BaseCamera
	{
		var y:Float = y != null ? y : x;

		originX = x;
		originY = y;

		return this;
	}

	/**
	 * Calculates what the Camera.scrollX and scrollY values would need to be in order to move
	 * the Camera so it is centered on the given x and y coordinates, without actually moving
	 * the Camera there. The results are clamped based on the Camera bounds, if set.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The horizontal coordinate to center on.
	 * @param y - The vertical coordinate to center on.
	 * @param out - A Vec2 to store the values in. If not given a new Vec2 is created.
	 *
	 * @return The scroll coordinates stored in the `x` and `y` properties.
	**/
	public function getScroll(x:Float, y:Float, ?out:Vector2):Vector2
	{
		var out:Vector2 = out != null ? out : new Vector2();

		var originX = width * 0.5;
		var originY = height * 0.5;

		out.x = x - originX;
		out.y = y - originY;

		if (useBounds)
		{
			out.x = clampX(out.x);
			out.y = clampY(out.y);
		}

		return out;
	}

	/**
	 * Moves the Camera horizontally so that it is centered on the given x coordinate, bounds allowing.
	 * Calling this does not change the scrollY value.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The horizontal coordinate to center on.
	 *
	 * @return This Camera instance.
	**/
	public function centerOnX(x:Float):BaseCamera
	{
		var originX = width * 0.5;

		midPoint.x = x;

		scrollX = x - originX;

		if (useBounds)
		{
			scrollX = clampX(scrollX);
		}

		return this;
	}

	/**
	 * Moves the Camera vertically so that it is centered on the given y coordinate, bounds allowing.
	 * Calling this does not change the scrollX value.
	 *
	 * @since 1.0.0
	 *
	 * @param y - The vertical coordinate to center on.
	 *
	 * @return This Camera instance.
	**/
	public function centerOnY(y:Float):BaseCamera
	{
		var originY = height * 0.5;

		midPoint.y = y;

		scrollY = y - originY;

		if (useBounds)
		{
			scrollY = clampY(scrollY);
		}

		return this;
	}

	/**
	 * Moves the Camera so that it is centered on the given coordinates, bounds allowing.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The horizontal coordinate to center on.
	 * @param y - The vertical coordinate to center on.
	 *
	 * @return This Camera instance.
	**/
	public function centerOn(x:Float, y:Float):BaseCamera
	{
		centerOnX(x);
		centerOnY(y);
		return this;
	}

	/**
	 * Moves the Camera so that it is looking at the center of the Camera Bounds, if enabled.
	 *
	 * @since 1.0.0
	 *
	 * @return This Camera instance.
	**/
	public function centerToBounds():BaseCamera
	{
		if (useBounds)
		{
			var bounds = _bounds;
			var originX = width * 0.5;
			var originY = height * 0.5;

			midPoint.set(bounds.centerX, bounds.centerY);

			scrollX = bounds.centerX - originX;
			scrollY = bounds.centerY - originY;
		}

		return this;
	}

	/**
	 * Moves the Camera so that it is re-centered based on its viewport size.
	 *
	 * @since 1.0.0
	 *
	 * @return This Camera instance.
	**/
	public function centerToSize():BaseCamera
	{
		scrollX = width * 0.5;
		scrollY = height * 0.5;

		return this;
	}

	/**
	 * Takes an array of Game Objects and returns a new array featuring only those objects
	 * visible by this camera.
	 *
	 * @since 1.0.0
	 *
	 * @param renderableObjects - An array of Game Objects to cull.
	 *
	 * @return An array of Game Objects visible to this Camera.
	**/
	public function cull(renderableObjects:Array<GameObject>):Array<GameObject>
	{
		if (disableCull)
		{
			return renderableObjects;
		}

		var cameraMatrix = this.matrix.matrix;

		var mva = cameraMatrix[0];
		var mvb = cameraMatrix[1];
		var mvc = cameraMatrix[2];
		var mvd = cameraMatrix[3];

		/* First Invert Matrix */
		var determinant = (mva * mvd) - (mvb * mvc);

		if (determinant == 0)
		{
			return renderableObjects;
		}

		var mve = cameraMatrix[4];
		var mvf = cameraMatrix[5];

		var scrollX = scrollX;
		var scrollY = scrollY;
		var cameraW = width;
		var cameraH = height;
		var length = renderableObjects.length;

		determinant = 1 / determinant;

		culledObjects.resize(0);

		for (index in 0...length)
		{
			var object = renderableObjects[index];

			if (Std.is(this, ISize))
			{
				culledObjects.push(object);
				continue;
			}

			var objectSize = (cast object : ISize);
			var objectTran = (cast object : ITransform);
			var objectScroll = (cast object : IScrollFactor);
			var objectOrigin = (cast object : IOrigin);

			var objectW = objectSize.width;
			var objectH = objectSize.height;

			var objectX = (objectTran.x - (scrollX * objectScroll.scrollFactorX)) - (objectW * objectOrigin.originX);
			var objectY = (objectTran.y - (scrollY * objectScroll.scrollFactorY)) - (objectH * objectOrigin.originY);
			var tx = (objectX * mva + objectY * mvc + mve);
			var ty = (objectX * mvb + objectY * mvd + mvf);
			var tw = ((objectX + objectW) * mva + (objectY + objectH) * mvc + mve);
			var th = ((objectX + objectW) * mvb + (objectY + objectH) * mvd + mvf);
			var cullTop = y;
			var cullBottom = cullTop + cameraH;
			var cullLeft = x;
			var cullRight = cullLeft + cameraW;

			if ((tw > cullLeft && tx < cullRight) && (th > cullTop && ty < cullBottom))
			{
				culledObjects.push(object);
			}
		}

		return culledObjects;
	}

	/**
	 * Converts the given `x` and `y` coordinates into World space, based on this Cameras transform.
	 * You can optionally provide a Vector2, or similar object, to store the results in.
	 *
	 * @method Phaser.Cameras.Scene2D.BaseCamera#getWorldPoint
	 * @since 3.0.0
	 *
	 * @generic {Phaser.Math.Vector2} O - [output,$return]
	 *
	 * @param {number} x - The x position to convert to world space.
	 * @param {number} y - The y position to convert to world space.
	 * @param {(object|Phaser.Math.Vector2)} [output] - An optional object to store the results in. If not provided a new Vector2 will be created.
	 *
	 * @return {Phaser.Math.Vector2} An object holding the converted values in its `x` and `y` properties.
	 */
	function getWorldPoint(x, y, output)
	{
		if (output == null)
		{
			output = new Vector2();
		}

		var cameraMatrix = this.matrix.matrix;

		var mva = cameraMatrix[0];
		var mvb = cameraMatrix[1];
		var mvc = cameraMatrix[2];
		var mvd = cameraMatrix[3];
		var mve = cameraMatrix[4];
		var mvf = cameraMatrix[5];

		//  Invert Matrix
		var determinant = (mva * mvd) - (mvb * mvc);

		if (determinant == 0)
		{
			output.x = x;
			output.y = y;

			return output;
		}

		determinant = 1 / determinant;

		var ima = mvd * determinant;
		var imb = -mvb * determinant;
		var imc = -mvc * determinant;
		var imd = mva * determinant;
		var ime = (mvc * mvf - mvd * mve) * determinant;
		var imf = (mvb * mve - mva * mvf) * determinant;

		var c = Math.cos(this.rotation);
		var s = Math.sin(this.rotation);

		var zoom = this.zoom;
		var res = this.resolution;

		var scrollX = this.scrollX;
		var scrollY = this.scrollY;

		//  Works for zoom of 1 with any resolution, but resolution > 1 and zoom !== 1 breaks
		var sx = x + ((scrollX * c - scrollY * s) * zoom);
		var sy = y + ((scrollX * s + scrollY * c) * zoom);

		//  Apply transform to point
		output.x = (sx * ima + sy * imc) * res + ime;
		output.y = (sx * imb + sy * imd) * res + imf;

		return output;
	}

	/**
	 * Given a Game Object, or an array of Game Objects, it will update all of their camera filter settings
	 * so that they are ignored by this Camera. This means they will not be rendered by this Camera.
	 *
	 * @since 1.0.0
	 *
	 * @param entries - The Game Object, or array of Game Objects, to be ignored by this Camera.
	 *
	 * @return This Camera instance.
	**/
	public function ignore(entries:Union3<GameObject, Array<GameObject>, Group>)
	{
		var id = this.id;

		if (!Std.is(entries, Array))
		{
			if (Group.isGroup(entries))
			{
				var entry = (cast entries : Group);
				this.ignore(entry.getChildren());
			}
			else
			{
				var entry = (cast entries : GameObject);
				entry.cameraFilter |= id;
			}

			return this;
		}

		var entries = (cast entries : Array<GameObject>);
		for (entry in entries)
		{
			entry.cameraFilter |= id;
		}

		return this;
	}

	/**
	 * Internal preRender step.
	 *
	 * @since 1.0.0
	 *
	 * @param resolution - The game resolution, as set in the Scale Manager.
	**/
	private function preRender(resolution:Float):Void
	{
		var halfWidth = width * 0.5;
		var halfHeight = height * 0.5;

		var zoom = this.zoom * resolution;

		var originX = width * this.originX;
		var originY = height * this.originY;

		var sx = scrollX;
		var sy = scrollY;

		if (useBounds)
		{
			sx = clampX(sx);
			sy = clampY(sy);
		}

		if (roundPixels)
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
		midPoint.set(midX, midY);

		var displayWidth = width / zoom;
		var displayHeight = height / zoom;

		worldView.setTo(midX - (displayWidth / 2), midY - (displayHeight / 2), displayWidth, displayHeight);

		matrix.applyITRS(x + originX, y + originY, rotation, zoom, zoom);
		matrix.translate(-originX, -originY);
	}

	/**
	 * Takes an x value and checks it's within the range of the Camera bounds, adjusting if required.
	 * Do not call this method if you are not using camera bounds.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The value to horizontally scroll clamp.
	 *
	 * @return The adjusted value to use as scrollX.
	**/
	public function clampX(x:Float):Float
	{
		var bounds = _bounds;

		var dw = displayWidth;

		var bx = bounds.x + ((dw - width) / 2);
		var bw = Math.max(bx, bx + bounds.width - dw);

		if (x < bx)
		{
			x = bx;
		}
		else if (x > bw)
		{
			x = bw;
		}

		return x;
	}

	/**
	 * Takes a y value and checks it's within the range of the Camera bounds, adjusting if required.
	 * Do not call this method if you are not using camera bounds.
	 *
	 * @since 1.0.0
	 *
	 * @param y - The value to vertically scroll clamp.
	 *
	 * @return The adjusted value to use as scrollY.
	**/
	public function clampY(y:Float):Float
	{
		var bounds = _bounds;
		var dh = displayHeight;
		var by = bounds.y + ((dh - height) / 2);
		var bh = Math.max(by, by + bounds.height - dh);
		if (y < by)
		{
			y = by;
		}
		else if (y > bh)
		{
			y = bh;
		}
		return y;
	}

	/**
	 * If this Camera has previously had movement bounds set on it, this will remove them.
	 *
	 * @since 1.0.0
	 *
	 * @return This Camera instance.
	**/
	public function removeBounds():BaseCamera
	{
		useBounds = false;

		dirty = true;

		_bounds.setEmpty();

		return this;
	}

	/**
	 * Set the rotation of this Camera. This causes everything it renders to appear rotated.
	 *
	 * Rotating a camera does not rotate the viewport itself, it is applied during rendering.
	 *
	 * @since 1.0.0
	 *
	 * @param degrees - The cameras angle of rotation, given in degrees.
	 *
	 * @return This Camera instance.
	**/
	public function setAngle(degrees:Float = 0):BaseCamera
	{
		rotation = MathUtility.degToRad(degrees);
		return this;
	}

	/**
	 * Sets the background color for this Camera.
	 *
	 * By default a Camera has a transparent background but it can be given a solid color, with any level
	 * of transparency, via this method.
	 *
	 * The color value can be specified using CSS color notation, hex or numbers.
	 *
	 * @since 1.0.0
	 *
	 * @param color - The color value. In CSS, hex or numeric color notation.
	 *
	 * @return This Camera instance.
	**/
	public function setBackgroundColor(color:Union3<String, Int,
		InputColorObject>):BaseCamera
	{
		if (color == null)
		{
			backgroundColor = new Color(0, 0, 0, 0);
		}
		else
		{
			backgroundColor = Color.valueToColor(color);
		}

		transparent = (this.backgroundColor.alpha == 0);

		return this;
	}

	/**
	 * Set the bounds of the Camera. The bounds are an axis-aligned rectangle.
	 *
	 * The Camera bounds controls where the Camera can scroll to, stopping it from scrolling off the
	 * edges and into blank space. It does not limit the placement of Game Objects, or where
	 * the Camera viewport can be positioned.
	 *
	 * Temporarily disable the bounds by changing the boolean `Camera.useBounds`.
	 *
	 * Clear the bounds entirely by calling `Camera.removeBounds`.
	 *
	 * If you set bounds that are smaller than the viewport it will stop the Camera from being
	 * able to scroll. The bounds can be positioned where-ever you wish. By default they are from
	 * 0x0 to the canvas width x height. This means that the coordinate 0x0 is the top left of
	 * the Camera bounds. However, you can position them anywhere. So if you wanted a game world
	 * that was 2048x2048 in size, with 0x0 being the center of it, you can set the bounds x/y
	 * to be -1024, -1024, with a width and height of 2048. Depending on your game you may find
	 * it easier for 0x0 to be the top-left of the bounds, or you may wish 0x0 to be the middle.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The top-left x coordinate of the bounds.
	 * @param y - The top-left y coordinate of the bounds.
	 * @param width - The width of the bounds, in pixels.
	 * @param height - The height of the bounds, in pixels.
	 * @param centerOn - If `true` the Camera will automatically be centered on the new bounds.
	 *
	 * @return This Camera instance.
	**/
	public function setBounds(x:Int, y:Int, width:Int, height:Int,
			centerOn:Bool = false):BaseCamera
	{
		_bounds.setTo(x, y, width, height);

		dirty = true;
		useBounds = true;

		if (centerOn)
		{
			centerToBounds();
		}
		else
		{
			scrollX = clampX(scrollX);
			scrollY = clampY(scrollY);
		}

		return this;
	}

	/**
	 * Returns a rectangle containing the bounds of the Camera.
	 *
	 * If the Camera does not have any bounds the rectangle will be empty.
	 *
	 * The rectangle is a copy of the bounds, so is safe to modify.
	 *
	 * @since 1.0.0
	 *
	 * @param out - An optional Rectangle to store the bounds in. If not given, a new Rectangle will be created.
	 *
	 * @return A rectangle containing the bounds of this Camera.
	**/
	public inline function getBounds(?out:Rectangle):Rectangle
	{
		if (out == null)
		{
			out = new Rectangle();
		}

		var source = this._bounds;

		out.setTo(source.x, source.y, source.width, source.height);

		return out;
	}

	/**
	 * Sets the name of this Camera.
	 * This value is for your own use and isn't used internally.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The name of the Camera.
	 *
	 * @return This Camera instance.
	**/
	public function setName(value:String = ""):BaseCamera
	{
		name = value;
		return this;
	}

	/**
	 * Set the position of the Camera viewport within the game.
	 *
	 * This does not change where the camera is 'looking'. See `setScroll` to control that.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The top-left x coordinate of the Camera viewport.
	 * @param y - The top-left y coordinate of the Camera viewport.
	 *
	 * @return This Camera instance.
	**/
	public function setPosition(x:Float, ?y:Float):BaseCamera
	{
		var y:Float = y != null ? y : x;

		this.x = x;
		this.y = y;

		return this;
	}

	/**
	 * Set the rotation of this Camera. This causes everything it renders to appear rotated.
	 *
	 * Rotating a camera does not rotate the viewport itself, it is applied during rendering.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The rotation of the Camera, in radians.
	 *
	 * @return This Camera instance.
	**/
	public function setRotation(value:Float = 0):BaseCamera
	{
		rotation = value;
		return this;
	}

	/**
	 * Should the Camera round pixel values to whole integers when rendering Game Objects?
	 *
	 * In some types of game, especially with pixel art, this is required to prevent sub-pixel aliasing.
	 *
	 * @since 1.0.0
	 *
	 * @param value - `true` to round Camera pixels, `false` to not.
	 *
	 * @return This Camera instance.
	**/
	public function setRoundPixels(value:Bool):BaseCamera
	{
		roundPixels = value;
		return this;
	}

	/**
	 * Sets the Scene the Camera is bound to.
	 *
	 * Also populates the `resolution` property and updates the internal size values.
	 *
	 * @since 1.0.0
	 *
	 * @param scene - The Scene the camera is bound to.
	 *
	 * @return This Camera instance.
	**/
	public function setScene(scene:Scene):BaseCamera
	{
		if (scene != null && _customViewport != null)
		{
			sceneManager.customViewports--;
		}

		this.scene = scene;

		var sys = scene.sys;

		sceneManager = sys.game.scene;
		scaleManager = sys.scale;
		cameraManager = sys.cameras;

		var res = scaleManager.resolution;

		this.resolution = res;

		_cx = _x * res;
		_cy = _y * res;
		_cw = _width * res;
		_ch = _height * res;

		updateSystem();

		return this;
	}

	/**
	 * Set the position of where the Camera is looking within the game.
	 * You can also modify the properties `Camera.scrollX` and `Camera.scrollY` directly.
	 * Use this method, or the scroll properties, to move your camera around the game world.
	 *
	 * This does not change where the camera viewport is placed. See `setPosition` to control that.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The x coordinate of the Camera in the game world.
	 * @param y - The y coordinate of the Camera in the game world.
	 *
	 * @return This Camera instance.
	**/
	public function setScroll(x:Float, ?y:Float):BaseCamera
	{
		var y:Float = y != null ? y : x;

		scrollX = x;
		scrollY = y;

		return this;
	}

	/**
	 * Set the size of the Camera viewport.
	 *
	 * By default a Camera is the same size as the game, but can be made smaller via this method,
	 * allowing you to create mini-cam style effects by creating and positioning a smaller Camera
	 * viewport within your game.
	 *
	 * @since 1.0.0
	 *
	 * @param width - The width of the Camera viewport.
	 * @param height - The height of the Camera viewport.
	 *
	 * @return This Camera instance.
	**/
	public function setSize(width:Int, ?height:Int):BaseCamera
	{
		var height:Int = height != null ? height : width;

		this.width = width;
		this.height = height;

		return this;
	}

	/**
	 * This method sets the position and size of the Camera viewport in a single call.
	 *
	 * If you're trying to change where the Camera is looking at in your game, then see
	 * the method `Camera.setScroll` instead. This method is for changing the viewport
	 * itself, not what the camera can see.
	 *
	 * By default a Camera is the same size as the game, but can be made smaller via this method,
	 * allowing you to create mini-cam style effects by creating and positioning a smaller Camera
	 * viewport within your game.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The top-left x coordinate of the Camera viewport.
	 * @param y - The top-left y coordinate of the Camera viewport.
	 * @param width - The width of the Camera viewport.
	 * @param height - The height of the Camera viewport.
	 *
	 * @return This Camera instance.
	**/
	public function setViewport(x:Float, y:Float, width:Int, height:Int):BaseCamera
	{
		this.x = x;
		this.y = y;
		this.width = width;
		this.height = height;

		return this;
	}

	/**
	 * Set the zoom value of the Camera.
	 *
	 * Changing to a smaller value, such as 0.5, will cause the camera to 'zoom out'.
	 * Changing to a larger value, such as 2, will cause the camera to 'zoom in'.
	 *
	 * A value of 1 means 'no zoom' and is the default.
	 *
	 * Changing the zoom does not impact the Camera viewport in any way, it is only applied during rendering.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The zoom value of the Camera. The minimum it can be is 0.001.
	 *
	 * @return This Camera instance.
	**/
	public function setZoom(value:Float = 1):BaseCamera
	{
		if (value == 0)
		{
			value = 0.001;
		}
		zoom = value;
		return this;
	}

	/**
	 * Sets the mask to be applied to this Camera during rendering.
	 *
	 * The mask must have been previously created and can be either a GeometryMask or a BitmapMask.
	 *
	 * Bitmap Masks only work on WebGL. Geometry Masks work on both WebGL and Canvas.
	 *
	 * If a mask is already set on this Camera it will be immediately replaced.
	 *
	 * Masks have no impact on physics or input detection. They are purely a rendering component
	 * that allows you to limit what is visible during the render pass.
	 *
	 * Note: You cannot mask a Camera that has `renderToTexture` set.
	 *
	 * @since 1.0.0
	 *
	 * @param mask - The mask this Camera will use when rendering.
	 * @param fixedPosition - Should the mask translate along with the Camera, or be fixed in place and not impacted by the Cameras transform?
	 *
	 * @return This Camera instance.
	**/
	public function setMask(mask:Mask, fixedPosition:Bool = true)
	{
		this.mask = mask;

		_maskCamera = (fixedPosition) ? this.cameraManager.defaultMask : this;

		return this;
	}

	/**
	 * Clears the mask that this Camera was using.
	 *
	 * @since 1.0.0
	 *
	 * @param destroyMask - Destroy the mask before clearing it?
	 *
	 * @return This Camera instance.
	**/
	public function clearMask(destroyMask:Bool = false):BaseCamera
	{
		if (destroyMask && mask != null)
		{
			mask.destroy();
		}

		mask = null;

		return this;
	}

	/**
	 * Returns an Object suitable for JSON storage containing all of the Camera viewport and rendering properties.
	 *
	 * @since 1.0.0
	 *
	 * @return A well-formed object suitable for conversion to JSON.
	**/
	public function toJSON()
	{
		var output = {
			name: this.name,
			x: this.x,
			y: this.y,
			width: this.width,
			height: this.height,
			zoom: this.zoom,
			rotation: this.rotation,
			roundPixels: this.roundPixels,
			scrollX: this.scrollX,
			scrollY: this.scrollY,
			backgroundColor: this.backgroundColor.rgba,
			bounds: if (useBounds)
			{
				{
					x: this._bounds.x,
					y: this._bounds.y,
					width: this._bounds.width,
					height: this._bounds.height
				};
			}
			else
			{
				null;
			}
		};

		return output;
	}

	/**
	 * Internal method called automatically by the Camera Manager.
	 *
	 * @since 1.0.0
	 *
	 * @param time - The current timestamp as generated by the Request Animation Frame or SetTimeout.
	 * @param delta - The delta time, in ms, elapsed since the last frame.
	**/
	@:allow(phaserHaxe)
	private function update()
	{
		//  NOOP
	}

	/**
	 * Internal method called automatically when the viewport changes.
	 *
	 * @since 1.0.0
	**/
	public function updateSystem()
	{
		if (scaleManager == null)
		{
			return;
		}

		var custom = (_x != 0 || _y != 0 || scaleManager.width != _width || scaleManager.height != _height);

		var sceneManager = sceneManager;

		if (custom && !_customViewport)
		{
			//  We need a custom viewport for this Camera
			sceneManager.customViewports++;
		}
		else if (!custom && _customViewport)
		{
			//  We're turning off a custom viewport for this Camera
			sceneManager.customViewports--;
		}

		dirty = true;
		_customViewport = custom;
	}

	/**
	 * Destroys this Camera instance and its internal properties and references.
	 * Once destroyed you cannot use this Camera again, even if re-added to a Camera Manager.
	 *
	 * This method is called automatically by `CameraManager.remove` if that methods `runDestroy` argument is `true`, which is the default.
	 *
	 * Unless you have a specific reason otherwise, always use `CameraManager.remove` and allow it to handle the camera destruction,
	 * rather than calling this method directly.
	 *
	 * @since 1.0.0
	**/
	public function destroy()
	{
		emit(Events.DESTROY, [this]);

		removeAllListeners();

		matrix.destroy();

		culledObjects = [];

		if (_customViewport)
		{
			//  We're turning off a custom viewport for this Camera
			sceneManager.customViewports--;
		}

		_bounds = null;

		scene = null;
		scaleManager = null;
		sceneManager = null;
		cameraManager = null;
	}
}
