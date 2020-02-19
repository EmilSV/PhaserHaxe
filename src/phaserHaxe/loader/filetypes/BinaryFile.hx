package phaserHaxe.loader.filetypes;

import phaserHaxe.loader.filetypes.typedefs.BinaryFileConfig;
import phaserHaxe.loader.typedefs.FileConfig;
import phaserHaxe.utils.types.Union;

typedef Config =
{
	dataTypeConstructor:Null<(js.lib.ArrayBuffer)>->Any
}

class BinaryFile extends File
{
	public function new(loader:LoaderPlugin, key:Union<String, BinaryFileConfig<Any>>, ?url:String,
			?xhrSettings:XHRSettingsObject, ?dataTypeConstructor:(js.lib.ArrayBuffer) -> Any)
	{
		var extension = "bin";
		if (!Std.is(key, String))
		{
			var config = (cast key : BinaryFileConfig<Any>);
			key = config.key;
			url = config.url;
			xhrSettings = config.xhrSettings;
			if (config.extension != null)
			{
				extension = config.extension;
			}
			if (config.dataTypeConstructor != null)
			{
				dataTypeConstructor = config.dataTypeConstructor;
			}
		}

		var fileConfig:FileConfig = {
			type: "binary",
			cache: loader.cacheManager.binary,
			extension: extension,
			responseType: ARRAYBUFFER,
			key: (cast key : String),
			url: url,
			xhrSettings: xhrSettings,
			config: {dataTypeConstructor: dataTypeConstructor}
		};

		super(loader, fileConfig);
	}

	/**
	 * Called automatically by Loader.nextFile.
	 * This method controls what extra work this File does with its loaded data.
	 *
	 * @since 1.0.0
	**/
	public override function onProcess()
	{
		this.state = FileConst.FILE_PROCESSING;

		var ctor = (this.config : Config).dataTypeConstructor;

		final response = this.xhrLoader.response;

		this.data = (ctor != null) ? ctor(response) : response;

		this.onProcessComplete();
	}
}
