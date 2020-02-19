package phaserHaxe.loader;

import phaserHaxe.loader.filetypes.AudioSpriteFile;
import phaserHaxe.loader.filetypes.typedefs.AudioSpriteFileConfig;
import phaserHaxe.loader.filetypes.typedefs.AudioFileConfig;
import phaserHaxe.loader.filetypes.typedefs.AtlasXMLFileConfig;
import phaserHaxe.loader.filetypes.typedefs.AtlasJSONFileConfig;
import phaserHaxe.loader.filetypes.AnimationJSONFile;
import phaserHaxe.loader.filetypes.ImageFile;
import phaserHaxe.loader.filetypes.JSONFile;
import phaserHaxe.loader.filetypes.typedefs.ImageFileConfig;
import phaserHaxe.loader.filetypes.typedefs.JSONFileConfig;
import phaserHaxe.utils.types.MultipleOrOne;
import phaserHaxe.utils.types.Union;
import phaserHaxe.loader.filetypes.AtlasXMLFile;
import phaserHaxe.loader.filetypes.AtlasJSONFile;
import phaserHaxe.loader.filetypes.AudioFile;

final class DefaultFileTypesTool
{
	/**
	 * Adds a JSON file, or array of JSON files, to the current load queue.
	 *
	 * You can call this method from within your Scene's `preload`, along with any other files you wish to load:
	 *
	 * ```haxe
	 * function preload ()
	 * {
	 *     load.json('wavedata', 'files/AlienWaveData.json');
	 * }
	 * ```
	 *
	 * The file is **not** loaded right away. It is added to a queue ready to be loaded either when the loader starts,
	 * or if it's already running, when the next free load slot becomes available. This happens automatically if you
	 * are calling this from within the Scene's `preload` method, or a related callback. Because the file is queued
	 * it means you cannot use the file immediately after calling this method, but must wait for the file to complete.
	 * The typical flow for a Phaser Scene is that you load assets in the Scene's `preload` method and then when the
	 * Scene's `create` method is called you are guaranteed that all of those assets are ready for use and have been
	 * loaded.
	 *
	 * The key must be a unique String. It is used to add the file to the global JSON Cache upon a successful load.
	 * The key should be unique both in terms of files being loaded and files already present in the JSON Cache.
	 * Loading a file using a key that is already taken will result in a warning. If you wish to replace an existing file
	 * then remove it from the JSON Cache first, before loading a new one.
	 *
	 * Instead of passing arguments you can pass a configuration object, such as:
	 *
	 * ```haxe
	 * load.json({
	 *     key: 'wavedata',
	 *     url: 'files/AlienWaveData.json'
	 * });
	 * ```
	 *
	 * See the documentation for `Phaser.Types.Loader.FileTypes.JSONFileConfig` for more details.
	 *
	 * Once the file has finished loading you can access it from its Cache using its key:
	 *
	 * ```haxe
	 * load.json('wavedata', 'files/AlienWaveData.json');
	 * // and later in your game ...
	 * var data = cache.json.get('wavedata');
	 * ```
	 *
	 * If you have specified a prefix in the loader, via `Loader.setPrefix` then this value will be prepended to this files
	 * key. For example, if the prefix was `LEVEL1.` and the key was `Waves` the final key will be `LEVEL1.Waves` and
	 * this is what you would use to retrieve the text from the JSON Cache.
	 *
	 * The URL can be relative or absolute. If the URL is relative the `Loader.baseURL` and `Loader.path` values will be prepended to it.
	 *
	 * If the URL isn't specified the Loader will take the key and create a filename from that. For example if the key is "data"
	 * and no URL is given then the Loader will set the URL to be "data.json". It will always add `.json` as the extension, although
	 * this can be overridden if using an object instead of method arguments. If you do not desire this action then provide a URL.
	 *
	 * You can also optionally provide a `dataKey` to use. This allows you to extract only a part of the JSON and store it in the Cache,
	 * rather than the whole file. For example, if your JSON data had a structure like this:
	 *
	 * ```json
	 * {
	 *     "level1": {
	 *         "baddies": {
	 *             "aliens": {},
	 *             "boss": {}
	 *         }
	 *     },
	 *     "level2": {},
	 *     "level3": {}
	 * }
	 * ```
	 *
	 * And you only wanted to store the `boss` data in the Cache, then you could pass `level1.baddies.boss`as the `dataKey`.
	 *
	 * Note: The ability to load this type of file will only be available if the JSON File type has been built into Phaser.
	 * It is available in the default build but can be excluded from custom builds.
	 *
	 * @since 1.0.0
	 *
	 * @param key - The key to use for this file, or a file configuration object, or array of them.
	 * @param url - The absolute or relative URL to load this file from. If undefined or `null` it will be set to `<key>.json`, i.e. if `key` was "alien" then the URL will be "alien.json".
	 * @param dataKey - When the JSON file loads only this property will be stored in the Cache.
	 * @param xhrSettings - An XHR Settings configuration object. Used in replacement of the Loaders default XHR Settings.
	 *
	 * @return The Loader instance.
	**/
	public static function json<T:LoaderPlugin>(loader:T, key:Union<String, MultipleOrOne<JSONFileConfig>>,
			?url:String, ?dataKey:String, ?xhrSettings:XHRSettingsObject):T
	{
		if (Std.is(key, Array))
		{
			final key = (cast key : Array<JSONFileConfig>);
			for (i in 0...key.length)
			{
				loader.addFile(new JSONFile(loader, key[i]));
			}
		}
		else
		{
			final key = (cast key : Union<String, JSONFileConfig>);
			loader.addFile(new JSONFile(loader, key, url, xhrSettings, dataKey));
		}

		return loader;
	}

	/**
	 * Adds an Animation JSON Data file, or array of Animation JSON files, to the current load queue.
	 *
	 * You can call this method from within your Scene's `preload`, along with any other files you wish to load:
	 *
	 * ```haxe
	 * function preload ()
	 * {
	 *     load.animation('baddieAnims', 'files/BaddieAnims.json');
	 * }
	 * ```
	 *
	 * The file is **not** loaded right away. It is added to a queue ready to be loaded either when the loader starts,
	 * or if it's already running, when the next free load slot becomes available. This happens automatically if you
	 * are calling this from within the Scene's `preload` method, or a related callback. Because the file is queued
	 * it means you cannot use the file immediately after calling this method, but must wait for the file to complete.
	 * The typical flow for a Phaser Scene is that you load assets in the Scene's `preload` method and then when the
	 * Scene's `create` method is called you are guaranteed that all of those assets are ready for use and have been
	 * loaded.
	 *
	 * If you call this from outside of `preload` then you are responsible for starting the Loader afterwards and monitoring
	 * its events to know when it's safe to use the asset. Please see the Phaser.Loader.LoaderPlugin class for more details.
	 *
	 * The key must be a unique String. It is used to add the file to the global JSON Cache upon a successful load.
	 * The key should be unique both in terms of files being loaded and files already present in the JSON Cache.
	 * Loading a file using a key that is already taken will result in a warning. If you wish to replace an existing file
	 * then remove it from the JSON Cache first, before loading a new one.
	 *
	 * Instead of passing arguments you can pass a configuration object, such as:
	 *
	 * ```haxe
	 * load.animation({
	 *     key: 'baddieAnims',
	 *     url: 'files/BaddieAnims.json'
	 * });
	 * ```
	 *
	 * See the documentation for `Phaser.Types.Loader.FileTypes.JSONFileConfig` for more details.
	 *
	 * Once the file has finished loading it will automatically be passed to the global Animation Managers `fromJSON` method.
	 * This will parse all of the JSON data and create animation data from it. This process happens at the very end
	 * of the Loader, once every other file in the load queue has finished. The reason for this is to allow you to load
	 * both animation data and the images it relies upon in the same load call.
	 *
	 * Once the animation data has been parsed you will be able to play animations using that data.
	 * Please see the Animation Manager `fromJSON` method for more details about the format and playback.
	 *
	 * You can also access the raw animation data from its Cache using its key:
	 *
	 * ```haxe
	 * load.animation('baddieAnims', 'files/BaddieAnims.json');
	 * // and later in your game ...
	 * var data = cache.json.get('baddieAnims');
	 * ```
	 *
	 * If you have specified a prefix in the loader, via `Loader.setPrefix` then this value will be prepended to this files
	 * key. For example, if the prefix was `LEVEL1.` and the key was `Waves` the final key will be `LEVEL1.Waves` and
	 * this is what you would use to retrieve the text from the JSON Cache.
	 *
	 * The URL can be relative or absolute. If the URL is relative the `Loader.baseURL` and `Loader.path` values will be prepended to it.
	 *
	 * If the URL isn't specified the Loader will take the key and create a filename from that. For example if the key is "data"
	 * and no URL is given then the Loader will set the URL to be "data.json". It will always add `.json` as the extension, although
	 * this can be overridden if using an object instead of method arguments. If you do not desire this action then provide a URL.
	 *
	 * You can also optionally provide a `dataKey` to use. This allows you to extract only a part of the JSON and store it in the Cache,
	 * rather than the whole file. For example, if your JSON data had a structure like this:
	 *
	 * ```json
	 * {
	 *     "level1": {
	 *         "baddies": {
	 *             "aliens": {},
	 *             "boss": {}
	 *         }
	 *     },
	 *     "level2": {},
	 *     "level3": {}
	 * }
	 * ```
	 *
	 * And if you only wanted to create animations from the `boss` data, then you could pass `level1.baddies.boss`as the `dataKey`.
	 *
	 * Note: The ability to load this type of file will only be available if the JSON File type has been built into Phaser.
	 * It is available in the default build but can be excluded from custom builds.
	 *
	 * @fires Phaser.Loader.LoaderPlugin#addFileEvent
	 * @since 1.0.0
	 *
	 * @param key - The key to use for this file, or a file configuration object, or array of them.
	 * @param url - The absolute or relative URL to load this file from. If undefined or `null` it will be set to `<key>.json`, i.e. if `key` was "alien" then the URL will be "alien.json".
	 * @param dataKey - When the Animation JSON file loads only this property will be stored in the Cache and used to create animation data.
	 * @param xhrSettings - An XHR Settings configuration object. Used in replacement of the Loaders default XHR Settings.
	 *
	 * @return The Loader instance.
	**/
	public static function animation<T:LoaderPlugin>(loader:T, key:Union<String, MultipleOrOne<JSONFileConfig>>,
			?url:String, ?dataKey:String, ?xhrSettings:XHRSettingsObject):T
	{
		//  Supports an Object file definition in the key argument
		//  Or an array of objects in the key argument
		//  Or a single entry where all arguments have been defined
		if (Std.is(key, Array))
		{
			final key = (cast key : Array<JSONFileConfig>);
			for (i in 0...key.length)
			{
				loader.addFile(new AnimationJSONFile(loader, key[i]));
			}
		}
		else
		{
			final key = (cast key : Union<String, JSONFileConfig>);
			loader.addFile(new AnimationJSONFile(loader, key, url, xhrSettings, dataKey));
		}

		return loader;
	}

	/**
	 * Adds a JSON based Texture Atlas, or array of atlases, to the current load queue.
	 *
	 * You can call this method from within your Scene's `preload`, along with any other files you wish to load:
	 *
	 * ```haxe
	 * function preload ()
	 * {
	 *     load.atlas("mainmenu", "images/MainMenu.png", "images/MainMenu.json");
	 * }
	 * ```
	 *
	 * The file is **not** loaded right away. It is added to a queue ready to be loaded either when the loader starts,
	 * or if it's already running, when the next free load slot becomes available. This happens automatically if you
	 * are calling this from within the Scene's `preload` method, or a related callback. Because the file is queued
	 * it means you cannot use the file immediately after calling this method, but must wait for the file to complete.
	 * The typical flow for a Phaser Scene is that you load assets in the Scene's `preload` method and then when the
	 * Scene's `create` method is called you are guaranteed that all of those assets are ready for use and have been
	 * loaded.
	 *
	 * If you call this from outside of `preload` then you are responsible for starting the Loader afterwards and monitoring
	 * its events to know when it's safe to use the asset. Please see the Phaser.Loader.LoaderPlugin class for more details.
	 *
	 * Phaser expects the atlas data to be provided in a JSON file, using either the JSON Hash or JSON Array format.
	 * These files are created by software such as Texture Packer, Shoebox and Adobe Flash / Animate.
	 * If you are using Texture Packer and have enabled multi-atlas support, then please use the Phaser Multi Atlas loader
	 * instead of this one.
	 *
	 * Phaser can load all common image types: png, jpg, gif and any other format the browser can natively handle.
	 *
	 * The key must be a unique String. It is used to add the file to the global Texture Manager upon a successful load.
	 * The key should be unique both in terms of files being loaded and files already present in the Texture Manager.
	 * Loading a file using a key that is already taken will result in a warning. If you wish to replace an existing file
	 * then remove it from the Texture Manager first, before loading a new one.
	 *
	 * Instead of passing arguments you can pass a configuration object, such as:
	 *
	 * ```haxe
	 * load.atlas({
	 *     key: "mainmenu",
	 *     textureURL: "images/MainMenu.png",
	 *     atlasURL: "images/MainMenu.json"
	 * });
	 * ```
	 *
	 * See the documentation for `Phaser.Types.Loader.FileTypes.AtlasJSONFileConfig` for more details.
	 *
	 * Instead of passing a URL for the atlas JSON data you can also pass in a well formed JSON object instead.
	 *
	 * Once the atlas has finished loading you can use frames from it as textures for a Game Object by referencing its key:
	 *
	 * ```haxe
	 * load.atlas("mainmenu", "images/MainMenu.png", "images/MainMenu.json");
	 * // and later in your game ...
	 * add.image(x, y, "mainmenu", "background");
	 * ```
	 *
	 * To get a list of all available frames within an atlas please consult your Texture Atlas software.
	 *
	 * If you have specified a prefix in the loader, via `Loader.setPrefix` then this value will be prepended to this files
	 * key. For example, if the prefix was `MENU.` and the key was `Background` the final key will be `MENU.Background` and
	 * this is what you would use to retrieve the image from the Texture Manager.
	 *
	 * The URL can be relative or absolute. If the URL is relative the `Loader.baseURL` and `Loader.path` values will be prepended to it.
	 *
	 * If the URL isn't specified the Loader will take the key and create a filename from that. For example if the key is "alien"
	 * and no URL is given then the Loader will set the URL to be "alien.png". It will always add `.png` as the extension, although
	 * this can be overridden if using an object instead of method arguments. If you do not desire this action then provide a URL.
	 *
	 * Phaser also supports the automatic loading of associated normal maps. If you have a normal map to go with this image,
	 * then you can specify it by providing an array as the `url` where the second element is the normal map:
	 *
	 * ```javascript
	 * this.load.atlas('mainmenu', [ 'images/MainMenu.png', 'images/MainMenu-n.png' ], 'images/MainMenu.json');
	 * ```
	 *
	 * Or, if you are using a config object use the `normalMap` property:
	 *
	 * ```haxe
	 * load.atlas({
	 *     key: "mainmenu",
	 *     textureURL: "images/MainMenu.png",
	 *     normalMap: "images/MainMenu-n.png",
	 *     atlasURL: "images/MainMenu.json"
	 * });
	 * ```
	 *
	 * The normal map file is subject to the same conditions as the image file with regard to the path, baseURL, CORs and XHR Settings.
	 * Normal maps are a WebGL only feature.
	 *
	 * Note: The ability to load this type of file will only be available if the Atlas JSON File type has been built into Phaser.
	 * It is available in the default build but can be excluded from custom builds.
	 *
	 * @fires Phaser.Loader.LoaderPlugin#addFileEvent
	 * @since 1.0.0
	 *
	 * @param key - The key to use for this file, or a file configuration object, or array of them.
	 * @param textureURL - The absolute or relative URL to load the texture image file from. If undefined or `null` it will be set to `<key>.png`, i.e. if `key` was "alien" then the URL will be "alien.png".
	 * @param atlasURL - The absolute or relative URL to load the texture atlas json data file from. If undefined or `null` it will be set to `<key>.json`, i.e. if `key` was "alien" then the URL will be "alien.json".
	 * @param textureXhrSettings - An XHR Settings configuration object for the atlas image file. Used in replacement of the Loaders default XHR Settings.
	 * @param atlasXhrSettings - An XHR Settings configuration object for the atlas json file. Used in replacement of the Loaders default XHR Settings.
	 *
	 * @return The Loader instance.
	**/
	public static function atlas<T:LoaderPlugin>(loader:T, key:Union<String, MultipleOrOne<AtlasJSONFileConfig>>,
			?textureURL:MultipleOrOne<String>, ?atlasURL:String, ?textureXhrSettings:XHRSettingsObject,
			?atlasXhrSettings:XHRSettingsObject):T
	{
		//  Supports an Object file definition in the key argument
		//  Or an array of objects in the key argument
		//  Or a single entry where all arguments have been defined

		if (Std.is(key, Array))
		{
			final key = (cast key : Array<AtlasJSONFileConfig>);
			for (i in 0...key.length)
			{
				final multifile = new AtlasJSONFile(loader, key[i]);

				loader.addFile(multifile.files);
			}
		}
		else
		{
			final key = (cast key : Union<String, AtlasJSONFileConfig>);

			final multifile = new AtlasJSONFile(loader, key, textureURL, atlasURL, textureXhrSettings, atlasXhrSettings);

			loader.addFile(multifile.files);
		}

		return loader;
	}

	/**
	 * Adds an XML based Texture Atlas, or array of atlases, to the current load queue.
	 *
	 * You can call this method from within your Scene's `preload`, along with any other files you wish to load:
	 *
	 * ```haxe
	 * function preload ()
	 * {
	 *     load.atlasXML("mainmenu", "images/MainMenu.png", "images/MainMenu.xml");
	 * }
	 * ```
	 *
	 * The file is **not** loaded right away. It is added to a queue ready to be loaded either when the loader starts,
	 * or if it's already running, when the next free load slot becomes available. This happens automatically if you
	 * are calling this from within the Scene's `preload` method, or a related callback. Because the file is queued
	 * it means you cannot use the file immediately after calling this method, but must wait for the file to complete.
	 * The typical flow for a Phaser Scene is that you load assets in the Scene's `preload` method and then when the
	 * Scene's `create` method is called you are guaranteed that all of those assets are ready for use and have been
	 * loaded.
	 *
	 * If you call this from outside of `preload` then you are responsible for starting the Loader afterwards and monitoring
	 * its events to know when it's safe to use the asset. Please see the Phaser.Loader.LoaderPlugin class for more details.
	 *
	 * Phaser expects the atlas data to be provided in an XML file format.
	 * These files are created by software such as Shoebox and Adobe Flash / Animate.
	 *
	 * Phaser can load all common image types: png, jpg, gif and any other format the browser can natively handle.
	 *
	 * The key must be a unique String. It is used to add the file to the global Texture Manager upon a successful load.
	 * The key should be unique both in terms of files being loaded and files already present in the Texture Manager.
	 * Loading a file using a key that is already taken will result in a warning. If you wish to replace an existing file
	 * then remove it from the Texture Manager first, before loading a new one.
	 *
	 * Instead of passing arguments you can pass a configuration object, such as:
	 *
	 * ```haxe
	 * load.atlasXML({
	 *     key: "mainmenu",
	 *     textureURL: "mages/MainMenu.png",
	 *     atlasURL: "images/MainMenu.xml"
	 * });
	 * ```
	 *
	 * See the documentation for `Phaser.Types.Loader.FileTypes.AtlasXMLFileConfig` for more details.
	 *
	 * Once the atlas has finished loading you can use frames from it as textures for a Game Object by referencing its key:
	 *
	 * ```javascript
	 * this.load.atlasXML('mainmenu', 'images/MainMenu.png', 'images/MainMenu.xml');
	 * // and later in your game ...
	 * this.add.image(x, y, 'mainmenu', 'background');
	 * ```
	 *
	 * To get a list of all available frames within an atlas please consult your Texture Atlas software.
	 *
	 * If you have specified a prefix in the loader, via `Loader.setPrefix` then this value will be prepended to this files
	 * key. For example, if the prefix was `MENU.` and the key was `Background` the final key will be `MENU.Background` and
	 * this is what you would use to retrieve the image from the Texture Manager.
	 *
	 * The URL can be relative or absolute. If the URL is relative the `Loader.baseURL` and `Loader.path` values will be prepended to it.
	 *
	 * If the URL isn't specified the Loader will take the key and create a filename from that. For example if the key is "alien"
	 * and no URL is given then the Loader will set the URL to be "alien.png". It will always add `.png` as the extension, although
	 * this can be overridden if using an object instead of method arguments. If you do not desire this action then provide a URL.
	 *
	 * Phaser also supports the automatic loading of associated normal maps. If you have a normal map to go with this image,
	 * then you can specify it by providing an array as the `url` where the second element is the normal map:
	 *
	 * ```haxe
	 * load.atlasXML("mainmenu", [ "images/MainMenu.png", "images/MainMenu-n.png" ], "images/MainMenu.xml");
	 * ```
	 *
	 * Or, if you are using a config object use the `normalMap` property:
	 *
	 * ```haxe
	 * load.atlasXML({
	 *     key: "mainmenu",
	 *     textureURL: "images/MainMenu.png",
	 *     normalMap: "images/MainMenu-n.png",
	 *     atlasURL: "images/MainMenu.xml"
	 * });
	 * ```
	 *
	 * The normal map file is subject to the same conditions as the image file with regard to the path, baseURL, CORs and XHR Settings.
	 * Normal maps are a WebGL only feature.
	 *
	 * Note: The ability to load this type of file will only be available if the Atlas XML File type has been built into Phaser.
	 * It is available in the default build but can be excluded from custom builds.
	 *
	 * @fires Phaser.Loader.LoaderPlugin#addFileEvent
	 * @since 1.0.0
	 *
	 * @param key - The key to use for this file, or a file configuration object, or array of them.
	 * @param textureURL - The absolute or relative URL to load the texture image file from. If undefined or `null` it will be set to `<key>.png`, i.e. if `key` was "alien" then the URL will be "alien.png".
	 * @param atlasURL - The absolute or relative URL to load the texture atlas xml data file from. If undefined or `null` it will be set to `<key>.xml`, i.e. if `key` was "alien" then the URL will be "alien.xml".
	 * @param textureXhrSettings - An XHR Settings configuration object for the atlas image file. Used in replacement of the Loaders default XHR Settings.
	 * @param atlasXhrSettings - An XHR Settings configuration object for the atlas xml file. Used in replacement of the Loaders default XHR Settings.
	 *
	 * @return The Loader instance.
	**/
	public static function atlasXML<T:LoaderPlugin>(loader:T, key:Union<String, MultipleOrOne<AtlasXMLFileConfig>>,
			?textureURL:MultipleOrOne<String>, ?atlasURL:String, ?textureXhrSettings:XHRSettingsObject,
			?atlasXhrSettings:XHRSettingsObject):T
	{
		//  Supports an Object file definition in the key argument
		//  Or an array of objects in the key argument
		//  Or a single entry where all arguments have been defined

		if (Std.is(key, Array))
		{
			final key = (cast key : Array<AtlasXMLFileConfig>);
			for (i in 0...key.length)
			{
				final multifile = new AtlasXMLFile(loader, key[i]);

				loader.addFile(multifile.files);
			}
		}
		else
		{
			final key = (cast key : Union<String, AtlasXMLFileConfig>);

			final multifile = new AtlasXMLFile(loader, key, textureURL, atlasURL, textureXhrSettings, atlasXhrSettings);

			loader.addFile(multifile.files);
		}

		return loader;
	}

	/**
	 * Adds an Audio or HTML5Audio file, or array of audio files, to the current load queue.
	 *
	 * You can call this method from within your Scene's `preload`, along with any other files you wish to load:
	 *
	 * ```haxe
	 * function preload ()
	 * {
	 *     load.audio("title", [ "music/Title.ogg", "music/Title.mp3", "music/Title.m4a" ]);
	 * }
	 * ```
	 *
	 * The file is **not** loaded right away. It is added to a queue ready to be loaded either when the loader starts,
	 * or if it's already running, when the next free load slot becomes available. This happens automatically if you
	 * are calling this from within the Scene's `preload` method, or a related callback. Because the file is queued
	 * it means you cannot use the file immediately after calling this method, but must wait for the file to complete.
	 * The typical flow for a Phaser Scene is that you load assets in the Scene's `preload` method and then when the
	 * Scene's `create` method is called you are guaranteed that all of those assets are ready for use and have been
	 * loaded.
	 *
	 * The key must be a unique String. It is used to add the file to the global Audio Cache upon a successful load.
	 * The key should be unique both in terms of files being loaded and files already present in the Audio Cache.
	 * Loading a file using a key that is already taken will result in a warning. If you wish to replace an existing file
	 * then remove it from the Audio Cache first, before loading a new one.
	 *
	 * Instead of passing arguments you can pass a configuration object, such as:
	 *
	 * ```haxe
	 * this.load.audio({
	 *     key: "title",
	 *     url: [ "music/Title.ogg", "music/Title.mp3", "music/Title.m4a" ]
	 * });
	 * ```
	 *
	 * See the documentation for `Phaser.Types.Loader.FileTypes.AudioFileConfig` for more details.
	 *
	 * The URLs can be relative or absolute. If the URLs are relative the `Loader.baseURL` and `Loader.path` values will be prepended to them.
	 *
	 * Due to different browsers supporting different audio file types you should usually provide your audio files in a variety of formats.
	 * ogg, mp3 and m4a are the most common. If you provide an array of URLs then the Loader will determine which _one_ file to load based on
	 * browser support.
	 *
	 * If audio has been disabled in your game, either via the game config, or lack of support from the device, then no audio will be loaded.
	 *
	 * Note: The ability to load this type of file will only be available if the Audio File type has been built into Phaser.
	 * It is available in the default build but can be excluded from custom builds.
	 *
	 * @method Phaser.Loader.LoaderPlugin#audio
	 * @fires Phaser.Loader.LoaderPlugin#addFileEvent
	 * @since 1.0.0
	 *
	 * @param key - The key to use for this file, or a file configuration object, or array of them.
	 * @param urls - The absolute or relative URL to load the audio files from.
	 * @param config - An object containing an `instances` property for HTML5Audio. Defaults to 1.
	 * @param xhrSettings - An XHR Settings configuration object. Used in replacement of the Loaders default XHR Settings.
	 *
	 * @return The Loader instance.
	**/
	public static function audio<T:LoaderPlugin>(loader:T, key:Union<String, MultipleOrOne<AudioFileConfig>>,
			?urls:MultipleOrOne<String>, ?config:Any, ?xhrSettings:XHRSettingsObject):T
	{
		var game = loader.systems.game;
		var audioConfig = game.config.audio;
		var deviceAudio = game.device.audio;

		if ((audioConfig != null && audioConfig.noAudio) || (!deviceAudio.webAudio && !deviceAudio.audioData))
		{
			//  Sounds are disabled, so skip loading audio
			return loader;
		}

		if (Std.is(key, Array))
		{
			final key = (cast key : Array<AudioFileConfig>);

			for (i in 0...key.length)
			{
				//  If it's an array it has to be an array of Objects, so we get everything out of the 'key' object
				final audioFile = AudioFile.create(loader, key[i]);

				if (audioFile != null)
				{
					loader.addFile(audioFile);
				}
			}
		}
		else
		{
			final key = (cast key : Union<String, AudioFileConfig>);

			final audioFile = AudioFile.create(loader, key, urls, config, xhrSettings);
			if (audioFile != null)
			{
				loader.addFile(audioFile);
			}
		}
		return loader;
	}

	/**
	 * Adds a JSON based Audio Sprite, or array of audio sprites, to the current load queue.
	 *
	 * You can call this method from within your Scene's `preload`, along with any other files you wish to load:
	 *
	 * ```haxe
	 * function preload ()
	 * {
	 *     load.audioSprite('kyobi', 'kyobi.json', [
	 *         'kyobi.ogg',
	 *         'kyobi.mp3',
	 *         'kyobi.m4a'
	 *     ]);
	 * }
	 * ```
	 *
	 * Audio Sprites are a combination of audio files and a JSON configuration.
	 * The JSON follows the format of that created by https://github.com/tonistiigi/audiosprite
	 *
	 * If the JSON file includes a 'resource' object then you can let Phaser parse it and load the audio
	 * files automatically based on its content. To do this exclude the audio URLs from the load:
	 *
	 * ```haxe
	 * function preload ()
	 * {
	 *     load.audioSprite('kyobi', 'kyobi.json');
	 * }
	 * ```
	 *
	 * The file is **not** loaded right away. It is added to a queue ready to be loaded either when the loader starts,
	 * or if it's already running, when the next free load slot becomes available. This happens automatically if you
	 * are calling this from within the Scene's `preload` method, or a related callback. Because the file is queued
	 * it means you cannot use the file immediately after calling this method, but must wait for the file to complete.
	 * The typical flow for a Phaser Scene is that you load assets in the Scene's `preload` method and then when the
	 * Scene's `create` method is called you are guaranteed that all of those assets are ready for use and have been
	 * loaded.
	 *
	 * If you call this from outside of `preload` then you are responsible for starting the Loader afterwards and monitoring
	 * its events to know when it's safe to use the asset. Please see the Phaser.Loader.LoaderPlugin class for more details.
	 *
	 * The key must be a unique String. It is used to add the file to the global Audio Cache upon a successful load.
	 * The key should be unique both in terms of files being loaded and files already present in the Audio Cache.
	 * Loading a file using a key that is already taken will result in a warning. If you wish to replace an existing file
	 * then remove it from the Audio Cache first, before loading a new one.
	 *
	 * Instead of passing arguments you can pass a configuration object, such as:
	 *
	 * ```haxe
	 * load.audioSprite({
	 *     key: 'kyobi',
	 *     jsonURL: 'audio/Kyobi.json',
	 *     audioURL: [
	 *         'audio/Kyobi.ogg',
	 *         'audio/Kyobi.mp3',
	 *         'audio/Kyobi.m4a'
	 *     ]
	 * });
	 * ```
	 *
	 * See the documentation for `Phaser.Types.Loader.FileTypes.AudioSpriteFileConfig` for more details.
	 *
	 * Instead of passing a URL for the audio JSON data you can also pass in a well formed JSON object instead.
	 *
	 * Once the audio has finished loading you can use it create an Audio Sprite by referencing its key:
	 *
	 * ```haxe
	 * load.audioSprite('kyobi', 'kyobi.json');
	 * // and later in your game ...
	 * var music = sound.addAudioSprite('kyobi');
	 * music.play('title');
	 * ```
	 *
	 * If you have specified a prefix in the loader, via `Loader.setPrefix` then this value will be prepended to this files
	 * key. For example, if the prefix was `MENU.` and the key was `Background` the final key will be `MENU.Background` and
	 * this is what you would use to retrieve the image from the Texture Manager.
	 *
	 * The URL can be relative or absolute. If the URL is relative the `Loader.baseURL` and `Loader.path` values will be prepended to it.
	 *
	 * Due to different browsers supporting different audio file types you should usually provide your audio files in a variety of formats.
	 * ogg, mp3 and m4a are the most common. If you provide an array of URLs then the Loader will determine which _one_ file to load based on
	 * browser support.
	 *
	 * If audio has been disabled in your game, either via the game config, or lack of support from the device, then no audio will be loaded.
	 *
	 * Note: The ability to load this type of file will only be available if the Audio Sprite File type has been built into Phaser.
	 * It is available in the default build but can be excluded from custom builds.
	 *
	 * @fires Phaser.Loader.LoaderPlugin#addFileEvent
	 * @since 1.0.0
	 *
	 * @param key - The key to use for this file, or a file configuration object, or an array of objects.
	 * @param jsonURL - The absolute or relative URL to load the json file from. Or a well formed JSON object to use instead.
	 * @param audioURL - The absolute or relative URL to load the audio file from. If empty it will be obtained by parsing the JSON file.
	 * @param audioConfig - The audio configuration options.
	 * @param audioXhrSettings - An XHR Settings configuration object for the audio file. Used in replacement of the Loaders default XHR Settings.
	 * @param jsonXhrSettings - An XHR Settings configuration object for the json file. Used in replacement of the Loaders default XHR Settings.
	 *
	 * @return The Loader.
	**/
	public static function audioSprite<T:LoaderPlugin>(loader:T,
			key:Union<String, MultipleOrOne<AudioSpriteFileConfig>>, jsonURL:String, ?audioURL:MultipleOrOne<String>,
			?audioConfig:Any, ?audioXhrSettings:XHRSettingsObject, ?jsonXhrSettings:XHRSettingsObject):T
	{
		var game = loader.systems.game;
		var gameAudioConfig = game.config.audio;
		var deviceAudio = game.device.audio;

		if ((gameAudioConfig != null && gameAudioConfig.noAudio) || (!deviceAudio.webAudio && !deviceAudio.audioData))
		{
			//  Sounds are disabled, so skip loading audio
			return loader;
		}

		var multifile;

		//  Supports an Object file definition in the key argument
		//  Or an array of objects in the key argument
		//  Or a single entry where all arguments have been defined

		if (Std.is(key, Array))
		{
			final key = (cast key : Array<AudioSpriteFileConfig>);

			for (i in 0...key.length)
			{
				multifile = new AudioSpriteFile(loader, key[i]);

				if (multifile.files != null)
				{
					loader.addFile(multifile.files);
				}
			}
		}
		else
		{
			multifile = new AudioSpriteFile(loader, (cast key : Union<String, AudioSpriteFileConfig>), jsonURL,
				audioURL, audioConfig, audioXhrSettings, jsonXhrSettings);

			if (multifile.files != null)
			{
				loader.addFile(multifile.files);
			}
		}

		return loader;
	}

	/**
	 * Adds an Image, or array of Images, to the current load queue.
	 *
	 * You can call this method from within your Scene's `preload`, along with any other files you wish to load:
	 *
	 * ```haxe
	 * function preload ()
	 * {
	 *     load.image('logo', 'images/phaserLogo.png');
	 * }
	 * ```
	 *
	 * The file is **not** loaded right away. It is added to a queue ready to be loaded either when the loader starts,
	 * or if it's already running, when the next free load slot becomes available. This happens automatically if you
	 * are calling this from within the Scene's `preload` method, or a related callback. Because the file is queued
	 * it means you cannot use the file immediately after calling this method, but must wait for the file to complete.
	 * The typical flow for a Phaser Scene is that you load assets in the Scene's `preload` method and then when the
	 * Scene's `create` method is called you are guaranteed that all of those assets are ready for use and have been
	 * loaded.
	 *
	 * Phaser can load all common image types: png, jpg, gif and any other format the browser can natively handle.
	 * If you try to load an animated gif only the first frame will be rendered. Browsers do not natively support playback
	 * of animated gifs to Canvas elements.
	 *
	 * The key must be a unique String. It is used to add the file to the global Texture Manager upon a successful load.
	 * The key should be unique both in terms of files being loaded and files already present in the Texture Manager.
	 * Loading a file using a key that is already taken will result in a warning. If you wish to replace an existing file
	 * then remove it from the Texture Manager first, before loading a new one.
	 *
	 * Instead of passing arguments you can pass a configuration object, such as:
	 *
	 * ```haxe
	 * load.image({
	 *     key: 'logo',
	 *     url: 'images/AtariLogo.png'
	 * });
	 * ```
	 *
	 * See the documentation for `Phaser.Types.Loader.FileTypes.ImageFileConfig` for more details.
	 *
	 * Once the file has finished loading you can use it as a texture for a Game Object by referencing its key:
	 *
	 * ```haxe
	 * load.image('logo', 'images/AtariLogo.png');
	 * // and later in your game ...
	 * add.image(x, y, 'logo');
	 * ```
	 *
	 * If you have specified a prefix in the loader, via `Loader.setPrefix` then this value will be prepended to this files
	 * key. For example, if the prefix was `MENU.` and the key was `Background` the final key will be `MENU.Background` and
	 * this is what you would use to retrieve the image from the Texture Manager.
	 *
	 * The URL can be relative or absolute. If the URL is relative the `Loader.baseURL` and `Loader.path` values will be prepended to it.
	 *
	 * If the URL isn't specified the Loader will take the key and create a filename from that. For example if the key is "alien"
	 * and no URL is given then the Loader will set the URL to be "alien.png". It will always add `.png` as the extension, although
	 * this can be overridden if using an object instead of method arguments. If you do not desire this action then provide a URL.
	 *
	 * Phaser also supports the automatic loading of associated normal maps. If you have a normal map to go with this image,
	 * then you can specify it by providing an array as the `url` where the second element is the normal map:
	 *
	 * ```haxe
	 * load.image('logo', [ 'images/AtariLogo.png', 'images/AtariLogo-n.png' ]);
	 * ```
	 *
	 * Or, if you are using a config object use the `normalMap` property:
	 *
	 * ```haxe
	 * load.image({
	 *     key: 'logo',
	 *     url: 'images/AtariLogo.png',
	 *     normalMap: 'images/AtariLogo-n.png'
	 * });
	 * ```
	 *
	 * The normal map file is subject to the same conditions as the image file with regard to the path, baseURL, CORs and XHR Settings.
	 * Normal maps are a WebGL only feature.
	 *
	 * Note: The ability to load this type of file will only be available if the Image File type has been built into Phaser.
	 * It is available in the default build but can be excluded from custom builds.
	 *
	 * @fires Phaser.Loader.LoaderPlugin#addFileEvent
	 * @since 1.0.0
	 *
	 * @param key - The key to use for this file, or a file configuration object, or array of them.
	 * @param url - The absolute or relative URL to load this file from. If undefined or `null` it will be set to `<key>.png`, i.e. if `key` was "alien" then the URL will be "alien.png".
	 * @param xhrSettings - An XHR Settings configuration object. Used in replacement of the Loaders default XHR Settings.
	 *
	 * @return The Loader instance.
	**/
	public static function image<T:LoaderPlugin>(loader:T, key:Union<String, MultipleOrOne<ImageFileConfig>>,
			?url:MultipleOrOne<String>, ?xhrSettings:XHRSettingsObject)
	{
		if (Std.is(key, Array))
		{
			final key = (cast key : Array<ImageFileConfig>);

			for (i in 0...key.length)
			{
				//  If it's an array it has to be an array of Objects, so we get everything out of the 'key' object
				loader.addFile(new ImageFile(loader, key[i]));
			}
		}
		else
		{
			final key = (cast key : Union<String, ImageFileConfig>);
			loader.addFile(new ImageFile(loader, key, url, xhrSettings));
		}

		return loader;
	}
}
