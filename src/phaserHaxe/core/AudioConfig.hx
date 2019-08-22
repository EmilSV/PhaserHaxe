package phaserHaxe.core;

#if js
import js.html.audio.AudioContext;
#end

#if js
/**
 * Config object containing various sound settings.
 *
 * @since 1.0.0
**/
typedef AudioConfig =
{
	/**
	 * Use HTML5 Audio instead of Web Audio.
	 *
	 * @since 1.0.0
	**/
	public var ?disableWebAudio:Bool;

	/**
	 * An existing Web Audio context
	 *
	 * @since 1.0.0
	**/
	public var ?context:AudioContext;

	/**
	 * Disable all audio output.
	 *
	 * @since 1.0.0
	**/
	public var ?noAudio:Bool;
}
#end
