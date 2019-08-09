package phaserHaxe.gameobjects.components;

#if eval
import haxe.macro.Context;
import haxe.macro.Expr;
import phaserHaxe.macro.ComponentBuilder;
#end

interface IFlip
{
	/**
	 * The horizontally flipped state of the Game Object.
	 *
	 * A Game Object that is flipped horizontally will render inversed on the horizontal axis.
	 * Flipping always takes place from the middle of the texture and does not impact the scale value.
	 * If this Game Object has a physics body, it will not change the body. This is a rendering toggle only.
	 *
	 * @since 1.0.0
	**/
	public var flipX:Bool;

	/**
	 * The vertically flipped state of the Game Object.
	 *
	 * A Game Object that is flipped vertically will render inversed on the vertical axis (i.e. upside down)
	 * Flipping always takes place from the middle of the texture and does not impact the scale value.
	 * If this Game Object has a physics body, it will not change the body. This is a rendering toggle only.
	 *
	 * @since 1.0.0
	**/
	public var flipY:Bool;

	/**
	 * Toggles the horizontal flipped state of this Game Object.
	 *
	 * A Game Object that is flipped horizontally will render inversed on the horizontal axis.
	 * Flipping always takes place from the middle of the texture and does not impact the scale value.
	 * If this Game Object has a physics body, it will not change the body. This is a rendering toggle only.
	 *
	 * @since 1.0.0
	 *
	 * @return This Game Object instance.
	**/
	public function toggleFlipX():IFlip;

	/**
	 * Toggles the vertical flipped state of this Game Object.
	 *
	 * @since 1.0.0
	 *
	 * @return This Game Object instance.
	**/
	public function toggleFlipY():IFlip;

	/**
	 * Sets the horizontal flipped state of this Game Object.
	 *
	 * A Game Object that is flipped horizontally will render inversed on the horizontal axis.
	 * Flipping always takes place from the middle of the texture and does not impact the scale value.
	 * If this Game Object has a physics body, it will not change the body. This is a rendering toggle only.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The flipped state. `false` for no flip, or `true` to be flipped.
	 *
	 * @return This Game Object instance.
	**/
	public function setFlipX(value:Bool):IFlip;

	/**
	 * Sets the vertical flipped state of this Game Object.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The flipped state. `false` for no flip, or `true` to be flipped.
	 *
	 * @return This Game Object instance.
	**/
	public function setFlipY(value:Bool):IFlip;

	/**
	 * Sets the horizontal and vertical flipped state of this Game Object.
	 *
	 * A Game Object that is flipped will render inversed on the flipped axis.
	 * Flipping always takes place from the middle of the texture and does not impact the scale value.
	 * If this Game Object has a physics body, it will not change the body. This is a rendering toggle only.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The horizontal flipped state. `false` for no flip, or `true` to be flipped.
	 * @param y - The horizontal flipped state. `false` for no flip, or `true` to be flipped.
	 *
	 * @return This Game Object instance.
	**/
	public function setFlip(x:Bool, y:Bool):IFlip;

	/**
	 * Resets the horizontal and vertical flipped state of this Game Object back to their default un-flipped state.
	 *
	 * @since 1.0.0
	 *
	 * @return This Game Object instance.
	**/
	public function resetFlip():IFlip;
}

@:noCompletion
final class FlipImplementation
{
	@:generic
	public static inline function toggleFlipX<T:IFlip>(self:T):T
	{
		self.flipX = !self.flipX;
		return self;
	}

	@:generic
	public static inline function toggleFlipY<T:IFlip>(self:T):T
	{
		self.flipY = !self.flipY;
		return self;
	}

	@:generic
	public static inline function setFlipX<T:IFlip>(self:T, value:Bool):T
	{
		self.flipX = value;
		return self;
	}

	@:generic
	public static inline function setFlipY<T:IFlip>(self:T, value:Bool):T
	{
		self.flipY = value;
		return self;
	}

	@:generic
	public static inline function setFlip<T:IFlip>(self:T, x:Bool, y:Bool):T
	{
		self.flipX = x;
		self.flipY = y;

		return self;
	}

	@:generic
	public static inline function resetFlip<T:IFlip>(self:T):T
	{
		self.flipX = false;
		self.flipY = false;

		return self;
	}
}

final class FlipBuilder
{
	#if eval
	public static function build():Array<Field>
	{
		final builder = new ComponentBuilder();

		builder.addVar({
			name: "flipX",
			type: macro:Bool
		});

		builder.addVar({
			name: "flipY",
			type: macro:Bool
		});

		return builder.createFelids();
	}
	#end
}
