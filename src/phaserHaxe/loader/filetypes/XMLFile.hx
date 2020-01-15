package phaserHaxe.loader.filetypes;

import phaserHaxe.loader.filetypes.typedefs.XMLFileConfig;
import phaserHaxe.utils.types.Union;

class XMLFile extends File
{
	public function new(loader:LoaderPlugin, key:Union<String, XMLFileConfig>,
        ?url:String, ?xhrSettings:XHRSettingsObject) 
    {
        super(null,null);
    }
}
