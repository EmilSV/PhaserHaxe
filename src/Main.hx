import phaserHaxe.gameobjects.components.ITransform;
import phaserHaxe.gameobjects.components.IFlip;
import phaserHaxe.gameobjects.components.IComputedSize;
import phaserHaxe.Scene;
import phaserHaxe.gameobjects.GameObject;
import haxe.ds.Either;

// @:build(phaserHaxe.macro.Mixin.build(FlipMixin, ComputedSizeMixin, TransformMixin))
// class TestG extends GameObject implements IFlip implements IComputedSize
// 		implements ITransform
// {
// 	public function new(scene:Scene, type:String)
// 	{
// 		super(scene, type);
// 	}
// }
class Main
{
	static public function test(v:Either<String, Float>) {}

	static public function anym(value:{}) {}

	static public function main():Void {}
}
