package phaserHaxe.loader.filetypes;

import js.html.Image as HTMLImage;
import phaserHaxe.loader.filetypes.typedefs.ImageFileConfig;
import phaserHaxe.loader.filetypes.typedefs.ImageFrameConfig;
import phaserHaxe.loader.typedefs.FileConfig;
import phaserHaxe.textures.TextureManager;
import phaserHaxe.utils.types.MultipleOrOne;
import phaserHaxe.utils.types.Union;

/**
 * A single Image File suitable for loading by the Loader.
 *
 * These are created when you use the Phaser.Loader.LoaderPlugin#image method and are not typically created directly.
 *
 * For documentation about what all the arguments and configuration options mean please see Phaser.Loader.LoaderPlugin#image.
 *
 * @since 1.0.0
**/
class ImageFile extends File
{
	/**
	 * @param loader - A reference to the Loader that is responsible for this file.
	 * @param key - The key to use for this file, or a file configuration object.
	 * @param url - The absolute or relative URL to load this file from. If undefined or `null` it will be set to `<key>.png`, i.e. if `key` was "alien" then the URL will be "alien.png".
	 * @param xhrSettings - Extra XHR Settings specifically for this file.
	 * @param frameConfig - The frame configuration object. Only provided for, and used by, Sprite Sheets.
	**/
	public function new(loader:LoaderPlugin, key:Union<String, ImageFileConfig>,
			?url:MultipleOrOne<String>, ?xhrSettings:XHRSettingsObject,
			?frameConfig:ImageFrameConfig)
	{
		var extension = "png";
		var normalMapURL = null;

		if (!Std.is(key, String))
		{
			var config = (cast key : ImageFileConfig);
			key = config.key;
			url = config.url;
			normalMapURL = config.normalMap;
			xhrSettings = config.xhrSettings;
			if (config.extension != null)
			{
				extension = config.extension;
			}
			frameConfig = config.frameConfig;
		}

		var key = (cast key : String);

		var url = if (url.isArray())
		{
			final urlArray = url.getArray();
			normalMapURL = urlArray[1];
			urlArray[0];
		}
		else
		{
			url.getOne();
		}

		var fileConfig:FileConfig = {
			type: "image",
			cache: loader.textureManager,
			extension: extension,
			responseType: BLOB,
			key: key,
			url: url,
			xhrSettings: xhrSettings,
			config: frameConfig
		};

		super(loader, fileConfig);

		//  Do we have a normal map to load as well?
		if (normalMapURL != null)
		{
			var normalMap = new ImageFile(loader, this.key, normalMapURL, xhrSettings, frameConfig);

			normalMap.type = "normalMap";

			this.setLink(normalMap);

			loader.addFile(normalMap);
		}
	}

	/**
	 * Called automatically by Loader.nextFile.
	 * This method controls what extra work this File does with its loaded data.
	 *
	 * @since 1.0.0
	**/
	public override function onProcess():Void
	{
		this.state = FileConst.FILE_PROCESSING;

		var data;
		this.data = data = new HTMLImage();

		data.crossOrigin = this.crossOrigin;

		var _this = this;

		data.onload = function()
		{
			File.revokeObjectURL(data);

			_this.onProcessComplete();
		};

		data.onerror = function()
		{
			File.revokeObjectURL(data);

			_this.onProcessError();
		};

		File.createObjectURL(data, this.xhrLoader.response, "image/png");
	}

	/**
	 * Adds this file to its target cache upon successful loading and processing.
	 *
	 * @since 1.0.0
	**/
	public override function addToCache()
	{
		var texture;

		if (linkFile != null && linkFile.state == FileConst.FILE_COMPLETE)
		{
			if (type == "image")
			{
				if (Std.is(cache, TextureManager))
				{
					var cache = (cast cache : TextureManager);
					texture = cache.addImage(key, data, linkFile.data);
				}
				else
				{
					throw new Error("cache is not of type TextureManager");
				}
			}
			else
			{
				if (Std.is(cache, TextureManager))
				{
					var cache = (cast cache : TextureManager);
					texture = cache.addImage(linkFile.key, linkFile.data, data);
				}
				else
				{
					throw new Error("cache is not of type TextureManager");
				}
			}

			pendingDestroy(texture);

			linkFile.pendingDestroy(texture);
		}
		else if (linkFile == null)
		{
			if (Std.is(cache, TextureManager))
			{
				var cache = (cast cache : TextureManager);
				texture = cache.addImage(key, data);
			}
			else
			{
				throw new Error("cache is not of type TextureManager");
			}
			pendingDestroy(texture);
		}
	}
}
