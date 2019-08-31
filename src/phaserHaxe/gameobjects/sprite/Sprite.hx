package phaserHaxe.gameobjects.sprite;

import phaserHaxe.gameobjects.components.*;
import phaserHaxe.macro.Mixin;
import phaserHaxe.gameobjects.sprite.ISpriteRenderer;

@:build(phaserHaxe.macro.Mixin.auto())
class Sprite extends GameObject implements IAlpha implements IBlendMode
		implements IDepth implements IFlip implements IGetBounds implements IMask
		implements IOrigin implements IPipeline implements IPipeline
		implements IPipeline implements IPipeline implements IScrollFactor
		implements ISize implements ITextureCrop implements ITint
		implements ITransform implements IVisible implements ISpriteRenderer
{
	public function new(scene, x, y, texture, frame)
	{
		super(scene, 'Sprite');
		_crop = resetCropObject();
	}
}
