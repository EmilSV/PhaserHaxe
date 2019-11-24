package phaserHaxe.loader;

import js.html.XMLHttpRequestResponseType;

/**
 * @since 1.0.0
**/
@:structInit
class XHRSettingsObject
{
	/**
	 * The response type of the XHR request, i.e. `blob`, `text`, etc.
	 *
	 * @since 1.0.0
	**/
	public var responseType:XMLHttpRequestResponseType;

	/**
	 * Should the XHR request use async or not?
	 *
	 * @since 1.0.0
	**/
	public var async:Null<Bool>;

	/**
	 * Optional username for the XHR request.
	 *
	 * @since 1.0.0
	**/
	public var user:Null<String>;

	/**
	 * Optional password for the XHR request.
	 *
	 * @since 1.0.0
	**/
	public var password:Null<String>;

	/**
	 * Optional XHR timeout value.
	 *
	 * @since 1.0.0
	**/
	public var timeout:Null<Int>;

	/**
	 * This value is used to populate the XHR `setRequestHeader` and is undefined by default.
	 *
	 * @since 1.0.0
	**/
	public var header:Null<String>;

	/**
	 * This value is used to populate the XHR `setRequestHeader` and is undefined by default.
	 *
	 * @since 1.0.0
	**/
	public var headerValue:Null<String>;

	/**
	 * This value is used to populate the XHR `setRequestHeader` and is undefined by default.
	 *
	 * @since 1.0.0
	**/
	public var requestedWith:Null<String>;

	/**
	 * Provide a custom mime-type to use instead of the default.
	 *
	 * @since 1.0.0
	**/
	public var overrideMimeType:Null<String>;

	/**
	 * Creates an XHRSettings Object with default values.
	 *
	 * @since 1.0.0
	 *
	 * @param responseType - The responseType, such as 'text'.
	 * @param async - Should the XHR request use async or not?
	 * @param user - Optional username for the XHR request.
	 * @param password - Optional password for the XHR request.
	 * @param timeout - Optional XHR timeout value.
	 *
	 * @return The XHRSettings object as used by the Loader.
	**/
	public function new(responseType:XMLHttpRequestResponseType = NONE,
			async:Bool = true, user:String = "", password:String = "", timeout:Int = 0)
	{
		// Before sending a request, set the xhr.responseType to "text",
		// "arraybuffer", "blob", or "document", depending on your data needs.
		// Note, setting xhr.responseType = '' (or omitting) will default the response to "text".

		//  Ignored by the Loader, only used by File.
		this.responseType = responseType;

		this.async = async;

		//  credentials
		this.user = user;
		this.password = password;

		//  timeout in ms (0 = no timeout)
		this.timeout = timeout;

		//  setRequestHeader
		this.header = null;
		this.headerValue = null;
		this.requestedWith = null;

		//  overrideMimeType
		this.overrideMimeType = null;
	}
}
