package phaserHaxe.gameobjects;

import phaserHaxe.gameobjects.components.TransformMatrix;
import phaserHaxe.textures.Frame;
import phaserHaxe.gameobjects.components.ITransform;
import phaserHaxe.gameobjects.components.IVisible.VisibleMixin;
import phaserHaxe.gameobjects.components.ITransform.TransformMixin;
import phaserHaxe.gameobjects.components.IMask.MaskMixin;
import phaserHaxe.gameobjects.components.IDepth.DepthMixin;
import phaserHaxe.gameobjects.components.IComputedSize.ComputedSizeImplementation;
import phaserHaxe.gameobjects.components.IBlendMode.BlendModeMixin;
import phaserHaxe.gameobjects.components.IAlpha.AlphaMixin;

@:build(phaserHaxe.macro.Mixin.build(AlphaMixin, BlendModeMixin, DepthMixin, MaskMixin, TransformMixin, VisibleMixin))
class Container extends GameObject implements IContainer
{
	/**
	 * The native (un-scaled) width of this Game Object.
	 *
	 * Changing this value will not change the size that the Game Object is rendered in-game.
	 * For that you need to either set the scale of the Game Object (`setScale`) or use
	 * the `displayWidth` property.
	 *
	 * @since 1.0.0
	**/
	public var width:Float;

	/**
	 * The native (un-scaled) height of this Game Object.
	 *
	 * Changing this value will not change the size that the Game Object is rendered in-game.
	 * For that you need to either set the scale of the Game Object (`setScale`) or use
	 * the `displayHeight` property.
	 *
	 * @since 1.0.0
	 */
	public var height:Float;

	/**
	 * The displayed width of this Game Object.
	 *
	 * This value takes into account the scale factor.
	 *
	 * Setting this value will adjust the Game Object's scale property.
	 *
	 * @since 1.0.0
	**/
	public var displayWidth(get, set):Float;

	/**
	 * The displayed height of this Game Object.
	 *
	 * This value takes into account the scale factor.
	 *
	 * Setting this value will adjust the Game Object's scale property.
	 *
	 * @since 1.0.0
	**/
	public var displayHeight(get, set):Float;

	private inline function get_displayWidth():Float
	{
		return ComputedSizeImplementation.get_displayWidth(this);
	}

	private inline function set_displayWidth(value:Float):Float
	{
		return ComputedSizeImplementation.set_displayWidth(this, value);
	}

	private inline function get_displayHeight():Float
	{
		return ComputedSizeImplementation.get_displayHeight(this);
	}

	private inline function set_displayHeight(value:Float):Float
	{
		return ComputedSizeImplementation.set_displayHeight(this, value);
	}

	/**
	 * Sets the size of this Game Object to be that of the given Frame.
	 *
	 * This will not change the size that the Game Object is rendered in-game.
	 * For that you need to either set the scale of the Game Object (`setScale`) or call the
	 * `setDisplaySize` method, which is the same thing as changing the scale but allows you
	 * to do so by giving pixel values.
	 *
	 * If you have enabled this Game Object for input, changing the size will _not_ change the
	 * size of the hit area. To do this you should adjust the `input.hitArea` object directly.
	 *
	 * @since 1.0.0
	 *
	 * @param frame - The frame to base the size of this Game Object on.
	 *
	 * @return This Game Object instance.
	**/
	public function setSizeToFrame(?frame:Frame):Container
	{
		return this;
	}

	/**
	 * Sets the internal size of this Game Object, as used for frame or physics body creation.
	 *
	 * This will not change the size that the Game Object is rendered in-game.
	 * For that you need to either set the scale of the Game Object (`setScale`) or call the
	 * `setDisplaySize` method, which is the same thing as changing the scale but allows you
	 * to do so by giving pixel values.
	 *
	 * If you have enabled this Game Object for input, changing the size will _not_ change the
	 * size of the hit area. To do this you should adjust the `input.hitArea` object directly.
	 *
	 * @since 1.0.0
	 *
	 * @param width - The width of this Game Object.
	 * @param height - The height of this Game Object.
	 *
	 * @return This Game Object instance.
	**/
	public function setSize(width:Float, height:Float):Container
	{
		return this;
	}

	/**
	 * Sets the display size of this Game Object.
	 *
	 * Calling this will adjust the scale.
	 *
	 * @since 1.0.0
	 *
	 * @param width - The width of this Game Object.
	 * @param height - The height of this Game Object.
	 *
	 * @return This Game Object instance.
	**/
	public function setDisplaySize(width:Float, height:Float):Container
	{
		return this;
	}

	/**
	 * Returns the world transform matrix as used for Bounds checks.
	 *
	 * The returned matrix is temporal and shouldn't be stored.
	 *
	 * @method Phaser.GameObjects.Container#getBoundsTransformMatrix
	 * @since 3.4.0
	 *
	 * @return {Phaser.GameObjects.Components.TransformMatrix} The world transform matrix.
	 */
	public function getBoundsTransformMatrix():TransformMatrix
	{
		throw new Error("Not implemented");
		//return this.getWorldTransformMatrix(this.tempTransformMatrix, this.localTransform);
	}
}
