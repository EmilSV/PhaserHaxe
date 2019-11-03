package phaserHaxe.cameras.scene2D.effects;

import phaserHaxe.math.MathUtility;
import phaserHaxe.math.Vector2Like;
import phaserHaxe.utils.types.Vector1Or2;
import phaserHaxe.math.Vector2;
import phaserHaxe.cameras.scene2D.typedefs.CameraShakeCallback;

/**
 * A Camera Shake effect.
 *
 * This effect will shake the camera viewport by a random amount, bounded by the specified intensity, each frame.
 *
 * Only the camera viewport is moved. None of the objects it is displaying are impacted, i.e. their positions do
 * not change.
 *
 * The effect will dispatch several events on the Camera itself and you can also specify an `onUpdate` callback,
 * which is invoked each frame for the duration of the effect if required.
 *
 * @since 1.0.0
 *
**/
class Shake
{
	/**
	 * The Camera this effect belongs to.
	 *
	 * @since 1.0.0
	**/
	public var camera(default, null):Camera;

	/**
	 * Is this effect actively running?
	 *
	 * @since 1.0.0
	**/
	public var isRunning(default, null) = false;

	/**
	 * The duration of the effect, in milliseconds.
	 *
	 * @since 1.0.0
	**/
	public var duration(default, null) = 0;

	/**
	 * The intensity of the effect. Use small float values. The default when the effect starts is 0.05.
	 * This is a Vector2 object, allowing you to control the shake intensity independently across x and y.
	 * You can modify this value while the effect is active to create more varied shake effects.
	 *
	 * @since 1.0.0
	**/
	public var intensity(default, null):Vector2 = new Vector2();

	/**
	 * If this effect is running this holds the current percentage of the progress, a value between 0 and 1.
	 *
	 * @since 1.0.0
	**/
	public var progress:Float = 0;

	/**
	 * Effect elapsed timer.
	 *
	 * @since 1.0.0
	**/
	private var _elapsed:Float = 0;

	/**
	 * How much to offset the camera by horizontally.
	 *
	 * @since 1.0.0
	**/
	private var _offsetX:Float = 0;

	/**
	 * How much to offset the camera by vertically.
	 *
	 * @since 1.0.0
	**/
	public var _offsetY:Float = 0;

	/**
	 * This callback is invoked every frame for the duration of the effect.
	 *
	 * @since 1.0.0
	**/
	private var _onUpdate:Null<CameraShakeCallback> = null;

	/**
	 * On Complete callback scope.
	 *
	 * @since 1.0.0
	**/
	private var _onUpdateScope:Null<Any> = null;

	public function new(camera:Camera)
	{
		this.camera = camera;
	}

	public inline function start(duration:Int = 100, ?intensity:Vector1Or2,
			force:Bool = false, ?callback:CameraShakeCallback, ?context:Any)
	{
		if (force || !isRunning)
		{
			if (intensity != null)
			{
				startImpl(duration, intensity.x, intensity.y, callback, context);
			}
			else
			{
				startImpl(duration, 0.05, 0.05, callback, context);
			}
		}
		return camera;
	}

	private function startImpl(duration:Int, intensityX:Float, intensityY:Float,
			callback:CameraShakeCallback, context:Null<Any>):Void
	{
		isRunning = true;
		this.duration = duration;
		progress = 0;

		this.intensity.x = intensityX;
		this.intensity.y = intensityY;

		_elapsed = 0;
		_offsetX = 0;
		_offsetY = 0;

		_onUpdate = callback;
		_onUpdateScope = context;

		camera.emit(Events.SHAKE_START, camera, this, duration, intensity);
	}

	/**
	 * The pre-render step for this effect. Called automatically by the Camera.
	 *
	 * @since 1.0.0
	**/
	public function preRender():Void
	{
		if (isRunning)
		{
			camera.matrix.translate(_offsetX, _offsetY);
		}
	}

	/**
	 * The main update loop for this effect. Called automatically by the Camera.
	 *
	 * @since 1.0.0
	 *
	 * @param time - The current timestamp as generated by the Request Animation Frame or SetTimeout.
	 * @param delta - The delta time, in ms, elapsed since the last frame.
	**/
	public function update(time:Int, delta:Float):Void
	{
		if (!isRunning)
		{
			return;
		}

		_elapsed += delta;

		progress = MathUtility.clamp(_elapsed / duration, 0, 1);

		if (_onUpdate != null)
		{
			callUpdate(_onUpdateScope, camera, progress);
		}

		if (_elapsed < duration)
		{
			var width = this.camera._cw;
			var height = this.camera._ch;
			var zoom = this.camera.zoom;

			this._offsetX = (Math.random() * intensity.x * width * 2 - intensity.x * width) * zoom;
			this._offsetY = (Math.random() * intensity.y * height * 2 - intensity.y * height) * zoom;

			if (camera.roundPixels)
			{
				_offsetX = Math.round(_offsetX);
				_offsetY = Math.round(_offsetY);
			}
		}
		else
		{
			effectComplete();
		}
	}

	/**
	 * Called internally when the effect completes.
	 *
	 * @fires Phaser.Cameras.Scene2D.Events#SHAKE_COMPLETE
	 * @since 1.0.0
	**/
	public function effectComplete()
	{
		_offsetX = 0;
		_offsetY = 0;

		_onUpdate = null;
		_onUpdateScope = null;

		isRunning = false;

		camera.emit(Events.SHAKE_COMPLETE, this.camera, this);
	}

	/**
	 * Resets this camera effect.
	 * If it was previously running, it stops instantly without calling its onComplete callback or emitting an event.
	 *
	 * @since 1.0.0
	**/
	public function reset()
	{
		isRunning = false;

		_offsetX = 0;
		_offsetY = 0;

		_onUpdate = null;
		_onUpdateScope = null;
	}

	/**
	 * Destroys this effect, releasing it from the Camera.
	 *
	 * @since 1.0.0
	**/
	public function destroy()
	{
		reset();

		camera = null;
		intensity = null;
	}

	private inline function callUpdate(context:Any, camera:Camera, progress:Float)
	{
		#if js
		if (_onUpdateScope != null)
		{
			(cast _onUpdate : js.lib.Function).call(context, camera, progress);
		}
		else
		#end
		{
			_onUpdate(camera, progress);
		}
	}
}
