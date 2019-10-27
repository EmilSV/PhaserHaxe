package phaserHaxe.gameobjects.blitter;

import phaserHaxe.utils.types.StringOrInt;
import phaserHaxe.utils.CustomData;
import phaserHaxe.textures.Frame;

class Bob
{
	/**
	 * The Blitter object that this Bob belongs to.
	 *
	 * @since 1.0.0
	**/
	public var parent:Blitter;

	/**
	 * The x position of this Bob, relative to the x position of the Blitter.
	 *
	 * @since 1.0.0
	**/
	public var x:Float;

	/**
	 * The y position of this Bob, relative to the y position of the Blitter.
	 *
	 * @since 1.0.0
	**/
	public var y:Float;

	/**
	 * The frame that the Bob uses to render with.
	 * To change the frame use the `Bob.setFrame` method.
	 *
	 * @since 1.0.0
	**/
	public var frame:Frame;

	/**
	 * A blank object which can be used to store data related to this Bob in.
	 *
	 * @since 1.0.0
	**/
	public var data:CustomData = new CustomData();

	/**
	 * The tint value of this Bob.bb
	 *
	 * @since 1.0.0
	 */
	public var tint:Int = 0xffffff;

	/**
	 * The visible state of this Bob.
	 *
	 * @since 1.0.0
	**/
	public var _visible:Bool;

	/**
	 * The alpha value of this Bob.
	 *
	 * @since 1.0.0
	**/
	private var _alpha:Float = 1;

	/**
	 * The horizontally flipped state of the Bob.
	 * A Bob that is flipped horizontally will render inversed on the horizontal axis.
	 * Flipping always takes place from the middle of the texture.
	 *
	 * @since 1.0.0
	**/
	public var flipX:Bool = false;

	/**
	 * The vertically flipped state of the Bob.
	 * A Bob that is flipped vertically will render inversed on the vertical axis (i.e. upside down)
	 * Flipping always takes place from the middle of the texture.
	 *
	 * @since 1.0.0
	**/
	public var flipY:Bool = false;

	/**
	 * The visible state of the Bob.
	 *
	 * An invisible Bob will skip rendering.
	 *
	 * @since 1.0.0
	**/
	public var visible(get, set):Bool;

	/**
	 * The alpha value of the Bob, between 0 and 1.
	 *
	 * A Bob with alpha 0 will skip rendering.
	 *
	 * @since 1.0.0
	**/
	public var alpha(get, set):Float;

	public function new(blitter:Blitter, x:Float, y:Float, frame:Frame, visible:Bool)
	{
		this.parent = blitter;
		this.x = x;
		this.y = y;
		this.frame = frame;
		this._visible = visible;
	}

	private inline function get_visible():Bool
	{
		return _visible;
	}

	private inline function set_visible(value:Bool):Bool
	{
		throw new Error("Not Implemented");

		// parent.dirty |= (_visible != value);
		// return _visible = value;
	}

	private inline function get_alpha():Float
	{
		return _alpha;
	}

	private inline function set_alpha(value:Float):Float
	{
		throw new Error("Not Implemented");

		// parent.dirty |= (_alpha > 0) != (value > 0);
		// return _alpha = value;
	}

	/**
	 * Sets the horizontal flipped state of this Bob.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The flipped state. `false` for no flip, or `true` to be flipped.
	 *
	 * @return This Bob Game Object.
	**/
	public function setFlipX(value:Bool):Bob
	{
		flipX = value;
		return this;
	}

	/**
	 * Sets the vertical flipped state of this Bob.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The flipped state. `false` for no flip, or `true` to be flipped.
	 *
	 * @return This Bob Game Object.
	**/
	public function setFlipY(value:Bool):Bob
	{
		flipY = value;
		return this;
	}

	/**
	 * Sets the horizontal and vertical flipped state of this Bob.
	 *
	 * @since 1.0.0
	 *
	 * @param  x - The horizontal flipped state. `false` for no flip, or `true` to be flipped.
	 * @param  y - The horizontal flipped state. `false` for no flip, or `true` to be flipped.
	 *
	 * @return This Bob Game Object.
	**/
	public function setFlip(x:Bool, y:Bool):Bob
	{
		flipX = x;
		flipY = y;
		return this;
	}

	/**
	 * Sets the visibility of this Bob.
	 *
	 * An invisible Bob will skip rendering.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The visible state of the Game Object.
	 *
	 * @return This Bob Game Object.
	**/
	public function setVisible(value:Bool):Bob
	{
		visible = value;
		return this;
	}

	/**
	 * Set the Alpha level of this Bob. The alpha controls the opacity of the Game Object as it renders.
	 * Alpha values are provided as a float between 0, fully transparent, and 1, fully opaque.
	 *
	 * A Bob with alpha 0 will skip rendering.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The alpha value used for this Bob. Between 0 and 1.
	 *
	 * @return This Bob Game Object.
	**/
	public function setAlpha(value:Float):Bob
	{
		alpha = value;
		return this;
	}

	/**
	 * Sets the tint of this Bob.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The tint value used for this Bob. Between 0 and 0xffffff.
	 *
	 * @return This Bob Game Object.
	**/
	public function setTint(value):Bob
	{
		tint = value;
		return this;
	}

	/**
	 * Destroys this Bob instance.
	 * Removes itself from the Blitter and clears the parent, frame and data properties.
	 *
	 * @since 1.0.0
	**/
	public function destroy():Bool
	{
		throw new Error("Not Implemented");

		// this.parent.dirty = true;

		// this.parent.children.remove(this);

		// this.parent = null;
		// this.frame = null;
		// this.data = null;
	}
}
