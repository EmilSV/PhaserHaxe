package phaserHaxe.loader.filetypes;

import phaserHaxe.utils.types.MultipleOrOne;
import phaserHaxe.loader.filetypes.typedefs.AtlasJSONFileConfig;
import phaserHaxe.utils.types.Union;

/**
 * @classdesc
 * A single JSON based Texture Atlas File suitable for loading by the Loader.
 *
 * These are created when you use the Phaser.Loader.LoaderPlugin#atlas method and are not typically created directly.
 *
 * For documentation about what all the arguments and configuration options mean please see Phaser.Loader.LoaderPlugin#atlas.
 *
 * https://www.codeandweb.com/texturepacker/tutorials/how-to-create-sprite-sheets-for-phaser3?source=photonstorm
 *
 * @class AtlasJSONFile
 * @extends Phaser.Loader.MultiFile
 * @memberof Phaser.Loader.FileTypes
 * @constructor
 * @since 3.0.0
 *
 * @param {Phaser.Loader.LoaderPlugin} loader - A reference to the Loader that is responsible for this file.
 * @param {(string|Phaser.Types.Loader.FileTypes.AtlasJSONFileConfig)} key - The key to use for this file, or a file configuration object.
 * @param {string|string[]} [textureURL] - The absolute or relative URL to load the texture image file from. If undefined or `null` it will be set to `<key>.png`, i.e. if `key` was "alien" then the URL will be "alien.png".
 * @param {string} [atlasURL] - The absolute or relative URL to load the texture atlas json data file from. If undefined or `null` it will be set to `<key>.json`, i.e. if `key` was "alien" then the URL will be "alien.json".
 * @param {Phaser.Types.Loader.XHRSettingsObject} [textureXhrSettings] - An XHR Settings configuration object for the atlas image file. Used in replacement of the Loaders default XHR Settings.
 * @param {Phaser.Types.Loader.XHRSettingsObject} [atlasXhrSettings] - An XHR Settings configuration object for the atlas json file. Used in replacement of the Loaders default XHR Settings.
**/
class AtlasJSONFile extends MultiFile
{
	public function new(loader:LoaderPlugin, key:Union<String, AtlasJSONFileConfig>,
			textureURL:MultipleOrOne<String>, atlasURL:String,
			textureXhrSettings:XHRSettingsObject, atlasXhrSettings:XHRSettingsObject)
	{
		var image;
        var data;

		if (!Std.is(key, String))
		{
			var config = (cast key : AtlasJSONFileConfig);

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

			var extension = config.atlasExtension;
			if (extension == null)
			{
				extension = "json";
			}

			data = new JSONFile(loader, {
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
			data = new JSONFile(loader, key, atlasURL, atlasXhrSettings);
		}

		if (image.linkFile == null)
		{
            final key = (cast key : String);
			//  Image has a normal map
			super(loader, "atlasjson", key, [image, data, image.linkFile]);
		}
		else
		{
            final key = (cast key : String);
			super(loader, "atlasjson", key, [image, data]);
		}
	}
}
