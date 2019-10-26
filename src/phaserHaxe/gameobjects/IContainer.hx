package phaserHaxe.gameobjects;

import phaserHaxe.gameobjects.components.IOrigin;
import phaserHaxe.gameobjects.components.TransformMatrix;
import phaserHaxe.gameobjects.components.IVisible;
import phaserHaxe.gameobjects.components.ITransform;
import phaserHaxe.gameobjects.components.IMask;
import phaserHaxe.gameobjects.components.IDepth;
import phaserHaxe.gameobjects.components.IComputedSize;
import phaserHaxe.gameobjects.components.IBlendMode;
import phaserHaxe.gameobjects.components.IAlpha;

interface IContainer extends IAlpha extends IBlendMode extends IComputedSize extends IDepth extends IMask extends ITransform extends IVisible extends IOrigin
{
	/**
	 * Returns the world transform matrix as used for Bounds checks.
	 *
	 * The returned matrix is temporal and shouldn't be stored.
	 *
	 * @since 1.0.0
	 *
	 * @return The world transform matrix.
	**/
	public function getBoundsTransformMatrix():TransformMatrix;
}
