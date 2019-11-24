package phaserHaxe.scene.typedefs;

import haxe.Constraints.Function;

typedef SceneTransitionConfig =
{
	/**
	 * The Scene key to transition to.
	 *
	 * @since 1.0.0
	**/
	public var target:String;

	/**
	 * The duration, in ms, for the transition to last.
	 *
	 * @since 1.0.0
	**/
	public var ?duration:Int;

	/**
	 *  Will the Scene responsible for the transition be sent to sleep on completion (`true`), or stopped? (`false`)
	 *
	 * @since 1.0.0
	**/
	public var sleep:Bool;

	/**
	 * Will the Scenes Input system be able to process events while it is transitioning in or out?
	 *
	 * @since 1.0.0
	**/
	public var allowInput:Bool;

	/**
	 * Move the target Scene to be above this one before the transition starts.
	 *
	 * @since 1.0.0
	**/
	public var moveAbove:Bool;

	/**
	 * Move the target Scene to be below this one before the transition starts.
	 *
	 * @since 1.0.0
	**/
	public var moveBelow:Bool;

	/**
	 * This callback is invoked every frame for the duration of the transition.
	 *
	 * @since 1.0.0
	**/
	public var ?onUpdate:Function;

	/**
	 * The context in which the callback is invoked.
	 *
	 * @since 1.0.0
	**/
	public var ?onUpdateScope:Any;

	/**
	 * An object containing any data you wish to be passed to the target Scenes init / create methods.
	 *
	 * @since 1.0.0
	**/
	public var ?data:Any;
};
