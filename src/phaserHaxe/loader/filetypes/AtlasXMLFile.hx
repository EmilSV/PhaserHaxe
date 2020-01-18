package phaserHaxe.loader.filetypes;

import phaserHaxe.utils.types.MultipleOrOne;
import phaserHaxe.loader.filetypes.typedefs.AtlasXMLFileConfig;
import phaserHaxe.utils.types.Union;

/**
 * A single XML based Texture Atlas File suitable for loading by the Loader.
 *
 * These are created when you use the Phaser.Loader.LoaderPlugin#atlasXML method and are not typically created directly.
 *
 * For documentation about what all the arguments and configuration options mean please see Phaser.Loader.LoaderPlugin#atlasXML.
 *
 * @since 1.0.0
**/
class AtlasXMLFile extends MultiFile
{
	/**
	 * @param loader - A reference to the Loader that is responsible for this file.
	 * @param key - The key to use for this file, or a file configuration object.
	 * @param textureURL - The absolute or relative URL to load the texture image file from. If undefined or `null` it will be set to `<key>.png`, i.e. if `key` was "alien" then the URL will be "alien.png".
	 * @param atlasURL - The absolute or relative URL to load the texture atlas xml data file from. If undefined or `null` it will be set to `<key>.xml`, i.e. if `key` was "alien" then the URL will be "alien.xml".
	 * @param textureXhrSettings - An XHR Settings configuration object for the atlas image file. Used in replacement of the Loaders default XHR Settings.
	 * @param atlasXhrSettings - An XHR Settings configuration object for the atlas xml file. Used in replacement of the Loaders default XHR Settings.
	**/
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
