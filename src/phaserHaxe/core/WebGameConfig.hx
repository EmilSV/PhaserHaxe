package phaserHaxe.core;

import js.html.HtmlElement;
import phaserHaxe.scale.CenterType;
import phaserHaxe.scale.ScaleModeType;
#if js
import js.html.CanvasRenderingContext2D;
import js.html.CanvasElement;
import phaserHaxe.Const;
import js.html.Element;

@:structInit
typedef WebGameConfig =
{
	/**
	 * The width of the game, in game pixels.
	 *
	 * @since 1.0.0
	**/
	public var ?width:Either<Int, String>;

	/**
	 * The height of the game, in game pixels.
	 *
	 * @since 1.0.0
	**/
	public var ?height:Either<Int, String>;

	/**
	 * Simple scale applied to the game canvas. 2 is double size, 0.5 is half size, etc.
	 *
	 * @since 1.0.0
	**/
	public var ?zoom:Float;

	/**
	 * The size of each game pixel, in canvas pixels. Values larger than 1 are "high" resolution.
	 *
	 * @since 1.0.0
	**/
	public var ?resolution:Float;

	/**
	 *  Which renderer to use. Phaser.AUTO, Phaser.CANVAS, Phaser.HEADLESS,
	 *  or Phaser.WEBGL. AUTO picks WEBGL if available, otherwise CANVAS.
	 *
	 * @since 1.0.0
	**/
	public var ?type:Int;

	/**
	 * The DOM element that will contain the game canvas, or its `id`.
	 * If undefined or if the named element doesn't exist, the game canvas is
	 * inserted directly into the document body. If `null` no parent will be
	 * used and you are responsible for adding the canvas to your environment.
	 *
	 * @since 1.0.0
	**/
	public var ?parent:Null<Either<Element, String>>;

	/**
	 * The scale mode as used by the Scale Manager. The default is zero, which is no scaling.
	 *
	 * @since 1.0.0
	**/
	public var ?scaleMode:ScaleModeType;

	/**
	 * Is the Scale Manager allowed to adjust the CSS height property of the parent to be 100%?
	 *
	 * @since 1.0.0
	**/
	public var ?expandParent:Bool;

	/**
	 * Automatically round the display and style sizes of the canvas. This can help with performance in lower-powered devices.
	 *
	 * @since 1.0.0
	**/
	public var ?autoRound:Bool;

	/**
	 * Automatically center the canvas within the parent?
	 *
	 * @since 1.0.0
	**/
	public var ?autoCenter:CenterType;

	/**
	 * How many ms should elapse before checking if the browser size has changed?
	 *
	 * @since 1.0.0
	**/
	public var ?resizeInterval:Int;

	/**
	 * The DOM element that will be sent into full screen mode, or its `id`.
	 * If undefined Phaser will create its own div and insert the canvas into it when entering fullscreen mode.
	 *
	 * @since 1.0.0
	**/
	public var ?fullscreenTarget:Null<Either<HtmlElement, String>>;

	/**
	 * The minimum width, in pixels, the canvas will scale down to. A value of zero means no minimum.
	 *
	 * @since 1.0.0
	**/
	public var ?minWidth:Int;

	/**
	 * The maximum width, in pixels, the canvas will scale up to. A value of zero means no maximum.
	 *
	 * @since 1.0.0
	**/
	public var ?maxWidth:Int;

	/**
	 * The minimum height, in pixels, the canvas will scale down to. A value of zero means no minimum.
	 *
	 * @since 1.0.0
	**/
	public var ?minHeight:Int;

	/**
	 * The maximum height, in pixels, the canvas will scale up to. A value of zero means no maximum.
	 *
	 * @since 1.0.0
	**/
	public var ?maxHeight:Int;

	/**
	 * Is Phaser running under a custom (non-native web) environment? If so, set this to `true` to skip internal Feature detection. If `true` the `renderType` cannot be left as `AUTO`.
	 *
	 * @since 1.0.0
	**/
	public var ?customEnvironment:Bool;

	/**
	 * Provide your own Canvas element for Phaser to use instead of
	 * creating one.
	 *
	 * @since 1.0.0
	**/
	public var ?canvas:Null<CanvasElement>;

	/**
	 * CSS styles to apply to the game canvas instead of Phasers default styles.
	 *
	 * @since 1.0.0
	**/
	public var ?canvasStyle:Null<String>;

	/**
	 * Provide your own Canvas Context for Phaser to use, instead of creating one.
	 *
	 * @since 1.0.0
	**/
	public var ?context:Null<CanvasRenderingContext2D>;

	/**
	 *  A scene or scenes to add to the game. If several are given,
	 * 	the first is started; the remainder are started only if they have
	 * `{ active: true }`. See the `sceneConfig` argument in `Phaser.Scenes.SceneManager#add`.
	 *
	 * @since 1.0.0
	**/
	public var ?scene:Dynamic;

	/**
	 * Seed for the random number generator.
	 *
	 * @since 1.0.0
	**/
	public var ?seed:Null<Array<String>>;

	/**
	 * The title of the game. Shown in the browser console.
	 *
	 * @since 1.0.0
	**/
	public var ?title:String;

	/**
	 * The URL of the game. Shown in the browser console.
	 *
	 * @since 1.0.0
	**/
	public var ?url:String;

	/**
	 * The version of the game. Shown in the browser console.
	 *
	 * @since 1.0.0
	**/
	public var ?version:String;

	/**
	 * Automatically call window.focus() when the game boots.
	 * Usually necessary to capture input events if the game is in a
	 * separate frame.
	 *
	 * @since 1.0.0
	**/
	public var ?autoFocus:Bool;

	/**
	 * Input configuration, or `false` to disable all game input.
	 *
	 * @since 1.0.0
	**/
	public var ?input:Either<InputConfig, Bool>;

	/**
	 * Disable the browser's default 'contextmenu' event
	 * (usually triggered by a right-button mouse click).
	 *
	 * @since 1.0.0
	**/
	public var ?disableContextMenu:Bool;

	/**
	 * Whether the game canvas will have a transparent background.
	 *
	 * @since 1.0.0
	**/
	public var ?transparent:Bool;

	/**
	 * Configuration for the banner printed in the browser console when the game starts.
	 *
	 * @since 1.0.0
	**/
	public var ?banner:Either<BannerConfig, Bool>;

	/**
	 * The DOM Container configuration object.
	 *
	 * @since 1.0.0
	**/
	public var ?dom:Null<DOMContainerConfig>;

	/**
	 * Game loop configuration.
	 *
	 * @since 1.0.0
	**/
	public var ?fps:Null<FPSConfig>;

	/**
	 * Game renderer configuration.
	 *
	 * @since 1.0.0
	**/
	public var ?render:Null<RenderConfig>;

	/**
	 * The background color of the game canvas. The default is black.
	 *
	 * @since 1.0.0
	**/
	public var ?backgroundColor:Either<String, Int>;

	/**
	 * Optional callbacks to run before or after game boot.
	 *
	 * @since 1.0.0
	**/
	public var ?callbacks:Null<CallbacksConfig>;

	/**
	 * Loader configuration.
	 *
	 * @since 1.0.0
	**/
	public var ?loader:Null<LoaderConfig>;

	/**
	 * Images configuration.
	 *
	 * @since 1.0.0
	**/
	public var ?images:Null<ImagesConfig>;

	/**
	 * Physics configuration.
	 *
	 * @since 1.0.0
	**/
	public var ?physics:Null<PhysicsConfig>; // Todo

	/**
	 * Plugins to install.
	 *
	 * @since 1.0.0
	**/
	public var ?plugins:Array<Any>;

	/**
	 * The Scale Manager configuration.
	 *
	 * @since 1.0.0
	**/
	public var ?scale:ScaleConfig;

	/**
	 * The Audio Configuration object.
	 *
	 * @since 1.0.0
	**/
	public var ?audio:AudioConfig;
}
#end
