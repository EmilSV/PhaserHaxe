package phaserHaxe.loader;

class MultiFile
{
	/**
	 * A reference to the Loader that is going to load this file.
	 *
	 * @since 1.0.0
	**/
	public var loader:LoaderPlugin;

	/**
	 * The file type string for sorting within the Loader.
	 *
	 * @since 1.0.0
	**/
	public var type:String;

	/**
	 * Unique cache key (unique within its file type)
	 *
	 * @since 1.0.0
	**/
	public var key:String;

	/**
	 * The current index being used by multi-file loaders to avoid key clashes.
	 *
	 * @since 1.0.0
	**/
	private var multiKeyIndex:Int;

	/**
	 * Array of files that make up this MultiFile.
	 *
	 * @since 1.0.0
	**/
	public var files:Array<File>;

	/**
	 * The completion status of this MultiFile.
	 *
	 * @since 1.0.0
	**/
	public var complete:Bool = false;

	/**
	 * The number of files to load.
	 *
	 * @since 1.0.0
	**/
	public var pending:Int;

	/**
	 * The number of files that failed to load.
	 *
	 * @since 1.0.0
	**/
	public var failed:Int = 0;

	/**
	 * A reference to the Loaders baseURL at the time this MultiFile was created.
	 * Used to populate child-files.
	 *
	 * @since 1.0.0
	**/
	public var baseURL:String;

	/**
	 * A reference to the Loaders path at the time this MultiFile was created.
	 * Used to populate child-files.
	 *
	 * @since 1.0.0
	**/
	public var path:String;

	/**
	 * A reference to the Loaders prefix at the time this MultiFile was created.
	 * Used to populate child-files.
	 *
	 * @since 1.0.0
	**/
	public var prefix:String;

	private function new(loader:LoaderPlugin, type:String, key:String,
			files:Array<File>)
	{
		this.loader = loader;

		this.type = type;

		this.key = key;

		this.multiKeyIndex = loader.multiKeyIndex++;

		this.files = files;

		this.pending = files.length;

		this.baseURL = loader.baseURL;

		this.path = loader.path;

		this.prefix = loader.prefix;

		//  Link the files
		for (i in 0...files.length)
		{
			files[i].multiFile = this;
		}
	}

	/**
	 * Checks if this MultiFile is ready to process its children or not.
	 *
	 * @since 1.0.0
	 *
	 * @return `true` if all children of this MultiFile have loaded, otherwise `false`.
	**/
	public function isReadyToProcess():Bool
	{
		return pending == 0 && failed == 0 && !complete;
	}

	/**
	 * Adds another child to this MultiFile, increases the pending count and resets the completion status.
	 *
	 * @since 1.0.0
	 *
	 * @param files - The File to add to this MultiFile.
	 *
	 * @return This MultiFile instance.
	**/
	public function addToMultiFile(file:File):MultiFile
	{
		files.push(file);

		file.multiFile = this;

		pending++;

		complete = false;

		return this;
	}

	/**
	 * Adds this file to its target cache upon successful loading and processing.
	 *
	 * @since 1.0.0
	**/
	public function addToCache() {}

	/**
	 * Called by each File when it finishes loading.
	 *
	 * @since 1.0.0
	 *
	 * @param file - The File that has completed processing.
	**/
	@:allow(phaserHaxe)
	private function onFileComplete(file:File):Void
	{
		var index = files.indexOf(file);

		if (index != -1)
		{
			pending--;
		}
	}

	/**
	 * Called by each File that fails to load.
	 *
	 * @since 1.0.0
	 *
	 * @param file - The File that has failed to load.
	**/
	@:allow(phaserHaxe)
	private function onFileFailed(file:File):Void
	{
		var index = files.indexOf(file);

		if (index != -1)
		{
			failed++;
		}
	}
}
