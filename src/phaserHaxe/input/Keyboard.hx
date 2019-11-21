package phaserHaxe.input;

import phaserHaxe.input.keyboard.Key;

class Keyboard
{
	/**
	 * The justDown value allows you to test if this Key has just been pressed down or not.
	 *
	 * When you check this value it will return `true` if the Key is down, otherwise `false`.
	 *
	 * You can only call justDown once per key press. It will only return `true` once, until the Key is released and pressed down again.
	 * This allows you to use it in situations where you want to check if this key is down without using an event, such as in a core game loop.
	 *
	 * @since 1.0.0
	 *
	 * @param key - The Key to check to see if it's just down or not.
	 *
	 * @return `true` if the Key was just pressed, otherwise `false`.
	**/
	public static function justDown(key:Key):Bool
	{
		if (key._justDown)
		{
			key._justDown = false;
			return true;
		}
		else
		{
			return false;
		}
	}

	/**
	 * The justUp value allows you to test if this Key has just been released or not.
	 *
	 * When you check this value it will return `true` if the Key is up, otherwise `false`.
	 *
	 * You can only call JustUp once per key release. It will only return `true` once, until the Key is pressed down and released again.
	 * This allows you to use it in situations where you want to check if this key is up without using an event, such as in a core game loop.
	 *
	 * @since 1.0.0
	 *
	 * @param key - The Key to check to see if it's just up or not.
	 *
	 * @return `true` if the Key was just released, otherwise `false`.
	**/
	public static function justUp(key:Key):Bool
	{
		if (key._justUp)
		{
			key._justUp = false;

			return true;
		}
		else
		{
			return false;
		}
	}

	/**
	 * Returns `true` if the Key was pressed down within the `duration` value given, based on the current
	 * game clock time. Or `false` if it either isn't down, or was pressed down longer ago than the given duration.
	 *
	 * @since 1.0.0
	 *
	 * @param key - The Key object to test.
	 * @param duration - The duration, in ms, within which the key must have been pressed down.
	 *
	 * @return `true` if the Key was pressed down within `duration` ms ago, otherwise `false`.
	**/
	public static function downDuration(key:Key, duration:Int = 50):Bool
	{
		var current = key.plugin.game.loop.time - key.timeDown;

		return (key.isDown && current < duration);
	}

	/**
	 * Returns `true` if the Key was released within the `duration` value given, based on the current
	 * game clock time. Or returns `false` if it either isn't up, or was released longer ago than the given duration.
	 *
	 * @since 1.0.0
	 *
	 * @param key - The Key object to test.
	 * @param duration - The duration, in ms, within which the key must have been released.
	 *
	 * @return `true` if the Key was released within `duration` ms ago, otherwise `false`.
	**/
	public static function UpDuration(key:Key, duration:Int = 50):Bool
	{
		var current = key.plugin.game.loop.time - key.timeUp;

		return (key.isUp && current < duration);
	}
}
