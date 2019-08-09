import phaserHaxe.gameobjects.components.Transform;
import phaserHaxe.gameobjects.components.Depth;
import phaserHaxe.gameobjects.components.Origin;
import phaserHaxe.gameobjects.GameObject;
import haxe.ds.Either;

class TestG implements IDepth
{
	public function new()
	{
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
