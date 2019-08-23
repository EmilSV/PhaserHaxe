package phaserHaxe.renderer;

import haxe.ds.Vector;

abstract BlendModeMap(Vector<String>)
{
	public function new()
	{
		this = new Vector<String>(BlendModes.XOR + 1);
	}

	@:arrayAccess
	public inline function get(key:BlendModes)
	{
		return this.get(key);
	}

	@:arrayAccess
	public inline function set(key:BlendModes, value:String):String
	{
		return this.set(key, value);
	}
}
