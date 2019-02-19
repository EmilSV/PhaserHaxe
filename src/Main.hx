import phaserHaxe.math.RandomDataGenerator;

class Main
{
	static public function main():Void
	{
		var rdg = new RandomDataGenerator(["stuff", "stuff"]);
		trace(rdg.integer());
		trace(rdg.integer());
		trace(rdg.integer());
		trace(rdg.integer());
		trace(rdg.integer());

		trace(rdg.uuid());
		trace(rdg.uuid());
		trace(rdg.uuid());
		trace(rdg.uuid());
		trace(rdg.uuid());
	}
}
