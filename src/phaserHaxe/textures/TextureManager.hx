package phaserHaxe.textures;

import phaserHaxe.gameobjects.RenderTexture;
import phaserHaxe.utils.MultipleOrOne;
import phaserHaxe.utils.StringOrInt;
import haxe.Constraints.Function;
import phaserHaxe.display.canvas.CanvasPool;
import haxe.ds.Map;
import js.html.CanvasElement as HTMLCanvasElement;
import js.html.CanvasRenderingContext2D;
import phaserHaxe.core.GameEvents;
import js.html.Image as HTMLImage;
import phaserHaxe.textures.Parser;
import js.html.ImageElement as HTMLImageElement;
import js.html.webgl.Texture as WebGLTexture;

/**
 * Textures are managed by the global TextureManager. This is a singleton class that is
 * responsible for creating and delivering Textures and their corresponding Frames to Game Objects.
 *
 * Sprites and other Game Objects get the texture data they need from the TextureManager.
 *
 * Access it via `scene.textures`.
 *
 * @since 1.0.0
 *
**/ class TextureManager extends EventEmitter
{
	/**
	 * The Game that this TextureManager belongs to.
	 *
	 * @since 1.0.0
	**/ public var game:Game;

	/**
	 * The name of this manager.
	 *
	 * @since 1.0.0
	**/
	public var name = "TextureManager";

	/**
	 * An object that has all of textures that Texture Manager creates.
	 * Textures are assigned to keys so we can access to any texture that this object has directly by key value without iteration.
	 *
	 * @since 1.0.0
	**/
	public var list:Map<String, Texture> = new Map();

	/**
	 * The temporary canvas element to save an pixel data of an arbitrary texture in getPixel() and getPixelAlpha() method.
	 *
	 * @since 1.0.0
	**/
	private var _tempCanvas:HTMLCanvasElement;

	/**
	 * The context of the temporary canvas element made to save an pixel data in getPixel() and getPixelAlpha() method.
	 *
	 * @since 1.0.0
	**/
	private var _tempContext:CanvasRenderingContext2D;

	/**
	 * An counting value used for emitting 'ready' event after all of managers in game is loaded.
	 *
	 * @since 1.0.0
	**/
	private var _pending:Int = 0;

	public function new(game:Game)
	{
		super();
		this.game = game;
		this._tempCanvas = CanvasPool.create2D(this, 1, 1);
		this._tempContext = this._tempCanvas.getContext('2d');

		game.events.once(GameEvents.BOOT, this.boot, this);
	}

	/**
	 * Calls each of the listeners registered for a given event.
	 *
	 * @param event - The event name.
	 * @returns `true` if the event had listeners, else `false`.
	**/
	public override function emit(event:TextureEvents, ?args:Array<Dynamic>):Bool
	{
		return super.emit(event, args);
	}

	/**
	 * Add a listener for a given event.
	 *
	 * @param event - The event name.
	 * @param fn - The listener function.
	 * @param context - The context to invoke the listener with.
	 * @returns `this`.
	**/
	public override function on(event:TextureEvents, fn:Function,
			?context:Dynamic):TextureManager
	{
		super.on(event, fn, context);
		return this;
	}

	/**
	 * Remove the listeners of a given event.
	 *
	 * @param event - The event name.
	 * @param fn - Only remove the listeners that match this function.
	 * @param context - Only remove the listeners that have this context.
	 * @param once - Only remove one-time listeners.
	 * @returns `this`.
	**/
	public override function off(event:TextureEvents, ?fn:Function, ?context:Dynamic,
			once:Bool = false):TextureManager
	{
		super.off(event, fn, context, once);
		return this;
	}

	/**
	 * The Boot Handler called by Phaser.Game when it first starts up.
	 *
	 * @since 1.0.0
	**/
	private function boot()
	{
		_pending = 2;
		on(TextureEvents.LOAD, updatePending, this);
		on(TextureEvents.ERROR, updatePending, this);
		addBase64('__DEFAULT', game.config.defaultImage);
		addBase64('__MISSING', game.config.missingImage);
		game.events.once(GameEvents.DESTROY, destroy, this);
	}

	/**
	 * After 'onload' or 'onerror' invoked twice, emit 'ready' event.
	 *
	 * @since 1.0.0
	**/
	private function updatePending()
	{
		_pending--;

		if (_pending == 0)
		{
			off(LOAD);
			off(ERROR);

			emit(READY);
		}
	}

	/**
	 * Checks the given texture key and throws a console.warn if the key is already in use, then returns false.
	 * If you wish to avoid the console.warn then use `TextureManager.exists` instead.
	 *
	 * @since 1.0.0
	 *
	 * @param key - The texture key to check.
	 *
	 * @return `true` if it's safe to use the texture key, otherwise `false`.
	**/
	public function checkKey(key:String)
	{
		if (exists(key))
		{
			Console.error('Texture key already in use: ' + key);
			return false;
		}
		return true;
	}

	/**
	 * Removes a Texture from the Texture Manager and destroys it. This will immediately
	 * clear all references to it from the Texture Manager, and if it has one, destroy its
	 * WebGLTexture. This will emit a `removetexture` event.
	 *
	 * Note: If you have any Game Objects still using this texture they will start throwing
	 * errors the next time they try to render. Make sure that removing the texture is the final
	 * step when clearing down to avoid this.
	 *
	 * @since 1.0.0
	 *
	 * @param key - The key of the Texture to remove, or a reference to it.
	 *
	 * @return The Texture Manager.
	**/
	public function remove(key:Either<String, Texture>):TextureManager
	{
		if (Std.is(key, String))
		{
			var keyString = (cast key : String);

			if (exists(keyString))
			{
				key = get(keyString);
			}
			else
			{
				Console.warn('No texture found matching key: ' + keyString);
				return this;
			}
		}

		final keyTexture = (cast key : Texture);

		//  By this point key should be a Texture, if not, the following fails anyway
		if (list.exists(keyTexture.key))
		{
			keyTexture.destroy();
			emit(REMOVE, [keyTexture.key]);
		}

		return this;
	}

	/**
	 * Removes a key from the Texture Manager but does not destroy the Texture that was using the key.
	 *
	 * @since 1.0.0
	 *
	 * @param key - The key to remove from the texture list.
	 *
	 * @return The Texture Manager.
	**/
	public function removeKey(key:String):TextureManager
	{
		if (list.exists(key))
		{
			list.remove(key);
		}
		return this;
	}

	/**
	 * Adds a new Texture to the Texture Manager created from the given Base64 encoded data.
	 *
	 * @since 1.0.0
	 *
	 * @param key - The unique string-based key of the Texture.
	 * @param data - The Base64 encoded data.
	 *
	 * @return This Texture Manager instance.
	**/
	public function addBase64(key:String, data:Any):TextureManager
	{
		if (checkKey(key))
		{
			var _this = this;
			var image = new HTMLImage();
			image.onerror = () ->
				{
					emit(ERROR, [key]);
				};

			image.onload = () ->
				{
					var texture = create(key, image);
					Parser.image(texture, 0);
					emit(ADD, [key, texture]);
					emit(LOAD, [key, texture]);
				};

			image.src = data;
		}
		return this;
	}

	/**
	 * Gets an existing texture frame and converts it into a base64 encoded image and returns the base64 data.
	 *
	 * You can also provide the image type and encoder options.
	 *
	 * This will only work with bitmap based texture frames, such as those created from Texture Atlases.
	 * It will not work with GL Texture objects, such as Shaders, or Render Textures. For those please
	 * see the WebGL Snapshot function instead.
	 *
	 * @since 1.0.0
	 *
	 * @param key - The unique string-based key of the Texture.
	 * @param frame - The string-based name, or integer based index, of the Frame to get from the Texture.
	 * @param type - [description]
	 * @param encoderOptions - [description]
	 *
	 * @return The base64 encoded data, or an empty string if the texture frame could not be found.
	**/
	public function getBase64(key:String, ?frame:StringOrInt, type:String = "image/png",
			encoderOptions:Float = 0.92)
	{
		var data = '';

		var textureFrame = getFrame(key, frame);

		if (textureFrame != null && (textureFrame.source.isRenderTexture || textureFrame.source.isGLTexture))
		{
			Console.warn('Cannot getBase64 from WebGL Texture');
		}
		else if (textureFrame != null)
		{
			var cd = textureFrame.canvasData;

			var canvas = CanvasPool.create2D(this, cast cd.width, cast cd.height);
			var ctx = canvas.getContext('2d');

			ctx.drawImage(textureFrame.source.image, cd.x, cd.y, cd.width, cd.height, 0,
				0, cd.width, cd.height);
			data = canvas.toDataURL(type, encoderOptions);
			CanvasPool.remove(canvas);
		}
		return data;
	}

	/**
	 * Adds a new Texture to the Texture Manager created from the given Image element.
	 *
	 * @since 1.0.0
	 *
	 * @param key - The unique string-based key of the Texture.
	 * @param source - The source Image element.
	 * @param dataSource - An optional data Image element.
	 *
	 * @return The Texture that was created, or `null` if the key is already in use.
	**/
	public function addImage(key:String, source:HTMLImageElement,
			dataSource:TextureSource.HtmlSource):Null<Texture>
	{
		var texture = null;

		if (checkKey(key))
		{
			texture = create(key, source);

			Parser.image(texture, 0);

			if (dataSource != null)
			{
				texture.setDataSource(dataSource);
			}

			emit(ADD, [key, texture]);
		}

		return texture;
	}

	/**
	 * Takes a WebGL Texture and creates a Phaser Texture from it, which is added to the Texture Manager using the given key.
	 *
	 * This allows you to then use the Texture as a normal texture for texture based Game Objects like Sprites.
	 *
	 * This is a WebGL only feature.
	 *
	 * @since 1.0.0
	 *
	 * @param key - The unique string-based key of the Texture.
	 * @param glTexture - The source Render Texture.
	 *
	 * @return The Texture that was created, or `null` if the key is already in use.
	**/
	public function addGLTexture(key:String, glTexture:WebGLTexture, ?width:Int,
			?height:Int)
	{
		var texture = null;

		if (checkKey(key))
		{
			texture = create(key, glTexture, width, height);

			texture.add("__BASE", 0, 0, 0, width, height);

			emit(ADD, [key, texture]);
		}

		return texture;
	}

	/**
	 * Adds a Render Texture to the Texture Manager using the given key.
	 * This allows you to then use the Render Texture as a normal texture for texture based Game Objects like Sprites.
	 *
	 * @since 1.0.0
	 *
	 * @param key - The unique string-based key of the Texture.
	 * @param renderTexture - The source Render Texture.
	 *
	 * @return The Texture that was created, or `null` if the key is already in use.
	**/
	public function addRenderTexture(key, renderTexture:RenderTexture)
	{
		var texture = null;
		if (checkKey(key))
		{
			texture = create(key, cast renderTexture);
			texture.add('__BASE', 0, 0, 0, renderTexture.width, renderTexture.height);
			emit(ADD, [key, texture]);
		}
		return texture;
	}

	/**
	 * Returns a Texture from the Texture Manager that matches the given key.
	 * If the key is undefined it will return the `__DEFAULT` Texture.
	 * If the key is given, but not found, it will return the `__MISSING` Texture.
	 *
	 * @since 1.0.0
	 *
	 * @param key - The unique string-based key of the Texture.
	 *
	 * @return The Texture that was created.
	**/
	public function get(key:String = "__DEFAULT"):Texture
	{
		if (list.exists(key))
		{
			return list[key];
		}
		else
		{
			return list['__MISSING'];
		}
	}

	/**
	 * Takes a Texture key and Frame name and returns a clone of that Frame if found.
	 *
	 * @since 1.0.0
	 *
	 * @param key - The unique string-based key of the Texture.
	 * @param frame - The string or index of the Frame to be cloned.
	 *
	 * @return A Clone of the given Frame.
	**/
	public function cloneFrame(key:String, frame:StringOrInt)
	{
		if (list.exists(key))
		{
			return this.list[key].get(frame).clone();
		}
		else
		{
			return null;
		}
	}

	/**
	 * Takes a Texture key and Frame name and returns a reference to that Frame, if found.
	 *
	 * @since 1.0.0
	 *
	 * @param key - The unique string-based key of the Texture.
	 * @param frame - The string-based name, or integer based index, of the Frame to get from the Texture.
	 *
	 * @return A Texture Frame object.
	**/
	public function getFrame(key:String, ?frame:StringOrInt):Null<Frame>
	{
		if (list.exists(key))
		{
			return list[key].get(frame);
		}
		else
		{
			return null;
		}
	}

	/**
	 * Checks the given key to see if a Texture using it exists within this Texture Manager.
	 *
	 * @method Phaser.Textures.TextureManager#exists
	 * @since 3.0.0
	 *
	 * @param key - The unique string-based key of the Texture.
	 *
	 * @return Returns `true` if a Texture matching the given key exists in this Texture Manager.
	**/
	public function exists(key:String):Bool
	{
		return list.exists(key);
	}

	/**
	 * Creates a new Texture using the given source and dimensions.
	 *
	 * @since 1.0.0
	 *
	 * @param key - The unique string-based key of the Texture.
	 * @param source - The source Image element.
	 * @param width - The width of the Texture.
	 * @param height - The height of the Texture.
	 *
	 * @return The Texture that was created, or `null` if the key is already in use.
	**/
	public function create(key:String, source:MultipleOrOne<TextureSource.HtmlSource>,
			?width:Int, ?height:Int):Null<Texture>
	{
		var texture = null;

		if (checkKey(key))
		{
			texture = new Texture(this, key, source, width, height);
			list[key] = texture;
		}

		return texture;
	}

	/**
	 * Destroys the Texture Manager and all Textures stored within it.
	 *
	 * @since 1.0.0
	**/
	public function destroy()
	{
		for (texture in list)
		{
			texture.destroy();
		}

		list.clear();
		game = null;
		CanvasPool.remove(_tempCanvas);
	}
}
