package phaserHaxe.loader;

/**
 * @since 1.0.0
**/
enum abstract FileConst(Int) from Int to Int
{
	/**
	 * The Loader is idle.
	 *
	 * @since 1.0.0
	**/
	var LOADER_IDLE = 0;

	/**
	 * The Loader is actively loading.
	 *
	 * @since 1.0.0
	**/
	var LOADER_LOADING = 1;

	/**
	 * The Loader is processing files is has loaded.
	 *
	 * @since 1.0.0
	**/
	var LOADER_PROCESSING = 2;

	/**
	 * The Loader has completed loading and processing.
	 *
	 * @since 1.0.0
	**/
	var LOADER_COMPLETE = 3;

	/**
	 * The Loader is shutting down.
	 *
	 * @since 1.0.0
	**/
	var LOADER_SHUTDOWN = 4;

	/**
	 * The Loader has been destroyed.
	 *
	 * @since 1.0.0
	**/
	var LOADER_DESTROYED = 5;

	/**
	 * File is in the load queue but not yet started
	 *
	 * @since 1.0.0
	**/
	var FILE_PENDING = 10;

	/**
	 * File has been started to load by the loader (onLoad called)
	 *
	 * @since 1.0.0
	**/
	var FILE_LOADING = 11;

	/**
	 * File has loaded successfully; awaiting processing
	 *
	 * @since 1.0.0
	**/
	var FILE_LOADED = 12;

	/**
	 * File failed to load
	 *
	 * @since 1.0.0
	**/
	var FILE_FAILED = 13;

	/**
	 * File is being processed (onProcess callback)
	 *
	 * @since 1.0.0
	**/
	var FILE_PROCESSING = 14;

	/**
	 * The File has errored somehow during processing.
	 *
	 * @since 1.0.0
	**/
	var FILE_ERRORED = 16;

	/**
	 * File has finished processing.
	 *
	 * @since 1.0.0
	**/
	var FILE_COMPLETE = 17;

	/**
	 * File has been destroyed
	 *
	 * @since 1.0.0
	**/
	var FILE_DESTROYED = 18;

	/**
	 * File was populated from local data and doesn't need an HTTP request
	 *
	 * @since 1.0.0
	**/
	var FILE_POPULATED = 19;
}
