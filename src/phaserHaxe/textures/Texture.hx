package phaserHaxe.textures;

import haxe.ds.StringMap;
import phaserHaxe.utils.types.MultipleOrOne;
import phaserHaxe.utils.types.StringOrInt;
import phaserHaxe.utils.CustomData;
import haxe.ds.Map;

/**
 * A Texture consists of a source, usually an Image from the Cache, and a collection of Frames.
 * The Frames represent the different areas of the Texture. For example a texture atlas
 * may have many Frames, one for each element within the atlas. Where-as a single image would have
 * just one frame, that encompasses the whole image.
 *
 * Every Texture, no matter where it comes from, always has at least 1 frame called the `__BASE` frame.
 * This frame represents the entirety of the source image.
 *
 * Textures are managed by the global TextureManager. This is a singleton class that is
 * responsible for creating and delivering Textures and their corresponding Frames to Game Objects.
 *
 * Sprites and other Game Objects get the texture data they need from the TextureManager.
 *
 * @since 1.0.0
**/
class Texture
{
	private static inline var TEXTURE_MISSING_ERROR = "Texture.frame missing: ";

	/**
	 * A reference to the Texture Manager this Texture belongs to.
	 *
	 * @since 1.0.0
	**/
	public var manager:TextureManager;

	/**
	 * The unique string-based key of this Texture.
	 *
	 * @since 1.0.0
	**/
	public var key:String;

	/**
	 * An array of TextureSource instances.
	 * These are unique to this Texture and contain the actual Image (or Canvas) data.
	 *
	 * @since 1.0.0
	**/
	public var source:Array<TextureSource>;

	/**
	 * An array of TextureSource data instances.
	 * Used to store additional data images, such as normal maps or specular maps.
	 *
	 * @since 1.0.0
	**/
	public var dataSource:Array<Dynamic>;

	/**
	 * A key-value object pair associating the unique Frame keys with the Frames objects.
	 *
	 * @since 1.0.0
	**/
	public var frames:Map<String, Frame>;

	/**
	 * Any additional data that was set in the source JSON (if any),
	 * or any extra data you'd like to store relating to this texture
	 *
	 * @since 1.0.0
	**/
	public var customData:CustomData<Dynamic>;

	/**
	 * The name of the first frame of the Texture.
	 *
	 * @since 1.0.0
	**/
	public var firstFrame:String;

	/**
	 * The total number of Frames in this Texture, including the `__BASE` frame.
	 *
	 * A Texture will always contain at least 1 frame because every Texture contains a `__BASE` frame by default,
	 * in addition to any extra frames that have been added to it, such as when parsing a Sprite Sheet or Texture Atlas.
	 *
	 * @since 1.0.0
	**/
	public var frameTotal:Int;

	/**
	 * @param manager - A reference to the Texture Manager this Texture belongs to.
	 * @param key - The unique string-based key of this Texture.
	 * @param source - An array of sources that are used to create the texture. Usually Images, but can also be a Canvas.
	 * @param width - The width of the Texture. This is optional and automatically derived from the source images.
	 * @param height - The height of the Texture. This is optional and automatically derived from the source images.
	**/
	public function new(manager:TextureManager, key:String,
			source:MultipleOrOne<TextureSource.HtmlSource>, ?width:Int, ?height:Int)
	{
		this.manager = manager;

		this.key = key;

		this.source = [];

		this.dataSource = [];

		this.frames = new Map();

		this.customData = new CustomData();

		this.firstFrame = "__BASE";

		this.frameTotal = 0;

		//  Load the Sources
		if (source.isArray())
		{
			for (item in source.getArray())
			{
				this.source.push(new TextureSource(cast this, item, width, height));
			}
		}
		else
		{
			this.source.push(new TextureSource(cast this, source.getOne(), width, height));
		}
	}

	/**
	 * Adds a new Frame to this Texture.
	 *
	 * A Frame is a rectangular region of a TextureSource with a unique index or string-based key.
	 *
	 * The name given must be unique within this Texture. If it already exists, this method will return `null`.
	 *
	 * @since 1.0.0
	 *
	 * @param name - The name of this Frame. The name is unique within the Texture.
	 * @param sourceIndex - The index of the TextureSource that this Frame is a part of.
	 * @param x - The x coordinate of the top-left of this Frame.
	 * @param y - The y coordinate of the top-left of this Frame.
	 * @param width - The width of this Frame.
	 * @param height - The height of this Frame.
	 *
	 * @return The Frame that was added to this Texture, or `null` if the given name already exists.
	**/
	public function add(name:StringOrInt, sourceIndex:Int, x:Int, y:Int, width:Int,
			height:Int):Null<Frame>
	{
		if (has(name))
		{
			return null;
		}

		final name = name.forceString();

		var frame = new Frame(this, name, sourceIndex, x, y, width, height);

		frames.set(name, frame);

		//  Set the first frame of the Texture (other than __BASE)
		//  This is used to ensure we don't spam the display with entire
		//  atlases of sprite sheets, but instead just the first frame of them
		//  should the dev incorrectly specify the frame index
		if (firstFrame == '__BASE')
		{
			firstFrame = name;
		}

		frameTotal++;

		return frame;
	}

	/**
	 * Removes the given Frame from this Texture. The Frame is destroyed immediately.
	 *
	 * Any Game Objects using this Frame should stop using it _before_ you remove it,
	 * as it does not happen automatically.
	 *
	 * @since 1.0.0
	 *
	 * @param name - The key of the Frame to remove.
	 *
	 * @return True if a Frame with the matching key was removed from this Texture.
	**/
	public function remove(name:StringOrInt):Bool
	{
		if (has(name))
		{
			var frame = this.get(name);
			frame.destroy();
			frames.remove(name.forceString());
			return true;
		}
		return false;
	}

	/**
	 * Checks to see if a Frame matching the given key exists within this Texture.
	 *
	 * @since 1.0.0
	 *
	 * @param name - The key of the Frame to check for.
	 *
	 * @return True if a Frame with the matching key exists in this Texture.
	**/
	public function has(name:StringOrInt):Bool
	{
		return name != null && frames.exists(name.forceString());
	}

	/**
	 * Gets a Frame from this Texture based on either the key or the index of the Frame.
	 *
	 * In a Texture Atlas Frames are typically referenced by a key.
	 * In a Sprite Sheet Frames are referenced by an index.
	 * Passing no value for the name returns the base texture.
	 *
	 * @since 1.0.0
	 *
	 * @param name - The string-based name, or integer based index, of the Frame to get from this Texture.
	 *
	 * @return The Texture Frame.
	**/
	public function get(?name:StringOrInt):Frame
	{
		//  null, undefined, empty string, zero
		if (name == null)
		{
			name = firstFrame;
		}

		var frame = frames.get(name.forceString());
		if (frame == null)
		{
			Console.warn(TEXTURE_MISSING_ERROR + name.forceString());
			frame = frames.get(firstFrame);
		}

		return frame;
	}

	/**
	 * Takes the given TextureSource and returns the index of it within this Texture.
	 * If it's not in this Texture, it returns -1.
	 * Unless this Texture has multiple TextureSources, such as with a multi-atlas, this
	 * method will always return zero or -1.
	 *
	 * @since 1.0.0
	 *
	 * @param source - The TextureSource to check.
	 *
	 * @return The index of the TextureSource within this Texture, or -1 if not in this Texture.
	**/
	public function getTextureSourceIndex(source:TextureSource):Int
	{
		for (i in 0...this.source.length)
		{
			if (this.source[i] == source)
			{
				return i;
			}
		}
		return -1;
	}

	/**
	 * Returns an array of all the Frames in the given TextureSource.
	 *
	 * @since 1.0.0
	 *
	 * @param sourceIndex - The index of the TextureSource to get the Frames from.
	 * @param includeBase - Include the `__BASE` Frame in the output array?
	 *
	 * @return An array of Texture Frames.
	**/
	public function getFramesFromTextureSource(sourceIndex:Int,
			includeBase:Bool = false):Array<Frame>
	{
		var out = [];

		for (frameName => frame in frames)
		{
			if (frameName == "__BASE" && !includeBase)
			{
				continue;
			}

			if (frame.sourceIndex == sourceIndex)
			{
				out.push(frame);
			}
		}

		return out;
	}

	/**
	 * Returns an array with all of the names of the Frames in this Texture.
	 *
	 * Useful if you want to randomly assign a Frame to a Game Object, as you can
	 * pick a random element from the returned array.
	 *
	 * @since 1.0.0
	 *
	 * @param includeBase - Include the `__BASE` Frame in the output array?
	 *
	 * @return An array of all Frame names in this Texture.
	**/
	public function getFrameNames(includeBase = false):Array<String>
	{
		var out = [];

		for (frameName in frames.keys())
		{
			if (frameName == "__BASE" && !includeBase)
			{
				continue;
			}

			out.push(frameName);
		}

		return out;
	}

	/**
	 * Given a Frame name, return the source image it uses to render with.
	 *
	 * This will return the actual DOM Image or Canvas element.
	 *
	 * @since 1.0.0
	 *
	 * @param name - The string-based name, or integer based index, of the Frame to get from this Texture.
	 *
	 * @return The DOM Image, Canvas Element or Render Texture.
	**/
	public function getSourceImage(?name:StringOrInt):ImageData
	{
		final name:String = if (name == null || frameTotal == 1)
		{
			"__BASE";
		}
		else
		{
			name.forceString();
		}

		var frame = frames[name];

		if (frame != null)
		{
			return frame.source.image;
		}
		else
		{
			Console.warn(TEXTURE_MISSING_ERROR + name);
			return frames["__BASE"].source.image;
		}
	}

	/**
	 * Given a Frame name, return the data source image it uses to render with.
	 * You can use this to get the normal map for an image for example.
	 *
	 * This will return the actual DOM Image.
	 *
	 * @since 1.0.0
	 *
	 * @param name - The string-based name, or integer based index, of the Frame to get from this Texture.
	 *
	 * @return The DOM Image or Canvas Element.
	**/
	public function getDataSourceImage(name:StringOrInt)
	{
		final name:String = if (name == null || frameTotal == 1)
		{
			"__BASE";
		}
		else
		{
			name.forceString();
		}

		var frame = frames[name];
		var idx;

		if (frame == null)
		{
			Console.warn(TEXTURE_MISSING_ERROR + name);

			idx = frames["__BASE"].sourceIndex;
		}
		else
		{
			idx = frame.sourceIndex;
		}

		return dataSource[idx].image;
	}

	/**
	 * Adds a data source image to this Texture.
	 *
	 * An example of a data source image would be a normal map, where all of the Frames for this Texture
	 * equally apply to the normal map.
	 *
	 * @since 1.0.0
	 *
	 * @param data - The source image.
	**/
	public function setDataSource(data:MultipleOrOne<TextureSource.HtmlSource>)
	{
		final data:Array<TextureSource.HtmlSource> = if (data.isArray())
		{
			data.getArray();
		}
		else
		{
			[data.getOne()];
		}

		for (i in 0...data.length)
		{
			var source = source[i];
			dataSource.push(new TextureSource(this, data[i], source.width, source.height));
		}
	}

	/**
	 * Sets the Filter Mode for this Texture.
	 *
	 * The mode can be either Linear, the default, or Nearest.
	 *
	 * For pixel-art you should use Nearest.
	 *
	 * The mode applies to the entire Texture, not just a specific Frame of it.
	 *
	 * @since 1.0.0
	 *
	 * @param filterMode - The Filter Mode.
	**/
	public function setFilter(filterMode:FilterMode)
	{
		for (i in 0...source.length)
		{
			source[i].setFilter(filterMode);
		}

		for (i in 0...dataSource.length)
		{
			dataSource[i].setFilter(filterMode);
		}
	}

	/**
	 * Destroys this Texture and releases references to its sources and frames.
	 *
	 * @since 1.0.0
	**/
	public function destroy()
	{
		for (i in 0...source.length)
		{
			source[i].destroy();
		}

		for (i in 0...dataSource.length)
		{
			dataSource[i].destroy();
		}

		frames.clear();

		source = [];
		dataSource = [];
		frames = new Map();

		manager.removeKey(this.key);

		manager = null;
	}
}
