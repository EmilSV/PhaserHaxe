package phaserHaxe.gameobjects.group;

@:forward
abstract Group(Dynamic)
{
	public static inline function isGroup(value:Dynamic):Bool
	{
		return false;
	}
}
