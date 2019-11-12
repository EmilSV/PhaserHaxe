package phaserHaxe.gameobjects.shape;

import phaserHaxe.display.IntColorRGBA;
import phaserHaxe.geom.Line;
import phaserHaxe.gameobjects.components.*;

@:using(phaserHaxe.gameobjects.shape.IShapeTools)
interface IShape extends IAlpha extends IBlendMode extends IComputedSize extends IDepth extends IGetBounds extends IMask extends IOrigin extends IPipeline extends IScrollFactor extends ITransform extends IVisible
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
	public var pathData(default, null):Array<Float>;

	/**
	 * Holds the earcut polygon path index data for filled rendering.
	 *
	 * @since 1.0.0
	**/
	public var pathIndexes(default, null):Array<Int>;

	/**
	 * The fill color used by this Shape.
	 *
	 * @since 1.0.0
	**/
	public var fillColor:IntColorRGBA;

	/**
	 * The fill alpha value used by this Shape.
	 *
	 * @since 1.0.0
	**/
	public var fillAlpha:Float;

	/**
	 * The stroke color used by this Shape.
	 *
	 * @since 1.0.0
	**/
	public var strokeColor:IntColorRGBA;

	/**
	 * The stroke alpha value used by this Shape.
	 *
	 * @since 1.0.0
	**/
	public var strokeAlpha:Float;

	/**
	 * The stroke line width used by this Shape.
	 *
	 * @since 1.0.0
	**/
	public var lineWidth:Float;

	/**
	 * Controls if this Shape is filled or not.
	 * Note that some Shapes do not support being filled (such as Line shapes)
	 *
	 * @since 1.0.0
	**/
	public var isFilled:Bool;

	/**
	 * Controls if this Shape is stroked or not.
	 * Note that some Shapes do not support being stroked (such as Iso Box shapes)
	 *
	 * @since 1.0.0
	**/
	public var isStroked:Bool;

	/**
	 * Controls if this Shape path is closed during rendering when stroked.
	 * Note that some Shapes are always closed when stroked (such as Ellipse shapes)
	 *
	 * @since 1.0.0
	**/
	public var closePath:Bool;

	/**
	 * Private internal value.
	 * A Line used when parsing internal path data to avoid constant object re-creation.
	 *
	 * @since 1.0.0
	**/
	private var _tempLine:Line;
}
