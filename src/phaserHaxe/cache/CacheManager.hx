package phaserHaxe.cache;

import phaserHaxe.core.GameEvents;
import haxe.ds.StringMap;

/**
 * The Cache Manager is the global cache owned and maintained by the Game instance.
 *
 * Various systems, such as the file Loader, rely on this cache in order to store the files
 * it has loaded. The manager itself doesn't store any files, but instead owns multiple BaseCache
 * instances, one per type of file. You can also add your own custom caches.
 *
 * @since 1.0.0
**/
class CacheManager
{
	/**
	 * A reference to the Phaser.Game instance that owns this CacheManager.
	 *
	 * @since 1.0.0
	**/
	private var game:Game;

	/**
	 * A Cache storing all binary files, typically added via the Loader.
	 *
	 * @since 1.0.0
	**/
	public var binary(default, null) = new BaseCache();

	/**
	 * A Cache storing all bitmap font data files, typically added via the Loader.
	 * Only the font data is stored in this cache, the textures are part of the Texture Manager.
	 *
	 * @since 1.0.0
	**/
	public var bitmapFont(default, null) = new BaseCache();

	/**
	 * A Cache storing all JSON data files, typically added via the Loader.
	 *
	 * @since 1.0.0
	**/
	public var json(default, null) = new BaseCache();

	/**
	 * A Cache storing all physics data files, typically added via the Loader.
	 *
	 * @since 1.0.0
	**/
	public var physics(default, null) = new BaseCache();

	/**
	 * A Cache storing all shader source files, typically added via the Loader.
	 *
	 * @since 1.0.0
	**/
	public var shader(default, null) = new BaseCache();

	/**
	 * A Cache storing all non-streaming audio files, typically added via the Loader.
	 *
	 * @since 1.0.0
	**/
	public var audio(default, null) = new BaseCache();

	/**
	 * A Cache storing all non-streaming video files, typically added via the Loader.
	 *
	 * @since 1.0.0
	**/
	public var video(default, null) = new BaseCache();

	/**
	 * A Cache storing all text files, typically added via the Loader.
	 *
	 * @since 1.0.0
	**/
	public var text(default, null) = new BaseCache();

	/**
	 * A Cache storing all html files, typically added via the Loader.
	 *
	 * @since 1.0.0
	**/
	public var html(default, null) = new BaseCache();

	/**
	 * A Cache storing all WaveFront OBJ files, typically added via the Loader.
	 *
	 * @since 1.0.0
	**/
	public var obj(default, null) = new BaseCache();

	/**
	 * A Cache storing all tilemap data files, typically added via the Loader.
	 * Only the data is stored in this cache, the textures are part of the Texture Manager.
	 *
	 * @since 1.0.0
	**/
	public var tilemap(default, null) = new BaseCache();

	/**
	 * A Cache storing all xml data files, typically added via the Loader.
	 *
	 * @since 1.0.0
	**/
	public var xml(default, null) = new BaseCache();

	/**
	 * An object that contains your own custom BaseCache entries.
	 * Add to this via the `addCustom` method.
	 *
	 * @since 1.0.0
	**/
	public var custom(default, null):StringMap<BaseCache> = new StringMap();

	/**
	 * @param game - A reference to the Phaser.Game instance that owns this CacheManager.
	**/
	public function new(game:Game)
	{
		game.events.once(GameEvents.DESTROY, this.destroy, this);
	}

	/**
	 * Add your own custom Cache for storing your own files.
	 * The cache will be available under `Cache.custom.key`.
	 * The cache will only be created if the key is not already in use.
	 *
	 * @since 1.0.0
	 *
	 * @param key - The unique key of your custom cache.
	 *
	 * @return A reference to the BaseCache that was created. If the key was already in use, a reference to the existing cache is returned instead.
	**/
	public function addCustom(key:String):BaseCache
	{
		if (!custom.exists(key))
		{
			custom.set(key, new BaseCache());
		}

		return custom.get(key);
	}

	/**
	 * Removes all entries from all BaseCaches and destroys all custom caches.
	 *
	 * @since 1.0.0
	**/
	public function destroy()
	{   
        binary.destroy();
		binary = null;

        bitmapFont.destroy();
		bitmapFont = null;

        json.destroy();
        json = null;

        physics.destroy();
		physics = null;

        shader.destroy();
		shader = null;

        audio.destroy();
		audio = null;

        video.destroy();
        video = null;

        text.destroy();
        text = null;

        html.destroy();
        html = null;

        obj.destroy();
        obj = null;

        tilemap.destroy();
        tilemap = null;
        
        xml.destroy();
        xml = null;

        for(item in custom)
        {
            item.destroy();
        }

        custom.clear();
        
        custom = null;

        game = null;
	}
}
