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
}
