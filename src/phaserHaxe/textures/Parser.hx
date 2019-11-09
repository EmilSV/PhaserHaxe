package phaserHaxe.textures;

import phaserHaxe.math.MathInt;
import phaserHaxe.geom.Rectangle;
import phaserHaxe.utils.CustomData;

private typedef JsonData =
{
	var ?textures:Array<JsonSource>;
	var ?frames:Array<JsonFrame>;
};

private typedef JsonSource =
{
	var ?frames:Array<JsonFrame>;
};

private typedef JsonFrame =
{
	var ?filename:String;
	var ?frame:JsonFrameDimensions;
	var ?sourceSize:JsonSourceSize;
	var ?spriteSourceSize:JsonSpriteSourceSize;
	var ?anchor:JsonAnchor;
	var ?trimmed:Bool;
	var ?rotated:Bool;
};

private typedef JsonFrameDimensions =
{
	var ?x:Float;
	var ?y:Float;
	var ?w:Float;
	var ?h:Float;
};

private typedef JsonSourceSize =
{
	var ?w:Float;
	var ?h:Float;
};

private typedef JsonSpriteSourceSize =
{
	var ?x:Float;
	var ?y:Float;
	var ?w:Float;
	var ?h:Float;
};

private typedef JsonAnchor =
{
	var ?x:Float;
	var ?y:Float;
};

final class Parser
{
	/**
	 * Adds an Image Element to a Texture.
	 *
	 * @since 1.0.0
	 *
	 * @param texture - The Texture to add the Frames to.
	 * @param sourceIndex - The index of the TextureSource.
	 *
	 * @return The Texture modified by this parser.
	**/
	public static function image(texture:Texture, sourceIndex:Int):Texture
	{
		var source = texture.source[sourceIndex];

		texture.add("__BASE", sourceIndex, 0, 0, source.width, source.height);

		return texture;
	}

	/**
	 * Parses a Texture Atlas JSON Array and adds the Frames to the Texture.
	 * JSON format expected to match that defined by Texture Packer, with the frames property containing an array of Frames.
	 *
	 * @since 1.0.0
	 *
	 * @param texture - The Texture to add the Frames to.
	 * @param sourceIndex - The index of the TextureSource.
	 * @param json - The JSON data.
	 *
	 * @return The Texture modified by this parser.
	**/
	public static function jsonArray(texture:Texture, sourceIndex:Int,
			json:Dynamic):Null<Texture>
	{
		final json:JsonData = json;

		if (json.frames == null && json.textures == null)
		{
			Console.warn("Invalid Texture Atlas JSON Array");
			return null;
		}

		//  Add in a __BASE entry (for the entire atlas)
		var source = texture.source[sourceIndex];

		texture.add("__BASE", sourceIndex, 0, 0, source.width, source.height);

		var frames = Std.is(json.textures, Array) ? json.textures[sourceIndex].frames : json.frames;

		var newFrame;

		for (i in 0...frames.length)
		{
			var src = frames[i];

			//  The frame values are the exact coordinates to cut the frame out of the atlas from
			newFrame = texture.add(src.filename, sourceIndex, Std.int(src.frame.x), Std.int(src.frame.y), Std.int(src.frame.w), Std.int(src.frame.h));

			//  These are the original (non-trimmed) sprite values
			if (src.trimmed)
			{
				newFrame.setTrim(Std.int(src.sourceSize.w), Std.int(src.sourceSize.h),
					Std.int(src.spriteSourceSize.x), Std.int(src.spriteSourceSize.y),
					Std.int(src.spriteSourceSize.w), Std.int(src.spriteSourceSize.h));
			}

			if (src.rotated)
			{
				newFrame.rotated = true;
				newFrame.updateUVsInverted();
			}

			if (src.anchor != null)
			{
				newFrame.customPivot = true;
				newFrame.pivotX = Std.int(src.anchor.x);
				newFrame.pivotY = Std.int(src.anchor.y);
			}

			//  Copy over any extra data
			newFrame.customData = CustomData.createFromDynamic(src);
		}

		//  Copy over any additional data that was in the JSON to Texture.customData
		CustomData.assignFromDynamic(texture.customData, json, (name) -> name != "frames");

		return texture;
	}

	/**
	 * Parses a Texture Atlas JSON Hash and adds the Frames to the Texture.
	 * JSON format expected to match that defined by Texture Packer, with the frames property containing an object of Frames.
	 *
	 * @since 1.0.0
	 *
	 * @param texture - The Texture to add the Frames to.
	 * @param sourceIndex - The index of the TextureSource.
	 * @param json - The JSON data.
	 *
	 * @return The Texture modified by this parser.
	 */
	public static function jsonHash(texture:Texture, sourceIndex:Int,
			json:Dynamic):Null<Texture>
	{
		throw new Error("not implemented");
	}

	/**
	 * Parses an XML Texture Atlas object and adds all the Frames into a Texture.
	 *
	 * @since 1.0.0
	 *
	 * @param texture - The Texture to add the Frames to.
	 * @param sourceIndex - The index of the TextureSource.
	 * @param xml - The XML data.
	 *
	 * @return The Texture modified by this parser.
	**/
	public static function atlasXML(texture:Texture, sourceIndex:Int,
			xml:Xml):Null<Texture>
	{
		inline function parseInt(value:String, defaultValue:Int = 0):Int
		{
			var n = Std.parseInt(value);
			if (n != null)
			{
				return n;
			}
			else
			{
				return defaultValue;
			}
		}

		//  Malformed?
		if (!xml.elementsNamed("TextureAtlas").hasNext())
		{
			Console.warn("Invalid Texture Atlas XML given");
			return null;
		}

		//  Add in a __BASE entry (for the entire atlas)
		var source = texture.source[sourceIndex];

		texture.add("__BASE", sourceIndex, 0, 0, source.width, source.height);

		//  By this stage frames is a fully parsed array
		var frames = xml.elementsNamed("SubTexture");

		var newFrame:Frame;

		for (frame in frames)
		{
			var name = frame.get("name");
			var x = parseInt(frame.get("x"), 10);
			var y = parseInt(frame.get("y"), 10);
			var width = parseInt(frame.get("width"), 10);
			var height = parseInt(frame.get("height"), 10);

			//  The frame values are the exact coordinates to cut the frame out of the atlas from
			newFrame = texture.add(name, sourceIndex, x, y, width, height);

			//  These are the original (non-trimmed) sprite values
			if (frame.get("frameX") != null)
			{
				var frameX = MathInt.abs(parseInt(frame.get("frameX"), 10));
				var frameY = MathInt.abs(parseInt(frame.get("frameY"), 10));
				var frameWidth = parseInt(frame.get("width"), 10);
				var frameHeight = parseInt(frame.get("frameHeight"), 10);

				newFrame.setTrim(width, height, frameX, frameY, frameWidth, frameHeight);
			}
		}

		return texture;
	}

	/**
	 * Parses a Unity YAML File and creates Frames in the Texture.
	 * For more details about Sprite Meta Data see https://docs.unity3d.com/ScriptReference/SpriteMetaData.html
	 *
	 * @since 1.0.0
	 *
	 * @param texture - The Texture to add the Frames to.
	 * @param sourceIndex - The index of the TextureSource.
	 * @param yaml - The YAML data.
	 *
	 * @return The Texture modified by this parser.
	**/
	public static function unityYAML(texture:Texture, sourceIndex:Int,
			yaml:String):Null<Texture>
	{
		var imageHeight;

		inline function addFrame(texture:Texture, sourceIndex:Int, name:String,
				frame:Rectangle)
		{
			var y = imageHeight - frame.y - frame.height;

			texture.add(name, sourceIndex, Std.int(frame.x), Std.int(y), Std.int(frame.width), Std.int(frame.height));
		}

		inline function parseInt(value:String, defaultValue:Int = 0):Int
		{
			var n = Std.parseInt(value);
			if (n != null)
			{
				return n;
			}
			else
			{
				return defaultValue;
			}
		}

		//  Add in a __BASE entry (for the entire atlas)
		var source = texture.source[sourceIndex];

		texture.add("__BASE", sourceIndex, 0, 0, source.width, source.height);

		imageHeight = source.height;

		var data = yaml.split("\n");

		var lineRegExp = ~/^[ ]*(- )*(\w+)+[: ]+(.*)/;

		var prevSprite = "";
		var currentSprite = "";
		var rect:Rectangle = {
			x: 0,
			y: 0,
			width: 0,
			height: 0
		};

		for (i in 0...data.length)
		{
			var results = lineRegExp.split(data[i]);

			if (results == null)
			{
				continue;
			}

			var isList = (results[1] == "- ");
			var key = results[2];
			var value = results[3];

			if (isList)
			{
				if (currentSprite != prevSprite)
				{
					addFrame(texture, sourceIndex, currentSprite, rect);

					prevSprite = currentSprite;
				}

				rect = {
					x: 0,
					y: 0,
					width: 0,
					height: 0
				};
			}

			if (key == "name")
			{
				//  Start new list
				currentSprite = value;
				continue;
			}

			switch (key)
			{
				case "x":
					rect.x = parseInt(value, 10);
				case "y":
					rect.y = parseInt(value, 10);
				case "width":
					rect.width = parseInt(value, 10);
				case "height":
					rect.height = parseInt(value, 10);
			}
		}

		if (currentSprite != prevSprite)
		{
			addFrame(texture, sourceIndex, currentSprite, rect);
		}

		return texture;
	}

	/**
	 * Parses a Sprite Sheet and adds the Frames to the Texture, where the Sprite Sheet is stored as a frame within an Atlas.
	 *
	 * In Phaser terminology a Sprite Sheet is a texture containing different frames, but each frame is the exact
	 * same size and cannot be trimmed or rotated.
	 *
	 * @since 1.0.0
	 *
	 * @param texture - The Texture to add the Frames to.
	 * @param frame - The Frame that contains the Sprite Sheet.
	 * @param config - An object describing how to parse the Sprite Sheet.
	 *
	 * @return The Texture modified by this parser.
	**/
	public static function spriteSheet(texture:Texture, sourceIndex:Int, x:Int, y:Int,
			width:Int, height:Int, config:SpriteSheetConfig):Null<Texture>
	{
		inline function getValue<T>(value:T, defaultValue:T)
		{
			return value != null ? value : defaultValue;
		}

		var frameWidth = config.frameWidth;
		var frameHeight = getValue(config.frameHeight, frameWidth);

		//  If missing we can't proceed
		if (frameWidth == null)
		{
			throw new Error("TextureManager.SpriteSheet: Invalid frameWidth given.");
		}

		//  Add in a __BASE entry (for the entire atlas)
		var source = texture.source[sourceIndex];

		texture.add("__BASE", sourceIndex, 0, 0, source.width, source.height);

		var startFrame = getValue(config.startFrame, 0);
		var endFrame = getValue(config.endFrame, -1);
		var margin = getValue(config.margin, 0);
		var spacing = getValue(config.spacing, 0);

		var row = Math.floor((width - margin + spacing) / (frameWidth + spacing));
		var column = Math.floor((height - margin + spacing) / (frameHeight + spacing));
		var total = row * column;

		if (total == 0)
		{
			Console.warn("SpriteSheet frame dimensions will result in zero frames.");
		}

		if (startFrame > total || startFrame < -total)
		{
			startFrame = 0;
		}

		if (startFrame < 0)
		{
			//  Allow negative skipframes.
			startFrame = total + startFrame;
		}

		if (endFrame != -1)
		{
			total = startFrame + (endFrame + 1);
		}

		var fx = margin;
		var fy = margin;
		var ax = 0;
		var ay = 0;

		for (i in 0...total)
		{
			ax = 0;
			ay = 0;

			var w = fx + frameWidth;
			var h = fy + frameHeight;

			if (w > width)
			{
				ax = w - width;
			}

			if (h > height)
			{
				ay = h - height;
			}

			texture.add(i, sourceIndex, x + fx, y + fy, frameWidth - ax, frameHeight - ay);

			fx += frameWidth + spacing;

			if (fx + frameWidth > width)
			{
				fx = margin;
				fy += frameHeight + spacing;
			}
		}

		return texture;
	}

	/**
	 * Parses a Sprite Sheet and adds the Frames to the Texture, where the Sprite Sheet is stored as a frame within an Atlas.
	 *
	 * In Phaser terminology a Sprite Sheet is a texture containing different frames, but each frame is the exact
	 * same size and cannot be trimmed or rotated.
	 *
	 * @since 1.0.0
	 *
	 * @param texture - The Texture to add the Frames to.
	 * @param frame - The Frame that contains the Sprite Sheet.
	 * @param config - An object describing how to parse the Sprite Sheet.
	 *
	 * @return The Texture modified by this parser.
	**/
	public static function spriteSheetFromAtlas(texture:Texture, frame:Frame,
			config:SpriteSheetFromAtlasConfig):Null<Texture>
	{
		inline function getValue<T>(value:T, defaultValue:T)
		{
			return value != null ? value : defaultValue;
		}

		var frameWidth = config.frameWidth;
		var frameHeight = getValue(config.frameHeight, frameWidth);

		//  If missing we can't proceed
		if (frameWidth == null)
		{
			throw new Error("TextureManager.SpriteSheetFromAtlas: Invalid frameWidth given.");
		}

		//  Add in a __BASE entry (for the entire atlas frame)
		var source = texture.source[0];
		texture.add("__BASE", 0, 0, 0, source.width, source.height);

		var startFrame = getValue(config.startFrame, 0);
		var endFrame = getValue(config.endFrame, -1);
		var margin = getValue(config.margin, 0);
		var spacing = getValue(config.spacing, 0);

		var x = frame.cutX;
		var y = frame.cutY;

		var cutWidth = frame.cutWidth;
		var cutHeight = frame.cutHeight;
		var sheetWidth = frame.realWidth;
		var sheetHeight = frame.realHeight;

		var row = Math.floor((sheetWidth - margin + spacing) / (frameWidth + spacing));
		var column = Math.floor((sheetHeight - margin + spacing) / (frameHeight +
			spacing));
		var total = row * column;

		// trim offsets

		var leftPad = frame.x;
		var leftWidth = frameWidth - leftPad;

		var rightWidth = frameWidth - ((sheetWidth - cutWidth) - leftPad);

		var topPad = frame.y;
		var topHeight = frameHeight - topPad;

		var bottomHeight = frameHeight - ((sheetHeight - cutHeight) - topPad);

		if (startFrame > total || startFrame < -total)
		{
			startFrame = 0;
		}

		if (startFrame < 0)
		{
			//  Allow negative skipframes.
			startFrame = total + startFrame;
		}

		if (endFrame != -1)
		{
			total = startFrame + (endFrame + 1);
		}

		var sheetFrame;
		var frameX = margin;
		var frameY = margin;
		var frameIndex = 0;
		var sourceIndex = frame.sourceIndex;

		for (sheetY in 0...column)
		{
			var topRow = (sheetY == 0);
			var bottomRow = (sheetY == column - 1);

			for (sheetX in 0...row)
			{
				var leftRow = (sheetX == 0);
				var rightRow = (sheetX == row - 1);

				sheetFrame = texture.add(frameIndex, sourceIndex, x + frameX, y + frameY, frameWidth, frameHeight);

				if (leftRow || topRow || rightRow || bottomRow)
				{
					var destX = (leftRow) ? leftPad : 0;
					var destY = (topRow) ? topPad : 0;

					var trimWidth = 0;
					var trimHeight = 0;

					if (leftRow)
					{
						trimWidth += (frameWidth - leftWidth);
					}

					if (rightRow)
					{
						trimWidth += Std.int(frameWidth - rightWidth);
					}

					if (topRow)
					{
						trimHeight += (frameHeight - topHeight);
					}

					if (bottomRow)
					{
						trimHeight += Std.int(frameHeight - bottomHeight);
					}

					var destWidth = frameWidth - trimWidth;
					var destHeight = frameHeight - trimHeight;

					sheetFrame.cutWidth = destWidth;
					sheetFrame.cutHeight = destHeight;

					sheetFrame.setTrim(frameWidth, frameHeight, destX, destY, destWidth, destHeight);
				}

				frameX += spacing;

				if (leftRow)
				{
					frameX += leftWidth;
				}
				else if (rightRow)
				{
					frameX += Std.int(rightWidth);
				}
				else
				{
					frameX += frameWidth;
				}

				frameIndex++;
			}

			frameX = margin;
			frameY += spacing;

			if (topRow)
			{
				frameY += topHeight;
			}
			else if (bottomRow)
			{
				frameY += Std.int(bottomHeight);
			}
			else
			{
				frameY += frameHeight;
			}
		}

		return texture;
	}
}
