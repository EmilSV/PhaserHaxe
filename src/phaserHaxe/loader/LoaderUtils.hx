package phaserHaxe.loader;

class LoaderUtils
{
	/**
	 * Given a File and a baseURL value this returns the URL the File will use to download from.
	 *
	 * @since 1.0.0
	 *
	 * @param file - The File object.
	 * @param baseURL - A default base URL.
	 *
	 * @return The URL the File will use.
	**/
	public static function getUrl(file:File, baseURL:String):String
	{
		if (file.url == null)
		{
			return null;
		}

        final reg = (~/^(?:blob:|data:|http:\/\/|https:\/\/|\/\/)/);
        
        if(reg.match(file.url))
        {
            return file.url;
        }

		return baseURL + file.url;
	}
}
