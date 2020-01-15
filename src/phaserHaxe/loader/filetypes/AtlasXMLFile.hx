package phaserHaxe.loader.filetypes;

import phaserHaxe.utils.types.MultipleOrOne;
import phaserHaxe.loader.filetypes.typedefs.AtlasXMLFileConfig;
import phaserHaxe.utils.types.Union;

class AtlasXMLFile extends MultiFile
{
	public function new(loader:LoaderPlugin, key:Union<String, AtlasXMLFileConfig>,
			?textureURL:MultipleOrOne<String>, ?atlasURL:String,
			?textureXhrSettings:XHRSettingsObject, ?atlasXhrSettings:XHRSettingsObject)
	{
		var image;
		var data;

		if (!Std.is(key, String))
		{
			var config = (cast key : AtlasXMLFileConfig);

			key = config.key;

			var extension = config.textureExtension;
			if (extension == null)
			{
				extension = "png";
			}

			image = new ImageFile(loader, {
				key: (cast key : String),
				url: config.textureURL,
				extension: extension,
				normalMap: config.normalMap,
				xhrSettings: config.textureXhrSettings
			});

			extension = config.atlasExtension;
			if (extension == null)
			{
				extension = "xml";
			}

			data = new XMLFile(loader, {
				key: (cast key : String),
				url: config.atlasURL,
				extension: extension,
				xhrSettings: config.atlasXhrSettings
			});
		}
		else
		{
			final key = (cast key : String);

			image = new ImageFile(loader, key, textureURL, textureXhrSettings);
			data = new XMLFile(loader, key, atlasURL, atlasXhrSettings);
		}

		final key = (cast key : String);

		if (image.linkFile != null)
		{
			//  Image has a normal map
			super(loader, "atlasxml", key, [image, data, image.linkFile]);
		}
		else
		{
			super(loader, "atlasxml", key, [image, data]);
		}
	}

	/**
	 * Adds this file to its target cache upon successful loading and processing.
	 *
	 * @since 1.0.0
	**/
	public override function addToCache()
	{
		if (isReadyToProcess())
		{
			final image = files[0];
			final xml = files[1];
			final normalMap = files[2] != null ? files[2].data : null;

			loader.textureManager.addAtlasXML(image.key, image.data, xml.data, normalMap);

			xml.addToCache();

			complete = true;
		}
	}
}
