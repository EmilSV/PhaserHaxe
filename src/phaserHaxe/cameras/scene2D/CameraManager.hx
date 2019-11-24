package phaserHaxe.cameras.scene2D;

import phaserHaxe.scale.ScaleEvents;
import haxe.Constraints.Function;
import phaserHaxe.utils.types.MultipleOrOne;
import phaserHaxe.geom.RectangleUtil;
import phaserHaxe.scene.Systems;
import phaserHaxe.scene.SceneEvents;
import phaserHaxe.cameras.scene2D.typedefs.JSONCamera;

class CameraManager
{
	/**
	 * The Scene that owns the Camera Manager plugin.
	 *
	 * @since 1.0.0
	**/
	public var scene:Scene;

	/**
	 * A reference to the Scene.Systems handler for the Scene that owns the Camera Manager.
	 *
	 * @since 1.0.0
	**/
	public var systems:Systems;

	/**
	 * All Cameras created by, or added to, this Camera Manager, will have their `roundPixels`
	 * property set to match this value. By default it is set to match the value set in the
	 * game configuration, but can be changed at any point. Equally, individual cameras can
	 * also be changed as needed.
	 *
	 * @since 1.0.0
	**/
	public var roundPixels:Bool;

	/**
	 * An Array of the Camera objects being managed by this Camera Manager.
	 * The Cameras are updated and rendered in the same order in which they appear in this array.
	 * Do not directly add or remove entries to this array. However, you can move the contents
	 * around the array should you wish to adjust the display order.
	 *
	 * @since 1.0.0
	**/
	public var cameras:Array<Camera> = [];

	/**
	 * A handy reference to the 'main' camera. By default this is the first Camera the
	 * Camera Manager creates. You can also set it directly, or use the `makeMain` argument
	 * in the `add` and `addExisting` methods. It allows you to access it from your game:
	 *
	 * ```haxe
	 * var cam = cameras.main;
	 * ```
	 *
	 * Also see the properties `camera1`, `camera2` and so on.
	 *
	 * @since 1.0.0
	**/
	public var main:Camera;

	/**
	 * A default un-transformed Camera that doesn't exist on the camera list and doesn't
	 * count towards the total number of cameras being managed. It exists for other
	 * systems, as well as your own code, should they require a basic un-transformed
	 * camera instance from which to calculate a view matrix.
	 *
	 * @since 1.0.0
	**/
	public var defaultCamera:Camera;

	public function new(scene:Scene)
	{
		this.scene = scene;

		this.systems = scene.sys;

		this.roundPixels = scene.sys.game.config.roundPixels;

		scene.sys.events.once(SceneEvents.BOOT, (this.boot : Function), this);
		scene.sys.events.on(SceneEvents.START, this.start, this);
	}

	/**
	 * This method is called automatically, only once, when the Scene is first created.
	 * Do not invoke it directly.
	 *
	 * @listens Phaser.Scenes.Events#DESTROY
	 * @since 1.0.0
	**/
	private function boot()
	{
		var sys = this.systems;

		if (sys.settings.cameras != null)
		{
			//  We have cameras to create
			this.fromJSON(sys.settings.cameras);
		}
		else
		{
			//  Make one
			this.add();
		}

		this.main = this.cameras[0];

		//  Create a default camera
		this.defaultCamera = cast new Camera(0, 0, sys.scale.width, sys.scale.height)
			.setScene(scene);

		sys.game.scale.on(ScaleEvents.RESIZE, this.onResize, this);

		systems.events.once(SceneEvents.DESTROY, this.destroy, this);
	}

	/**
	 * This method is called automatically by the Scene when it is starting up.
	 * It is responsible for creating local systems, properties and listening for Scene events.
	 * Do not invoke it directly.
	 *
	 * @listens Phaser.Scenes.Events#UPDATE
	 * @listens Phaser.Scenes.Events#SHUTDOWN
	 * @since 1.0.0
	**/
	private function start()
	{
		if (main == null)
		{
			var sys = this.systems;

			if (sys.settings.cameras != null)
			{
				//  We have cameras to create
				this.fromJSON(sys.settings.cameras);
			}
			else
			{
				//  Make one
				this.add();
			}

			this.main = this.cameras[0];
		}

		var eventEmitter = this.systems.events;

		eventEmitter.on(SceneEvents.UPDATE, this.update, this);
		eventEmitter.once(SceneEvents.SHUTDOWN, this.shutdown, this);
	}

	/**
	 * Adds a new Camera into the Camera Manager. The Camera Manager can support up to 31 different Cameras.
	 *
	 * Each Camera has its own viewport, which controls the size of the Camera and its position within the canvas.
	 *
	 * Use the `Camera.scrollX` and `Camera.scrollY` properties to change where the Camera is looking, or the
	 * Camera methods such as `centerOn`. Cameras also have built in special effects, such as fade, flash, shake,
	 * pan and zoom.
	 *
	 * By default Cameras are transparent and will render anything that they can see based on their `scrollX`
	 * and `scrollY` values. Game Objects can be set to be ignored by a Camera by using the `Camera.ignore` method.
	 *
	 * The Camera will have its `roundPixels` property set to whatever `CameraManager.roundPixels` is. You can change
	 * it after creation if required.
	 *
	 * See the Camera class documentation for more details.
	 *
	 * @since 1.0.0
	 *
	 * @param x - The horizontal position of the Camera viewport.
	 * @param y - The vertical position of the Camera viewport.
	 * @param width - The width of the Camera viewport. If not given it'll be the game config size.
	 * @param height - The height of the Camera viewport. If not given it'll be the game config size.
	 * @param makeMain - Set this Camera as being the 'main' camera. This just makes the property `main` a reference to it.
	 * @param name - The name of the Camera.
	 *
	 * @return The newly created Camera.
	**/
	public function add(x:Int = 0, y:Int = 0, ?width:Int, ?height:Int,
			makeMain:Bool = false, name:String = ""):Camera
	{
		if (width == null)
		{
			width = this.scene.sys.scale.width;
		}
		if (height == null)
		{
			height = this.scene.sys.scale.height;
		}

		var camera = new Camera(x, y, width, height);

		camera.setName(name);
		camera.setScene(this.scene);
		camera.setRoundPixels(this.roundPixels);

		camera.id = this.getNextID();

		this.cameras.push(camera);

		if (makeMain)
		{
			this.main = camera;
		}

		return camera;
	}

	/**
	 * Adds an existing Camera into the Camera Manager.
	 *
	 * The Camera should either be a `Phaser.Cameras.Scene2D.Camera` instance, or a class that extends from it.
	 *
	 * The Camera will have its `roundPixels` property set to whatever `CameraManager.roundPixels` is. You can change
	 * it after addition if required.
	 *
	 * The Camera will be assigned an ID, which is used for Game Object exclusion and then added to the
	 * manager. As long as it doesn't already exist in the manager it will be added then returned.
	 *
	 * If this method returns `null` then the Camera already exists in this Camera Manager.
	 *
	 * @since 1.0.0
	 *
	 * @param camera - The Camera to be added to the Camera Manager.
	 * @param makeMain - Set this Camera as being the 'main' camera. This just makes the property `main` a reference to it.
	 *
	 * @return The Camera that was added to the Camera Manager, or `null` if it couldn't be added.
	**/
	public function addExisting(camera:Camera, makeMain = false):Camera
	{
		var index = cameras.indexOf(camera);

		if (index == -1)
		{
			camera.id = getNextID();

			camera.setRoundPixels(roundPixels);

			cameras.push(camera);

			if (makeMain)
			{
				main = camera;
			}

			return camera;
		}

		return null;
	}

	/**
	 * Gets the next available Camera ID number.
	 *
	 * The Camera Manager supports up to 31 unique cameras, after which the ID returned will always be zero.
	 * You can create additional cameras beyond 31, but they cannot be used for Game Object exclusion.
	 *
	 * @since 1.0.0
	 *
	 * @return The next available Camera ID, or 0 if they're all already in use.
	**/
	private function getNextID():Int
	{
		var cameras = this.cameras;

		var testID = 1;

		//  Find the first free camera ID we can use

		for (t in 0...32)
		{
			var found = false;

			for (i in 0...cameras.length)
			{
				var camera = cameras[i];

				if (camera != null && camera.id == testID)
				{
					found = true;
					continue;
				}
			}

			if (found)
			{
				testID = testID << 1;
			}
			else
			{
				return testID;
			}
		}

		return 0;
	}

	/**
	 * Gets the total number of Cameras in this Camera Manager.
	 *
	 * If the optional `isVisible` argument is set it will only count Cameras that are currently visible.
	 *
	 * @since 1.0.0
	 *
	 * @param isVisible - Set the `true` to only include visible Cameras in the total.
	 *
	 * @return The total number of Cameras in this Camera Manager.
	**/
	public function getTotal(isVisible:Bool = false):Int
	{
		var total = 0;

		for (i in 0...cameras.length)
		{
			var camera = cameras[i];

			if (!isVisible || (isVisible && camera.visible))
			{
				total++;
			}
		}

		return total;
	}

	/**
	 * Populates this Camera Manager based on the given configuration object, or an array of config objects.
	 *
	 * See the `Phaser.Cameras.Scene2D.typedefs.JSONCamera` documentation for details of the object structure.
	 *
	 * @since 1.0.0
	 *
	 * @param config - A Camera configuration object, or an array of them, to be added to this Camera Manager.
	 *
	 * @return This Camera Manager instance.
	**/
	public function fromJSON(config:MultipleOrOne<JSONCamera>):CameraManager
	{
		var config = config.forceArray();

		var gameWidth = this.scene.sys.scale.width;
		var gameHeight = this.scene.sys.scale.height;

		for (i in 0...config.length)
		{
			var cameraConfig = config[i];

			inline function getValue<T>(value:T, defaultValue:T):T
			{
				return cameraConfig != null && value != null ? value : defaultValue;
			}

			var x = getValue(cameraConfig.x, 0);
			var y = getValue(cameraConfig.y, 0);
			var width = getValue(cameraConfig.width, gameWidth);
			var height = getValue(cameraConfig.height, gameHeight);

			var camera = add(x, y, width, height);

			//  Direct properties
			camera.name = getValue(cameraConfig.name, '');
			camera.zoom = getValue(cameraConfig.zoom, 1);
			camera.rotation = getValue(cameraConfig.rotation, 0);
			camera.scrollX = getValue(cameraConfig.scrollX, 0);
			camera.scrollY = getValue(cameraConfig.scrollY, 0);
			camera.roundPixels = getValue(cameraConfig.roundPixels, false);
			camera.visible = getValue(cameraConfig.visible, true);

			// Background Color
			var backgroundColor = getValue(cameraConfig.backgroundColor, null);

			if (backgroundColor != null)
			{
				camera.setBackgroundColor(backgroundColor);
			}

			//  Bounds
			var boundsConfig = getValue(cameraConfig.bounds, null);

			if (boundsConfig != null)
			{
				var bx = getValue(boundsConfig.x, 0);
				var by = getValue(boundsConfig.y, 0);
				var bwidth = getValue(boundsConfig.width, gameWidth);
				var bheight = getValue(boundsConfig.height, gameHeight);

				camera.setBounds(bx, by, bwidth, bheight);
			}
		}

		return this;
	}

	/**
	 * Gets a Camera based on its name.
	 *
	 * Camera names are optional and don't have to be set, so this method is only of any use if you
	 * have given your Cameras unique names.
	 *
	 * @since 1.0.0
	 *
	 * @param name - The name of the Camera.
	 *
	 * @return The first Camera with a name matching the given string, otherwise `null`.
	**/
	public function getCamera(name:String):Camera
	{
		var cameras = this.cameras;

		for (item in cameras)
		{
			if (item.name == name)
			{
				return item;
			}
		}

		return null;
	}

	/**
	 * Returns an array of all cameras below the given Pointer.
	 *
	 * The first camera in the array is the top-most camera in the camera list.
	 *
	 * @since 1.0.0
	 *
	 * @param pointer - The Pointer to check against.
	 *
	 * @return {Phaser.Cameras.Scene2D.Camera[]} An array of cameras below the Pointer.
	**/
	public function getCamerasBelowPointer(pointer)
	{
		var cameras = this.cameras;

		var x = pointer.x;
		var y = pointer.y;

		var output = [];

		for (camera in cameras)
		{
			if (camera.visible && camera.inputEnabled && RectangleUtil.contains(camera, x, y))
			{
				//  So the top-most camera is at the top of the search array
				output.unshift(camera);
			}
		}

		return output;
	}

	/**
	 * Removes the given Camera, or an array of Cameras, from this Camera Manager.
	 *
	 * If found in the Camera Manager it will be immediately removed from the local cameras array.
	 * If also currently the 'main' camera, 'main' will be reset to be camera 0.
	 *
	 * The removed Cameras are automatically destroyed if the `runDestroy` argument is `true`, which is the default.
	 * If you wish to re-use the cameras then set this to `false`, but know that they will retain their references
	 * and internal data until destroyed or re-added to a Camera Manager.
	 *
	 * @since 1.0.0
	 *
	 * @param camera - The Camera, or an array of Cameras, to be removed from this Camera Manager.
	 * @param runDestroy - Automatically call `Camera.destroy` on each Camera removed from this Camera Manager.
	 *
	 * @return The total number of Cameras removed.
	**/
	public function remove(camera:MultipleOrOne<Camera>, runDestroy:Bool = true):Int
	{
		var camera = camera.forceArray();

		var total = 0;
		var cameras = this.cameras;

		for (i in 0...camera.length)
		{
			var index = cameras.indexOf(camera[i]);

			if (index != 1)
			{
				if (runDestroy)
				{
					cameras[index].destroy();
				}

				cameras.splice(index, 1);

				total++;
			}
		}

		if (main == null && cameras[0] != null)
		{
			main = cameras[0];
		}

		return total;
	}

	/**
	 * The internal render method. This is called automatically by the Scene and should not be invoked directly.
	 *
	 * It will iterate through all local cameras and render them in turn, as long as they're visible and have
	 * an alpha level > 0.
	 *
	 * @since 1.0.0
	 *
	 * @param {(Phaser.Renderer.Canvas.CanvasRenderer|Phaser.Renderer.WebGL.WebGLRenderer)} renderer - The Renderer that will render the children to this camera.
	 * @param {Phaser.GameObjects.GameObject[]} children - An array of renderable Game Objects.
	 * @param {number} interpolation - Interpolation value. Reserved for future use.
	**/
	private function render(renderer, children, interpolation)
	{
		var scene = this.scene;
		var cameras = this.cameras;

		for (i in 0...cameras.length)
		{
			var camera = cameras[i];

			if (camera.visible && camera.alpha > 0)
			{
				//  Hard-coded to 1 for now
				camera.preRender(1);

				renderer.render(scene, children, interpolation, camera);
			}
		}
	}

	/**
	 * Resets this Camera Manager.
	 *
	 * This will iterate through all current Cameras, destroying them all, then it will reset the
	 * cameras array, reset the ID counter and create 1 new single camera using the default values.
	 *
	 * @since 1.0.0
	 *
	 * @return The freshly created main Camera.
	**/
	public function resetAll()
	{
		for (i in 0...cameras.length)
		{
			cameras[i].destroy();
		}

		cameras = [];

		this.main = this.add();

		return this.main;
	}

	/**
	 * The main update loop. Called automatically when the Scene steps.
	 *
	 * @since 1.0.0
	 *
	 * @param time - The current timestamp as generated by the Request Animation Frame or SetTimeout.
	 * @param delta - The delta time, in ms, elapsed since the last frame.
	**/
	private function update(time, delta)
	{
		for (item in cameras)
		{
			item.update(time, delta);
		}
	}

	/**
	 * The event handler that manages the `resize` event dispatched by the Scale Manager.
	 *
	 * @method Phaser.Cameras.Scene2D.CameraManager#onResize
	 * @since 3.18.0
	 *
	 * @param {Phaser.Structs.Size} gameSize - The default Game Size object. This is the un-modified game dimensions.
	 * @param {Phaser.Structs.Size} baseSize - The base Size object. The game dimensions multiplied by the resolution. The canvas width / height values match this.
	 */
	function onResize(gameSize, baseSize, displaySize, resolution, previousWidth,
			previousHeight)
	{
		for (i in 0...cameras.length)
		{
			var cam = this.cameras[i];

			//  if camera is at 0x0 and was the size of the previous game size, then we can safely assume it
			//  should be updated to match the new game size too

			if (cam.x == 0 && cam.y == 0 && cam.width == previousWidth && cam.height == previousHeight)
			{
				cam.setSize(baseSize.width, baseSize.height);
			}
		}
	}

	/**
	 * Resizes all cameras to the given dimensions.
	 *
	 * @since 1.0.0
	 *
	 * @param width - The new width of the camera.
	 * @param height - The new height of the camera.
	**/
	public function resize(width, height)
	{
		for (item in cameras)
		{
			item.setSize(width, height);
		}
	}

	/**
	 * The Scene that owns this plugin is shutting down.
	 * We need to kill and reset all internal properties as well as stop listening to Scene events.
	 *
	 * @since 1.0.0
	**/
	private function shutdown()
	{
		this.main = null;

		for (camera in cameras)
		{
			camera.destroy();
		}

		this.cameras = [];

		var eventEmitter = this.systems.events;

		eventEmitter.off(SceneEvents.UPDATE, (this.update : Function), this);
		eventEmitter.off(SceneEvents.SHUTDOWN, (this.shutdown : Function), this);
	}

	/**
	 * The Scene that owns this plugin is being destroyed.
	 * We need to shutdown and then kill off all external references.
	 *
	 * @since 1.0.0
	**/
	private function destroy()
	{
		this.shutdown();

		this.defaultCamera.destroy();

		this.scene.sys.events.off(SceneEvents.START, this.start, this);

		this.scene = null;
		this.systems = null;
	}
}
