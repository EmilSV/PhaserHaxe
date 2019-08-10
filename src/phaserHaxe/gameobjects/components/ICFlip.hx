package phaserHaxe.gameobjects.components;

@:autoBuild(phaserHaxe.macro.Mixin.build(FlipMixin))
interface ICFlip
{
	/**
	 * The horizontally flipped state of the Game Object.
	 *
	 * A Game Object that is flipped horizontally will render inversed on the horizontal axis.
	 * Flipping always takes place from the middle of the texture and does not impact the scale value.
	 * If this Game Object has a physics body, it will not change the body. This is a rendering toggle only.
	 *
	 * @default false
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
	 * @default false
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
	public function toggleFlipX():ICFlip;

	/**
	 * Toggles the vertical flipped state of this Game Object.
	 *
	 * @since 1.0.0
	 *
	 * @return This Game Object instance.
	**/
	public function toggleFlipY():ICFlip;

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
	public function setFlipX(value:Bool):ICFlip;

	/**
	 * Sets the vertical flipped state of this Game Object.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The flipped state. `false` for no flip, or `true` to be flipped.
	 *
	 * @return This Game Object instance.
	**/
	public function setFlipY(value:Bool):ICFlip;

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
	public function setFlip(x:Bool, y:Bool):ICFlip;

	/**
	 * Resets the horizontal and vertical flipped state of this Game Object back to their default un-flipped state.
	 *
	 * @since 1.0.0
	 *
	 * @return This Game Object instance.
	**/
	public function resetFlip():ICFlip;
}

final class FlipImplementation
{
	public static inline function toggleFlipX<T:ICFlip>(self:T):T
	{
		self.flipX = !self.flipX;
		return self;
	}

	public static inline function toggleFlipY<T:ICFlip>(self:T):T
	{
		self.flipY = !self.flipY;
		return self;
	}

	public static inline function setFlipX<T:ICFlip>(self:T, value:Bool):T
	{
		self.flipX = value;
		return self;
	}

	public static inline function setFlipY<T:ICFlip>(self:T, value:Bool):T
	{
		self.flipY = value;
		return self;
	}

	public static inline function setFlip<T:ICFlip>(self:T, x:Bool, y:Bool):T
	{
		self.flipX = x;
		self.flipY = y;

		return self;
	}

	public static inline function resetFlip<T:ICFlip>(self:T):T
	{
		self.flipX = false;
		self.flipY = false;

		return self;
	}
}

final class FlipMixin
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
	public var flipX:Bool = false;

	/**
	 * The vertically flipped state of the Game Object.
	 *
	 * A Game Object that is flipped vertically will render inversed on the vertical axis (i.e. upside down)
	 * Flipping always takes place from the middle of the texture and does not impact the scale value.
	 * If this Game Object has a physics body, it will not change the body. This is a rendering toggle only.
	 *
	 * @since 1.0.0
	**/
	public var flipY:Bool = false;

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
	public function toggleFlipX():FlipMixin
	{
		return cast FlipImplementation.toggleFlipX(cast this);
	}

	/**
	 * Toggles the vertical flipped state of this Game Object.
	 *
	 * @since 1.0.0
	 *
	 * @return This Game Object instance.
	**/
	public function toggleFlipY():FlipMixin
	{
		return cast FlipImplementation.toggleFlipY(cast this);
	}

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
	public function setFlipX(value:Bool):FlipMixin
	{
		return cast FlipImplementation.setFlipX(cast this, value);
	}

	/**
	 * Sets the vertical flipped state of this Game Object.
	 *
	 * @since 1.0.0
	 *
	 * @param value - The flipped state. `false` for no flip, or `true` to be flipped.
	 *
	 * @return This Game Object instance.
	**/
	public function setFlipY(value:Bool):FlipMixin
	{
		return cast FlipImplementation.setFlipY(cast this, value);
	}

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
	public function setFlip(x:Bool, y:Bool):FlipMixin
	{
		return cast FlipImplementation.setFlip(cast this, x, y);
	}

	/**
	 * Resets the horizontal and vertical flipped state of this Game Object back to their default un-flipped state.
	 *
	 * @since 1.0.0
	 *
	 * @return This Game Object instance.
	**/
	public function resetFlip():FlipMixin
	{
		return cast FlipImplementation.resetFlip(cast this);
	}
}
