package phaserHaxe.animations;

import phaserHaxe.utils.StringOrInt;

/**
 *
 * @since 1.0.0
**/
@:structInit
final class AnimationFrameConfig
{
	/**
	 *  The key that the animation will be associated with. i.e. sprite.animations.play(key)
	 *
	 * @since 1.0.0
	**/
	public var key:Null<String>;

	/**
	 *  [description]
	 *
	 * @since 1.0.0
	**/
	public var frame:Null<StringOrInt>;

	/**
	 *  [description]
	 *
	 * @since 1.0.0
	**/
	public var duration:Float;

	/**
	 *  [description]
	 *
	 * @since 1.0.0
	**/
	public var visible:Null<Bool>;

	public function new(?key:String, ?frame:StringOrInt, ?duration:Float, ?visible:Bool)
	{
		this.key = key;
		this.frame = frame;
		this.duration = duration != null ? duration : 0;
		this.visible = visible;
	}
}
