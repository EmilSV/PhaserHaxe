package phaserHaxe.loader;

@:forward
abstract LoaderPlugin(Dynamic)
{
	public function new(scene:Scene) 
    {
        this = null;
    }
}
