package phaserHaxe.scene.typedefs;

import phaserHaxe.utils.types.MultipleOrOne;
import phaserHaxe.core.LoaderConfig;
import phaserHaxe.core.PhysicsConfig;
import phaserHaxe.utils.types.Union;
import phaserHaxe.loader.filetypes.typedefs.PackFileConfig;
import phaserHaxe.cameras.scene2D.typedefs.JSONCamera;

/**
 * @since 1.0.0
**/
typedef SettingsConfig =
{
	/**
	 * The unique key of this Scene. Must be unique within the entire Game instance.
	 *
	 * @since 1.0.0
	**/
	public var ?key:String;

	/**
	 * Does the Scene start as active or not? An active Scene updates each step.
	 *
	 * @since 1.0.0
	**/
	public var ?active:Bool;

	/**
	 * Does the Scene start as visible or not? A visible Scene renders each step.
	 *
	 * @since 1.0.0
	**/
	public var ?visible:Bool;

	/**
	 *  An optional Loader Packfile to be loaded before the Scene begins.
	 *
	 * @since 1.0.0
	**/
	public var ?pack:PackFileConfig;

	/**
	 * An optional Camera configuration object.
	 *
	 * @since 1.0.0
	**/
	public var ?cameras:MultipleOrOne<JSONCamera>;

	/**
	 * Overwrites the default injection map for a scene.
	 *
	 * @since 1.0.0
	**/
	public var ?map:Union<Map<String, String>, {}>;

	/**
	 * Extends the injection map for a scene.
	 *
	 * @since 1.0.0
	**/
	public var ?mapAdd:Union<Map<String, String>, {}>;

	/**
	 * The physics configuration object for the Scene.
	 *
	 * @since 1.0.0
	**/
	public var ?physics:PhysicsConfig;

	/**
	 * The loader configuration object for the Scene.
	 *
	 * @since 1.0.0
	**/
	public var ?loader:LoaderConfig;

	/**
	 * The plugin configuration object for the Scene.
	 *
	 * @since 1.0.0
	**/
	public var ?plugins:Any;
};
