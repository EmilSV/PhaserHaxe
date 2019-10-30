package phaserHaxe.gameobjects;

import phaserHaxe.gameobjects.typedefs.JSONGameObject;
import phaserHaxe.gameobjects.components.*;

final class Components
{
	/**
	 * Build a JSON representation of the given Game Object.
	 *
	 * This is typically extended further by Game Object specific implementations.
	 *
	 * @since 1.0.0
	 *
	 * @param gameObject - The Game Object to export as JSON.
	 *
	 * @return A JSON representation of the Game Object.
	**/
	public static function toJSON<T:GameObject>(gameObject:T):JSONGameObject
	{
		var out:JSONGameObject = {
			name: gameObject.name,
			type: gameObject.type,
            data: {}
		};

		if (Std.is(gameObject, ITransform))
		{
			final gameObject = (cast gameObject : ITransform);
			out.x = gameObject.x;
			out.y = gameObject.y;
			out.scale = {
				x: gameObject.scaleX,
				y: gameObject.scaleY
			};
			out.rotation = gameObject.rotation;
		}

		if (Std.is(gameObject, IDepth))
		{
			final gameObject = (cast gameObject : IDepth);
			out.depth = gameObject.depth;
		}

		if (Std.is(gameObject, IOrigin))
		{
			final gameObject = (cast gameObject : IOrigin);
			out.origin = {
				x: gameObject.originX,
				y: gameObject.originY
			};
		}

		if (Std.is(gameObject, IFlip))
		{
			final gameObject = (cast gameObject : IFlip);
			out.flipX = gameObject.flipX;
			out.flipY = gameObject.flipY;
		}

		if (Std.is(gameObject, IAlpha))
		{
			final gameObject = (cast gameObject : IAlpha);
			out.alpha = gameObject.alpha;
		}

		if (Std.is(gameObject, IVisible))
		{
			final gameObject = (cast gameObject : IVisible);
			out.visible = gameObject.visible;
		}

		if (Std.is(gameObject, IBlendMode))
		{
			final gameObject = (cast gameObject : IBlendMode);
			out.blendMode = gameObject.blendMode;
		}

		if (Std.is(gameObject, IBaseTexture))
		{
			final gameObject = (cast gameObject : IBaseTexture);
			out.textureKey = gameObject.texture.key;
			out.frameKey = gameObject.frame.name;
		}
		else
		{
			out.textureKey = "";
			out.frameKey = "";
		}

		return out;
	}
}
