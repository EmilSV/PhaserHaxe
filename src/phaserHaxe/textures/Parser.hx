package phaserHaxe.textures;

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

		texture.add('__BASE', sourceIndex, 0, 0, source.width, source.height);

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
		throw new Error("not implemented");
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
			xml:Dynamic):Null<Texture>
	{
		throw new Error("not implemented");

		// //  Malformed?
		// if (!xml.getElementsByTagName('TextureAtlas'))
		// {
		// 	console.warn('Invalid Texture Atlas XML given');
		// 	return;
		// }

		// //  Add in a __BASE entry (for the entire atlas)
		// var source = texture.source[sourceIndex];

		// texture.add('__BASE', sourceIndex, 0, 0, source.width, source.height);

		// //  By this stage frames is a fully parsed array
		// var frames = xml.getElementsByTagName('SubTexture');

		// var newFrame;

		// for (var i = 0;
		// i < frames.length;
		// i++)
		// {
		// 	var frame = frames[i].attributes;

		// 	var name = frame.name.value;
		// 	var x = parseInt(frame.x.value, 10);
		// 	var y = parseInt(frame.y.value, 10);
		// 	var width = parseInt(frame.width.value, 10);
		// 	var height = parseInt(frame.height.value, 10);

		// 	//  The frame values are the exact coordinates to cut the frame out of the atlas from
		// 	newFrame = texture.add(name, sourceIndex, x, y, width, height);

		// 	//  These are the original (non-trimmed) sprite values
		// 	if (frame.frameX)
		// 	{
		// 		var frameX = Math.abs(parseInt(frame.frameX.value, 10));
		// 		var frameY = Math.abs(parseInt(frame.frameY.value, 10));
		// 		var frameWidth = parseInt(frame.frameWidth.value, 10);
		// 		var frameHeight = parseInt(frame.frameHeight.value, 10);

		// 		newFrame.setTrim(width, height, frameX, frameY, frameWidth, frameHeight);
		// 	}
		// }

		// return texture;
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
			yaml:Dynamic):Null<Texture>
	{
		throw new Error("not implemented");

		// //  Add in a __BASE entry (for the entire atlas)
		// var source = texture.source[sourceIndex];

		// texture.add('__BASE', sourceIndex, 0, 0, source.width, source.height);

		// imageHeight = source.height;

		// var data = yaml.split('\n');

		// var lineRegExp = /^[ ]*(- )*(\w+)+[: ]+(.*)/;

		// var prevSprite = '';
		// var currentSprite = '';
		// var rect = { x: 0, y: 0, width: 0, height: 0 };

		// // var pivot = { x: 0, y: 0 };
		// // var border = { x: 0, y: 0, z: 0, w: 0 };

		// for (var i = 0; i < data.length; i++)
		// {
		// 	var results = data[i].match(lineRegExp);

		// 	if (!results)
		// 	{
		// 		continue;
		// 	}

		// 	var isList = (results[1] === '- ');
		// 	var key = results[2];
		// 	var value = results[3];

		// 	if (isList)
		// 	{
		// 		if (currentSprite !== prevSprite)
		// 		{
		// 			addFrame(texture, sourceIndex, currentSprite, rect);

		// 			prevSprite = currentSprite;
		// 		}

		// 		rect = { x: 0, y: 0, width: 0, height: 0 };
		// 	}

		// 	if (key === 'name')
		// 	{
		// 		//  Start new list
		// 		currentSprite = value;
		// 		continue;
		// 	}

		// 	switch (key)
		// 	{
		// 		case 'x':
		// 		case 'y':
		// 		case 'width':
		// 		case 'height':
		// 			rect[key] = parseInt(value, 10);
		// 			break;

		// 		// case 'pivot':
		// 		//     pivot = eval('var obj = ' + value);
		// 		//     break;

		// 		// case 'border':
		// 		//     border = eval('var obj = ' + value);
		// 		//     break;
		// 	}
		// }

		// if (currentSprite !== prevSprite)
		// {
		// 	addFrame(texture, sourceIndex, currentSprite, rect);
		// }

		// return texture;
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
		throw new Error("not implemented");

		// var frameWidth = GetFastValue(config, 'frameWidth', null);
		// var frameHeight = GetFastValue(config, 'frameHeight', frameWidth);

		// //  If missing we can't proceed
		// if (frameWidth == = null)
		// {
		// 	throw new Error('TextureManager.SpriteSheet: Invalid frameWidth given.');
		// }

		// //  Add in a __BASE entry (for the entire atlas)
		// var source = texture.source[sourceIndex];

		// texture.add('__BASE', sourceIndex, 0, 0, source.width, source.height);

		// var startFrame = GetFastValue(config, 'startFrame', 0);
		// var endFrame = GetFastValue(config, 'endFrame', -1);
		// var margin = GetFastValue(config, 'margin', 0);
		// var spacing = GetFastValue(config, 'spacing', 0);

		// var row = Math.floor((width - margin + spacing) / (frameWidth + spacing));
		// var column = Math.floor((height - margin + spacing) / (frameHeight + spacing));
		// var total = row * column;

		// if (total == = 0)
		// {
		// 	console.warn('SpriteSheet frame dimensions will result in zero frames.');
		// }

		// if (startFrame > total || startFrame < -total)
		// {
		// 	startFrame = 0;
		// }

		// if (startFrame < 0)
		// {
		// 	//  Allow negative skipframes.
		// 	startFrame = total + startFrame;
		// }

		// if (endFrame != = -1)
		// {
		// 	total = startFrame + (endFrame + 1);
		// }

		// var fx = margin;
		// var fy = margin;
		// var ax = 0;
		// var ay = 0;

		// for (var i = 0;
		// i < total;
		// i++)
		// {
		// 	ax = 0;
		// 	ay = 0;

		// 	var w = fx + frameWidth;
		// 	var h = fy + frameHeight;

		// 	if (w > width)
		// 	{
		// 		ax = w - width;
		// 	}

		// 	if (h > height)
		// 	{
		// 		ay = h - height;
		// 	}

		// 	texture.add(i, sourceIndex, x + fx, y + fy, frameWidth - ax, frameHeight - ay);

		// 	fx += frameWidth + spacing;

		// 	if (fx + frameWidth > width)
		// 	{
		// 		fx = margin;
		// 		fy += frameHeight + spacing;
		// 	}
		// }

		// return texture;
	}

	/**
	 * Parses a Sprite Sheet and adds the Frames to the Texture, where the Sprite Sheet is stored as a frame within an Atlas.
	 *
	 * In Phaser terminology a Sprite Sheet is a texture containing different frames, but each frame is the exact
	 * same size and cannot be trimmed or rotated.
	 *
	 * @since 1.0.0
	 *
	 * @param {Phaser.Textures.Texture} texture - The Texture to add the Frames to.
	 * @param {Phaser.Textures.Frame} frame - The Frame that contains the Sprite Sheet.
	 * @param {object} config - An object describing how to parse the Sprite Sheet.
	 *
	 * @return The Texture modified by this parser.
	**/
	public static function spriteSheetFromAtlas(texture:Texture, frame:Frame,
			config:SpriteSheetFromAtlasConfig):Null<Texture>
	{
		throw new Error("not implemented");

		// var frameWidth = GetFastValue(config, 'frameWidth', null);
		// var frameHeight = GetFastValue(config, 'frameHeight', frameWidth);

		// //  If missing we can't proceed
		// if (!frameWidth)
		// {
		// 	throw new Error('TextureManager.SpriteSheetFromAtlas: Invalid frameWidth given.');
		// }

		// //  Add in a __BASE entry (for the entire atlas frame)
		// var source = texture.source[0];
		// texture.add('__BASE', 0, 0, 0, source.width, source.height);

		// var startFrame = GetFastValue(config, 'startFrame', 0);
		// var endFrame = GetFastValue(config, 'endFrame', -1);
		// var margin = GetFastValue(config, 'margin', 0);
		// var spacing = GetFastValue(config, 'spacing', 0);

		// var x = frame.cutX;
		// var y = frame.cutY;

		// var cutWidth = frame.cutWidth;
		// var cutHeight = frame.cutHeight;
		// var sheetWidth = frame.realWidth;
		// var sheetHeight = frame.realHeight;

		// var row = Math.floor((sheetWidth - margin + spacing) / (frameWidth + spacing));
		// var column = Math.floor((sheetHeight - margin + spacing) / (frameHeight + spacing));
		// var total = row * column;

		// //  trim offsets

		// var leftPad = frame.x;
		// var leftWidth = frameWidth - leftPad;

		// var rightWidth = frameWidth - ((sheetWidth - cutWidth) - leftPad);

		// var topPad = frame.y;
		// var topHeight = frameHeight - topPad;

		// var bottomHeight = frameHeight - ((sheetHeight - cutHeight) - topPad);

		// if (startFrame > total || startFrame < -total)
		// {
		// 	startFrame = 0;
		// }

		// if (startFrame < 0)
		// {
		// 	//  Allow negative skipframes.
		// 	startFrame = total + startFrame;
		// }

		// if (endFrame !== -1)
		// {
		// 	total = startFrame + (endFrame + 1);
		// }

		// var sheetFrame;
		// var frameX = margin;
		// var frameY = margin;
		// var frameIndex = 0;
		// var sourceIndex = frame.sourceIndex;

		// for (var sheetY = 0; sheetY < column; sheetY++)
		// {
		// 	var topRow = (sheetY === 0);
		// 	var bottomRow = (sheetY === column - 1);

		// 	for (var sheetX = 0; sheetX < row; sheetX++)
		// 	{
		// 		var leftRow = (sheetX === 0);
		// 		var rightRow = (sheetX === row - 1);

		// 		sheetFrame = texture.add(frameIndex, sourceIndex, x + frameX, y + frameY, frameWidth, frameHeight);

		// 		if (leftRow || topRow || rightRow || bottomRow)
		// 		{
		// 			var destX = (leftRow) ? leftPad : 0;
		// 			var destY = (topRow) ? topPad : 0;

		// 			var trimWidth = 0;
		// 			var trimHeight = 0;

		// 			if (leftRow)
		// 			{
		// 				trimWidth += (frameWidth - leftWidth);
		// 			}

		// 			if (rightRow)
		// 			{
		// 				trimWidth += (frameWidth - rightWidth);
		// 			}

		// 			if (topRow)
		// 			{
		// 				trimHeight += (frameHeight - topHeight);
		// 			}

		// 			if (bottomRow)
		// 			{
		// 				trimHeight += (frameHeight - bottomHeight);
		// 			}

		// 			var destWidth = frameWidth - trimWidth;
		// 			var destHeight = frameHeight - trimHeight;

		// 			sheetFrame.cutWidth = destWidth;
		// 			sheetFrame.cutHeight = destHeight;

		// 			sheetFrame.setTrim(frameWidth, frameHeight, destX, destY, destWidth, destHeight);
		// 		}

		// 		frameX += spacing;

		// 		if (leftRow)
		// 		{
		// 			frameX += leftWidth;
		// 		}
		// 		else if (rightRow)
		// 		{
		// 			frameX += rightWidth;
		// 		}
		// 		else
		// 		{
		// 			frameX += frameWidth;
		// 		}

		// 		frameIndex++;
		// 	}

		// 	frameX = margin;
		// 	frameY += spacing;

		// 	if (topRow)
		// 	{
		// 		frameY += topHeight;
		// 	}
		// 	else if (bottomRow)
		// 	{
		// 		frameY += bottomHeight;
		// 	}
		// 	else
		// 	{
		// 		frameY += frameHeight;
		// 	}
		// }

		// return texture;
	}
}
