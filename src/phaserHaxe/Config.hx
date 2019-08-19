package phaserHaxe;

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

class Config
{
	/**
	 *
	**/
	public var width:Either<Int, String>;

	/**
	 *
	**/
	public var height:Either<Int, String>;

	/**
	 *
	**/
	public var zoom:ZoomType;

	/**
	 *
	**/
	public var resolution:Float;

	/**
	 *
	**/
	public var parent:Null<Any>;

	/**
	 *
	**/
	public var scaleMode:ScaleModeType;

	/**
	 *
	**/
	public var expandParent:Bool;

	/**
	 *
	**/
	public var autoRound:Int;

	/**
	 *
	**/
	public var autoCenter:CenterType;

	/**
	 *
	**/
	public var resizeInterval:Int;

	/**
	 *
	**/
	public var fullscreenTarget:Null<Either<HtmlElement, String>>;

	/**
	 *
	**/
	public var minWidth:Int;

	/**
	 *
	**/
	public var maxWidth:Int;

	/**
	 *
	**/
	public var minHeight:Int;

	/**
	 *
	**/
	public var maxHeight:Int;

	/**
	 *
	**/
	public var scaleConfig:ScaleConfig;

	/**
	 *
	**/
	public var renderType:Int;

	/**
	 *
	**/
	public var canvas:Null<CanvasElement>;

	/**
	 *
	**/
	public var context:Null<Either<CanvasRenderingContext2D, WebGL2RenderingContext>>;

	/**
	 *
	**/
	public var canvasStyle:Null<String>;

	/**
	 *
	**/
	public var customEnvironment:Bool;

	/**
	 *
	**/
	public var sceneConfig:Null<Any>;

	/**
	 *
	**/
	public var seed:Array<String>;

	/**
	 *
	**/
	public var gameTitle:String;

	/**
	 *
	**/
	public var gameURL:String;

	/**
	 *
	**/
	public var gameVersion:String;

	/**
	 *
	**/
	public var autoFocus:Bool;

	/**
	 *
	**/
	public var domCreateContainer:Null<Bool>;

	/**
	 *
	**/
	public var domBehindCanvas:Null<Bool>;

	/**
	 *
	**/
	public var inputKeyboard:Bool;

	/**
	 *
	**/
	public var inputKeyboardEventTarget:Any;

	/**
	 *
	**/
	public var inputKeyboardCapture:Null<Array<Int>>;

	/**
	 *
	**/
	public var inputMouse:Either<Bool, Any>;

	/**
	 *
	**/
	public var inputMouseEventTarget:Any;

	/**
	 *
	**/
	public var inputMouseCapture:Bool;

	/**
	 *
	**/
	public var inputTouch:Bool;

	/**
	 *
	**/
	public var inputTouchEventTarget:Any;

	/**
	 *
	**/
	public var inputTouchCapture:Bool;

	/**
	 *
	**/
	public var inputActivePointers:Int;

	/**
	 *
	**/
	public var inputSmoothFactor:Int;

	/**
	 *
	**/
	public var inputWindowEvents:Bool;

	/**
	 *
	**/
	public var inputGamepad:Bool;

	/**
	 *
	**/
	public var inputGamepadEventTarget:Any;

	/**
	 *
	**/
	public var disableContextMenu:Bool;

	/**
	 *
	**/
	public var audio:AudioConfig;

	/**
	 *
	**/
	public var hideBanner:Bool;

	/**
	 *
	**/
	public var hidePhaser:Bool;

	/**
	 *
	**/
	public var bannerTextColor:String;

	/**
	 *
	**/
	public var bannerBackgroundColor:Array<String>;

	/**
	 *
	**/
	public var fps:FPSConfig;

	/**
	 *
	**/
	public var renderConfig:RenderConfig;

	/**
	 *
	**/
	public var antialias:Bool;

	/**
	 *
	**/
	public var desynchronized:Bool;

	/**
	 *
	**/
	public var roundPixels:Bool;

	/**
	 *
	**/
	public var pixelArt:Bool;

	/**
	 *
	**/
	public var transparent:Bool;

	/**
	 *
	**/
	public var clearBeforeRender:Bool;

	/**
	 *
	**/
	public var premultipliedAlpha:Bool;

	/**
	 *
	**/
	public var failIfMajorPerformanceCaveat:Bool;

	/**
	 *
	**/
	public var powerPreference:String;

	/**
	 *
	**/
	public var batchSize:Int;

	/**
	 *
	**/
	public var maxLights:Int;

	/**
	 *
	**/
	public var backgroundColor:Color;

	/**
	 *
	**/
	public var preBoot:BootCallback;

	/**
	 *
	**/
	public var postBoot:BootCallback;

	/**
	 *
	**/
	public var physics:PhysicsConfig;

	/**
	 *
	**/
	public var defaultPhysicsSystem:Either<Bool, String>;

	/**
	 *
	**/
	public var loaderBaseURL:String;

	/**
	 *
	**/
	public var loaderPath:String;

	/**
	 *
	**/
	public var loaderMaxParallelDownloads:Int;

	/**
	 *
	**/
	public var loaderCrossOrigin:Null<String>;

	/**
	 *
	**/
	public var loaderResponseType:String;

	/**
	 *
	**/
	public var loaderAsync:Bool;

	/**
	 *
	**/
	public var loaderUser:String;

	/**
	 *
	**/
	public var loaderPassword:String;

	/**
	 *
	**/
	public var loaderTimeout:Int;

	/**
	 *
	**/
	public var installGlobalPlugins:Array<Any>;

	/**
	 *
	**/
	public var installScenePlugins:Array<Any>;

	/**
	 *
	**/
	public var defaultPlugins:Dynamic;

	/**
	 *
	**/
	public var defaultImage:String;

	/**
	 *
	**/
	public var missingImage:String;
}
