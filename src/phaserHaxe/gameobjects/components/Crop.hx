package phaserHaxe.gameobjects.components;

import phaserHaxe.geom.Rectangle;
import phaserHaxe.gameobjects.components.Flip;
#if eval
import haxe.macro.Context;
import haxe.macro.Expr;
import phaserHaxe.macro.ComponentBuilder;
#end

/**
 * TODO: Placeholder
**/
typedef Texture = Dynamic;

/**
 * TODO: Placeholder
**/
typedef Frame = Dynamic;

@:structInit
class ResetCropObject
{
	public var u0:Float;
	public var v0:Float;
	public var u1:Float;
	public var v1:Float;
	public var width:Float;
	public var height:Float;
	public var x:Float;
	public var y:Float;
	public var flipX:Bool;
	public var flipY:Bool;
	public var cx:Float;
	public var cy:Float;
	public var cw:Float;
	public var ch:Float;
}

@:autoBuild(phaserHaxe.gameobjects.components.CropBuilder.build())
interface ICrop
{
	/**
	 * The Texture this Game Object is using to render with.
	 *
	 * @since 1.0.0
	**/
	public var texture:Texture;

	/**
	 * The Texture Frame this Game Object is using to render with.
	 *
	 * @since 1.0.0
	**/
	public var frame:Frame;

	/**
	 * A boolean flag indicating if this Game Object is being cropped or not.
	 * You can toggle this at any time after `setCrop` has been called, to turn cropping on or off.
	 * Equally, calling `setCrop` with no arguments will reset the crop and disable it.
	 *
	 * @since 1.0.0
	**/
	public var isCropped:Bool;

	/**
	 * Applies a crop to a texture based Game Object, such as a Sprite or Image.
	 *
	 * The crop is a rectangle that limits the area of the texture frame that is visible during rendering.
	 *
	 * Cropping a Game Object does not change its size, dimensions, physics body or hit area, it just
	 * changes what is shown when rendered.
	 *
	 * The crop coordinates are relative to the texture frame, not the Game Object, meaning 0 x 0 is the top-left.
	 *
	 * Therefore, if you had a Game Object that had an 800x600 sized texture, and you wanted to show only the left
	 * half of it, you could call `setCrop(0, 0, 400, 600)`.
	 *
	 * It is also scaled to match the Game Object scale automatically. Therefore a crop rect of 100x50 would crop
	 * an area of 200x100 when applied to a Game Object that had a scale factor of 2.
	 *
	 * You can either pass in numeric values directly, or you can provide a single Rectangle object as the first argument.
	 *
	 * Call this method with no arguments at all to reset the crop, or toggle the property `isCropped` to `false`.
	 *
	 * You should do this if the crop rectangle becomes the same size as the frame itself, as it will allow
	 * the renderer to skip several internal calculations.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The x coordinate to start the crop from. Or a Phaser.Geom.Rectangle object, in which case the rest of the arguments are ignored.
	 * @param y - The y coordinate to start the crop from.
	 * @param width - The width of the crop rectangle in pixels.
	 * @param height - The height of the crop rectangle in pixels.
	 *
	 * @return This Game Object instance.
	**/
	public function setCrop(?x:Either<Rectangle, Float>, ?y:Float, ?width:Float,
		?height:Float):ICrop;

	/**
	 * Internal method that returns a blank, well-formed crop object for use by a Game Object.
	 *
	 * @since 1.0.0
	 *
	 * @return The crop object.
	**/
	private function resetCropObject():ResetCropObject;
}

@:noCompletion
final class CropImplementation
{
	@:generic
	public inline static function setCrop<T:ICrop>(self:T, ?x:Either<Rectangle, Float>,
			?y:Float, ?width:Float, ?height:Float):T
	{
		// TODO: fix type
		final dynSelf = (self : Dynamic);
		
		final flipSelf = Std.is(self, IFlip) ? (cast self : IFlip) : null;

		if (x == null)
		{
			self.isCropped = false;
		}
		else if (self.frame != null)
		{
			if (Std.is(x, Float))
			{
				self.frame.setCropUVs(dynSelf._crop, x, y, width, height,
					flipSelf.flipX, flipSelf.flipY);
			}
			else
			{
				final rect = (cast x : Rectangle);

				self.frame.setCropUVs(dynSelf._crop, rect.x, rect.y, rect.width,
					rect.height, flipSelf.flipX, flipSelf.flipY);
			}

			self.isCropped = true;
		}

		return self;
	}

	@:generic
	public inline static function resetCropObject<T:ICrop>(self:T):ResetCropObject
	{
		return {
			u0: 0,
			v0: 0,
			u1: 0,
			v1: 0,
			width: 0,
			height: 0,
			x: 0,
			y: 0,
			flipX: false,
			flipY: false,
			cx: 0,
			cy: 0,
			cw: 0,
			ch: 0
		};
	}
}

final class CropBuilder
{
	#if eval
	public static function build():Array<Field>
	{
		final builder = new ComponentBuilder();

		builder.addVar({
			name: "texture",
			doc: "The Texture this Game Object is using to render with.",
			type: macro:phaserHaxe.gameobjects.components.Crop.Texture
		}).addVar({
			name: "frame",
			type: macro:phaserHaxe.gameobjects.components.Crop.Frame
		}).addVar({
			name: "isCropped",
			type: macro:Bool
		});

		builder.addFunction({
			name: "setCrop",

			doc: "Applies a crop to a texture based Game Object, such as a Sprite or Image.
			
			The crop is a rectangle that limits the area of the texture frame that is visible during rendering.
			
			Cropping a Game Object does not change its size, dimensions, physics body or hit area, it just
			changes what is shown when rendered.
			
			The crop coordinates are relative to the texture frame, not the Game Object, meaning 0 x 0 is the top-left.
			Therefore, if you had a Game Object that had an 800x600 sized texture, and you wanted to show only the left
			half of it, you could call `setCrop(0, 0, 400, 600)`.
			
			It is also scaled to match the Game Object scale automatically. Therefore a crop rect of 100x50 would crop
			an area of 200x100 when applied to a Game Object that had a scale factor of 2.
			
			You can either pass in numeric values directly, or you can provide a single Rectangle object as the first argument.
			Call this method with no arguments at all to reset the crop, or toggle the property `isCropped` to `false`.
			
			You should do this if the crop rectangle becomes the same size as the frame itself, as it will allow
			the renderer to skip several internal calculations. 
			
			@param x - The x coordinate to start the crop from. Or a Phaser.Geom.Rectangle object, in which case the rest of the arguments are ignored.
			@param y - The y coordinate to start the crop from.
			@param width - The width of the crop rectangle in pixels.
			@param height - The height of the crop rectangle in pixels.
			
			@return This Game Object instance.",

			ret: builder.buildType,
			args: [
				{
					name: "x",
					type: macro:phaserHaxe.Either<Rectangle, Float>,
					opt: true
				},
				{
					name: "y",
					type: macro:Float,
					opt: true
				},
				{
					name: "width",
					type: macro:Float,
					opt: true
				},
				{
					name: "height",
					type: macro:Float,
					opt: true
				}
			],
			expr: macro return
				phaserHaxe.gameobjects.components.setCrop(x, y, width, height)
		}).addFunction({
			name: "resetCropObject",

			doc: "Internal method that returns a blank, well-formed crop object for use by a Game Object.
			@return The crop object.",

			access: [APrivate],

			ret: macro:phaserHaxe.gameobjects.components.Crop.ResetCropObject,
			expr: macro return phaserHaxe.gameobjects.components.resetCropObject(this)
		});
		return builder.createFelids();
	}
	#end
}
