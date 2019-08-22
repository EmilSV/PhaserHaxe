package phaserHaxe;

import haxe.macro.Expr.Case;
import haxe.ds.Option;
import phaserHaxe.core.GamepadInputConfig;
import phaserHaxe.core.TouchInputConfig;
import phaserHaxe.core.MouseInputConfig;
import phaserHaxe.core.KeyboardInputConfig;
import js.Browser;
import phaserHaxe.core.InputConfig;
import phaserHaxe.Const;
import haxe.ds.ReadOnlyArray;
import phaserHaxe.core.WebGameConfig;
import js.html.webgl.PowerPreference;
import phaserHaxe.core.PhysicsConfig;
import phaserHaxe.core.BootCallback;
import phaserHaxe.display.Color;
import phaserHaxe.core.RenderConfig;
import phaserHaxe.core.FPSConfig;
import phaserHaxe.core.AudioConfig;
import js.html.webgl.WebGL2RenderingContext;
import js.html.CanvasRenderingContext2D;
import js.html.CanvasElement;
import phaserHaxe.core.ScaleConfig;
import js.html.HtmlElement;
import phaserHaxe.scale.CenterType;
import phaserHaxe.scale.ScaleModeType;
import phaserHaxe.scale.ZoomType;
import phaserHaxe.device.Input as DeviceInput;

class Config
{
	/**
	 * The width of the underlying canvas, in pixels.
	 *
	 * @since 1.0.0
	**/
	public final width:Either<Int, String>;

	/**
	 * The height of the underlying canvas, in pixels.
	 *
	 * @since 1.0.0
	**/
	public final height:Either<Int, String>;

	/**
	 * The zoom factor, as used by the Scale Manager.
	 *
	 * @since 1.0.0
	**/
	public final zoom:ZoomType;

	/**
	 * The canvas device pixel resolution. Currently un-used.
	 *
	 * @since 1.0.0
	**/
	public final resolution:Float;

	/**
	 * A parent DOM element into which the canvas created by the renderer will be injected.
	 *
	 * @since 1.0.0
	**/
	public final parent:Null<Any>;

	/**
	 * The scale mode as used by the Scale Manager. The default is zero, which is no scaling.
	 *
	 * @since 1.0.0
	**/
	public final scaleMode:ScaleModeType;

	/**
	 * Is the Scale Manager allowed to adjust the CSS height property of the parent to be 100%?
	 *
	 * @since 1.0.0
	**/
	public final expandParent:Bool;

	/**
	 * Automatically round the display and style sizes of the canvas. This can help with performance in lower-powered devices.
	 *
	 * @since 1.0.0
	**/
	public final autoRound:Bool;

	/**
	 * Automatically center the canvas within the parent?
	 *
	 * @since 1.0.0
	**/
	public final autoCenter:CenterType;

	/**
	 * How many ms should elapse before checking if the browser size has changed?
	 *
	 * @since 1.0.0
	**/
	public final resizeInterval:Int;

	/**
	 * The DOM element that will be sent into full screen mode, or its `id`.
	 * If undefined Phaser will create its own div and insert the canvas into it when entering fullscreen mode.
	 *
	 * @since 1.0.0
	**/
	public final fullscreenTarget:Null<Either<HtmlElement, String>>;

	/**
	 * The minimum width, in pixels, the canvas will scale down to. A value of zero means no minimum.
	 *
	 * @since 1.0.0
	**/
	public final minWidth:Int;

	/**
	 * The maximum width, in pixels, the canvas will scale up to. A value of zero means no maximum.
	 *
	 * @since 1.0.0
	**/
	public final maxWidth:Int;

	/**
	 * The minimum height, in pixels, the canvas will scale down to. A value of zero means no minimum.
	 *
	 * @since 1.0.0
	**/
	public final minHeight:Int;

	/**
	 * The maximum height, in pixels, the canvas will scale up to. A value of zero means no maximum.
	 *
	 * @since 1.0.0
	**/
	public final maxHeight:Int;

	/**
	 * Force Phaser to use a specific renderer. Can be `CONST.CANVAS`, `CONST.WEBGL`, `CONST.HEADLESS` or `CONST.AUTO` (default)
	 *
	 * @since 1.0.0
	**/
	public final renderType:Int;

	/**
	 * Force Phaser to use your own Canvas element instead of creating one.
	 *
	 * @since 1.0.0
	**/
	public final canvas:Null<CanvasElement>;

	/**
	 * Force Phaser to use your own Canvas context instead of creating one.
	 *
	 * @since 1.0.0
	**/
	public final context:Null<Either<CanvasRenderingContext2D, WebGL2RenderingContext>>;

	/**
	 * Optional CSS attributes to be set on the canvas object created by the renderer.
	 *
	 * @since 1.0.0
	**/
	public final canvasStyle:Null<String>;

	/**
	 * Is Phaser running under a custom (non-native web) environment? If so, set this to `true` to skip internal Feature detection. If `true` the `renderType` cannot be left as `AUTO`.
	 *
	 * @since 1.0.0
	**/
	public final customEnvironment:Bool;

	/**
	 * The default Scene configuration object.
	 *
	 * @since 1.0.0
	**/
	public final sceneConfig:Null<Any>;

	/**
	 * A seed which the Random Data Generator will use. If not given, a dynamic seed based on the time is used.
	 *
	 * @since 1.0.0
	**/
	public final seed:Array<String>;

	/**
	 * The title of the game.
	 *
	 * @since 1.0.0
	**/
	public final gameTitle:String;

	/**
	 * The URL of the game.
	 *
	 * @since 1.0.0
	**/
	public final gameURL:String;

	/**
	 * The version of the game.
	 *
	 * @since 1.0.0
	**/
	public final gameVersion:String;

	/**
	 * If `true` the window will automatically be given focus immediately and on any future mousedown event.
	 *
	 * @since 1.0.0
	**/
	public final autoFocus:Bool;

	/**
	 * Should the game create a div element to act as a DOM Container? Only enable if you're using DOM Element objects. You must provide a parent object if you use this feature.
	 *
	 * @since 1.0.0
	**/
	public final domCreateContainer:Null<Bool>;

	/**
	 * Should the DOM Container that is created (if `dom.createContainer` is true) be positioned behind (true) or over the top (false, the default) of the game canvas?
	 *
	 * @since 1.0.0
	**/
	public final domBehindCanvas:Null<Bool>;

	/**
	 * Enable the Keyboard Plugin. This can be disabled in games that don't need keyboard input.
	 *
	 * @since 1.0.0
	**/
	public final inputKeyboard:Bool;

	/**
	 * The DOM Target to listen for keyboard events on. Defaults to `window` if not specified.
	 *
	 * @since 1.0.0
	**/
	public final inputKeyboardEventTarget:Any;

	/**
	 * `preventDefault` will be called on every non-modified key which has a key code in this array. By default, it is empty.
	 *
	 * @since 1.0.0
	**/
	public final inputKeyboardCapture:Null<Array<Int>>;

	/**
	 * Enable the Mouse Plugin. This can be disabled in games that don't need mouse input.
	 *
	 * @since 1.0.0
	**/
	public final inputMouse:Either<Bool, Any>;

	/**
	 * The DOM Target to listen for mouse events on. Defaults to the game canvas if not specified.
	 *
	 * @since 1.0.0
	**/
	public final inputMouseEventTarget:Any;

	/**
	 * Should mouse events be captured? I.e. have prevent default called on them.
	 *
	 * @since 1.0.0
	**/
	public final inputMouseCapture:Bool;

	/**
	 * Enable the Touch Plugin. This can be disabled in games that don't need touch input.
	 *
	 * @since 1.0.0
	**/
	public final inputTouch:Bool;

	/**
	 * The DOM Target to listen for touch events on. Defaults to the game canvas if not specified.
	 *
	 * @since 1.0.0
	**/
	public final inputTouchEventTarget:Any;

	/**
	 * Should touch events be captured? I.e. have prevent default called on them.
	 *
	 * @since 1.0.0
	**/
	public final inputTouchCapture:Bool;

	/**
	 * The number of Pointer objects created by default. In a mouse-only, or non-multi touch game, you can leave this as 1.
	 *
	 * @since 1.0.0
	**/
	public final inputActivePointers:Int;

	/**
	 * The smoothing factor to apply during Pointer movement. See {@link Phaser.Input.Pointer#smoothFactor}.
	 *
	 * @since 1.0.0
	**/
	public final inputSmoothFactor:Int;

	/**
	 * Should Phaser listen for input events on the Window? If you disable this, events like 'POINTER_UP_OUTSIDE' will no longer fire.
	 *
	 * @since 1.0.0
	**/
	public final inputWindowEvents:Bool;

	/**
	 * Enable the Gamepad Plugin. This can be disabled in games that don't need gamepad input.
	 *
	 * @since 1.0.0
	**/
	public final inputGamepad:Bool;

	/**
	 * The DOM Target to listen for gamepad events on. Defaults to `window` if not specified.
	 *
	 * @since 1.0.0
	**/
	public final inputGamepadEventTarget:Any;

	/**
	 * Set to `true` to disable the right-click context menu.
	 *
	 * @since 1.0.0
	**/
	public final disableContextMenu:Bool;

	/**
	 * The Audio Configuration object.
	 *
	 * @since 1.0.0
	**/
	public final audio:AudioConfig;

	/**
	 * Don't write the banner line to the console.log.
	 *
	 * @since 1.0.0
	**/
	public final hideBanner:Bool;

	/**
	 * Omit Phaser's name and version from the banner.
	 *
	 * @since 1.0.0
	**/
	public final hidePhaser:Bool;

	/**
	 * The color of the banner text.
	 *
	 * @since 1.0.0
	**/
	public final bannerTextColor:String;

	/**
	 * The background colors of the banner.
	 *
	 * @since 1.0.0
	**/
	public final bannerBackgroundColor:Array<String>;

	/**
	 * The Frame Rate Configuration object, as parsed by the Timestep class.
	 *
	 * @since 1.0.0
	**/
	public final fps:FPSConfig;

	/**
	 *
	 *
	 * @since 1.0.0
	**/
	public final renderConfig:RenderConfig;

	/**
	 * When set to `true`, WebGL uses linear interpolation to draw scaled or
	 * rotated textures, giving a smooth appearance. When set to `false`,
	 * WebGL uses nearest-neighbor interpolation, giving a crisper appearance.
	 * `false` also disables antialiasing of the game canvas itself,
	 * if the browser supports it, when the game canvas is scaled.
	 *
	 * @since 1.0.0
	**/
	public final antialias:Bool;

	/**
	 * When set to `true` it will create a desynchronized context for both 2D and WebGL.
	 * See https://developers.google.com/web/updates/2019/05/desynchronized for details.
	 *
	 * @since 1.0.0
	**/
	public final desynchronized:Bool;

	/**
	 * Draw texture-based Game Objects at only whole-integer positions. Game Objects without textures, like Graphics, ignore this property.
	 *
	 * @since 1.0.0
	**/
	public final roundPixels:Bool;

	/**
	 * Prevent pixel art from becoming blurred when scaled. It will remain crisp (tells the WebGL renderer to automatically create textures using a linear filter mode).
	 *
	 * @since 1.0.0
	**/
	public final pixelArt:Bool;

	/**
	 * Whether the game canvas will have a transparent background.
	 *
	 * @since 1.0.0
	**/
	public final transparent:Bool;

	/**
	 * Whether the game canvas will be cleared between each rendering frame. You can disable this if you have a full-screen background image or game object.
	 *
	 * @since 1.0.0
	**/
	public final clearBeforeRender:Bool;

	/**
	 * In WebGL mode, sets the drawing buffer to contain colors with pre-multiplied alpha.
	 *
	 * @since 1.0.0
	**/
	public final premultipliedAlpha:Bool;

	/**
	 * Let the browser abort creating a WebGL context if it judges performance would be unacceptable.
	 *
	 * @since 1.0.0
	**/
	public final failIfMajorPerformanceCaveat:Bool;

	/**
	 * "high-performance", "low-power" or "default". A hint to the browser on how much device power the game might use.
	 *
	 * @since 1.0.0
	**/
	public final powerPreference:PowerPreference;

	/**
	 * The default WebGL Batch size.
	 *
	 * @since 1.0.0
	**/
	public final batchSize:Int;

	/**
	 * The maximum number of lights allowed to be visible within range of a single Camera in the LightManager.
	 *
	 * @since 1.0.0
	**/
	public final maxLights:Int;

	/**
	 * The background color of the game canvas. The default is black. This value is ignored if `transparent` is set to `true`.
	 *
	 * @since 1.0.0
	**/
	public final backgroundColor:Color;

	/**
	 * Called before Phaser boots. Useful for initializing anything not related to Phaser that Phaser may require while booting.
	 *
	 * @since 1.0.0
	**/
	public final preBoot:BootCallback;

	/**
	 * A function to run at the end of the boot sequence. At this point, all the game systems have started and plugins have been loaded.
	 *
	 * @since 1.0.0
	**/
	public final postBoot:BootCallback;

	/**
	 * The Physics Configuration object.
	 *
	 * @since 1.0.0
	**/
	public final physics:PhysicsConfig;

	/**
	 * The default physics system. It will be started for each scene. Either 'arcade', 'impact' or 'matter'.
	 *
	 * @since 1.0.0
	**/
	public final defaultPhysicsSystem:Either<Bool, String>;

	/**
	 * A URL used to resolve paths given to the loader. Example: 'http://labs.phaser.io/assets/'.
	 *
	 * @since 1.0.0
	**/
	public final loaderBaseURL:String;

	/**
	 * A URL path used to resolve relative paths given to the loader. Example: 'images/sprites/'.
	 *
	 * @since 1.0.0
	**/
	public final loaderPath:String;

	/**
	 * Maximum parallel downloads allowed for resources (Default to 32).
	 *
	 * @since 1.0.0
	**/
	public final loaderMaxParallelDownloads:Int;

	/**
	 * 'anonymous', 'use-credentials', or `undefined`. If you're not making cross-origin requests, leave this as `undefined`. See {@link https://developer.mozilla.org/en-US/docs/Web/HTML/CORS_settings_attributes}.
	 *
	 * @since 1.0.0
	**/
	public final loaderCrossOrigin:Null<String>;

	/**
	 * The response type of the XHR request, e.g. `blob`, `text`, etc.
	 *
	 * @since 1.0.0
	**/
	public final loaderResponseType:String;

	/**
	 * Should the XHR request use async or not?
	 *
	 * @since 1.0.0
	**/
	public final loaderAsync:Bool;

	/**
	 * Optional username for all XHR requests.
	 *
	 * @since 1.0.0
	**/
	public final loaderUser:String;

	/**
	 * Optional password for all XHR requests.
	 *
	 * @since 1.0.0
	**/
	public final loaderPassword:String;

	/**
	 * Optional XHR timeout value, in ms.
	 *
	 * @since 1.0.0
	**/
	public final loaderTimeout:Int;

	/**
	 * An array of global plugins to be installed.
	 *
	 * @since 1.0.0
	**/
	public final installGlobalPlugins:Array<Any>;

	/**
	 * An array of Scene level plugins to be installed.
	 *
	 * @since 1.0.0
	**/
	public final installScenePlugins:Array<Any>;

	/**
	 * The plugins installed into every Scene (in addition to CoreScene and Global).
	 *
	 * @since 1.0.0
	**/
	public final defaultPlugins:Array<Any>;

	/**
	 * A base64 encoded PNG that will be used as the default blank texture.
	 *
	 * @since 1.0.0
	**/
	public final defaultImage:String;

	/**
	 * A base64 encoded PNG that will be used as the default texture when a texture is assigned that is missing or not loaded.
	 *
	 * @since 1.0.0
	**/
	public final missingImage:String;

	// private static function defaultConfig():WebGameConfig
	// {
	// 	return {
	// 		width: 1024,
	// 		height: 768,
	// 		zoom: 1,
	// 		resolution: 1,
	// 		parent: null,
	// 		scaleMode: 0,
	// 		expandParent: true,
	// 		autoRound: false,
	// 		autoCenter: 0,
	// 		resizeInterval: 500,
	// 		fullscreenTarget: null,
	// 		minWidth: 500,
	// 		maxWidth: 500,
	// 		minHeight: 500,
	// 		maxHeight: 500,
	// 		scale: {
	// 			width: 1024,
	// 			height: 768,
	// 			zoom: 1,
	// 			resolution: 1,
	// 			parent: null,
	// 			mode: 0,
	// 			expandParent: true,
	// 			autoRound: false,
	// 			autoCenter: 0,
	// 			fullscreenTarget: null,
	// 			min: {
	// 				width: 500,
	// 				height: 500
	// 			},
	// 			max: {
	// 				width: 500,
	// 				height: 500,
	// 			}
	// 		},
	// 		type: Const.AUTO,
	// 		canvas: null,
	// 		context: null,
	// 		customEnvironment: false,
	// 		scene: null,
	// 		seed: [Std.string((Date.now().getTime() * Math.random()))],
	// 		title: "",
	// 		url: "https://phaser.io",
	// 		version: "",
	// 		autoFocus: true,
	// 		dom: {
	// 			createContainer: false,
	// 			behindCanvas: false
	// 		},
	// 		input: Some({
	// 			keyboard: Some({
	// 				target: Browser.window,
	// 				capture: []
	// 			}),
	// 			mouse: Some({
	// 				target: null,
	// 				capture: true
	// 			}),
	// 			touch: DeviceInput.touch ? Some({
	// 				target: null,
	// 				capture: true
	// 			}) : None,
	// 			activePointers: 1,
	// 			smoothFactor: 0,
	// 			windowEvents: true,
	// 			gamepad: None
	// 		}),
	// 		audio: null,
	// 		banner:
	// 	};
	// }

	public function new(config:Null<WebGameConfig>)
	{
		inline function getValue<T>(value:Null<T>, defaultValue:T)
		{
			return value != null ? value : defaultValue;
		}

		if (config != null)
		{
			config = {};
		}

		final defaultBannerColor = ['#ff0000', '#ffff00', '#00ff00', '#00ffff', '#000000'];

		final defaultBannerTextColor = '#ffffff';

		width = getValue(config.width, 1024);

		height = getValue(config.height, 768);

		zoom = getValue(config.zoom, 1);

		resolution = getValue(config.resolution, 1);

		parent = getValue(config.parent, null);

		scaleMode = getValue(config.scaleMode, 0);

		expandParent = getValue(config.expandParent, true);

		autoRound = getValue(config.autoRound, false);

		autoCenter = getValue(config.autoCenter, 0);

		fullscreenTarget = getValue(config.fullscreenTarget, null);

		minWidth = getValue(config.minWidth, 500);

		maxWidth = getValue(config.maxWidth, 500);

		minHeight = getValue(config.minHeight, 500);

		maxHeight = getValue(config.maxHeight, 500);

		var scaleConfig = getValue(config.scale, null);

		if (scaleConfig != null)
		{
			width = getValue(scaleConfig.width, 1024);

			height = getValue(scaleConfig.height, 768);

			zoom = getValue(scaleConfig.zoom, 1);

			resolution = getValue(scaleConfig.resolution, 1);

			parent = getValue(scaleConfig.parent, null);

			scaleMode = getValue(scaleConfig.mode, 0);

			expandParent = getValue(scaleConfig.expandParent, true);

			autoRound = getValue(scaleConfig.autoRound, false);

			autoCenter = getValue(scaleConfig.autoCenter, 0);

			fullscreenTarget = getValue(scaleConfig.fullscreenTarget, null);

			if (scaleConfig.min != null)
			{
				minWidth = getValue(scaleConfig.min.width, 500);
				minHeight = getValue(scaleConfig.min.height, 500);
			}
			else
			{
				minWidth = 500;
				minHeight = 500;
			}

			if (scaleConfig.max != null)
			{
				maxWidth = getValue(scaleConfig.max.width, 500);
				maxHeight = getValue(scaleConfig.max.height, 500);
			}
			else
			{
				maxWidth = 500;
				maxHeight = 500;
			}

			renderType = getValue(config.type, Const.AUTO);

			canvas = getValue(config.canvas, null);

			context = getValue(config.context, null);

			customEnvironment = getValue(config.customEnvironment, false);

			sceneConfig = getValue(config.scene, null);

			seed = getValue(config.seed, [Std.string((Date.now()
				.getTime() * Math.random()))]);

			gameTitle = getValue(config.title, "");

			gameURL = getValue(config.url, "https://phaser.io");

			gameVersion = getValue(config.version, '');

			autoFocus = getValue(config.autoFocus, true);

			if (config.dom != null)
			{
				domCreateContainer = getValue(config.dom.createContainer, false);
				domBehindCanvas = getValue(config.dom.createContainer, false);
			}
			else
			{
				domCreateContainer = false;
				domBehindCanvas = false;
			}

			//  Input

			switch (config.input)
			{
				case null | None:
					inputKeyboard = config.input != None;
					inputKeyboardEventTarget = Browser.window;
					inputKeyboardCapture = [];

					inputMouse = config.input != None;
					inputMouseEventTarget = null;
					inputMouseCapture = true;

					inputTouch = config.input != None && DeviceInput.touch;
					inputTouchEventTarget = null;
					inputTouchCapture = true;

					inputGamepad = false;
					inputGamepadEventTarget = Browser.window;

					inputActivePointers = 1;
					inputSmoothFactor = 0;
					inputWindowEvents = true;

				case Some(v):
					switch (v.keyboard)
					{
						case None | null:
							inputKeyboard = v.keyboard != None;
							inputKeyboardEventTarget = Browser.window;
							inputKeyboardCapture = [];
						case Some(v):
							inputKeyboard = true;
							inputKeyboardEventTarget = getValue(v.target, Browser.window);
							inputKeyboardCapture = getValue(v.capture, []);
					}

					switch (v.mouse)
					{
						case None | null:
							inputMouse = v.mouse != None;
							inputMouseEventTarget = null;
							inputMouseCapture = true;
						case Some(v):
							inputMouse = true;
							inputMouseEventTarget = getValue(v.target, null);
							inputMouseCapture = getValue(v.capture, true);
					}

					switch (v.touch)
					{
						case None | null:
							inputTouch = config.input != None && DeviceInput.touch;
							inputTouchEventTarget = null;
							inputTouchCapture = true;
						case Some(v):
							inputTouch = true;
							inputTouchEventTarget = getValue(v.target, null);
							inputTouchCapture = getValue(v.capture, true);
					}

					switch (v.gamepad)
					{
						case None | null:
							inputGamepad = false;
							inputGamepadEventTarget = Browser.window;
						case Some(v):
							inputGamepad = true;
							inputGamepadEventTarget = getValue(v.target, Browser.window);
					}

					inputActivePointers = getValue(v.activePointers, 1);
					inputSmoothFactor = getValue(v.smoothFactor, 0);
					inputWindowEvents = getValue(v.windowEvents, true);
			}

			audio = config.audio;

			hideBanner = (getValue(config.banner, null) != None);

			switch (config.banner)
			{
				case None | null:
					hideBanner = config.banner != None;
					hidePhaser = false;
					bannerTextColor = defaultBannerTextColor;
					bannerBackgroundColor = defaultBannerColor;
				case Some(v):
					hideBanner = false;
					hidePhaser = getValue(v.hidePhaser, false);
					bannerTextColor = getValue(v.text, defaultBannerTextColor);
					bannerBackgroundColor = getValue(v.background, defaultBannerColor);
			}

			if (gameTitle == '' && hidePhaser)
			{
				hideBanner = true;
			}

			fps = getValue(config.fps, null);

			final renderConfig = getValue(config.render, config);

			antialias = getValue(renderConfig.antialias, true);
			desynchronized = getValue(renderConfig.desynchronized, false);
			roundPixels = getValue(renderConfig.roundPixels, false);
			pixelArt = getValue(renderConfig.pixelArt, zoom == 1);
			transparent = getValue(renderConfig.transparent, false);
			clearBeforeRender = getValue(renderConfig.clearBeforeRender, true);
			premultipliedAlpha = getValue(renderConfig.premultipliedAlpha, true);
			failIfMajorPerformanceCaveat = getValue(renderConfig.failIfMajorPerformanceCaveat, true);
			powerPreference = getValue(renderConfig.powerPreference, DEFAULT);
			batchSize = getValue(renderConfig.batchSize, 2000);
			maxLights = getValue(renderConfig.maxLights, 2000);

			var bgc = getValue(config.backgroundColor, 0);

			backgroundColor = Color.valueToColor(bgc);
		}
	}
}
