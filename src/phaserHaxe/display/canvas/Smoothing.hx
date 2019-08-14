package phaserHaxe.display.canvas;

#if js
import js.Syntax as JsSyntax;
import phaserHaxe.Either;
import js.html.CanvasRenderingContext2D;
import js.html.webgl.WebGL2RenderingContext;

/**
 * @since 1.0.0
**/
final class Smoothing
{
	public static inline var isSupported = true;

	private static var prefix = '';

	public static function getPrefix(context:Either<CanvasRenderingContext2D,
		WebGL2RenderingContext>):String
	{
		js.Syntax.code("        
        var vendors = [ 'i', 'webkitI', 'msI', 'mozI', 'oI' ];
        for (var i = 0; i < vendors.length; i++)
        {
            var s = vendors[i] + 'mageSmoothingEnabled';

            if (s in {0})
            {
                return s;
            }
        }", context);

		return null;
	}

	/**
	 * Sets the Image Smoothing property on the given context. Set to false to disable image smoothing.
	 * By default browsers have image smoothing enabled, which isn't always what you visually want, especially
	 * when using pixel art in a game. Note that this sets the property on the context itself, so that any image
	 * drawn to the context will be affected. This sets the property across all current browsers but support is
	 * patchy on earlier browsers, especially on mobile.
	 *
	 * @since 1.0.0
	 *
	 * @param context - The context on which to enable smoothing.
	 *
	 * @return The provided context.
	**/
	public static function enable<T:Either<CanvasRenderingContext2D,
		WebGL2RenderingContext>>(context:T):T
	{
		if (JsSyntax.strictEq(prefix, ""))
		{
			prefix = getPrefix(context);
		}

		if (JsSyntax.code("{0}", prefix))
		{
			JsSyntax.code("{0}[{1}] = true", context, prefix);
		}

		return context;
	}

	/**
	 * Sets the Image Smoothing property on the given context. Set to false to disable image smoothing.
	 * By default browsers have image smoothing enabled, which isn't always what you visually want, especially
	 * when using pixel art in a game. Note that this sets the property on the context itself, so that any image
	 * drawn to the context will be affected. This sets the property across all current browsers but support is
	 * patchy on earlier browsers, especially on mobile.
	 *
	 * @since 1.0.0
	 *
	 * @param context - The context on which to disable smoothing.
	 *
	 * @return The provided context.
	**/
	public static function disable<T:Either<CanvasRenderingContext2D,
		WebGL2RenderingContext>>(context:T):T
	{
		if (JsSyntax.strictEq(prefix, ""))
		{
			prefix = getPrefix(context);
		}

		if (JsSyntax.code("{0}", prefix))
		{
			JsSyntax.code("{0}[{1}] = false", context, prefix);
		}

		return context;
	}

	/**
	 * Returns `true` if the given context has image smoothing enabled, otherwise returns `false`.
	 * Returns null if no smoothing prefix is available.
	 *
	 * @since 1.0.0
	 *
	 * @param  context - The context to check.
	 *
	 * @return `true` if smoothing is enabled on the context, otherwise `false`. `null` if not supported.
	**/
	function isEnabled(context:Either<CanvasRenderingContext2D,
		WebGL2RenderingContext>):Null<Bool>
	{
		return (JsSyntax.strictEq(prefix, null)) ? JsSyntax.field(context, prefix) : null;
	}
}
#else

/**
 * @since 1.0.0
**/
final class Smoothing
{
	public static inline var isSupported = false;

	public static function getPrefix(context:Dynamic):String
		throw "Not Implemented";

	/**
	 * Sets the Image Smoothing property on the given context. Set to false to disable image smoothing.
	 * By default browsers have image smoothing enabled, which isn't always what you visually want, especially
	 * when using pixel art in a game. Note that this sets the property on the context itself, so that any image
	 * drawn to the context will be affected. This sets the property across all current browsers but support is
	 * patchy on earlier browsers, especially on mobile.
	 *
	 * @since 1.0.0
	 *
	 * @param context - The context on which to enable smoothing.
	 *
	 * @return The provided context.
	**/
	public static function enable(context:Dynamic):Dynamic
		throw "Not Implemented";

	/**
	 * Sets the Image Smoothing property on the given context. Set to false to disable image smoothing.
	 * By default browsers have image smoothing enabled, which isn't always what you visually want, especially
	 * when using pixel art in a game. Note that this sets the property on the context itself, so that any image
	 * drawn to the context will be affected. This sets the property across all current browsers but support is
	 * patchy on earlier browsers, especially on mobile.
	 *
	 * @since 1.0.0
	 *
	 * @param context - The context on which to disable smoothing.
	 *
	 * @return The provided context.
	**/
	public static function disable(context:Dynamic):Dynamic
		throw "Not Implemented";

	/**
	 * Returns `true` if the given context has image smoothing enabled, otherwise returns `false`.
	 * Returns null if no smoothing prefix is available.
	 *
	 * @since 1.0.0
	 *
	 * @param  context - The context to check.
	 *
	 * @return `true` if smoothing is enabled on the context, otherwise `false`. `null` if not supported.
	**/
	public static inline function isEnabled(context:Dynamic):Null<Bool>
		throw "Not Implemented";
}
#end
