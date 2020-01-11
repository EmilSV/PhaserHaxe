package phaserHaxe.loader;

import phaserHaxe.loader.filetypes.AnimationJSONFile;
import phaserHaxe.loader.filetypes.ImageFile;
import phaserHaxe.loader.filetypes.JSONFile;
import phaserHaxe.loader.filetypes.typedefs.ImageFileConfig;
import phaserHaxe.loader.filetypes.typedefs.JSONFileConfig;
import phaserHaxe.utils.types.MultipleOrOne;
import phaserHaxe.utils.types.Union;

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
	public static function json<T:LoaderPlugin>(loader:T,
			key:Union<String, MultipleOrOne<JSONFileConfig>>, ?url:String,
			?dataKey:String, ?xhrSettings:XHRSettingsObject):T
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
	public static function animation<T:LoaderPlugin>(loader:T,
			key:Union<String, MultipleOrOne<JSONFileConfig>>, ?url:String,
			?dataKey:String, ?xhrSettings:XHRSettingsObject):T
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
	public static function image<T:LoaderPlugin>(loader:T,
			key:Union<String, MultipleOrOne<ImageFileConfig>>,
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
