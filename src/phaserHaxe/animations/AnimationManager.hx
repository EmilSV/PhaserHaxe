package phaserHaxe.animations;

import phaserHaxe.iterator.StepIterator;
import haxe.Json;
import phaserHaxe.animations.JSONAnimation;
import phaserHaxe.core.GameEvents;
import phaserHaxe.textures.TextureManager;
import phaserHaxe.Game;
import phaserHaxe.utils.StringUtils;

typedef JSONData = Either3<String, JSONAnimation, JSONAnimations>;

/**
 * The Animation Manager.
 *
 * Animations are managed by the global Animation Manager. This is a singleton class that is
 * responsible for creating and delivering animations and their corresponding data to all Game Objects.
 * Unlike plugins it is owned by the Game instance, not the Scene.
 *
 * Sprites and other Game Objects get the data they need from the AnimationManager.
 *
 * @since 1.0.0
**/
class AnimationManager extends EventEmitter
{
	/**
	 * A reference to the Phaser.Game instance.
	 *
	 * @since 1.0.0
	**/
	private var game:Game;

	/**
	 * A reference to the Texture Manager.
	 *
	 * @since 1.0.0
	**/
	@:allow(phaserHaxe)
	private var textureManager:TextureManager = null;

	/**
	 * The global time scale of the Animation Manager.
	 *
	 * This scales the time delta between two frames, thus influencing the speed of time for the Animation Manager.
	 *
	 * @since 1.0.0
	**/
	public var globalTimeScale:Float = 1;

	/**
	 * The Animations registered in the Animation Manager.
	 *
	 * This map should be modified with the {@link #add} and {@link #create} methods of the Animation Manager.
	 *
	 * @since 1.0.0
	**/
	private var anims:Map<String, Animation> = new Map();

	/**
	 * Whether the Animation Manager is paused along with all of its Animations.
	 *
	 * @since 1.0.0
	**/
	public var paused:Bool = false;

	/**
	 * The name of this Animation Manager.
	 *
	 * @since 1.0.0
	**/
	public var name:String = 'AnimationManager';

	public function new(game:Game)
	{
		super();
		this.game = game;

		game.events.once(GameEvents.BOOT, this.boot, [this]);
	}

	/**
	 * Registers event listeners after the Game boots.
	 *
	 * @since 1.0.0
	**/
	public function boot()
	{
		this.textureManager = this.game.textures;

		this.game.events.once(GameEvents.DESTROY, this.destroy, [this]);
	}

	/**
	 * Adds an existing Animation to the Animation Manager.
	 *
	 * @fires Phaser.Animations.Events#ADD_ANIMATION
	 * @since 1.0.0
	 *
	 * @param key - The key under which the Animation should be added. The Animation will be updated with it. Must be unique.
	 * @param animation - The Animation which should be added to the Animation Manager.
	 *
	 * @return This Animation Manager.
	**/
	public function add(key:String, animation:Animation):AnimationManager
	{
		if (anims.exists(key))
		{
			Console.warn('Animation key exists: ' + key);
			return this;
		}

		animation.key = key;
		anims.set(key, animation);
		emit(AnimationEvents.ADD_ANIMATION, [key, animation]);

		return this;
	}

	/**
	 * Checks to see if the given key is already in use within the Animation Manager or not.
	 *
	 * Animations are global. Keys created in one scene can be used from any other Scene in your game. They are not Scene specific.
	 *
	 * @since 1.0.0
	 *
	 * @param key - The key of the Animation to check.
	 *
	 * @return `true` if the Animation already exists in the Animation Manager, or `false` if the key is available.
	**/
	public function exists(key:String):Bool
	{
		return anims.exists(key);
	}

	/**
	 * Creates a new Animation and adds it to the Animation Manager.
	 *
	 * Animations are global. Once created, you can use them in any Scene in your game. They are not Scene specific.
	 *
	 * If an invalid key is given this method will return `false`.
	 *
	 * If you pass the key of an animation that already exists in the Animation Manager, that animation will be returned.
	 *
	 * A brand new animation is only created if the key is valid and not already in use.
	 *
	 * If you wish to re-use an existing key, call `AnimationManager.remove` first, then this method.
	 *
	 * @fires Phaser.Animations.Events#ADD_ANIMATION
	 * @since 1.0.0
	 *
	 * @param config - The configuration settings for the Animation.
	 *
	 * @return The Animation that was created, or `false` is the key is already in use.
	**/
	public function create(config:AnimationData):Null<Animation>
	{
		var key = config.key;
		var anim = false;
		if (key != null)
		{
			anim = get(key);
			if (!anim)
			{
				var anim = new Animation(this, key, config);
				this.anims.set(key, anim);
				this.emit(AnimationEvents.ADD_ANIMATION, [key, anim]);
				return anim;
			}
		}

		return null;
	}

	/**
	 * Loads this Animation Manager's Animations and settings from a JSON object.
	 *
	 * @since 1.0.0
	 *
	 * @param data - The JSON object to parse.
	 * @param clearCurrentAnimations - If set to `true`, the current animations will be removed (`anims.clear()`). If set to `false` (default), the animations in `data` will be added.
	 *
	 * @return An array containing all of the Animation objects that were created as a result of this call.
	**/
	public function fromJSON(data:JSONData,
			clearCurrentAnimations:Bool = false):Array<Null<Animation>>
	{
		if (clearCurrentAnimations == null)
		{
			clearCurrentAnimations = false;
		}

		if (clearCurrentAnimations)
		{
			anims.clear();
		}

		//  Do we have a String (i.e. from JSON, or an Object?)
		if (Std.is(data, String))
		{
			data = Json.parse((cast data : String));
		}

		final data = (cast data : Dynamic);

		var output = [];

		//  Array of animations, or a single animation?
		if (data.anims != null && Std.is(data.anims, Array))
		{
			final data = (cast data : JSONAnimations);

			for (i in 0...data.anims.length)
			{
				output.push(create(data.anims[i]));
			}

			if (data.globalTimeScale != null || data.globalTimeScale != 0)
			{
				globalTimeScale = data.globalTimeScale;
			}
		}
		else if (data.key != null && data.type == "frame")
		{
			output.push(create(data));
		}
		return output;
	}

	/**
	 * [description]
	 *
	 * @since 1.0.0
	 *
	 * @param key - The key for the texture containing the animation frames.
	 * @param config - The configuration object for the animation frame names.
	 *
	 * @return The array of objects.
	**/
	public function generateFrameNames(key:String,
			?config:GenerateFrameNames):Array<AnimationFrameConfig>
	{
		inline function getValue<T>(value:T, defaultValue:T)
		{
			return config != null && value != null ? value : defaultValue;
		}

		var prefix = getValue(config.prefix, '');
		var start = getValue(config.start, 0);
		var end = getValue(config.end, 0);
		var suffix = getValue(config.suffix, '');
		var zeroPad = getValue(config.zeroPad, 0);
		var out = getValue(config.outputArray, []);
		var frames = getValue(config.frames, false);
		var texture = this.textureManager.get(key);

		if (texture != null)
		{
			return out;
		}

		var diff = (start < end) ? 1 : -1;

		if (config == null)
		{
			//  Use every frame in the atlas?
			final frames = texture.getFrameNames();

			for (i in 0...frames.length)
			{
				out.push({key: key, frame: frames[i]});
			}
		}
		else if (Std.is(frames, Array))
		{
			var frame:String;
			final frames = (cast frames : Array<String>);

			//  Have they provided their own custom frame sequence array?
			for (i in 0...frames.length)
			{
				frame = prefix + StringUtils.pad(frames[i], zeroPad, '0', LEFT) + suffix;
				if (texture.has(frame))
				{
					out.push({key: key, frame: frame});
				}
			}
		}
		else
		{
			var frame:String;
			for (i in new StepIterator(start, end, diff))
			{
				frame = prefix + StringUtils.pad(i, zeroPad, '0', LEFT) + suffix;
				if (texture.has(frame))
				{
					out.push({key: key, frame: frame});
				}
			}
		}

		return out;
	}

	/**
	 * Generate an array of {@link Phaser.Types.Animations.AnimationFrame} objects from a texture key and configuration object.
	 *
	 * Generates objects with numbered frame names, as configured by the given {@link Phaser.Types.Animations.GenerateFrameNumbers}.
	 *
	 * @since 1.0.0
	 *
	 * @param key - The key for the texture containing the animation frames.
	 * @param config - The configuration object for the animation frames.
	 *
	 * @return The array of {@link Phaser.Types.Animations.AnimationFrame} objects.
	**/
	public function generateFrameNumbers(key:String,
			config:GenerateFrameNumbers):Array<AnimationFrameConfig>
	{
		inline function getValue<T>(value:T, defaultValue:T)
		{
			return config != null && value != null ? value : defaultValue;
		}

		var startFrame = getValue(config.start, 0);
		var endFrame = getValue(config.end, -1);
		var firstFrame = getValue(config.first, null);
		var out = getValue(config.outputArray, []);
		var frames = getValue(config.frames, false);
		var texture = this.textureManager.get(key);

		if (texture == null)
		{
			return out;
		}

		if (firstFrame != null && texture.has(firstFrame))
		{
			out.push({key: key, frame: firstFrame});
		}

		var i;
		//  Have they provided their own custom frame sequence array?
		if (Std.is(frames, Array))
		{
			for (frame in (cast frames : Array<Int>))
			{
				if (texture.has(frame))
				{
					out.push({key: key, frame: frame});
				}
			}
		}
		else
		{
			//  No endFrame then see if we can get it
			if (endFrame == -1)
			{
				endFrame = texture.frameTotal;
			}

			var diff = (startFrame < endFrame) ? 1 : -1;

			for (i in new StepIterator(startFrame, endFrame, diff))
			{
				if (texture.has(i))
				{
					out.push({key: key, frame: i});
				}
			}
		}
		return out;
	}

	// /**
	//  * Get an Animation.
	//  *
	//  * @method Phaser.Animations.AnimationManager#get
	//  * @since 3.0.0
	//  *
	//  * @param {string} key - The key of the Animation to retrieve.
	//  *
	//  * @return {Phaser.Animations.Animation} The Animation.
	//  */
	// get: function (key)
	// {
	//     return this.anims.get(key);
	// },
	// /**
	//  * Load an Animation into a Game Object's Animation Component.
	//  *
	//  * @method Phaser.Animations.AnimationManager#load
	//  * @since 3.0.0
	//  *
	//  * @param {Phaser.GameObjects.GameObject} child - The Game Object to load the animation into.
	//  * @param {string} key - The key of the animation to load.
	//  * @param {(string|integer)} [startFrame] - The name of a start frame to set on the loaded animation.
	//  *
	//  * @return {Phaser.GameObjects.GameObject} The Game Object with the animation loaded into it.
	//  */
	// load: function (child, key, startFrame)
	// {
	//     var anim = this.get(key);
	//     if (anim)
	//     {
	//         anim.load(child, startFrame);
	//     }
	//     else
	//     {
	//         console.warn('Missing animation: ' + key);
	//     }
	//     return child;
	// },
	// /**
	//  * Pause all animations.
	//  *
	//  * @method Phaser.Animations.AnimationManager#pauseAll
	//  * @fires Phaser.Animations.Events#PAUSE_ALL
	//  * @since 3.0.0
	//  *
	//  * @return {Phaser.Animations.AnimationManager} This Animation Manager.
	//  */
	// pauseAll: function ()
	// {
	//     if (!this.paused)
	//     {
	//         this.paused = true;
	//         this.emit(Events.PAUSE_ALL);
	//     }
	//     return this;
	// },
	// /**
	//  * Play an animation on the given Game Objects that have an Animation Component.
	//  *
	//  * @method Phaser.Animations.AnimationManager#play
	//  * @since 3.0.0
	//  *
	//  * @param {string} key - The key of the animation to play on the Game Object.
	//  * @param {Phaser.GameObjects.GameObject|Phaser.GameObjects.GameObject[]} child - The Game Objects to play the animation on.
	//  *
	//  * @return {Phaser.Animations.AnimationManager} This Animation Manager.
	//  */
	// play: function (key, child)
	// {
	//     if (!Array.isArray(child))
	//     {
	//         child = [ child ];
	//     }
	//     var anim = this.get(key);
	//     if (!anim)
	//     {
	//         return;
	//     }
	//     for (var i = 0; i < child.length; i++)
	//     {
	//         child[i].anims.play(key);
	//     }
	//     return this;
	// },
	// /**
	//  * Remove an animation.
	//  *
	//  * @method Phaser.Animations.AnimationManager#remove
	//  * @fires Phaser.Animations.Events#REMOVE_ANIMATION
	//  * @since 3.0.0
	//  *
	//  * @param {string} key - The key of the animation to remove.
	//  *
	//  * @return {Phaser.Animations.Animation} [description]
	//  */
	// remove: function (key)
	// {
	//     var anim = this.get(key);
	//     if (anim)
	//     {
	//         this.emit(Events.REMOVE_ANIMATION, key, anim);
	//         this.anims.delete(key);
	//     }
	//     return anim;
	// },
	// /**
	//  * Resume all paused animations.
	//  *
	//  * @method Phaser.Animations.AnimationManager#resumeAll
	//  * @fires Phaser.Animations.Events#RESUME_ALL
	//  * @since 3.0.0
	//  *
	//  * @return {Phaser.Animations.AnimationManager} This Animation Manager.
	//  */
	// resumeAll: function ()
	// {
	//     if (this.paused)
	//     {
	//         this.paused = false;
	//         this.emit(Events.RESUME_ALL);
	//     }
	//     return this;
	// },
	// /**
	//  * Takes an array of Game Objects that have an Animation Component and then
	//  * starts the given animation playing on them, each one offset by the
	//  * `stagger` amount given to this method.
	//  *
	//  * @method Phaser.Animations.AnimationManager#staggerPlay
	//  * @since 3.0.0
	//  *
	//  * @generic {Phaser.GameObjects.GameObject[]} G - [items,$return]
	//  *
	//  * @param {string} key - The key of the animation to play on the Game Objects.
	//  * @param {Phaser.GameObjects.GameObject|Phaser.GameObjects.GameObject[]} children - An array of Game Objects to play the animation on. They must have an Animation Component.
	//  * @param {number} [stagger=0] - The amount of time, in milliseconds, to offset each play time by.
	//  *
	//  * @return {Phaser.Animations.AnimationManager} This Animation Manager.
	//  */
	// staggerPlay: function (key, children, stagger)
	// {
	//     if (stagger === undefined) { stagger = 0; }
	//     if (!Array.isArray(children))
	//     {
	//         children = [ children ];
	//     }
	//     var anim = this.get(key);
	//     if (!anim)
	//     {
	//         return;
	//     }
	//     for (var i = 0; i < children.length; i++)
	//     {
	//         children[i].anims.delayedPlay(stagger * i, key);
	//     }
	//     return this;
	// },
	// /**
	//  * Get the animation data as javascript object by giving key, or get the data of all animations as array of objects, if key wasn't provided.
	//  *
	//  * @method Phaser.Animations.AnimationManager#toJSON
	//  * @since 3.0.0
	//  *
	//  * @param {string} key - [description]
	//  *
	//  * @return {Phaser.Types.Animations.JSONAnimations} [description]
	//  */
	// toJSON: function (key)
	// {
	//     if (key !== undefined && key !== '')
	//     {
	//         return this.anims.get(key).toJSON();
	//     }
	//     else
	//     {
	//         var output = {
	//             anims: [],
	//             globalTimeScale: this.globalTimeScale
	//         };
	//         this.anims.each(function (animationKey, animation)
	//         {
	//             output.anims.push(animation.toJSON());
	//         });
	//         return output;
	//     }
	// },
	// /**
	//  * Destroy this Animation Manager and clean up animation definitions and references to other objects.
	//  * This method should not be called directly. It will be called automatically as a response to a `destroy` event from the Phaser.Game instance.
	//  *
	//  * @method Phaser.Animations.AnimationManager#destroy
	//  * @since 3.0.0
	//  */
	// destroy: function ()
	// {
	//     this.anims.clear();
	//     this.textureManager = null;
	//     this.game = null;
	// }
}
