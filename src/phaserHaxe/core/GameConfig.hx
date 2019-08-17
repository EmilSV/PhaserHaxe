package phaserHaxe.core;

import js.html.CanvasRenderingContext2D;
import js.html.CanvasElement;
import phaserHaxe.Const;
import js.html.Element;

@:structInit
final class GameConfig
{
	public var width:Either<Int, String> = 1024;
	public var height:Either<Int, String> = 768;

	public var zoom:Float = 1;
	public var resolution:Float = 1;
	public var type:Int = Const.AUTO;

	public var parent:Either<Element, String> = null;
	public var canvas:CanvasElement = null;
	public var canvasStyle:String = null;

	public var context:CanvasRenderingContext2D = null;
	public var scene:Dynamic = null;
	public var seed:Array<String> = null;

	public var title:String = "";

	public var url:String = "http://phaser.io";

	public var version:String = "";
	public var autoFocus:Bool = true;

	public var input:Either<InputConfig, Bool> = true;

	public var disableContextMenu:Bool = true;
}
