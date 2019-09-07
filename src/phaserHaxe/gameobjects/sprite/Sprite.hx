package phaserHaxe.gameobjects.sprite;

import phaserHaxe.gameobjects.components.*;

@:build(phaserHaxe.macro.Mixin.auto())
@:allow(phaserHaxe.renderer.canvas.CanvasRenderer)
class Sprite extends GameObject implements IAlpha implements IBlendMode
		implements IDepth implements IFlip implements IGetBounds implements IMask
		implements IOrigin implements IPipeline implements IScrollFactor
		implements ISize implements ITextureCrop implements ITint
		implements ITransform implements IVisible
{
	public function new(scene, x, y, texture, frame)
	{
		super(scene, 'Sprite');
		_crop = resetCropObject();
	}
}
