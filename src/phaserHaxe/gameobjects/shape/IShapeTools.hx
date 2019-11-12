package phaserHaxe.gameobjects.shape;

import phaserHaxe.display.IntColorRGBA;

class IShapeTools
{
	/**
	 * Sets the fill color and alpha for this Shape.
	 *
	 * If you wish for the Shape to not be filled then call this method with no arguments, or just set `isFilled` to `false`.
	 *
	 * Note that some Shapes do not support fill colors, such as the Line shape.
	 *
	 * This call can be chained.
	 *
	 * @since 1.0.0
	 *
	 * @param color - The color used to fill this shape. If not provided the Shape will not be filled.
	 * @param alpha - The alpha value used when filling this shape, if a fill color is given.
	 *
	 * @return This Game Object instance.
	**/
	@:generic
	public static inline function setFillStyle<T:IShape>(shape:T, ?color:IntColorRGBA,
			alpha:Float = 1):T
	{
		if (color == null)
		{
			shape.isFilled = false;
		}
		else
		{
			shape.fillColor = color;
			shape.fillAlpha = alpha;
			shape.isFilled = true;
		}
		return shape;
	}

	/**
	 * Sets the stroke color and alpha for this Shape.
	 *
	 * If you wish for the Shape to not be stroked then call this method with no arguments, or just set `isStroked` to `false`.
	 *
	 * Note that some Shapes do not support being stroked, such as the Iso Box shape.
	 *
	 * This call can be chained.
	 *
	 * @since 1.0.0
	 *
	 * @param lineWidth - The width of line to stroke with. If not provided or undefined the Shape will not be stroked.
	 * @param color - The color used to stroke this shape. If not provided the Shape will not be stroked.
	 * @param alpha - The alpha value used when stroking this shape, if a stroke color is given.
	 *
	 * @return This Game Object instance.
	**/
	@:generic
	public static inline function setStrokeStyle<T:IShape>(shape:T, ?lineWidth:Float,
			?color:IntColorRGBA, alpha:Float = 1):T
	{
		if (lineWidth == null)
		{
			shape.isStroked = false;
		}
		else
		{
			shape.lineWidth = lineWidth;
			shape.strokeColor = color != null ? color : 0xffffff;
			shape.strokeAlpha = alpha;
			shape.isStroked = true;
		}

		return shape;
	}

	/**
	 * Sets if this Shape path is closed during rendering when stroked.
	 * Note that some Shapes are always closed when stroked (such as Ellipse shapes)
	 *
	 * This call can be chained.
	 *
	 * @since 1.0.0
	 *
	 * @param value - Set to `true` if the Shape should be closed when stroked, otherwise `false`.
	 *
	 * @return This Game Object instance.
	**/
	@:generic
	public static inline function setClosePath<T:IShape>(shape:T, value:Bool):T
	{
		shape.closePath = value;
		return shape;
	}
}
