package phaserHaxe.gameobjects.blitter;

import phaserHaxe.gameobjects.components.*;

@:build(phaserHaxe.macro.Mixin.auto())
class Blitter extends GameObject implements IAlpha implements IBlendMode implements IDepth implements IMask
		implements IPipeline implements IScrollFactor implements ISize
		implements ITexture implements ITransform implements IVisible {}
