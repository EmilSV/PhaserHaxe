package phaserHaxe.loader;

import haxe.ds.StringMap;

abstract FileConfigData(StringMap<Any>)
{
	public function new()
	{
		this = new StringMap<Any>();
	}

	@:arrayAccess @:noCompletion public inline function arrayWrite(k:String, v:Any):Any
	{
		this.set(k, v);
		return v;
	}

	@:arrayAccess @:noCompletion public inline function get(key:String)
	{
		return this.get(key);
	}
}
