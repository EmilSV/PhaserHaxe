package phaserHaxe.structs;

import js.html.HtmlElement;
import phaserHaxe.math.MathConst;
import phaserHaxe.math.MathUtility.clamp as clamp;
import phaserHaxe.math.Snap.snapFloor as snapFloor;
import phaserHaxe.math.Vector2;

enum abstract AspectMode(Int) from Int to Int
{
	/**
	 * Do not make the size fit the aspect ratio. Change the ratio when the size changes.
	 *
	 * @since 1.0.0
	**/
	public var NONE = 0;

	/**
	 * The height is automatically adjusted based on the width.
	 *
	 * @since 1.0.0
	**/
	public var WIDTH_CONTROLS_HEIGHT = 1;

	/**
	 * The width is automatically adjusted based on the height.
	 *
	 * @since 1.0.0
	**/
	public var HEIGHT_CONTROLS_WIDTH = 2;

	/**
	 * The width and height are automatically adjusted to fit inside the given target area,
	 * while keeping the aspect ratio. Depending on the aspect ratio there may be some
	 * space inside the area which is not covered.
	 *
	 * @since 1.0.0
	**/
	public var FIT = 3;

	/**
	 * The width and height are automatically adjusted to make the size cover
	 * the entire target area while keeping the aspect ratio.
	 * This may extend further out than the target size.
	 *
	 * @since 1.0.0
	**/
	public var ENVELOP = 4;
}

/**
 * The Size component allows you to set `width` and `height` properties and define the relationship between them.
 *
 * The component can automatically maintain the aspect ratios between the two values, and clamp them
 * to a defined min-max range. You can also control the dominant axis. When dimensions are given to the Size component
 * that would cause it to exceed its min-max range, the dimensions are adjusted based on the dominant axis.
 *
 * @since 1.0.0
 *
 * @param width - The width of the Size component.
 * @param height - The height of the Size component. If not given, it will use the `width`.
 * @param aspectMode - The aspect mode of the Size component. Defaults to 0, no mode.
 * @param parent - The parent of this Size component. Can be any object with public `width` and `height` properties. Dimensions are clamped to keep them within the parent bounds where possible.
**/
class Size
{
	/**
	 * Internal width value.
	 *
	 * @since 1.0.0
	**/
	private var _width:Float;

	/**
	 * Internal height value.
	 *
	 * @since 1.0.0
	**/
	private var _height:Float;

	/**
	 * Internal parent reference.
	 *
	 * @since 1.0.0
	**/
	private var _parent:{width:Float, height:Float};

	/**
	 * The aspect mode this Size component will use when calculating its dimensions.
	 * This property is read-only. To change it use the `setAspectMode` method.
	 *
	 * @since 1.0.0
	**/
	public var aspectMode(default, null):AspectMode;

	/**
	 * The proportional relationship between the width and height.
	 *
	 * This property is read-only and is updated automatically when either the `width` or `height` properties are changed,
	 * depending on the aspect mode.
	 *
	 * @since 1.0.0
	**/
	public var aspectRatio(default, null):Float;

	/**
	 * The minimum allowed width.
	 * Cannot be less than zero.
	 * This value is read-only. To change it see the `setMin` method.
	 *
	 * @since 1.0.0
	**/
	public var minWidth(default, null):Float = 0;

	/**
	 * The maximum allowed width.
	 * This value is read-only. To change it see the `setMax` method.
	 *
	 * @since 1.0.0
	**/
	public var minHeight(default, null):Float = 0;

	/**
	 * The minimum allowed width.
	 * Cannot be less than zero.
	 * This value is read-only. To change it see the `setMin` method.
	 *
	 * @since 1.0.0
	**/
	public var maxWidth(default, null):Float = MathConst.FLOAT_MAX;

	/**
	 * The maximum allowed height.
	 * This value is read-only. To change it see the `setMax` method.
	 *
	 * @since 1.0.0
	**/
	public var maxHeight(default, null):Float = MathConst.FLOAT_MAX;

	/**
	 * A Vector2 containing the horizontal and vertical snap values, which the width and height are snapped to during resizing.
	 *
	 * By default this is disabled.
	 *
	 * This property is read-only. To change it see the `setSnap` method.
	 *
	 * @since 1.0.0
	**/
	public var snapTo(default, null):Vector2 = new Vector2();

	public function new(width:Float = 0, ?height:Float, aspectMode:AspectMode = NONE,
			parent:Any = null)
	{
		var height:Float = height != null ? height : width;

		_width = width;
		_height = height;
		_parent = parent;
		this.aspectMode = aspectMode;
		aspectRatio = (height == 0) ? 1 : width / height;
	}

	/**
	 * Sets the aspect mode of this Size component.
	 *
	 * The aspect mode controls what happens when you modify the `width` or `height` properties, or call `setSize`.
	 *
	 * It can be a number from 0 to 4, or a Size constant:
	 *
	 * 0. NONE = Do not make the size fit the aspect ratio. Change the ratio when the size changes.
	 * 1. WIDTH_CONTROLS_HEIGHT = The height is automatically adjusted based on the width.
	 * 2. HEIGHT_CONTROLS_WIDTH = The width is automatically adjusted based on the height.
	 * 3. FIT = The width and height are automatically adjusted to fit inside the given target area, while keeping the aspect ratio. Depending on the aspect ratio there may be some space inside the area which is not covered.
	 * 4. ENVELOP = The width and height are automatically adjusted to make the size cover the entire target area while keeping the aspect ratio. This may extend further out than the target size.
	 *
	 * Calling this method automatically recalculates the `width` and the `height`, if required.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The aspect mode value.
	 *
	 * @return This Size component instance.
	**/
	public function setAspectMode(value:AspectMode = NONE)
	{
		aspectMode = value;
		return setSize(_width, _height);
	}

	/**
	 * Sets, or clears, the parent of this Size component.
	 *
	 * To clear the parent call this method with no arguments.
	 *
	 * The parent influences the maximum extents to which this Size compoent can expand,
	 * based on the aspect mode:
	 *
	 * NONE - The parent clamps both the width and height.
	 * WIDTH_CONTROLS_HEIGHT - The parent clamps just the width.
	 * HEIGHT_CONTROLS_WIDTH - The parent clamps just the height.
	 * FIT - The parent clamps whichever axis is required to ensure the size fits within it.
	 * ENVELOP - The parent is used to ensure the size fully envelops the parent.
	 *
	 * Calling this method automatically calls `setSize`.
	 *
	 * @since 1.0.0
	 *
	 * @param parent - Sets the parent of this Size component. Don't provide a value to clear an existing parent.
	 *
	 * @return This Size component instance.
	**/
	public function setParent(?parent:Any):Size
	{
		this._parent = parent;

		return this.setSize(_width, _height);
	}

	/**
	 * Set the minimum width and height values this Size component will allow.
	 *
	 * The minimum values can never be below zero, or greater than the maximum values.
	 *
	 * Setting this will automatically adjust both the `width` and `height` properties to ensure they are within range.
	 *
	 * Note that based on the aspect mode, and if this Size component has a parent set or not, the minimums set here
	 * _can_ be exceed in some situations.
	 *
	 * @since 1.0.0
	 *
	 * @param width - The minimum allowed width of the Size component.
	 * @param height - The minimum allowed height of the Size component. If not given, it will use the `width`.
	 *
	 * @return This Size component instance.
	**/
	public function setMin(width:Float = 0, ?height:Float)
	{
		var height:Float = height != null ? height : width;

		minWidth = clamp(width, 0, maxWidth);
		minHeight = clamp(height, 0, maxHeight);

		return setSize(_width, _height);
	}

	/**
	 * Set the maximum width and height values this Size component will allow.
	 *
	 * Setting this will automatically adjust both the `width` and `height` properties to ensure they are within range.
	 *
	 * Note that based on the aspect mode, and if this Size component has a parent set or not, the maximums set here
	 * _can_ be exceed in some situations.
	 *
	 * @method Phaser.Structs.Size#setMax
	 * @since 1.0.0
	 *
	 * @param width - The maximum allowed width of the Size component.
	 * @param height - The maximum allowed height of the Size component. If not given, it will use the `width`.
	 *
	 * @return This Size component instance.
	**/
	public function setMax(width:Float = MathConst.FLOAT_MAX, ?height:Float)
	{
		final height = height != null ? height : width;

		maxWidth = clamp(width, minWidth, MathConst.FLOAT_MAX);
		maxHeight = clamp(height, minHeight, MathConst.FLOAT_MAX);

		return setSize(_width, _height);
	}

	/**
	 * Sets the width and height of this Size component based on the aspect mode.
	 *
	 * If the aspect mode is 'none' then calling this method will change the aspect ratio, otherwise the current
	 * aspect ratio is honored across all other modes.
	 *
	 * If snapTo values have been set then the given width and height are snapped first, prior to any further
	 * adjustment via min/max values, or a parent.
	 *
	 * If minimum and/or maximum dimensions have been specified, the values given to this method will be clamped into
	 * that range prior to adjustment, but may still exceed them depending on the aspect mode.
	 *
	 * If this Size component has a parent set, and the aspect mode is `fit` or `envelop`, then the given sizes will
	 * be clamped to the range specified by the parent.
	 *
	 * @since 1.0.0
	 *
	 * @param width - The new width of the Size component.
	 * @param height - The new height of the Size component. If not given, it will use the `width`.
	 *
	 * @return This Size component instance.
	**/
	public function setSize(width:Float = 0, ?height:Float):Size
	{
		final height = height != null ? height : width;

		return this;
	}

	/**
	 * Sets a new aspect ratio, overriding what was there previously.
	 *
	 * It then calls `setSize` immediately using the current dimensions.
	 *
	 * @since 1.0.0
	 *
	 * @param ratio - The new aspect ratio.
	 *
	 * @return This Size component instance.
	**/
	public function setAspectRatio(ratio:Float):Size
	{
		aspectRatio = ratio;
		return setSize(_width, _height);
	}

	/**
	 * Sets a new width and height for this Size component and updates the aspect ratio based on them.
	 *
	 * It _doesn't_ change the `aspectMode` and still factors in size limits such as the min max and parent bounds.
	 *
	 * @method Phaser.Structs.Size#resize
	 * @since 3.16.0
	 *
	 * @param {number} width - The new width of the Size component.
	 * @param {number} [height=width] - The new height of the Size component. If not given, it will use the `width`.
	 *
	 * @return {this} This Size component instance.
	**/
	public function resize(width, height):Size
	{
		this._width = this.getNewWidth(snapFloor(width, this.snapTo.x));
		this._height = this.getNewHeight(snapFloor(height, this.snapTo.y));
		this.aspectRatio = (this._height == 0) ? 1 : this._width / this._height;
		return this;
	}

	/**
	 * Takes a new width and passes it through the min/max clamp and then checks it doesn't exceed the parent width.
	 *
	 * @method Phaser.Structs.Size#getNewWidth
	 * @since 1.0.0
	 *
	 * @param value - The value to clamp and check.
	 * @param checkParent - Check the given value against the parent, if set.
	 *
	 * @return The modified width value.
	**/
	function getNewWidth(value:Float, checkParent:Bool = true):Float
	{
		value = clamp(value, minWidth, maxWidth);
		if (checkParent && _parent != null && value > _parent.width)
		{
			value = Math.max(minWidth, _parent.width);
		}
		return value;
	}

	/**
	 * Takes a new height and passes it through the min/max clamp and then checks it doesn't exceed the parent height.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The value to clamp and check.
	 * @param checkParent - Check the given value against the parent, if set.
	 *
	 * @return The modified height value.
	**/
	public function getNewHeight(value:Float, checkParent = true):Float
	{
		value = clamp(value, this.minHeight, this.maxHeight);
		if (checkParent && _parent != null && value > _parent.height)
		{
			value = Math.max(this.minHeight, this._parent.height);
		}
		return value;
	}

	/**
	 * The current `width` and `height` are adjusted to fit inside the given dimensions, while keeping the aspect ratio.
	 *
	 * If `fit` is true there may be some space inside the target area which is not covered if its aspect ratio differs.
	 * If `fit` is false the size may extend further out than the target area if the aspect ratios differ.
	 *
	 * If this Size component has a parent set, then the width and height passed to this method will be clamped so
	 * it cannot exceed that of the parent.
	 *
	 * @since 1.0.0
	 *
	 * @param width - The new width of the Size component.
	 * @param height - The new height of the Size component. If not given, it will use the width value.
	 * @param fit - Perform a `fit` (true) constraint, or an `envelop` (false) constraint.
	 *
	 * @return This Size component instance.
	**/
	public function constrain(width:Float = 0, ?height:Float, fit:Bool = true):Size
	{
		var height = height != null ? height : width;

		width = getNewWidth(width);
		height = getNewHeight(height);
		var snap = snapTo;
		var newRatio = (height == 0) ? 1 : width / height;
		if ((fit && aspectRatio > newRatio) || (!fit && aspectRatio < newRatio))
		{
			//  We need to change the height to fit the width
			// height = width / this.aspectRatio;
			width = snapFloor(width, snap.x);
			height = width / aspectRatio;
			if (snap.y > 0)
			{
				height = snapFloor(height, snap.y);
				//  Reduce the width accordingly
				width = height * aspectRatio;
			}
		}
		else if ((fit && aspectRatio < newRatio) || (!fit && aspectRatio > newRatio))
		{
			//  We need to change the width to fit the height
			// width = height * this.aspectRatio;
			height = snapFloor(height, snap.y);
			width = height * aspectRatio;
			if (snap.x > 0)
			{
				width = snapFloor(width, snap.x);
				//  Reduce the height accordingly
				height = width * (1 / aspectRatio);
			}
		}
		_width = width;
		_height = height;
		return this;
	}

	/**
	 * The current `width` and `height` are adjusted to fit inside the given dimensions, while keeping the aspect ratio.
	 *
	 * There may be some space inside the target area which is not covered if its aspect ratio differs.
	 *
	 * If this Size component has a parent set, then the width and height passed to this method will be clamped so
	 * it cannot exceed that of the parent.
	 *
	 * @since 1.0.0
	 *
	 * @param width - The new width of the Size component.
	 * @param height - The new height of the Size component. If not given, it will use the width value.
	 *
	 * @return This Size component instance.
	**/
	public inline function fitTo(width:Float = 0, ?height:Float):Size
	{
		return constrain(width, height, true);
	}

	/**
	 * The current `width` and `height` are adjusted so that they fully envlop the given dimensions, while keeping the aspect ratio.
	 *
	 * The size may extend further out than the target area if the aspect ratios differ.
	 *
	 * If this Size component has a parent set, then the values are clamped so that it never exceeds the parent
	 * on the longest axis.
	 *
	 * @method Phaser.Structs.Size#envelop
	 * @since 1.0.0
	 *
	 * @param width - The new width of the Size component.
	 * @param height - The new height of the Size component. If not given, it will use the width value.
	 *
	 * @return This Size component instance.
	**/
	public inline function envelop(width:Float = 0, ?height:Float):Size
	{
		return constrain(width, height, true);
	}

	/**
	 * Sets the width of this Size component.
	 *
	 * Depending on the aspect mode, changing the width may also update the height and aspect ratio.
	 *
	 * @since 1.0.0
	 *
	 * @param width - The new width of the Size component.
	 *
	 * @return This Size component instance.
	**/
	public function setWidth(value:Float):Size
	{
		return setSize(value, _height);
	}

	/**
	 * Sets the height of this Size component.
	 *
	 * Depending on the aspect mode, changing the height may also update the width and aspect ratio.
	 *
	 * @since 1.0.0
	 *
	 * @param height - The new height of the Size component.
	 *
	 * @return This Size component instance.
	**/
	public function setHeight(value):Size
	{
		return setSize(_width, value);
	}

	/**
	 * Returns a string representation of this Size component.
	 *
	 * @since 1.0.0
	 *
	 * @return A string representation of this Size component.
	**/
	public function toString():String
	{
		return
			'[{ Size (width=$_width height=$_height aspectRatio=$aspectRatio aspectMode=$aspectMode) }]';
	}

	/**
	 * Sets the values of this Size component to the `element.style.width` and `height`
	 * properties of the given DOM Element. The properties are set as `px` values.
	 *
	 * @since 1.0.0
	 *
	 * @param element - The DOM Element to set the CSS style on.
	**/
	public function setCSS(element:HtmlElement):Void
	{
		if (element != null && element.style != null)
		{
			element.style.width = '${_width}px';
			element.style.height = '${_height}px';
		}
	}

	/**
	 * Copies the aspect mode, aspect ratio, width and height from this Size component
	 * to the given Size component. Note that the parent, if set, is not copied across.
	 *
	 * @since 3.16.0
	 *
	 * @param destination - The Size component to copy the values to.
	 *
	 * @return The updated destination Size component.
	**/
	public function Copy(destination:Size):Size
	{
		destination.setAspectMode(this.aspectMode);

		destination.aspectRatio = this.aspectRatio;

		return destination.setSize(this.width, this.height);
	}

	/**
	 * Destroys this Size component.
	 *
	 * This clears the local properties and any parent object, if set.
	 *
	 * A destroyed Size component cannot be re-used.
	 *
	 * @since 1.0.0
	**/
	public function destroy():Void
	{
		_parent = null;
		snapTo = null;
	}

	public var width(get, set):Float;

	private inline function get_width():Float
	{
		return _width;
	}

	private inline function set_width(value:Float):Float
	{
		setSize(value, _height);
		return _width;
	}
}
