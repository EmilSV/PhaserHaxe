package phaserHaxe.scene.typedefs;

import phaserHaxe.core.LoaderConfig;
import phaserHaxe.core.PhysicsConfig;
import phaserHaxe.utils.types.Union;
import phaserHaxe.utils.types.MultipleOrOne;
import phaserHaxe.cameras.scene2D.typedefs.JSONCamera;
import phaserHaxe.loader.filetypes.typedefs.PackFileConfig;
import phaserHaxe.Scene;

/**
 * @since 1.0.0
**/
typedef SettingsObject =
{
	/**
	 * The current status of the Scene. Maps to the Scene constants.
	 *
	 * @since 1.0.0
	**/
	public var status:Float;

	/**
	 * The unique key of this Scene. Unique within the entire Game instance.
	 *
	 * @since 1.0.0
	**/
	public var key:String;

	/**
	 * The active state of this Scene. An active Scene updates each step.
	 *
	 * @since 1.0.0
	**/
	public var active:Bool;

	/**
	 * The visible state of this Scene. A visible Scene renders each step.
	 *
	 * @since 1.0.0
	**/
	public var visible:Bool;

	/**
	 * Has the Scene finished booting?
	 *
	 * @since 1.0.0
	**/
	public var isBooted:Bool;

	/**
	 * Is the Scene in a state of transition?
	 *
	 * @since 1.0.0
	**/
	public var isTransition:Bool;

	/**
	 * The Scene this Scene is transitioning from, if set.
	 *
	 * @since 1.0.0
	**/
	public var transitionFrom:Scene;

	/**
	 * The duration of the transition, if set.
	 *
	 * @since 1.0.0
	**/
	public var transitionDuration:Int;

	/**
	 * Is this Scene allowed to receive input during transitions?
	 *
	 * @since 1.0.0
	**/
	public var transitionAllowInput:Bool;

	/**
	 * a data bundle passed to this Scene from the Scene Manager.
	 *
	 * @since 1.0.0
	**/
	public var data:{};

	/**
	 * The Loader Packfile to be loaded before the Scene begins.
	 *
	 * @since 1.0.0
	**/
	public var ?pack:PackFileConfig;

	/**
	 * The Camera configuration object.
	 *
	 * @since 1.0.0
	**/
	public var ?cameras:MultipleOrOne<JSONCamera>;

	/**
	 * The Scene's Injection Map.
	 *
	 * @since 1.0.0
	**/
	public var map:Union<Map<String, String>, {}>;

	/**
	 * The physics configuration object for the Scene.
	 *
	 * @since 1.0.0
	**/
	public var physics:PhysicsConfig;

	/**
	 * The loader configuration object for the Scene.
	 *
	 * @since 1.0.0
	**/
	public var loader:LoaderConfig;

	/**
	 * The plugin configuration object for the Scene.
	 *
	 * @since 1.0.0
	**/
	public var ?plugins:Any;

	public var input:Dynamic;
};
