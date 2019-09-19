package phaserHaxe.gameobjects;

import phaserHaxe.gameobjects.components.IDepth;
import phaserHaxe.scene.Systems;
import phaserHaxe.structs.List;
import phaserHaxe.scene.Events as SceneEvents;
import phaserHaxe.utils.ArrayUtils;

/**
 * The Display List plugin.
 *
 * Display Lists belong to a Scene and maintain the list of Game Objects to render every frame.
 *
 * Some of these Game Objects may also be part of the Scene's [Update List]{@link Phaser.GameObjects.UpdateList}, for updating.
 *
 * @since 1.0.0
 *
**/
class DisplayList extends List<GameObject>
{
	/**
	 * The flag the determines whether Game Objects should be sorted when `depthSort()` is called.
	 *
	 * @since 1.0.0
	**/
	public var sortChildrenFlag:Bool = false;

	/**
	 * The Scene that this Display List belongs to.
	 *
	 * @since 1.0.0
	**/
	public var scene:Scene;

	/**
	 * The Scene's Systems.
	 *
	 * @since 1.0.0
	**/
	public var systems:Systems;

	/**
	 * @param scene - The Scene that this Display List belongs to.
	**/
	public function new(scene:Scene)
	{
		super(scene);

		this.scene = scene;

		this.systems = scene.sys;

		scene.sys.events.once(SceneEvents.BOOT, boot, this);
		scene.sys.events.on(SceneEvents.START, start, this);
	}

	/**
	 * This method is called automatically, only once, when the Scene is first created.
	 * Do not invoke it directly.
	 *
	 * @since 1.0.0
	**/
	private function boot()
	{
		systems.events.once(SceneEvents.DESTROY, destroy, this);
	}

	/**
	 * This method is called automatically by the Scene when it is starting up.
	 * It is responsible for creating local systems, properties and listening for Scene events.
	 * Do not invoke it directly.
	 *
	 * @since 1.0.0
	**/
	private function start()
	{
		systems.events.once(SceneEvents.SHUTDOWN, shutdown, this);
	}

	/**
	 * Force a sort of the display list on the next call to depthSort.
	 *
	 * @since 1.0.0
	**/
	public function queueDepthSort()
	{
		sortChildrenFlag = true;
	}

	/**
	 * Immediately sorts the display list if the flag is set.
	 *
	 * @since 1.0.0
	**/
	public function depthSort()
	{
		if (sortChildrenFlag)
		{
			ArrayUtils.stableSort(list, sortByDepth);
			sortChildrenFlag = false;
		}
	}

	/**
	 * Compare the depth of two Game Objects.
	 *
	 * @since 1.0.0
	 *
	 * @param childA - The first Game Object.
	 * @param childB - The second Game Object.
	 *
	 * @return The difference between the depths of each Game Object.
	**/
	public function sortByDepth(childA:GameObject, childB:GameObject):Int
	{
		final depthA = if (Std.is(childA, IDepth))
		{
			(cast childA : IDepth).depth;
		}
		else
		{
			0;
		}

		final depthB = if (Std.is(childB, IDepth))
		{
			(cast childB : IDepth).depth;
		}
		else
		{
			0;
		}

		return depthA - depthB;
	}

	/**
	 * Returns an array which contains all objects currently on the Display List.
	 * This is a reference to the main list array, not a copy of it, so be careful not to modify it.
	 *
	 * @since 1.0.0
	 *
	 * @return The group members.
	**/
	public function getChildren():Array<GameObject>
	{
		return list;
	}

	/**
	 * The Scene that owns this plugin is shutting down.
	 * We need to kill and reset all internal properties as well as stop listening to Scene events.
	 *
	 * @since 1.0.0
	**/
	public override function shutdown()
	{
		var i = list.length;

		while (i-- == 0)
		{
			list[i].destroy(true);
		}

		list.resize(0);

		systems.events.off(SceneEvents.SHUTDOWN, shutdown, this);
	}

	/**
	 * The Scene that owns this plugin is being destroyed.
	 * We need to shutdown and then kill off all external references.
	 *
	 * @since 1.0.0
	**/
	public override function destroy()
	{
		shutdown();

		scene.sys.events.off(SceneEvents.START, start, this);

		scene = null;
		systems = null;
	}
}
