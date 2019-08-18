package phaserHaxe.core;

#if js
import js.html.CanvasRenderingContext2D;
import js.html.CanvasElement;
import phaserHaxe.Const;
import js.html.Element;

@:structInit
final class WebGameConfig
{
	/**
	 * The width of the game, in game pixels.
	 *
	 * @since 1.0.0
	**/
	public var width:Either<Int, String> = 1024;

	/**
	 * The height of the game, in game pixels.
	 *
	 * @since 1.0.0
	**/
	public var height:Either<Int, String> = 768;

	/**
	 * Simple scale applied to the game canvas. 2 is double size, 0.5 is half size, etc.
	 *
	 * @since 1.0.0
	**/
	public var zoom:Float = 1;

	/**
	 * The size of each game pixel, in canvas pixels. Values larger than 1 are "high" resolution.
	 *
	 * @since 1.0.0
	**/
	public var resolution:Float = 1;

	/**
	 *  Which renderer to use. Phaser.AUTO, Phaser.CANVAS, Phaser.HEADLESS,
	 *  or Phaser.WEBGL. AUTO picks WEBGL if available, otherwise CANVAS.
	 *
	 * @since 1.0.0
	**/
	public var type:Int = Const.AUTO;

	/**
	 * The DOM element that will contain the game canvas, or its `id`.
	 * If undefined or if the named element doesn't exist, the game canvas is
	 * inserted directly into the document body. If `null` no parent will be
	 * used and you are responsible for adding the canvas to your environment.
	 *
	 * @since 1.0.0
	**/
	public var parent:Null<Either<Element, String>> = null;

	/**
	 * Provide your own Canvas element for Phaser to use instead of
	 * creating one.
	 *
	 * @since 1.0.0
	**/
	public var canvas:Null<CanvasElement> = null;

	/**
	 * CSS styles to apply to the game canvas instead of Phasers default styles.
	 *
	 * @since 1.0.0
	**/
	public var canvasStyle:Null<String> = null;

	/**
	 * Provide your own Canvas Context for Phaser to use, instead of creating one.
	 *
	 * @since 1.0.0
	**/
	public var context:Null<CanvasRenderingContext2D> = null;

	/**
	 *  A scene or scenes to add to the game. If several are given,
	 * 	the first is started; the remainder are started only if they have
	 * `{ active: true }`. See the `sceneConfig` argument in `Phaser.Scenes.SceneManager#add`.
	 *
	 * @since 1.0.0
	**/
	public var scene:Dynamic = null;

	/**
	 * Seed for the random number generator.
	 *
	 * @since 1.0.0
	**/
	public var seed:Null<Array<String>> = null;

	/**
	 * The title of the game. Shown in the browser console.
	 *
	 * @since 1.0.0
	**/
	public var title:String = "";

	/**
	 * The URL of the game. Shown in the browser console.
	 *
	 * @since 1.0.0
	**/
	public var url:String = "http://phaser.io";

	/**
	 * The version of the game. Shown in the browser console.
	 *
	 * @since 1.0.0
	**/
	public var version:String = "";

	/**
	 * Automatically call window.focus() when the game boots.
	 * Usually necessary to capture input events if the game is in a
	 * separate frame.
	 *
	 * @since 1.0.0
	**/
	public var autoFocus:Bool = true;

	/**
	 * Input configuration, or `false` to disable all game input.
	 *
	 * @since 1.0.0
	**/
	public var input:Either<InputConfig, Bool> = true;

	/**
	 * Disable the browser's default 'contextmenu' event
	 * (usually triggered by a right-button mouse click).
	 *
	 * @since 1.0.0
	**/
	public var disableContextMenu:Bool = true;

	/**
	 * Whether the game canvas will have a transparent background.
	 *
	 * @since 1.0.0
	**/
	public var transparent:Bool = false;

	/**
	 * Configuration for the banner printed in the browser console when the game starts.
	 *
	 * @since 1.0.0
	**/
	public var banner:Either<BannerConfig, Bool> = false;

	/**
	 * The DOM Container configuration object.
	 *
	 * @since 1.0.0
	**/
	public var dom:Null<DOMContainerConfig> = null;

	/**
	 * Game loop configuration.
	 *
	 * @since 1.0.0
	**/
	public var fps:Null<FPSConfig> = null;

	/**
	 * Game renderer configuration.
	 *
	 * @since 1.0.0
	**/
	public var render:Null<RenderConfig>;

	/**
	 * The background color of the game canvas. The default is black.
	 *
	 * @since 1.0.0
	**/
	public var backgroundColor:Either<String, Int> = 0x000000;

	/**
	 * Optional callbacks to run before or after game boot.
	 *
	 * @since 1.0.0
	**/
	public var callbacks:Null<CallbacksConfig> = null;

	/**
	 * Loader configuration.
	 *
	 * @since 1.0.0
	**/
	public var loader:Null<LoaderConfig> = null;

	/**
	 * Images configuration.
	 *
	 * @since 1.0.0
	**/
	public var images:Null<ImagesConfig> = null;

	/**
	 * Physics configuration.
	 *
	 * @since 1.0.0
	**/
	public var physics:Dynamic = null; // Todo

	/**
	 * Plugins to install.
	 *
	 * @since 1.0.0
	**/
	public var plugins:Dynamic = null; // Todo

	/**
	 * The Scale Manager configuration.
	 *
	 * @since 1.0.0
	**/
	public var scale:Dynamic = null; // Todo

	/**
	 * The Audio Configuration object.
	 *
	 * @since 1.0.0
	**/
	public var audio:Dynamic = null; // Todo

}
#end
