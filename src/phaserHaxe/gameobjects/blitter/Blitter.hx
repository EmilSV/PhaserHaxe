package phaserHaxe.gameobjects.blitter;

import phaserHaxe.renderer.webgl.WebGLRenderer;
import phaserHaxe.cameras.scene2D.Camera;
import phaserHaxe.renderer.canvas.CanvasRenderer;
import phaserHaxe.gameobjects.sprite.ISpriteRenderer;
import phaserHaxe.utils.types.MultipleOrOne;
import phaserHaxe.utils.types.Union3;
import phaserHaxe.textures.Frame;
import phaserHaxe.utils.types.StringOrInt;
import phaserHaxe.utils.types.Union;
import phaserHaxe.gameobjects.components.*;
import phaserHaxe.structs.List;

@:build(phaserHaxe.macro.Mixin.auto())
class Blitter extends GameObject implements IAlpha implements IBlendMode
		implements IDepth implements IMask implements IPipeline
		implements IScrollFactor implements ISize implements ITexture
		implements ITransform implements IVisible implements ISpriteRenderer
{
	/**
	 * The children of this Blitter.
	 * This List contains all of the Bob objects created by the Blitter.
	 *
	 * @since 1.0.0
	**/
	public var children:List<Bob> = new List();

	/**
	 * A transient array that holds all of the Bobs that will be rendered this frame.
	 * The array is re-populated whenever the dirty flag is set.
	 *
	 * @since 1.0.0
	**/
	private var renderList:Array<Bob> = [];

	/**
	 * Is the Blitter considered dirty?
	 * A 'dirty' Blitter has had its child count changed since the last frame.
	 *
	 * @since 1.0.0
	**/
	public var dirty:Bool = false;

	public function new(scene:Scene, x:Float, y:Float, texture:String,
			frame:StringOrInt = 0)
	{
		super(scene, "Blitter");

		this.setTexture(texture, frame);
		this.setPosition(x, y);
		this.initPipeline();
	}

	/**
	 * Creates a new Bob in this Blitter.
	 *
	 * The Bob is created at the given coordinates, relative to the Blitter and uses the given frame.
	 * A Bob can use any frame belonging to the texture bound to the Blitter.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The x position of the Bob. Bob coordinate are relative to the position of the Blitter object.
	 * @param y - The y position of the Bob. Bob coordinate are relative to the position of the Blitter object.
	 * @param frame - The Frame the Bob will use. It _must_ be part of the Texture the parent Blitter object is using.
	 * @param visible - Should the created Bob render or not?
	 * @param index - The position in the Blitters Display List to add the new Bob at. Defaults to the top of the list.
	 *
	 * @return The newly created Bob object.
	**/
	public function create(x:Float, y:Float, ?frame:FrameArg, visible:Bool = true,
			?index:Int):Bob
	{
		var index:Int = if (index == null)
		{
			children.length;
		}
		else
		{
			index;
		}

		var frame:Frame = if (frame == null)
		{
			this.frame;
		}
		else if (!Std.is(frame, Frame))
		{
			texture.get(cast frame);
		}
		else
		{
			cast frame;
		}

		var bob = new Bob(this, x, y, frame, visible);

		children.addAt(bob, index, false);

		dirty = true;

		return bob;
	}

	/**
	 * Creates multiple Bob objects within this Blitter and then passes each of them to the specified callback.
	 *
	 * @since 1.0.0
	 *
	 * @param callback - The callback to invoke after creating a bob. It will be sent two arguments: The Bob and the index of the Bob.
	 * @param quantity - The quantity of Bob objects to create.
	 * @param frame - The Frame the Bobs will use. It must be part of the Blitter Texture.
	 * @param visible - Should the created Bob render or not?
	 *
	 * @return An array of Bob objects that were created.
	**/
	public function createFromCallback(callback:(bob:Bob, index:Int) -> Void,
			quantity:Int, frame:FrameArg, visible:Bool = true):Array<Bob>
	{
		var bobs = this.createMultiple(quantity, frame, visible);

		for (i in 0...bobs.length)
		{
			var bob = bobs[i];

			callback(bob, i);
		}

		return bobs;
	}

	/**
	 * Creates multiple Bobs in one call.
	 *
	 * The amount created is controlled by a combination of the `quantity` argument and the number of frames provided.
	 *
	 * If the quantity is set to 10 and you provide 2 frames, then 20 Bobs will be created. 10 with the first
	 * frame and 10 with the second.
	 *
	 * @since 1.0.0
	 *
	 * @param quantity - The quantity of Bob objects to create.
	 * @param frame - The Frame the Bobs will use. It must be part of the Blitter Texture.
	 * @param visible - Should the created Bob render or not?
	 *
	 * @return An array of Bob objects that were created.
	**/
	public function createMultiple(quantity:Int, frame:FrameMultiArg,
			visible:Bool = true):Array<Bob>
	{
		if (frame == null)
		{
			frame = this.frame.name;
		}
		if (visible == null)
		{
			visible = true;
		}

		var frame:Array<FrameArg> = if (!Std.is(frame, Array))
		{
			[cast frame];
		}
		else
		{
			cast frame;
		}

		var bobs = [];

		for (singleFrame in frame)
		{
			for (i in 0...quantity)
			{
				bobs.push(create(0, 0, singleFrame, visible));
			}
		}

		return bobs;
	}

	/**
	 * Checks if the given child can render or not, by checking its `visible` and `alpha` values.
	 *
	 * @since 1.0.0
	 *
	 * @param child - The Bob to check for rendering.
	 *
	 * @return Returns `true` if the given child can render, otherwise `false`.
	**/
	public function childCanRender(child:Bob):Bool
	{
		return child.visible && child.alpha > 0;
	}

	/**
	 * Returns an array of Bobs to be rendered.
	 * If the Blitter is dirty then a new list is generated and stored in `renderList`.
	 *
	 * @since 1.0.0
	 *
	 * @return An array of Bob objects that will be rendered this frame.
	**/
	public function getRenderList():Array<Bob>
	{
		if (dirty)
		{
			renderList = children.list.filter(childCanRender);
			dirty = false;
		}

		return renderList;
	}

	/**
	 * Removes all Bobs from the children List and clears the dirty flag.
	 *
	 * @since 1.0.0
	**/
	public function clear()
	{
		this.children.removeAll();
		this.dirty = true;
	}

	/**
	 * Renders this Game Object with the Canvas Renderer to the given Camera.
	 * The object will not render if any of its renderFlags are set or it is being actively filtered out by the Camera.
	 * This method should not be called directly. It is a utility function of the Render module.
	 *
	 * @since 1.0.0
	 * @private
	 *
	 * @param renderer - A reference to the current active Canvas renderer.
	 * @param src - The Game Object being rendered in this call.
	 * @param interpolationPercentage - Reserved for future use and custom pipelines.
	 * @param camera - The Camera that is rendering the Game Object.
	 * @param parentMatrix - This transform matrix is defined if the game object is nested
	**/
	private function renderCanvas(renderer:CanvasRenderer, src:GameObject,
			interpolationPercentage:Float, camera:Camera,
			parentMatrix:TransformMatrix):Void
	{
		var src = (cast src : Blitter);

		var list = src.getRenderList();

		if (list.length == 0)
		{
			return;
		}

		var ctx = renderer.currentContext;

		var alpha = camera.alpha * src.alpha;

		if (alpha == 0)
		{
			//  Nothing to see, so abort early
			return;
		}

		//  Blend Mode + Scale Mode
		ctx.globalCompositeOperation = renderer.blendModes[src.blendMode];

		ctx.imageSmoothingEnabled = !(!renderer.antialias || src.frame.source.scaleMode != 0);

		var cameraScrollX = src.x - camera.scrollX * src.scrollFactorX;
		var cameraScrollY = src.y - camera.scrollY * src.scrollFactorY;

		ctx.save();

		if (parentMatrix != null)
		{
			parentMatrix.copyToContext(ctx);
		}

		var roundPixels = camera.roundPixels;

		//  Render bobs
		for (bob in list)
		{
			var flip = bob.flipX || bob.flipY;
			var frame = bob.frame;
			var cd = frame.canvasData;
			var dx = frame.x;
			var dy = frame.y;
			var fx = 1;
			var fy = 1;

			var bobAlpha = bob.alpha * alpha;

			if (bobAlpha == 0)
			{
				continue;
			}

			ctx.globalAlpha = bobAlpha;

			if (!flip)
			{
				if (roundPixels)
				{
					dx = Math.round(dx);
					dy = Math.round(dy);
				}

				ctx.drawImage(cast frame.source.image, cd.x, cd.y, cd.width, cd.height,
					dx + bob.x + cameraScrollX, dy + bob.y + cameraScrollY, cd.width,
					cd.height);
			}
			else
			{
				if (bob.flipX)
				{
					fx = -1;
					dx -= cd.width;
				}

				if (bob.flipY)
				{
					fy = -1;
					dy -= cd.height;
				}

				ctx.save();
				ctx.translate(bob.x + cameraScrollX, bob.y + cameraScrollY);
				ctx.scale(fx, fy);
				ctx.drawImage(cast frame.source.image, cd.x, cd.y, cd.width, cd.height,
					dx, dy, cd.width, cd.height);
				ctx.restore();
			}
		}

		ctx.restore();
	}

	/**
	 * Renders this Game Object with the WebGL Renderer to the given Camera.
	 * The object will not render if any of its renderFlags are set or it is being actively filtered out by the Camera.
	 * This method should not be called directly. It is a utility function of the Render module.
	 *
	 * @since 1.0.0
	 * @private
	 *
	 * @param renderer - A reference to the current active WebGL renderer.
	 * @param src - The Game Object being rendered in this call.
	 * @param interpolationPercentage - Reserved for future use and custom pipelines.
	 * @param camera - The Camera that is rendering the Game Object.
	 * @param parentMatrix - This transform matrix is defined if the game object is nested
	**/
	private function renderWebGL(renderer:WebGLRenderer, src:GameObject,
		interpolationPercentage:Float, camera:Camera,
		parentMatrix:TransformMatrix):Void {}

	/**
	 * Internal destroy handler, called as part of the destroy process.
	 *
	 * @since 1.0.0
	**/
	private override function preDestroy()
	{
		children.destroy();
		renderList = [];
	}
}

abstract FrameMultiArg(Dynamic) from Int from String from Array<Int> from Array<String>
	from Frame from Array<Frame> from StringOrInt from FrameArg {}
abstract FrameArg(Dynamic) from Int from String from Frame from StringOrInt {}
