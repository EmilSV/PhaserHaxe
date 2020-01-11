package phaserHaxe.loader;

enum abstract LoaderEvents(String) to String
{
	/**
	 * The Loader Plugin Add File Event.
	 *
	 * This event is dispatched when a new file is successfully added to the Loader and placed into the load queue.
	 *
	 * Listen to it from a Scene using: `this.load.on('addfile', listener)`.
	 *
	 * If you add lots of files to a Loader from a `preload` method, it will dispatch this event for each one of them.
	 *
	 * @since 1.0.0
	 *
	 * @param key - {string} The unique key of the file that was added to the Loader.
	 * @param type - {string} The [file type]{@link Phaser.Loader.File#type} string of the file that was added to the Loader, i.e. `image`.
	 * @param loader - {Phaser.Loader.LoaderPlugin} A reference to the Loader Plugin that dispatched this event.
	 * @param file - {Phaser.Loader.File} A reference to the File which was added to the Loader.
	**/
	var ADD = "addfile";

	/**
	 * The Loader Plugin Complete Event.
	 *
	 * This event is dispatched when the Loader has fully processed everything in the load queue.
	 * By this point every loaded file will now be in its associated cache and ready for use.
	 *
	 * Listen to it from a Scene using: `this.load.on('complete', listener)`.
	 *
	 * @since 1.0.0
	 *
	 * @param loader - {Phaser.Loader.LoaderPlugin} A reference to the Loader Plugin that dispatched this event.
	 * @param totalComplete - {integer} The total number of files that successfully loaded.
	 * @param totalFailed - {integer} The total number of files that failed to load.
	**/
	var COMPLETE = "complete";

	/**
	 * The File Load Complete Event.
	 *
	 * This event is dispatched by the Loader Plugin when any file in the queue finishes loading.
	 *
	 * Listen to it from a Scene using: `this.load.on('filecomplete', listener)`.
	 *
	 * You can also listen for the completion of a specific file. See the [FILE_KEY_COMPLETE]{@linkcode Phaser.Loader.Events#event:FILE_KEY_COMPLETE} event.
	 *
	 * @since 1.0.0
	 *
	 * @param key - {string} The key of the file that just loaded and finished processing.
	 * @param type - {string} The [file type]{@link Phaser.Loader.File#type} of the file that just loaded, i.e. `image`.
	 * @param data - {any} The raw data the file contained.
	**/
	var FILE_COMPLETE = "filecomplete";

	/**
	 * The File Load Complete Event.
	 *
	 * This event is dispatched by the Loader Plugin when any file in the queue finishes loading.
	 *
	 * It uses a special dynamic event name constructed from the key and type of the file.
	 *
	 * For example, if you have loaded an `image` with a key of `monster`, you can listen for it
	 * using the following:
	 *
	 * ```haxe
	 * load.on('filecomplete-image-monster', (key, type, data) -> {
	 *     // Your handler code
	 * });
	 * ```
	 *
	 * Or, if you have loaded a texture `atlas` with a key of `Level1`:
	 *
	 * ```haxe
	 * load.on('filecomplete-atlas-Level1', (key, type, data) -> {
	 *     // Your handler code
	 * });
	 * ```
	 *
	 * Or, if you have loaded a sprite sheet with a key of `Explosion` and a prefix of `GAMEOVER`:
	 *
	 * ```haxe
	 * load.on('filecomplete-spritesheet-GAMEOVERExplosion', (key, type, data) -> {
	 *     // Your handler code
	 * });
	 * ```
	 *
	 * You can also listen for the generic completion of files. See the [FILE_COMPLETE]{@linkcode Phaser.Loader.Events#event:FILE_COMPLETE} event.
	 *
	 * @since 1.0.0
	 *
	 * @param key - {string} The key of the file that just loaded and finished processing.
	 * @param type - {string} The [file type]{@link Phaser.Loader.File#type} of the file that just loaded, i.e. `image`.
	 * @param data - {any} The raw data the file contained.
	**/
	var FILE_KEY_COMPLETE = "filecomplete-";

	/**
	 * The File Load Error Event.
	 *
	 * This event is dispatched by the Loader Plugin when a file fails to load.
	 *
	 * Listen to it from a Scene using: `this.load.on('loaderror', listener)`.
	 *
	 * @since 1.0.0
	 *
	 * @param file - {Phaser.Loader.File} A reference to the File which errored during load.
	**/
	var FILE_LOAD_ERROR = "loaderror";

	/**
	 * The File Load Event.
	 *
	 * This event is dispatched by the Loader Plugin when a file finishes loading,
	 * but _before_ it is processed and added to the internal Phaser caches.
	 *
	 * Listen to it from a Scene using: `this.load.on('load', listener)`.
	 *
	 * @since 1.0.0
	 *
	 * @param file - {Phaser.Loader.File} A reference to the File which just finished loading.
	**/
	var FILE_LOAD = "load";

	/**
	 * The File Load Progress Event.
	 *
	 * This event is dispatched by the Loader Plugin during the load of a file, if the browser receives a DOM ProgressEvent and
	 * the `lengthComputable` event property is true. Depending on the size of the file and browser in use, this may, or may not happen.
	 *
	 * Listen to it from a Scene using: `this.load.on('fileprogress', listener)`.
	 *
	 * @since 1.0.0
	 *
	 * @param file - {Phaser.Loader.File} A reference to the File which errored during load.
	 * @param percentComplete - {number} A value between 0 and 1 indicating how 'complete' this file is.
	**/
	var FILE_PROGRESS = "fileprogress";

	/**
	 * The Loader Plugin Post Process Event.
	 *
	 * This event is dispatched by the Loader Plugin when the Loader has finished loading everything in the load queue.
	 * It is dispatched before the internal lists are cleared and each File is destroyed.
	 *
	 * Use this hook to perform any last minute processing of files that can only happen once the
	 * Loader has completed, but prior to it emitting the `complete` event.
	 *
	 * Listen to it from a Scene using: `this.load.on('postprocess', listener)`.
	 *
	 * @since 1.0.0
	 *
	 * @param loader - {Phaser.Loader.LoaderPlugin} A reference to the Loader Plugin that dispatched this event.
	**/
	var POST_PROCESS = "postprocess";

	/**
	 * The Loader Plugin Progress Event.
	 *
	 * This event is dispatched when the Loader updates its load progress, typically as a result of a file having completed loading.
	 *
	 * Listen to it from a Scene using: `this.load.on('progress', listener)`.
	 *
	 * @since 1.0.0
	 *
	 * @param progress - {number} The current progress of the load. A value between 0 and 1.
	**/
	var PROGRESS = "progress";

	/**
	 * The Loader Plugin Start Event.
	 *
	 * This event is dispatched when the Loader starts running. At this point load progress is zero.
	 *
	 * This event is dispatched even if there aren't any files in the load queue.
	 *
	 * Listen to it from a Scene using: `this.load.on('start', listener)`.
	 *
	 * @since 1.0.0
	 *
	 * @param loader - {Phaser.Loader.LoaderPlugin} A reference to the Loader Plugin that dispatched this event.
	**/
	var START = "start";
}
