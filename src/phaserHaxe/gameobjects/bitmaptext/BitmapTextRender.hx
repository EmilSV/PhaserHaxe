package phaserHaxe.gameobjects.bitmaptext;

import phaserHaxe.renderer.webgl.WebGLRenderer;
import phaserHaxe.gameobjects.components.TransformMatrix;
import phaserHaxe.cameras.scene2D.Camera;
import phaserHaxe.renderer.canvas.CanvasRenderer;
import phaserHaxe.renderer.canvas.Utils.CanvasUtils;

final class BitmapTextRender
{
	/**
	 * Renders this Game Object with the Canvas Renderer to the given Camera.
	 * The object will not render if any of its renderFlags are set or it is being actively filtered out by the Camera.
	 * This method should not be called directly. It is a utility function of the Render module.
	 *
	 * @since 1.0.0
	 *
	 * @param renderer - A reference to the current active Canvas renderer.
	 * @param src - The Game Object being rendered in this call.
	 * @param interpolationPercentage - Reserved for future use and custom pipelines.
	 * @param camera - The Camera that is rendering the Game Object.
	 * @param parentMatrix - This transform matrix is defined if the game object is nested
	**/
	public static function bitmapTextCanvasRenderer(renderer:CanvasRenderer,
			src:BitmapText, interpolationPercentage:Float, camera:Camera,
			parentMatrix:TransformMatrix):Void
	{
		var text = src.text;
		var textLength = text.length;

		var ctx = renderer.currentContext;

		if (textLength == 0 || !CanvasUtils.setTransform(renderer, ctx, src, camera, parentMatrix))
		{
			return;
		}

		var textureFrame = src.frame;

		var chars = src.fontData.chars;
		var lineHeight = src.fontData.lineHeight;
		var letterSpacing = src.letterSpacing;

		var xAdvance:Float = 0;
		var yAdvance:Float = 0;

		var charCode = 0;

		var glyph = null;
		var glyphX:Float = 0;
		var glyphY:Float = 0;
		var glyphW:Float = 0;
		var glyphH:Float = 0;

		var x:Float = 0;
		var y:Float = 0;

		var lastGlyph = null;
		var lastCharCode = 0;

		var image = src.frame.source.image;

		var textureX = textureFrame.cutX;
		var textureY = textureFrame.cutY;

		var scale = (src.fontSize / src.fontData.size);

		var align = src.align;
		var currentLine = 0;
		var lineOffsetX:Float = 0;

		//  Update the bounds - skipped internally if not dirty
		src.getTextBounds(false);

		var lineData = src._bounds.lines;

		if (align == 1)
		{
			lineOffsetX = (lineData.longest - lineData.lengths[0]) / 2;
		}
		else if (align == 2)
		{
			lineOffsetX = (lineData.longest - lineData.lengths[0]);
		}

		ctx.translate(-src.displayOriginX, -src.displayOriginY);

		var roundPixels = camera.roundPixels;

		for (i in 0...textLength)
		{
			charCode = text.charCodeAt(i);

			if (charCode == 10)
			{
				currentLine++;

				if (align == 1)
				{
					lineOffsetX = (lineData.longest - lineData.lengths[currentLine]) / 2;
				}
				else if (align == 2)
				{
					lineOffsetX = (lineData.longest - lineData.lengths[currentLine]);
				}

				xAdvance = 0;
				yAdvance += lineHeight;
				lastGlyph = null;

				continue;
			}

			glyph = chars[charCode];

			if (glyph == null)
			{
				continue;
			}

			glyphX = textureX + glyph.x;
			glyphY = textureY + glyph.y;

			glyphW = glyph.width;
			glyphH = glyph.height;

			x = glyph.xOffset + xAdvance;
			y = glyph.yOffset + yAdvance;

			if (lastGlyph != null)
			{
				var kerningOffset = glyph.kerning[lastCharCode];
				x += (kerningOffset != null) ? kerningOffset : 0;
			}

			x *= scale;
			y *= scale;

			x += lineOffsetX;

			xAdvance += glyph.xAdvance + letterSpacing;
			lastGlyph = glyph;
			lastCharCode = charCode;

			//  Nothing to render or a space? Then skip to the next glyph
			if (glyphW == 0 || glyphH == 0 || charCode == 32)
			{
				continue;
			}

			if (roundPixels)
			{
				x = Math.round(x);
				y = Math.round(y);
			}

			ctx.save();

			ctx.translate(x, y);

			ctx.scale(scale, scale);

			ctx.drawImage(cast image, glyphX, glyphY, glyphW, glyphH, 0.0, 0.0, glyphW,
				glyphH);

			ctx.restore();
		}

		ctx.restore();
	}

	public static function bitmapTextWebGLRenderer(self:BitmapText,
			renderer:WebGLRenderer, src:BitmapText, interpolationPercentage:Float,
			camera:Camera, parentMatrix:TransformMatrix)
	{
		throw new Error("Not Implemented");
	}
}
