package phaserHaxe.display.canvas;

import phaserHaxe.Const;
import phaserHaxe.display.canvas.Smoothing;
#if js
import js.html.CanvasElement;
import js.Syntax as JsSyntax;
import js.Browser;
#end

#if js
@:structInit
final class CanvasContainer
{
	public var parent:Any;
	public var canvas:CanvasElement;
	public var type:Int;

	public function new(parent:Any, canvas:CanvasElement, type:Int)
	{
		this.parent = parent;
		this.canvas = canvas;
		this.type = type;
	}
}
#else
@:structInit
final class CanvasContainer
{
	public var parent:Any;
	public var canvas:Dynamic;
	public var type:Int;

	public function new(parent:Any, canvas:Dynamic, type:Int)
	{
		this.parent = parent;
		this.canvas = canvas;
		this.type = type;
	}
}
#end

#if js
/**
 * The CanvasPool is a global static object, that allows Phaser to recycle and pool 2D Context Canvas DOM elements.
 * It does not pool WebGL Contexts, because once the context options are set they cannot be modified again,
 * which is useless for some of the Phaser pipelines / renderer.
 *
 * This singleton is instantiated as soon as Phaser loads, before a Phaser.Game instance has even been created.
 * Which means all instances of Phaser Games on the same page can share the one single pool.
 *
 * @since 1.0.0
**/
final class CanvasPool
{
	public static inline var isSupported = true;

	// The pool into which the canvas elements are placed.
	private static var pool:Array<CanvasContainer> = [];
	//  Automatically apply smoothing(false) to created Canvas elements
	private static var _disableContextSmoothing = false;

	/**
	 * Creates a new Canvas DOM element, or pulls one from the pool if free.
	 *
	 * @since 1.0.0
	 *
	 * @param parent - The parent of the Canvas object.
	 * @param width - The width of the Canvas.
	 * @param height - The height of the Canvas.
	 * @param canvasType - The type of the Canvas. Either `Phaser.CANVAS` or `Phaser.WEBGL`.
	 * @param selfParent - Use the generated Canvas element as the parent?
	 *
	 * @return The canvas element that was created or pulled from the pool
	**/
	public static function create(parent:Any, width:Int = 1, height:Int = 1,
			canvasType:Int = Const.CANVAS, selfParent:Bool = false):CanvasElement
	{
		var canvas;

		var container = first(canvasType);

		if (container == null)
		{
			container = {
				parent: parent,
				canvas: cast Browser.document.createElement("canvas"),
				type: canvasType
			};

			if (canvasType == Const.CANVAS)
			{
				pool.push(container);
			}

			canvas = container.canvas;
		}
		else
		{
			container.parent = parent;
			canvas = container.canvas;
		}

		if (selfParent)
		{
			container.parent = canvas;
		}

		canvas.width = width;
		canvas.height = height;

		if (_disableContextSmoothing && canvasType == Const.CANVAS)
		{
			Smoothing.disable(canvas.getContext("2d"));
		}

		return canvas;
	}

	/**
	 * Creates a new Canvas DOM element, or pulls one from the pool if free.
	 *
	 * @since 1.0.0
	 *
	 * @param parent - The parent of the Canvas object.
	 * @param width - The width of the Canvas.
	 * @param height - The height of the Canvas.
	 *
	 * @return The created canvas.
	**/
	public static function create2D(parent:Any, width:Int = 1,
			height:Int = 1):CanvasElement
	{
		return create(parent, width, height, Const.CANVAS);
	}

	/**
	 * Creates a new Canvas DOM element, or pulls one from the pool if free.
	 *
	 * @since 1.0.0
	 *
	 * @param parent - The parent of the Canvas object.
	 * @param width - The width of the Canvas.
	 * @param height - The height of the Canvas.
	 *
	 * @return The created WebGL canvas.
	**/
	public static function createWebGL(parent:Any, width:Int = 1,
			height:Int = 1):CanvasElement
	{
		return create(parent, width, height, Const.WEBGL);
	}

	/**
	 * Gets the first free canvas index from the pool.
	 *
	 * @since 1.0.0
	 *
	 * @param canvasType - The type of the Canvas. Either `Phaser.CANVAS` or `Phaser.WEBGL`.
	 *
	 * @return The first free canvas, or `null` if a WebGL canvas was requested or if the pool doesn't have free canvases.
	**/
	public static function first(canvasType:Int = Const.CANVAS):CanvasContainer
	{
		if (canvasType == null)
		{
			canvasType = Const.CANVAS;
		}
		if (canvasType == Const.WEBGL)
		{
			return null;
		}

		for (i in 0...pool.length)
		{
			var container = pool[i];
			if (container.parent == null && container.type == canvasType)
			{
				return container;
			}
		}
		return null;
	}

	/**
	 * Looks up a canvas based on its parent, and if found puts it back in the pool, freeing it up for re-use.
	 * The canvas has its width and height set to 1, and its parent attribute nulled.
	 *
	 * @since 1.0.0
	 *
	 * @param parent - The canvas or the parent of the canvas to free.
	**/
	public static function remove(parent:Any):Void
	{
		var isCanvas = JsSyntax.instanceof(parent, CanvasElement);

		for (container in pool)
		{
			if ((isCanvas && container.canvas == parent) || (!isCanvas && container.parent == parent))
			{
				container.parent = null;
				container.canvas.width = 1;
				container.canvas.height = 1;
			}
		}
	}

	/**
	 * Gets the total number of used canvas elements in the pool.
	 *
	 * @since 1.0.0
	 *
	 * @return The number of used canvases.
	**/
	public static function total():Int
	{
		var c = 0;

		for (container in pool)
		{
			if (container.parent)
			{
				c++;
			}
		}

		return c;
	}

	/**
	 * Gets the total number of free canvas elements in the pool.
	 *
	 * @since 1.0.0
	 *
	 * @return The number of free canvases.
	**/
	public static function free():Int
	{
		return pool.length - total();
	}

	/**
	 * Disable context smoothing on any new Canvas element created.
	 *
	 * @since 1.0.0
	**/
	public static function disableSmoothing():Void
	{
		_disableContextSmoothing = true;
	}

	/**
	 * Enable context smoothing on any new Canvas element created.
	 *
	 * @since 1.0.0
	**/
	public static function enableSmoothing():Void
	{
		_disableContextSmoothing = false;
	}
}
#else

/**
 * The CanvasPool is a global static object, that allows Phaser to recycle and pool 2D Context Canvas DOM elements.
 * It does not pool WebGL Contexts, because once the context options are set they cannot be modified again,
 * which is useless for some of the Phaser pipelines / renderer.
 *
 * This singleton is instantiated as soon as Phaser loads, before a Phaser.Game instance has even been created.
 * Which means all instances of Phaser Games on the same page can share the one single pool.
 *
 * @since 1.0.0
**/
final class CanvasPool
{
	public static inline var isSupported = false;

	/**
	 * Creates a new Canvas DOM element, or pulls one from the pool if free.
	 *
	 * @since 1.0.0
	 *
	 * @param parent - The parent of the Canvas object.
	 * @param width - The width of the Canvas.
	 * @param height - The height of the Canvas.
	 * @param canvasType - The type of the Canvas. Either `Phaser.CANVAS` or `Phaser.WEBGL`.
	 * @param selfParent - Use the generated Canvas element as the parent?
	 *
	 * @return The canvas element that was created or pulled from the pool
	**/
	public static function create(parent:Any, width:Int = 1, height:Int = 1,
			canvasType:Int = Const.CANVAS, selfParent:Bool = false):Dynamic
		throw "Not Implemented";

	/**
	 * Creates a new Canvas DOM element, or pulls one from the pool if free.
	 *
	 * @since 1.0.0
	 *
	 * @param parent - The parent of the Canvas object.
	 * @param width - The width of the Canvas.
	 * @param height - The height of the Canvas.
	 *
	 * @return The created canvas.
	**/
	public static function create2D(parent:Any, width:Int = 1, height:Int = 1):Dynamic
		throw "Not Implemented";

	/**
	 * Creates a new Canvas DOM element, or pulls one from the pool if free.
	 *
	 * @since 1.0.0
	 *
	 * @param parent - The parent of the Canvas object.
	 * @param width - The width of the Canvas.
	 * @param height - The height of the Canvas.
	 *
	 * @return The created WebGL canvas.
	**/
	public static function createWebGL(parent:Any, width:Int = 1, height:Int = 1):Dynamic
		throw "Not Implemented";

	/**
	 * Gets the first free canvas index from the pool.
	 *
	 * @since 1.0.0
	 *
	 * @param canvasType - The type of the Canvas. Either `Phaser.CANVAS` or `Phaser.WEBGL`.
	 *
	 * @return The first free canvas, or `null` if a WebGL canvas was requested or if the pool doesn't have free canvases.
	**/
	public static function first(canvasType:Int = Const.CANVAS):Dynamic
		throw "Not Implemented";

	/**
	 * Looks up a canvas based on its parent, and if found puts it back in the pool, freeing it up for re-use.
	 * The canvas has its width and height set to 1, and its parent attribute nulled.
	 *
	 * @since 1.0.0
	 *
	 * @param parent - The canvas or the parent of the canvas to free.
	**/
	public static function remove(parent:Any):Void
		throw "Not Implemented";

	/**
	 * Gets the total number of used canvas elements in the pool.
	 *
	 * @since 1.0.0
	 *
	 * @return The number of used canvases.
	**/
	public static function total():Int
		throw "Not Implemented";

	/**
	 * Gets the total number of free canvas elements in the pool.
	 *
	 * @since 1.0.0
	 *
	 * @return The number of free canvases.
	**/
	public static function free():Int
		throw "Not Implemented";

	/**
	 * Disable context smoothing on any new Canvas element created.
	 *
	 * @since 1.0.0
	**/
	public static function disableSmoothing():Void
		throw "Not Implemented";

	/**
	 * Enable context smoothing on any new Canvas element created.
	 *
	 * @since 1.0.0
	**/
	public static function enableSmoothing():Void
		throw "Not Implemented";
}
#end
