package phaserHaxe.cameras.scene2D;

import phaserHaxe.display.mask.Mask;
import phaserHaxe.gameobjects.GameObject;
import phaserHaxe.display.Color;
import phaserHaxe.gameobjects.components.IAlpha;
import phaserHaxe.gameobjects.components.IVisible;
import phaserHaxe.scene.SceneManager;
import phaserHaxe.math.MathUtility.clamp as clamp;
import phaserHaxe.scale.ScaleManager;
import phaserHaxe.geom.Rectangle;
import phaserHaxe.gameobjects.components.TransformMatrix;
import phaserHaxe.math.Vector2;

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
class BaseCamera extends EventEmitter implements IAlpha implements IVisible
{
	/**
	 * Private internal value. Holds the visible value.
	 *
	 * @since 1.0.0
	**/
	private var _visible:Bool = true;

	/**
	 * Private internal value. Holds the global alpha value.
	 *
	 * @since 1.0.0
	**/
	private var _alpha:Float = 1;

	/**
	 * Private internal value. Holds the top-left alpha value.
	 *
	 * @since 1.0.0
	**/
	private var _alphaTL:Float = 1;

	/**
	 * Private internal value. Holds the top-right alpha value.
	 *
	 * @since 1.0.0
	**/
	private var _alphaTR:Float = 1;

	/**
	 * Private internal value. Holds the bottom-left alpha value.
	 *
	 * @since 1.0.0
	**/
	private var _alphaBL:Float = 1;

	/**
	 * Private internal value. Holds the bottom-right alpha value.
	 *
	 * @since 1.0.0
	**/
	private var _alphaBR:Float = 1;

	/**
	 * The flags that are compared against `RENDER_MASK` to determine if this Game Object will render or not.
	 * The bits are 0001 | 0010 | 0100 | 1000 set by the components Visible, Alpha, Transform and Texture respectively.
	 * If those components are not used by your custom class then you can use this bitmask as you wish.
	 *
	 * @since 1.0.0
	**/
	public var renderFlags:Int = 15;

	/**
	 * The alpha value of the Game Object.
	 *
	 * This is a global value, impacting the entire Game Object, not just a region of it.
	 *
	 * @since 1.0.0
	**/
	public var alpha(get, set):Float;

	/**
	 * The alpha value starting from the top-left of the Game Object.
	 * This value is interpolated from the corner to the center of the Game Object.
	 *
	 * @webglOnly
	 * @since 1.0.0
	**/
	public var alphaTopLeft(get, set):Float;

	/**
	 * The alpha value starting from the top-right of the Game Object.
	 * This value is interpolated from the corner to the center of the Game Object.
	 *
	 * @webglOnly
	 * @since 1.0.0
	**/
	public var alphaTopRight(get, set):Float;

	/**
	 * The alpha value starting from the bottom-left of the Game Object.
	 * This value is interpolated from the corner to the center of the Game Object.
	 *
	 * @webglOnly
	 * @since 1.0.0
	**/
	public var alphaBottomLeft(get, set):Float;

	/**
	 * The alpha value starting from the bottom-right of the Game Object.
	 * This value is interpolated from the corner to the center of the Game Object.
	 *
	 * @webglOnly
	 * @since 1.0.0
	**/
	public var alphaBottomRight(get, set):Float;

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
	public final resolution:Float = 1;

	/**
	 * Should this camera round its pixel values to integers?
	 *
	 * @since 1.0.0
	**/
	public var roundPixels:Bool = false;

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
	private var _cx:Float = 0;

	/**
	 * Internal Camera Y value multiplied by the resolution.
	 *
	 * @since 1.0.0
	**/
	private var _cy:Float = 0;

	/**
	 * Internal Camera Width value multiplied by the resolution.
	 *
	 * @since 1.0.0
	**/
	private var _cw:Float = 0;

	/**
	 * Internal Camera Height value multiplied by the resolution.
	 *
	 * @since 1.0.0
	**/
	private var _ch:Float = 0;

	/**
	 * The width of the Camera viewport, in pixels.
	 *
	 * The viewport is the area into which the Camera renders. Setting the viewport does
	 * not restrict where the Camera can scroll to.
	 *
	 * @since 1.0.0
	**/
	private var _width:Float;

	/**
	 * The height of the Camera viewport, in pixels.
	 *
	 * The viewport is the area into which the Camera renders. Setting the viewport does
	 * not restrict where the Camera can scroll to.
	 *
	 * @since 1.0.0
	**/
	private var _height:Float;

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
	public var backgroundColor:Color;

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
	public var midPoint:Vector2;

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

	private inline function get_alphaTopLeft():Float
	{
		return _alphaTL;
	}

	private inline function set_alphaTopLeft(value:Float):Float
	{
		final v = clamp(value, 0, 1);
		_alphaTL = v;

		if (v != 0)
		{
			renderFlags |= 2;
		}

		return v;
	}

	private inline function get_alphaTopRight():Float
	{
		return _alphaTR;
	}

	private inline function set_alphaTopRight(value:Float):Float
	{
		final v = clamp(value, 0, 1);

		_alphaTR = v;

		if (v != 0)
		{
			renderFlags |= 2;
		}

		return v;
	}

	private inline function get_alpha():Float
	{
		return _alpha;
	}

	private inline function set_alpha(value:Float):Float
	{
		final v = clamp(value, 0, 1);

		_alpha = v;
		_alphaTL = v;
		_alphaTR = v;
		_alphaBL = v;
		_alphaBR = v;

		if (v == 0)
		{
			renderFlags &= ~2;
		}
		else
		{
			renderFlags |= 2;
		}

		return v;
	}

	private inline function get_alphaBottomLeft():Float
	{
		return _alphaBL;
	}

	private inline function set_alphaBottomLeft(value:Float):Float
	{
		final v = clamp(value, 0, 1);

		_alphaBL = v;

		if (v != 0)
		{
			renderFlags |= 2;
		}

		return v;
	}

	private inline function get_alphaBottomRight():Float
	{
		return _alphaBR;
	}

	private inline function set_alphaBottomRight(value:Float):Float
	{
		final v = clamp(value, 0, 1);

		_alphaBR = v;

		if (v != 0)
		{
			renderFlags |= 2;
		}

		return v;
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

	private inline function get_width():Float
	{
		return _width;
	}

	private inline function set_width(value:Float):Float
	{
		this._width = value;
		this._cw = value * this.resolution;
		// this.updateSystem();
		return _width;
	}

	private inline function get_height():Float
	{
		return _height;
	}

	private inline function set_height(value:Float):Float
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

	/**
	 * Clears all alpha values associated with this Game Object.
	 *
	 * Immediately sets the alpha levels back to 1 (fully opaque).
	 *
	 * @since 1.0.0
	 *
	 * @return This Game Object instance.
	**/
	public function clearAlpha():BaseCamera
	{
		setAlpha(1);
		return this;
	}

	/**
	 * Set the Alpha level of this Game Object. The alpha controls the opacity of the Game Object as it renders.
	 * Alpha values are provided as a float between 0, fully transparent, and 1, fully opaque.
	 *
	 * If your game is running under WebGL you can optionally specify four different alpha values, each of which
	 * correspond to the four corners of the Game Object. Under Canvas only the `topLeft` value given is used.
	 *
	 * @since 1.0.0
	 *
	 * @param topLeft - The alpha value used for the top-left of the Game Object. If this is the only value given it's applied across the whole Game Object.
	 * @param topRight - The alpha value used for the top-right of the Game Object. WebGL only.
	 * @param bottomLeft - The alpha value used for the bottom-left of the Game Object. WebGL only.
	 * @param bottomRight - The alpha value used for the bottom-right of the Game Object. WebGL only.
	 *
	 * @return This Game Object instance.
	**/
	public function setAlpha(topLeft:Float = 1, ?topRight:Float, ?bottomLeft:Float,
			?bottomRight:Float):BaseCamera
	{
		//  Treat as if there is only one alpha value for the whole Game Object
		if (topRight == null)
		{
			alpha = topLeft;
		}
		else
		{
			_alphaTL = clamp(topLeft, 0, 1);
			_alphaTR = clamp(topRight, 0, 1);
			_alphaBL = clamp(bottomLeft, 0, 1);
			_alphaBR = clamp(bottomRight, 0, 1);
		}

		return this;
	}

	private inline function get_visible():Bool
	{
		return _visible;
	}

	private function set_visible(value:Bool):Bool
	{
		if (value)
		{
			_visible = true;
			renderFlags |= 1;
		}
		else
		{
			_visible = false;
			renderFlags &= ~1;
		}
		return value;
	}

	/**
	 * Sets the visibility of this Game Object.
	 *
	 * An invisible Game Object will skip rendering, but will still process update logic.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The visible state of the Game Object.
	 *
	 * @return This Game Object instance.
	**/
	public function setVisible(value:Bool):BaseCamera
	{
		visible = value;
		return this;
	}
}
