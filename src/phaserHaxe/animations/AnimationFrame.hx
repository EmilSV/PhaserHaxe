package phaserHaxe.animations;

import phaserHaxe.textures.Frame;
import phaserHaxe.utils.StringOrInt;

class AnimationFrame
{
	/**
	 * The key of the Texture this AnimationFrame uses.
	 *
	 * @since 1.0.0
	**/
	public var textureKey:String;

	/**
	 * The key of the Frame within the Texture that this AnimationFrame uses.
	 *
	 * @since 1.0.0
	**/
	public var textureFrame:StringOrInt;

	/**
	 * The index of this AnimationFrame within the Animation sequence.
	 *
	 * @since 1.0.0
	**/
	public var index:Int;

	/**
	 * A reference to the Texture Frame this AnimationFrame uses for rendering.
	 *
	 * @since 1.0.0
	**/
	public var frame:Frame;

	/**
	 * Is this the first frame in an animation sequence?
	 *
	 * @since 1.0.0
	 */
	@:allow(phaserHaxe.animations)
	public var isFirst(default, null):Bool = false;

	/**
	 * Is this the last frame in an animation sequence?
	 *
	 * @since 1.0.0
	**/
	@:allow(phaserHaxe.animations)
	public var isLast(default, null):Bool = false;

	/**
	 * A reference to the AnimationFrame that comes before this one in the animation, if any.
	 *
	 * @since 1.0.0
	**/
	@:allow(phaserHaxe.animations)
	public var prevFrame(default, null):AnimationFrame = null;

	/**
	 * A reference to the AnimationFrame that comes after this one in the animation, if any.
	 *
	 * @since 1.0.0
	**/
	@:allow(phaserHaxe.animations)
	public var nextFrame(default, null):AnimationFrame = null;

	/**
	 * Additional time (in ms) that this frame should appear for during playback.
	 * The value is added onto the msPerFrame set by the animation.
	 *
	 * @since 1.0.0
	**/
	public var duration:Float = 0;

	/**
	 * What % through the animation does this frame come?
	 * This value is generated when the animation is created and cached here.
	 *
	 * @since 1.0.0
	**/
	@:allow(phaserHaxe.animations)
	public var progress(default, null):Float = 0;

	public function new(textureKey:String, textureFrame:StringOrInt, index:Int,
			frame:Frame)
	{
		this.textureKey = textureKey;

		this.textureFrame = textureFrame;

		this.index = index;

		this.frame = frame;
	}

	/**
	 * Generates a JavaScript object suitable for converting to JSON.
	 *
	 * @since 1.0.0
	 *
	 * @return The AnimationFrame data.
	**/
	public function toJSON():JSONAnimationFrame
	{
		return {
			key: textureKey,
			frame: textureFrame,
			duration: duration
		};
	}

	/**
	 * Destroys this object by removing references to external resources and callbacks.
	 *
	 * @since 1.0.0
	**/
	public function destroy():Void
	{
		this.frame = null;
	}
}
