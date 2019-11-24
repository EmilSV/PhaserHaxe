package phaserHaxe;

import phaserHaxe.gameobjects.components.ITexture;
import phaserHaxe.textures.TextureManager;
import phaserHaxe.input.typedefs.InteractiveObject;
import phaserHaxe.input.typedefs.HitAreaCallback;
import phaserHaxe.gameobjects.GameObject;

final class Input
{
	/**
	 * Creates a new Interactive Object.
	 *
	 * This is called automatically by the Input Manager when you enable a Game Object for input.
	 *
	 * The resulting Interactive Object is mapped to the Game Object's `input` property.
	 *
	 * @since 1.0.0
	 *
	 * @param gameObject - The Game Object to which this Interactive Object is bound.
	 * @param hitArea - The hit area for this Interactive Object. Typically a geometry shape, like a Rectangle or Circle.
	 * @param hitAreaCallback - The 'contains' check callback that the hit area shape will use for all hit tests.
	 *
	 * @return The new Interactive Object.
	**/
	public static function createInteractiveObject(gameObject:GameObject, hitArea:Any,
			hitAreaCallback:HitAreaCallback):InteractiveObject
	{
		return {
			gameObject: gameObject,

			enabled: true,
			alwaysEnabled: false,
			draggable: false,
			dropZone: false,
			cursor: null,

			target: null,

			camera: null,

			hitArea: hitArea,
			hitAreaCallback: hitAreaCallback,
			hitAreaDebug: null,

			//  Has the dev specified their own shape, or is this bound to the texture size?
			customHitArea: false,

			localX: 0,
			localY: 0,

			//  0 = Not being dragged
			//  1 = Being checked for dragging
			//  2 = Being dragged
			dragState: 0,

			dragStartX: 0,
			dragStartY: 0,
			dragStartXGlobal: 0,
			dragStartYGlobal: 0,

			dragX: 0,
			dragY: 0
		};
	}

	/**
	 * Creates a new Pixel Perfect Handler function.
	 *
	 * Access via `InputPlugin.makePixelPerfect` rather than calling it directly.
	 *
	 * @since 1.0.0
	 *
	 * @param textureManager - A reference to the Texture Manager.
	 * @param alphaTolerance - The alpha level that the pixel should be above to be included as a successful interaction.
	 *
	 * @return The new Pixel Perfect Handler function.
	**/
	public static function createPixelPerfectHandler(textureManager:TextureManager,
			alphaTolerance:Int):(hitArea:Any, x:Float, y:Float,
			gameObject:GameObject) -> Bool
	{
		return function(hitArea, x, y, gameObject)
		{
			var gameObject = (cast gameObject : ITexture);

			var alpha = textureManager.getPixelAlpha(x, y, gameObject.texture.key, gameObject.frame.name);

			return (alpha != null && alpha != 0 && alpha >= alphaTolerance);
		};
	}
}
