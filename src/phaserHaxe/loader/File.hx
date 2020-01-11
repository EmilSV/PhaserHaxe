package phaserHaxe.loader;

using StringTools;

import js.html.Blob as HTMLBlob;
import js.html.XMLHttpRequest;
import js.html.ProgressEvent as WebProgressEvent;
import js.Syntax as JsSyntax;
import js.html.Image as HTMLImageElement;
import phaserHaxe.loader.typedefs.FileConfig;
import phaserHaxe.loader.XHRSettingsObject;
import phaserHaxe.cache.BaseCache;
import phaserHaxe.utils.types.Union;
import phaserHaxe.textures.TextureManager;

/**
 * The base File class used by all File Types that the Loader can support.
 * You shouldn't create an instance of a File directly, but should extend it with your own class, setting a custom type and processing methods.
 *
 * @since 1.0.0
**/
class File
{
	/**
	 * A reference to the Loader that is going to load this file.
	 *
	 * @since 1.0.0
	**/
	public var loader:LoaderPlugin;

	/**
	 * A reference to the Cache, or Texture Manager, that is going to store this file if it loads.
	 *
	 * @since 1.0.0
	**/
	public var cache:Union<BaseCache, TextureManager>;

	/**
	 * The file type string (image, json, etc) for sorting within the Loader.
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
	 * The URL of the file, not including baseURL.
	 * Automatically has Loader.path prepended to it.
	 *
	 * @since 1.0.0
	**/
	public var url:String;

	/**
	 * The final URL this file will load from, including baseURL and path.
	 * Set automatically when the Loader calls 'load' on this file.
	 *
	 * @since 1.0.0
	**/
	public var src:String = '';

	/**
	 * The merged XHRSettings for this file.
	 *
	 * @since 1.0.0
	**/
	public var xhrSettings:XHRSettingsObject;

	/**
	 * The XMLHttpRequest instance (as created by XHR Loader) that is loading this File.
	 *
	 * @since 1.0.0
	**/
	public var xhrLoader:Null<XMLHttpRequest> = null;

	/**
	 * The current state of the file. One of the FILE_CONST values.
	 *
	 * @since 1.0.0
	**/
	public var state:Int;

	/**
	 * The total size of this file.
	 * Set by onProgress and only if loading via XHR.
	 *
	 * @since 1.0.0
	**/
	public var bytesTotal:Int = 0;

	/**
	 * Updated as the file loads.
	 * Only set if loading via XHR.
	 *
	 * @since 1.0.0
	**/
	public var bytesLoaded:Int = -1;

	/**
	 * A percentage value between 0 and 1 indicating how much of this file has loaded.
	 * Only set if loading via XHR.
	 *
	 * @since 3.0.0
	**/
	public var percentComplete:Float = -1;

	/**
	 * For CORs based loading.
	 * If this is undefined then the File will check BaseLoader.crossOrigin and use that (if set)
	 *
	 * @since 1.0.0
	**/
	public var crossOrigin:Null<String>;

	/**
	 * The processed file data, stored here after the file has loaded.
	 *
	 * @since 1.0.0
	**/
	public var data:Any;

	/**
	 * A config object that can be used by file types to store transitional data.
	 *
	 * @since 1.0.0
	**/
	public var config:Any;

	/**
	 * If this is a multipart file, i.e. an atlas and its json together, then this is a reference
	 * to the parent MultiFile. Set and used internally by the Loader or specific file types.
	 *
	 * @name Phaser.Loader.File#multiFile
	 * @type {?Phaser.Loader.MultiFile}
	 * @since 1.0.0
	**/
	public var multiFile:Null<MultiFile>;

	/**
	 * Does this file have an associated linked file? Such as an image and a normal map.
	 * Atlases and Bitmap Fonts use the multiFile, because those files need loading together but aren't
	 * actually bound by data, where-as a linkFile is.
	 *
	 * @since 1.0.0
	**/
	public var linkFile:File;

	/**
	 * @param {Phaser.Loader.LoaderPlugin} loader - The Loader that is going to load this File.
	 * @param {Phaser.Types.Loader.FileConfig} fileConfig - The file configuration object, as created by the file type.
	**/
	private function new(loader:LoaderPlugin, fileConfig:FileConfig)
	{
		// this.loader = loader;

		// this.cache = GetFastValue(fileConfig, 'cache', false);

		// this.type = GetFastValue(fileConfig, 'type', false);

		// this.key = GetFastValue(fileConfig, 'key', false);

		// var loadKey = this.key;

		// if (loader.prefix && loader.prefix != = '')
		// {
		// 	this.key = loader.prefix + loadKey;
		// }

		// if (!this.type || !this.key)
		// {
		// 	throw new Error('Error calling \'Loader.' + this.type + '\' invalid key provided.');
		// }

		// this.url = GetFastValue(fileConfig, 'url');

		// if (this.url == = undefined)
		// {
		// 	this.url = loader.path + loadKey + '.' +
		// 		GetFastValue(fileConfig, 'extension', '');
		// }
		// else if (typeof(this.url) != = 'function')
		// {
		// 	this.url = loader.path + this.url;
		// }

		// this.src = '';

		// this.xhrSettings = XHRSettings(GetFastValue(fileConfig, 'responseType', undefined));

		// if (GetFastValue(fileConfig, 'xhrSettings', false))
		// {
		// 	this.xhrSettings = MergeXHRSettings(this.xhrSettings, GetFastValue(fileConfig, 'xhrSettings', {}));
		// }

		// this.xhrLoader = null;

		// this.state = (typeof(this.url) == = 'function') ? CONST.FILE_POPULATED : CONST.FILE_PENDING;

		// this.bytesTotal = 0;

		// this.bytesLoaded = -1;

		// this.percentComplete = -1;

		// this.crossOrigin = undefined;

		// this.data = undefined;

		// this.config = GetFastValue(fileConfig, 'config', {});
	}

	/**
	 * Links this File with another, so they depend upon each other for loading and processing.
	 *
	 * @since 1.0.0
	 *
	 * @param {Phaser.Loader.File} fileB - The file to link to this one.
	**/
	public function setLink(fileB)
	{
		this.linkFile = fileB;

		fileB.linkFile = this;
	}

	/**
	 * Resets the XHRLoader instance this file is using.
	 *
	 * @since 1.0.0
	**/
	public function resetXHR()
	{
		if (this.xhrLoader != null)
		{
			this.xhrLoader.onload = null;
			this.xhrLoader.onerror = null;
			this.xhrLoader.onprogress = null;
		}
	}

	/**
	 * Called by the Loader, starts the actual file downloading.
	 * During the load the methods onLoad, onError and onProgress are called, based on the XHR events.
	 * You shouldn't normally call this method directly, it's meant to be invoked by the Loader.
	 *
	 * @since 1.0.0
	**/
	public function load()
	{
		// if (this.state == InputConst.FILE_POPULATED)
		// {
		// 	//  Can happen for example in a JSONFile if they've provided a JSON object instead of a URL
		// 	this.loader.nextFile(this, true);
		// }
		// else
		// {
		// 	this.src = GetURL(this, this.loader.baseURL);

		// 	if (this.src.indexOf('data:') ==  0)
		// 	{
		// 		console.warn('Local data URIs are not supported: ' + this.key);
		// 	}
		// 	else
		// 	{
		// 		//  The creation of this XHRLoader starts the load process going.
		// 		//  It will automatically call the following, based on the load outcome:
		// 		//
		// 		// xhr.onload = this.onLoad
		// 		// xhr.onerror = this.onError
		// 		// xhr.onprogress = this.onProgress

		// 		this.xhrLoader = XHRLoader(this, this.loader.xhr);
		// 	}
		// }
	}

	/**
	 * Called when the file finishes loading, is sent a DOM ProgressEvent.
	 *
	 * @since 1.0.0
	 *
	 * @param xhr - The XMLHttpRequest that caused this onload event.
	 * @param event - The DOM ProgressEvent that resulted from this load.
	**/
	public function onLoad(xhr:XMLHttpRequest, event:WebProgressEvent)
	{
		// var localFileOk = ((xhr.responseURL && xhr.responseURL.indexOf('file://') == = 0 && event.target.status == = 0));

		// var success = !(event.target && event.target.status != = 200) || localFileOk;

		// //  Handle HTTP status codes of 4xx and 5xx as errors, even if xhr.onerror was not called.
		// if (xhr.readyState == = 4 && xhr.status >= 400 && xhr.status <= 599)
		// {
		// 	success = false;
		// }

		// this.resetXHR();

		// this.loader.nextFile(this, success);
	}

	/**
	 * Called if the file errors while loading, is sent a DOM ProgressEvent.
	 *
	 * @method Phaser.Loader.File#onError
	 * @since 3.0.0
	 *
	 * @param {XMLHttpRequest} xhr - The XMLHttpRequest that caused this onload event.
	 * @param {ProgressEvent} event - The DOM ProgressEvent that resulted from this error.
	**/
	public function onError(xhr:XMLHttpRequest, event:WebProgressEvent)
	{
		// this.resetXHR();

		// this.loader.nextFile(this, false);
	}

	/**
	 * Called during the file load progress. Is sent a DOM ProgressEvent.
	 *
	 * @method Phaser.Loader.File#onProgress
	 * @fires Phaser.Loader.Events#FILE_PROGRESS
	 * @since 3.0.0
	 *
	 * @param {ProgressEvent} event - The DOM ProgressEvent.
	 */
	public function onProgress(event)
	{
		// if (event.lengthComputable)
		// {
		// 	this.bytesLoaded = event.loaded;
		// 	this.bytesTotal = event.total;

		// 	this.percentComplete = Math.min((this.bytesLoaded / this.bytesTotal), 1);

		// 	this.loader.emit(Events.FILE_PROGRESS, this, this.percentComplete);
		// }
	}

	/**
	 * Usually overridden by the FileTypes and is called by Loader.nextFile.
	 * This method controls what extra work this File does with its loaded data, for example a JSON file will parse itself during this stage.
	 *
	 * @method Phaser.Loader.File#onProcess
	 * @since 3.0.0
	**/
	public function onProcess()
	{
		// this.state = CONST.FILE_PROCESSING;

		// this.onProcessComplete();
	}

	/**
	 * Called when the File has completed processing.
	 * Checks on the state of its multifile, if set.
	 *
	 * @since 1.0.0
	**/
	public function onProcessComplete()
	{
		// this.state = CONST.FILE_COMPLETE;

		// if (this.multiFile)
		// {
		// 	this.multiFile.onFileComplete(this);
		// }

		// this.loader.fileProcessComplete(this);
	}

	/**
	 * Called when the File has completed processing but it generated an error.
	 * Checks on the state of its multifile, if set.
	 *
	 * @method Phaser.Loader.File#onProcessError
	 * @since 3.7.0
	**/
	public function onProcessError()
	{
		// this.state = CONST.FILE_ERRORED;

		// if (this.multiFile)
		// {
		// 	this.multiFile.onFileFailed(this);
		// }

		// this.loader.fileProcessComplete(this);
	}

	/**
	 * Checks if a key matching the one used by this file exists in the target Cache or not.
	 * This is called automatically by the LoaderPlugin to decide if the file can be safely
	 * loaded or will conflict.
	 *
	 * @since 1.0.0
	 *
	 * @return `true` if adding this file will cause a conflict, otherwise `false`.
	**/
	public function hasCacheConflict():Bool
	{
		return if (Std.is(cache, TextureManager))
		{
			cache != null && (cast cache : TextureManager).exists(key);
		} else
		{
			cache != null && (cast cache : BaseCache).exists(key);
		}
	}

	/**
	 * Adds this file to its target cache upon successful loading and processing.
	 * This method is often overridden by specific file types.
	 *
	 * @since 1.0.0
	**/
	public function addToCache()
	{
		// if (this.cache)
		// {
		//     this.cache.add(this.key, this.data);
		// }

		// this.pendingDestroy();
	}

	/**
	 * Called once the file has been added to its cache and is now ready for deletion from the Loader.
	 * It will emit a `filecomplete` event from the LoaderPlugin.
	 *
	 * @fires Phaser.Loader.Events#FILE_COMPLETE
	 * @fires Phaser.Loader.Events#FILE_KEY_COMPLETE
	 * @since 1.0.0
	**/
	public function pendingDestroy(?data:Any)
	{
		// if (data == null) { data = this.data; }

		// var key = this.key;
		// var type = this.type;

		// this.loader.emit(Events.FILE_COMPLETE, key, type, data);
		// this.loader.emit(Events.FILE_KEY_COMPLETE + type + '-' + key, key, type, data);

		// this.loader.flagForRemoval(this);
	}

	/**
	 * Destroy this File and any references it holds.
	 *
	 * @since 1.0.0
	**/
	public function destroy()
	{
		this.loader = null;
		this.cache = null;
		this.xhrSettings = null;
		this.multiFile = null;
		this.linkFile = null;
		this.data = null;
	}

	/**
	 * Static method for creating object URL using URL API and setting it as image 'src' attribute.
	 * If URL API is not supported (usually on old browsers) it falls back to creating Base64 encoded url using FileReader.
	 *
	 * @since 1.0.0
	 *
	 * @param image - Image object which 'src' attribute should be set to object URL.
	 * @param blob - A Blob object to create an object URL for.
	 * @param defaultType - Default mime type used if blob type is not available.
	**/
	public static function createObjectURL(image:HTMLImageElement, blob:HTMLBlob,
			defaultType:String)
	{
		if (JsSyntax.strictEq(JsSyntax.typeof(js.html.URL), "function"))
		{
			js.html.URL.createObjectURL(blob);
		}
		else
		{
			var reader = new js.html.FileReader();

			reader.onload = function()
			{
				var type = blob.type;
				if (type != null && type.length == 0)
				{
					type = defaultType;
				}
				image.removeAttribute("crossOrigin");
				image.src = "data:" + type + ";base64," + reader.result.split(",")[1];
			};

			reader.onerror = image.onerror;

			reader.readAsDataURL(blob);
		}
	}

	/**
	 * Static method for releasing an existing object URL which was previously created
	 * by calling {@link File#createObjectURL} method.
	 *
	 * @since 1.0.0
	 *
	 * @param image - Image object which 'src' attribute should be revoked.
	**/
	public static function revokeObjectURL(image:HTMLImageElement):Void
	{
		if (JsSyntax.strictEq(JsSyntax.typeof(js.html.URL), "function"))
		{
			js.html.URL.revokeObjectURL(image.src);
		}
	}
}
