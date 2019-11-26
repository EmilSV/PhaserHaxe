package phaserHaxe.loader;

import phaserHaxe.utils.types.MultipleOrOne;
import phaserHaxe.scene.SceneEvents;
import phaserHaxe.scene.SceneManager;
import phaserHaxe.textures.TextureManager;
import phaserHaxe.cache.CacheManager;
import phaserHaxe.scene.Systems;
import phaserHaxe.structs.Set;
import haxe.Json;

class LoaderPlugin
{
	/**
	 * The Scene which owns this Loader instance.
	 *
	 * @since 3.0.0
	**/
	public var scene:Scene;

	/**
	 * A reference to the Scene Systems.
	 *
	 * @since 1.0.0
	**/
	public var systems:Systems;

	/**
	 * A reference to the global Cache Manager.
	 *
	 * @since 1.0.0
	**/
	public var cacheManager:CacheManager;

	/**
	 * A reference to the global Texture Manager.
	 *
	 * @since 1.0.0
	**/
	public var textureManager:TextureManager;

	/**
	 * A reference to the global Scene Manager.
	 *
	 * @since 1.0.0
	**/
	private var sceneManager:SceneManager;

	/**
	 * An optional prefix that is automatically prepended to the start of every file key.
	 * If prefix was `MENU.` and you load an image with the key 'Background' the resulting key would be `MENU.Background`.
	 * You can set this directly, or call `Loader.setPrefix()`. It will then affect every file added to the Loader
	 * from that point on. It does _not_ change any file already in the load queue.
	 *
	 * @since 1.0.0
	**/
	public var prefix:String = "";

	/**
	 * The value of `path`, if set, is placed before any _relative_ file path given. For example:
	 *
	 * ```haxe
	 * load.path = "images/sprites/";
	 * load.image("ball", "ball.png");
	 * load.image("tree", "level1/oaktree.png");
	 * load.image("boom", "http://server.com/explode.png");
	 * ```
	 *
	 * Would load the `ball` file from `images/sprites/ball.png` and the tree from
	 * `images/sprites/level1/oaktree.png` but the file `boom` would load from the URL
	 * given as it's an absolute URL.
	 *
	 * Please note that the path is added before the filename but *after* the baseURL (if set.)
	 *
	 * If you set this property directly then it _must_ end with a "/". Alternatively, call `setPath()` and it'll do it for you.
	 *
	 * @since 1.0.0
	**/
	public var path:String = "";

	/**
	 * If you want to append a URL before the path of any asset you can set this here.
	 *
	 * Useful if allowing the asset base url to be configured outside of the game code.
	 *
	 * If you set this property directly then it _must_ end with a "/". Alternatively, call `setBaseURL()` and it'll do it for you.
	 *
	 * @since 1.0.0
	**/
	public var baseURL:String = "";

	/**
	 * The number of concurrent / parallel resources to try and fetch at once.
	 *
	 * Old browsers limit 6 requests per domain; modern ones, especially those with HTTP/2 don't limit it at all.
	 *
	 * The default is 32 but you can change this in your Game Config, or by changing this property before the Loader starts.
	 *
	 * @since 1.0.0
	**/
	public var maxParallelDownloads:Int;

	/**
	 * xhr specific global settings (can be overridden on a per-file basis)
	 *
	 * @since 1.0.0
	**/
	public var xhr:XHRSettingsObject;

	/**
	 * The crossOrigin value applied to loaded images. Very often this needs to be set to 'anonymous'.
	 *
	 * @since 1.0.0
	**/
	public var crossOrigin:String;

	/**
	 * The total number of files to load. It may not always be accurate because you may add to the Loader during the process
	 * of loading, especially if you load a Pack File. Therefore this value can change, but in most cases remains static.
	 *
	 * @since 1.0.0
	**/
	public var totalToLoad:Int = 0;

	/**
	 * The progress of the current load queue, as a float value between 0 and 1.
	 * This is updated automatically as files complete loading.
	 * Note that it is possible for this value to go down again if you add content to the current load queue during a load.
	 *
	 * @since 1.0.0
	**/
	public var progress:Float = 0;

	/**
	 * Files are placed in this Set when they're added to the Loader via `addFile`.
	 *
	 * They are moved to the `inflight` Set when they start loading, and assuming a successful
	 * load, to the `queue` Set for further processing.
	 *
	 * By the end of the load process this Set will be empty.
	 *
	 * @since 1.0.0
	**/
	public var list:Set<File> = new Set<File>();

	/**
	 * Files are stored in this Set while they're in the process of being loaded.
	 *
	 * Upon a successful load they are moved to the `queue` Set.
	 *
	 * By the end of the load process this Set will be empty.
	 *
	 * @since 1.0.0
	**/
	public var inflight:Set<File> = new Set<File>();

	/**
	 * Files are stored in this Set while they're being processed.
	 *
	 * If the process is successful they are moved to their final destination, which could be
	 * a Cache or the Texture Manager.
	 *
	 * At the end of the load process this Set will be empty.
	 *
	 * @since 1.0.0
	**/
	public var queue:Set<File> = new Set<File>();

	/**
	 * A temporary Set in which files are stored after processing,
	 * awaiting destruction at the end of the load process.
	 *
	 * @since 1.0.0
	**/
	private var _deleteQueue:Set<File> = new Set<File>();

	/**
	 * The total number of files that failed to load during the most recent load.
	 * This value is reset when you call `Loader.start`.
	 *
	 * @since 1.0.0
	**/
	public var totalFailed:Int = 0;

	/**
	 * The total number of files that successfully loaded during the most recent load.
	 * This value is reset when you call `Loader.start`.
	 *
	 * @since 1.0.0
	**/
	public var totalComplete:Int = 0;

	/**
	 * The current state of the Loader.
	 *
	 * @since 1.0.0
	**/
	public var state(default, null):Int = LoaderConst.LOADER_IDLE;

	/**
	 * The current index being used by multi-file loaders to avoid key clashes.
	 *
	 * @since 1.0.0
	**/
	@:allow(phaserHaxe)
	private var multiKeyIndex:Int = 0;

	/**
	 * This method is called automatically, only once, when the Scene is first created.
	 * Do not invoke it directly.
	 *
	 * @since 1.0.0
	**/
	private function boot()
	{
		systems.events.once(SceneEvents.DESTROY, this.destroy, this);
	}

	/**
	 * This method is called automatically by the Scene when it is starting up.
	 * It is responsible for creating local systems, properties and listening for Scene events.
	 * Do not invoke it directly.
	 *
	 * @since 1.0.0
	**/
	private function pluginStart()
	{
		systems.events.once(SceneEvents.SHUTDOWN, this.shutdown, this);
	}

	/**
	 * If you want to append a URL before the path of any asset you can set this here.
	 *
	 * Useful if allowing the asset base url to be configured outside of the game code.
	 *
	 * Once a base URL is set it will affect every file loaded by the Loader from that point on. It does _not_ change any
	 * file _already_ being loaded. To reset it, call this method with no arguments.
	 *
	 * @since 1.0.0
	 *
	 * @param url - The URL to use. Leave empty to reset.
	 *
	 * @return This Loader object.
	**/
	public function setBaseURL(url:String = ""):LoaderPlugin
	{
		if (url != "" && url.substr(-1) != "/")
		{
			url = url + "/";
		}

		this.baseURL = url;

		return this;
	}

	/**
	 * The value of `path`, if set, is placed before any _relative_ file path given. For example:
	 *
	 * ```haxe
	 * load.setPath("images/sprites/");
	 * load.image("ball", "ball.png");
	 * load.image("tree", "level1/oaktree.png");
	 * load.image("boom", "http://server.com/explode.png");
	 * ```
	 *
	 * Would load the `ball` file from `images/sprites/ball.png` and the tree from
	 * `images/sprites/level1/oaktree.png` but the file `boom` would load from the URL
	 * given as it's an absolute URL.
	 *
	 * Please note that the path is added before the filename but *after* the baseURL (if set.)
	 *
	 * Once a path is set it will then affect every file added to the Loader from that point on. It does _not_ change any
	 * file _already_ in the load queue. To reset it, call this method with no arguments.
	 *
	 * @since 1.0.0
	 *
	 * @param path - The path to use. Leave empty to reset.
	 *
	 * @return This Loader object.
	**/
	public function setPath(path:String = ""):LoaderPlugin
	{
		if (path != "" && path.substr(-1) != "/")
		{
			path = path + "/";
		}

		this.path = path;

		return this;
	}

	/**
	 * An optional prefix that is automatically prepended to the start of every file key.
	 *
	 * If prefix was `MENU.` and you load an image with the key 'Background' the resulting key would be `MENU.Background`.
	 *
	 * Once a prefix is set it will then affect every file added to the Loader from that point on. It does _not_ change any
	 * file _already_ in the load queue. To reset it, call this method with no arguments.
	 *
	 * @since 1.0.0
	 *
	 * @param prefix - The prefix to use. Leave empty to reset.
	 *
	 * @return This Loader object.
	**/
	public function setPrefix(prefix:String = ""):LoaderPlugin
	{
		this.prefix = prefix;
		return this;
	}

	/**
	 * Sets the Cross Origin Resource Sharing value used when loading files.
	 *
	 * Files can override this value on a per-file basis by specifying an alternative `crossOrigin` value in their file config.
	 *
	 * Once CORs is set it will then affect every file loaded by the Loader from that point on, as long as they don't have
	 * their own CORs setting. To reset it, call this method with no arguments.
	 *
	 * For more details about CORs see https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS
	 *
	 * @since 1.0.0
	 *
	 * @param crossOrigin - The value to use for the `crossOrigin` property in the load request.
	 *
	 * @return This Loader object.
	**/
	public function setCORS(crossOrigin:String):LoaderPlugin
	{
		this.crossOrigin = crossOrigin;
		return this;
	}

	/**
	 * Adds a file, or array of files, into the load queue.
	 *
	 * The file must be an instance of `Phaser.Loader.File`, or a class that extends it. The Loader will check that the key
	 * used by the file won't conflict with any other key either in the loader, the inflight queue or the target cache.
	 * If allowed it will then add the file into the pending list, read for the load to start. Or, if the load has already
	 * started, ready for the next batch of files to be pulled from the list to the inflight queue.
	 *
	 * You should not normally call this method directly, but rather use one of the Loader methods like `image` or `atlas`,
	 * however you can call this as long as the file given to it is well formed.
	 *
	 * @method Phaser.Loader.LoaderPlugin#addFile
	 * @fires Phaser.Loader.Events#ADD
	 * @since 3.0.0
	 *
	 * @param {(Phaser.Loader.File|Phaser.Loader.File[])} file - The file, or array of files, to be added to the load queue.
	 */
	public function addFile(file:MultipleOrOne<File>):Void
	{
		// if (!Array.isArray(file))
		// {
		//     file = [ file ];
		// }

		// for (var i = 0; i < file.length; i++)
		// {
		//     var item = file[i];

		//     //  Does the file already exist in the cache or texture manager?
		//     //  Or will it conflict with a file already in the queue or inflight?
		//     if (!this.keyExists(item))
		//     {
		//         this.list.set(item);

		//         this.emit(Events.ADD, item.key, item.type, this, item);

		//         if (this.isLoading())
		//         {
		//             this.totalToLoad++;
		//             this.updateProgress();
		//         }
		//     }
		// }
	}

	/**
	 * Checks the key and type of the given file to see if it will conflict with anything already
	 * in a Cache, the Texture Manager, or the list or inflight queues.
	 *
	 * @method Phaser.Loader.LoaderPlugin#keyExists
	 * @since 3.7.0
	 *
	 * @param {Phaser.Loader.File} file - The file to check the key of.
	 *
	 * @return {boolean} `true` if adding this file will cause a cache or queue conflict, otherwise `false`.
	 */
	private function keyExists(file:File):Bool
	{
		var keyConflict = file.hasCacheConflict();

		// if (!keyConflict)
		// {
		//     this.list.iterate(function (item)
		//     {
		//         if (item.type === file.type && item.key === file.key)
		//         {
		//             keyConflict = true;

		//             return false;
		//         }

		//     });
		// }

		// if (!keyConflict && this.isLoading())
		// {
		//     this.inflight.iterate(function (item)
		//     {
		//         if (item.type === file.type && item.key === file.key)
		//         {
		//             keyConflict = true;

		//             return false;
		//         }

		//     });

		//     this.queue.iterate(function (item)
		//     {
		//         if (item.type === file.type && item.key === file.key)
		//         {
		//             keyConflict = true;

		//             return false;
		//         }

		//     });
		// }

		return keyConflict;
	}

	/**
	 * Takes a well formed, fully parsed pack file object and adds its entries into the load queue. Usually you do not call
	 * this method directly, but instead use `Loader.pack` and supply a path to a JSON file that holds the
	 * pack data. However, if you've got the data prepared you can pass it to this method.
	 *
	 * You can also provide an optional key. If you do then it will only add the entries from that part of the pack into
	 * to the load queue. If not specified it will add all entries it finds. For more details about the pack file format
	 * see the `LoaderPlugin.pack` method.
	 *
	 * @since 1.0.0
	 *
	 * @param data - The Pack File data to be parsed and each entry of it to added to the load queue.
	 * @param packKey - An optional key to use from the pack file data.
	 *
	 * @return `true` if any files were added to the queue, otherwise `false`.
	**/
	public function addPack(pack:Any, packKey:String):Bool
	{
		var total = 0;

		//  if no packKey provided we'll add everything to the queue
		// if (packKey && pack.hasOwnProperty(packKey))
		// {
		//     pack = { packKey: pack[packKey] };
		// }

		// //  Store the loader settings in case this pack replaces them
		// var currentBaseURL = this.baseURL;
		// var currentPath = this.path;
		// var currentPrefix = this.prefix;

		// //  Here we go ...
		// for (var key in pack)
		// {
		//     var config = pack[key];

		//     //  Any meta data to process?
		//     var baseURL = GetFastValue(config, 'baseURL', currentBaseURL);
		//     var path = GetFastValue(config, 'path', currentPath);
		//     var prefix = GetFastValue(config, 'prefix', currentPrefix);
		//     var files = GetFastValue(config, 'files', null);
		//     var defaultType = GetFastValue(config, 'defaultType', 'void');

		//     if (Array.isArray(files))
		//     {
		//         this.setBaseURL(baseURL);
		//         this.setPath(path);
		//         this.setPrefix(prefix);

		//         for (var i = 0; i < files.length; i++)
		//         {
		//             var file = files[i];
		//             var type = (file.hasOwnProperty('type')) ? file.type : defaultType;

		//             if (this[type])
		//             {
		//                 this[type](file);
		//                 total++;
		//             }
		//         }
		//     }
		// }

		// //  Reset the loader settings
		// this.setBaseURL(currentBaseURL);
		// this.setPath(currentPath);
		// this.setPrefix(currentPrefix);

		return (total > 0);
	}

	/**
	 * Is the Loader actively loading, or processing loaded files?
	 *
	 * @since 1.0.0
	 *
	 * @return `true` if the Loader is busy loading or processing, otherwise `false`.
	**/
	public function isLoading():Bool
	{
		return state == LoaderConst.LOADER_LOADING || state == LoaderConst.LOADER_PROCESSING;
	}

	/**
	 * Is the Loader ready to start a new load?
	 *
	 * @since 1.0.0
	 *
	 * @return `true` if the Loader is ready to start a new load, otherwise `false`.
	**/
	public function isReady():Bool
	{
		return state == LoaderConst.LOADER_IDLE || state == LoaderConst.LOADER_COMPLETE;
	}

	/**
	 * Starts the Loader running. This will reset the progress and totals and then emit a `start` event.
	 * If there is nothing in the queue the Loader will immediately complete, otherwise it will start
	 * loading the first batch of files.
	 *
	 * The Loader is started automatically if the queue is populated within your Scenes `preload` method.
	 *
	 * However, outside of this, you need to call this method to start it.
	 *
	 * If the Loader is already running this method will simply return.
	 *
	 * @method Phaser.Loader.LoaderPlugin#start
	 * @fires Phaser.Loader.Events#START
	 * @since 3.0.0
	 */
	public function start():Void
	{
		// if (!this.isReady())
		// {
		//     return;
		// }

		// this.progress = 0;

		// this.totalFailed = 0;
		// this.totalComplete = 0;
		// this.totalToLoad = this.list.size;

		// this.emit(Events.START, this);

		// if (this.list.size === 0)
		// {
		//     this.loadComplete();
		// }
		// else
		// {
		//     this.state = CONST.LOADER_LOADING;

		//     this.inflight.clear();
		//     this.queue.clear();

		//     this.updateProgress();

		//     this.checkLoadQueue();

		//     this.systems.events.on(SceneEvents.UPDATE, this.update, this);
		// }
	}

	/**
	 * Called automatically during the load process.
	 * It updates the `progress` value and then emits a progress event, which you can use to
	 * display a loading bar in your game.
	 *
	 * @fires Phaser.Loader.Events#PROGRESS
	 * @since 1.0.0
	**/
	public function updateProgress():Void
	{
		// this.progress = 1 - ((this.list.size + this.inflight.size) / this.totalToLoad);

		// this.emit(Events.PROGRESS, this.progress);
	}

	/**
	 * Called automatically during the load process.
	 *
	 * @since 1.0.0
	**/
	public function update():Void
	{
		// if (this.state === CONST.LOADER_LOADING && this.list.size > 0 && this.inflight.size < this.maxParallelDownloads)
		// {
		//     this.checkLoadQueue();
		// }
	}

	/**
	 * An internal method called by the Loader.
	 *
	 * It will check to see if there are any more files in the pending list that need loading, and if so it will move
	 * them from the list Set into the inflight Set, set their CORs flag and start them loading.
	 *
	 * It will carrying on doing this for each file in the pending list until it runs out, or hits the max allowed parallel downloads.
	 *
	 * @since 1.0.0
	**/
	private function checkLoadQueue():Void
	{
		// this.list.each(function (file)
		// {
		//     if (file.state === CONST.FILE_POPULATED || (file.state === CONST.FILE_PENDING && this.inflight.size < this.maxParallelDownloads))
		//     {
		//         this.inflight.set(file);

		//         this.list.delete(file);

		//         //  If the file doesn't have its own crossOrigin set, we'll use the Loaders (which is undefined by default)
		//         if (!file.crossOrigin)
		//         {
		//             file.crossOrigin = this.crossOrigin;
		//         }

		//         file.load();
		//     }

		//     if (this.inflight.size === this.maxParallelDownloads)
		//     {
		//         //  Tells the Set iterator to abort
		//         return false;
		//     }

		// }, this);
	}

	/**
	 * An internal method called automatically by the XHRLoader belong to a File.
	 *
	 * This method will remove the given file from the inflight Set and update the load progress.
	 * If the file was successful its `onProcess` method is called, otherwise it is added to the delete queue.
	 *
	 * @fires Phaser.Loader.Events#FILE_LOAD
	 * @fires Phaser.Loader.Events#FILE_LOAD_ERROR
	 * @since 1.0.0
	 *
	 * @param file - The File that just finished loading, or errored during load.
	 * @param success - `true` if the file loaded successfully, otherwise `false`.
	**/
	public function nextFile(file:File, success:Bool):Void
	{
		// //  Has the game been destroyed during load? If so, bail out now.
		// if (!this.inflight)
		// {
		//     return;
		// }

		// this.inflight.delete(file);

		// this.updateProgress();

		// if (success)
		// {
		//     this.totalComplete++;

		//     this.queue.set(file);

		//     this.emit(Events.FILE_LOAD, file);

		//     file.onProcess();
		// }
		// else
		// {
		//     this.totalFailed++;

		//     this._deleteQueue.set(file);

		//     this.emit(Events.FILE_LOAD_ERROR, file);

		//     this.fileProcessComplete(file);
		// }
	}

	/**
	 * An internal method that is called automatically by the File when it has finished processing.
	 *
	 * If the process was successful, and the File isn't part of a MultiFile, its `addToCache` method is called.
	 *
	 * It this then removed from the queue. If there are no more files to load `loadComplete` is called.
	 *
	 * @since 1.0.0
	 *
	 * @param file - The file that has finished processing.
	**/
	public function fileProcessComplete(file:File):Void
	{
		// //  Has the game been destroyed during load? If so, bail out now.
		// if (!this.scene || !this.systems || !this.systems.game || this.systems.game.pendingDestroy)
		// {
		//     return;
		// }

		// //  This file has failed, so move it to the failed Set
		// if (file.state === CONST.FILE_ERRORED)
		// {
		//     if (file.multiFile)
		//     {
		//         file.multiFile.onFileFailed(file);
		//     }
		// }
		// else if (file.state === CONST.FILE_COMPLETE)
		// {
		//     if (file.multiFile)
		//     {
		//         if (file.multiFile.isReadyToProcess())
		//         {
		//             //  If we got here then all files the link file needs are ready to add to the cache
		//             file.multiFile.addToCache();
		//         }
		//     }
		//     else
		//     {
		//         //  If we got here, then the file processed, so let it add itself to its cache
		//         file.addToCache();
		//     }
		// }

		// //  Remove it from the queue
		// this.queue.delete(file);

		// //  Nothing left to do?

		// if (this.list.size === 0 && this.inflight.size === 0 && this.queue.size === 0)
		// {
		//     this.loadComplete();
		// }
	}

	/**
	 * Called at the end when the load queue is exhausted and all files have either loaded or errored.
	 * By this point every loaded file will now be in its associated cache and ready for use.
	 *
	 * Also clears down the Sets, puts progress to 1 and clears the deletion queue.
	 *
	 * @fires Phaser.Loader.Events#COMPLETE
	 * @fires Phaser.Loader.Events#POST_PROCESS
	 * @since 3.7.0
	**/
	public function loadComplete():Void
	{
		// this.emit(Events.POST_PROCESS, this);

		// this.list.clear();
		// this.inflight.clear();
		// this.queue.clear();

		// this.progress = 1;

		// this.state = CONST.LOADER_COMPLETE;

		// this.systems.events.off(SceneEvents.UPDATE, this.update, this);

		// //  Call 'destroy' on each file ready for deletion
		// this._deleteQueue.iterateLocal('destroy');

		// this._deleteQueue.clear();

		// this.emit(Events.COMPLETE, this, this.totalComplete, this.totalFailed);
	}

	/**
	 * Adds a File into the pending-deletion queue.
	 *
	 * @since 1.0.0
	 *
	 * @param file - The File to be queued for deletion when the Loader completes.
	**/
	public function flagForRemoval(file:File):Void
	{
		this._deleteQueue.set(file);
	}

	/**
	 * Converts the given JSON data into a file that the browser then prompts you to download so you can save it locally.
	 *
	 * The data must be well formed JSON and ready-parsed, not a JavaScript object.
	 *
	 * @method Phaser.Loader.LoaderPlugin#saveJSON
	 * @since 3.0.0
	 *
	 * @param {*} data - The JSON data, ready parsed.
	 * @param {string} [filename=file.json] - The name to save the JSON file as.
	 *
	 * @return {Phaser.Loader.LoaderPlugin} This Loader plugin.
	**/
	public function saveJSON(data:Any, ?filename:String):LoaderPlugin
	{
		return save(Json.stringify(data), filename);
	}

	/**
	 * Causes the browser to save the given data as a file to its default Downloads folder.
	 *
	 * Creates a DOM level anchor link, assigns it as being a `download` anchor, sets the href
	 * to be an ObjectURL based on the given data, and then invokes a click event.
	 *
	 * @since 1.0.0
	 *
	 * @param data - The data to be saved. Will be passed through URL.createObjectURL.
	 * @param filename - The filename to save the file as.
	 * @param filetype - The file type to use when saving the file. Defaults to JSON.
	 *
	 * @return This Loader plugin.
	**/
	public function save(data:Any, filename:String = "file.json",
			filetype:String = "application/json"):LoaderPlugin
	{
		// if (filename === undefined) { filename = 'file.json'; }
		// if (filetype === undefined) { filetype = 'application/json'; }

		// var blob = new Blob([ data ], { type: filetype });

		// var url = URL.createObjectURL(blob);

		// var a = document.createElement('a');

		// a.download = filename;
		// a.textContent = 'Download ' + filename;
		// a.href = url;
		// a.click();

		return this;
	}

	/**
	 * Resets the Loader.
	 *
	 * This will clear all lists and reset the base URL, path and prefix.
	 *
	 * Warning: If the Loader is currently downloading files, or has files in its queue, they will be aborted.
	 *
	 * @since 1.0.0
	**/
	public function reset():Void
	{
		// this.list.clear();
		// this.inflight.clear();
		// this.queue.clear();

		// var gameConfig = this.systems.game.config;
		// var sceneConfig = this.systems.settings.loader;

		// this.setBaseURL(GetFastValue(sceneConfig, 'baseURL', gameConfig.loaderBaseURL));
		// this.setPath(GetFastValue(sceneConfig, 'path', gameConfig.loaderPath));
		// this.setPrefix(GetFastValue(sceneConfig, 'prefix', gameConfig.loaderPrefix));

		// this.state = CONST.LOADER_IDLE;
	}

	/**
	 * The Scene that owns this plugin is shutting down.
	 * We need to kill and reset all internal properties as well as stop listening to Scene events.
	 *
	 * @method Phaser.Loader.LoaderPlugin#shutdown
	 * @private
	 * @since 3.0.0
	 */
	private function shutdown():Void
	{
		// this.reset();

		// this.state = CONST.LOADER_SHUTDOWN;

		// this.systems.events.off(SceneEvents.UPDATE, this.update, this);
		// this.systems.events.off(SceneEvents.SHUTDOWN, this.shutdown, this);
	}

	/**
	 * The Scene that owns this plugin is being destroyed.
	 * We need to shutdown and then kill off all external references.
	 *
	 * @method Phaser.Loader.LoaderPlugin#destroy
	 * @private
	 * @since 3.0.0
	**/
	private function destroy():Void
	{
		// this.shutdown();

		// this.state = CONST.LOADER_DESTROYED;

		// this.systems.events.off(SceneEvents.UPDATE, this.update, this);
		// this.systems.events.off(SceneEvents.START, this.pluginStart, this);

		// this.list = null;
		// this.inflight = null;
		// this.queue = null;

		// this.scene = null;
		// this.systems = null;
		// this.textureManager = null;
		// this.cacheManager = null;
		// this.sceneManager = null;
	}
}
