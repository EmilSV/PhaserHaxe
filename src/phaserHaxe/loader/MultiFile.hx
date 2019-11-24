package phaserHaxe.loader;

import js.html.File;

@:forward
abstract MultiFile(Dynamic)
{
	public function new(loader:LoaderPlugin, type:String, key:String, files:Array<File>)
	{
		this = null;
	}
}
