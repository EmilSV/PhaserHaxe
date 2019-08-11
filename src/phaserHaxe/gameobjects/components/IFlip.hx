package phaserHaxe.gameobjects.components;

interface IFlip
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

final class FlipImplementation
{
	public static inline function toggleFlipX<T:IFlip>(self:T):T
	{
		self.flipX = !self.flipX;
		return self;
	}

	public static inline function toggleFlipY<T:IFlip>(self:T):T
	{
		self.flipY = !self.flipY;
		return self;
	}

	public static inline function setFlipX<T:IFlip>(self:T, value:Bool):T
	{
		self.flipX = value;
		return self;
	}

	public static inline function setFlipY<T:IFlip>(self:T, value:Bool):T
	{
		self.flipY = value;
		return self;
	}

	public static inline function setFlip<T:IFlip>(self:T, x:Bool, y:Bool):T
	{
		self.flipX = x;
		self.flipY = y;

		return self;
	}

	public static inline function resetFlip<T:IFlip>(self:T):T
	{
		self.flipX = false;
		self.flipY = false;

		return self;
	}
}

final class FlipMixin implements IFlip
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
		return cast FlipImplementation.toggleFlipX(this);
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
		return FlipImplementation.toggleFlipY(this);
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
		return FlipImplementation.setFlipX(this, value);
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
		return FlipImplementation.setFlipY(this, value);
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
		return FlipImplementation.setFlip(this, x, y);
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
		return FlipImplementation.resetFlip(this);
	}
}
