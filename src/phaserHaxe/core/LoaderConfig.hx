package phaserHaxe.core;

/**
 * @since 1.0.0
**/
@:structInit
final class LoaderConfig
{
	/**
	 * A URL used to resolve paths given to the loader.
	 * Example: 'http://labs.phaser.io/assets/'.
	 *
	 * @since 1.0.0
	**/
	public var baseURL:Null<String> = null;

	/**
	 * A URL path used to resolve relative paths given to the loader.
	 * Example: 'images/sprites/'.
	 *
	 * @since 1.0.0
	**/
	public var path:Null<String> = null;

	/**
	 * The maximum number of resources the loader will start loading at once.
	 *
	 * @since 1.0.0
	**/
	public var maxParallelDownloads:Int = 32;

	/**
	 * 'anonymous', 'use-credentials', or `undefined`.If you're
	 * not making cross-origin requests,leave this as `undefined`. See
	 * {@link https://developer.mozilla.org/en-US/docs/Web/HTML/CORS_settings_attributes}.
	 *
	 * @since 1.0.0
	**/
	public var crossOrigin:Null<String> = null;

	/**
	 * The response type of the XHR request, e.g. `blob`, `text`, etc.
	 *
	 * @since 1.0.0
	**/
	public var responseType:Null<String> = null;

	/**
	 * Should the XHR request use async or not?
	 *
	 * @since 1.0.0
	**/
	public var async:Bool = true;

	/**
	 * Optional username for all XHR requests.
	 *
	 * @since 1.0.0
	**/
	public var user:Null<String> = null;

	/**
	 * Optional password for all XHR requests.
	 *
	 * @since 1.0.0
	**/
	public var password:Null<String> = null;

	/**
	 * Optional XHR timeout value, in ms.
	 *
	 * @since 1.0.0
	**/
	public var timeout:Int = 0;
}
