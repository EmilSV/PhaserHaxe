package phaserHaxe.gameobjects;

enum abstract RenderFlags(Int) from Int to Int
{
	var VISIBLE = 1;
	var ALPHA = 2;
	var TRANSFORM = 4;
	var TEXTURE = 8;

	public inline function hasFlag(flag:RenderFlags):Bool
	{
		return (this & flag) != 0;
	}

	public inline function hasAllFlags(flag:RenderFlags):Bool
	{
		return (this & flag) == this;
	}
}
