import phaserHaxe.gameobjects.components.ICTransform;
import phaserHaxe.gameobjects.components.ICComputedSize;
import phaserHaxe.gameobjects.components.ICOrigin;
import phaserHaxe.gameobjects.GameObject;
import haxe.ds.Either;

class TestG implements ICComputedSize
{
	public function new() {

	}
}

class Main
{
	static public function test(v:Either<String, Float>) {}

	static public function main():Void
	{
		var n = new TestG();
	}
}
