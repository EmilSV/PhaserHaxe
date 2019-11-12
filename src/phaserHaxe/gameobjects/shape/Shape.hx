package phaserHaxe.gameobjects.shape;

import phaserHaxe.gameobjects.components.*;
import phaserHaxe.geom.Line;
import phaserHaxe.display.IntColorRGBA;

/**
 * The Shape Game Object is a base class for the various different shapes, such as the Arc, Star or Polygon.
 * You cannot add a Shape directly to your Scene, it is meant as a base for your own custom Shape classes.
 *
 * @since 1.0.0
 *
 * @param scene - The Scene to which this Game Object belongs. A Game Object can only belong to one Scene at a time.
 * @param type - The internal type of the Shape.
 * @param data - The data of the source shape geometry, if any.
**/
@:build(phaserHaxe.macro.Mixin.auto())
class Shape extends GameObject implements IShape implements IAlpha implements IBlendMode
		implements IComputedSize implements IDepth implements IGetBounds
		implements IMask implements IOrigin implements IPipeline
		implements IScrollFactor implements ITransform implements IVisible
{
	/**
	 * The source Shape data. Typically a geometry object.
	 * You should not manipulate this directly.
	 *
	 * @since 1.0.0
	**/
	public var geom(default, null):Any;

	/**
	 * Holds the polygon path data for filled rendering.
	 *
	 * @since 1.0.0
	**/
	public var pathData(default, null):Array<Float> = [];

	/**
	 * Holds the earcut polygon path index data for filled rendering.
	 *
	 * @since 1.0.0
	**/
	public var pathIndexes(default, null):Array<Int> = [];

	/**
	 * The fill color used by this Shape.
	 *
	 * @since 1.0.0
	**/
	public var fillColor:IntColorRGBA = 0xffffff;

	/**
	 * The fill alpha value used by this Shape.
	 *
	 * @since 1.0.0
	**/
	public var fillAlpha:Float = 1;

	/**
	 * The stroke color used by this Shape.
	 *
	 * @since 1.0.0
	**/
	public var strokeColor:IntColorRGBA = 0xffffff;

	/**
	 * The stroke alpha value used by this Shape.
	 *
	 * @since 1.0.0
	**/
	public var strokeAlpha:Float = 1;

	/**
	 * The stroke line width used by this Shape.
	 *
	 * @since 1.0.0
	**/
	public var lineWidth:Float = 1;

	/**
	 * Controls if this Shape is filled or not.
	 * Note that some Shapes do not support being filled (such as Line shapes)
	 *
	 * @since 1.0.0
	**/
	public var isFilled:Bool = false;

	/**
	 * Controls if this Shape is stroked or not.
	 * Note that some Shapes do not support being stroked (such as Iso Box shapes)
	 *
	 * @since 1.0.0
	**/
	public var isStroked:Bool = false;

	/**
	 * Controls if this Shape path is closed during rendering when stroked.
	 * Note that some Shapes are always closed when stroked (such as Ellipse shapes)
	 *
	 * @since 1.0.0
	**/
	public var closePath:Bool = true;

	/**
	 * Private internal value.
	 * A Line used when parsing internal path data to avoid constant object re-creation.
	 *
	 * @since 1.0.0
	**/
	private var _tempLine:Line = new Line();

	public function new(scene:Scene, ?type:String, ?data:Any)
	{
		type = type != null ? type : "Shape";
		super(scene, "Shape");

		geom = data;
		initPipeline();
	}

	/**
	 * Internal destroy handler, called as part of the destroy process.
	 *
	 * @since 1.0.0
	**/
	private function preDestroy()
	{
		geom = null;
		_tempLine = null;
		pathData = [];
		pathIndexes = [];
	}
}
