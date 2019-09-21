package phaserHaxe.textures;

enum abstract TextureEvents(String) from String to String
{
	/**
	 * The Texture Add Event.
	 *
	 * This event is dispatched by the Texture Manager when a texture is added to it.
	 *
	 * Listen to this event from within a Scene using: `textures.on('addtexture', listener)`.
	 *
	 * @since 1.0.0
	 *
	 * @param key:String - The key of the Texture that was added to the Texture Manager.
	 * @param texture:Texture - A reference to the Texture that was added to the Texture Manager.
	**/
	var ADD = "addtexture";

	/**
	 * The Texture Load Error Event.
	 *
	 * This event is dispatched by the Texture Manager when a texture it requested to load failed.
	 * This only happens when base64 encoded textures fail. All other texture types are loaded via the Loader Plugin.
	 *
	 * Listen to this event from within a Scene using: `textures.on('onerror', listener)`.
	 *
	 * @since 1.0.0
	 *
	 * @param key:String - The key of the Texture that failed to load into the Texture Manager.
	**/
	var ERROR = "onerror";

	/**
	 * The Texture Load Event.
	 *
	 * This event is dispatched by the Texture Manager when a texture has finished loading on it.
	 * This only happens for base64 encoded textures. All other texture types are loaded via the Loader Plugin.
	 *
	 * Listen to this event from within a Scene using: `textures.on('onload', listener)`.
	 *
	 * This event is dispatched after the [ADD]{@linkcode Phaser.Textures.Events#event:ADD} event.
	 *
	 * @since 1.0.0
	 *
	 * @param key:String - The key of the Texture that was loaded by the Texture Manager.
	 * @param texture:Texture - A reference to the Texture that was loaded by the Texture Manager.
	**/
	var LOAD = "onload";

	/**
	 * This internal event signifies that the Texture Manager is now ready and the Game can continue booting.
	 *
	 * When a Phaser Game instance is booting for the first time, the Texture Manager has to wait on a couple of non-blocking
	 * async events before it's fully ready to carry on. When those complete the Texture Manager emits this event via the Game
	 * instance, which tells the Game to carry on booting.
	 *
	 * @since 1.0.0
	**/
	var READY = "ready";

	/**
	 * The Texture Remove Event.
	 *
	 * This event is dispatched by the Texture Manager when a texture is removed from it.
	 *
	 * Listen to this event from within a Scene using: `textures.on('removetexture', listener)`.
	 *
	 * If you have any Game Objects still using the removed texture, they will start throwing
	 * errors the next time they try to render. Be sure to clear all use of the texture in this event handler.
	 *
	 * @since 1.0.0
	 *
	 * @param key:String - The key of the Texture that was removed from the Texture Manager.
	**/
	var REMOVE = "removetexture";
}
