import phaserHaxe.gameobjects.components.Transform;
import phaserHaxe.gameobjects.components.Depth;
import phaserHaxe.gameobjects.components.Origin;
import phaserHaxe.gameobjects.GameObject;
import phaserHaxe.StringOrNumber;

class TestG implements ITransform implements IDepth implements IOrigin
{
	public function new() {}
}

class Main
{
	static public function test(v:StringOrNumber)
	{
		v.match({
			string: (s) ->
				{
					var s1 = s + "g";
				},
			number: (n) ->
				{
					trace(n);
				}
		});
	}

	static public function main():Void
	{
		var n = new TestG();
		test(4);
	}
}
