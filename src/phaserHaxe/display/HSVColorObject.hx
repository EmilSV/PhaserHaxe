package phaserHaxe.display;

@:structInit
final class HSVColorObject
{
	public var h:Float;
	public var s:Float;
	public var v:Float;

	public function new(h:Float = 0, s:Float = 0, v:Float = 0)
	{
		this.h = h;
		this.s = s;
		this.v = v;
	}
}
