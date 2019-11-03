package phaserHaxe.math;

final class EaseMap
{
	private static final values = [
		// Old
		"Power0" => Easing.linear, "Power1" => Easing.quadraticOut,
		"Power2" => Easing.cubicOut, "Power3" => Easing.quarticOut,
		"Power4" => Easing.quinticOut, "Quad" => Easing.quadraticOut,
		"Cubic" => Easing.cubicOut, "Quart" => Easing.quarticOut,
		"Quint" => Easing.quinticOut, "Sine" => Easing.sineOut,
		"Expo" => Easing.expoOut, "Elastic" => Easing.elasticOut.bind(_, 0.1, 0.1),
		"Back" => Easing.backOut.bind(_, 1.70158), "Bounce" => Easing.bounceOut,
		"Stepped" => Easing.stepped.bind(_, 1), 'Quad.easeIn' => Easing.quadraticIn,
		'Cubic.easeIn' => Easing.cubicIn, 'Quart.easeIn' => Easing.quarticIn,
		'Quint.easeIn' => Easing.quinticIn, 'Sine.easeIn' => Easing.sineIn,
		'Expo.easeIn' => Easing.expoIn, 'Circ.easeIn' => Easing.circularIn,
		'Elastic.easeIn' => Easing.elasticIn.bind(_, 0.1, 0.1),
		'Back.easeIn' => Easing.backIn.bind(_, 1.70158),
		'Bounce.easeIn' => Easing.bounceIn, 'Quad.easeOut' => Easing.quadraticOut,
		'Cubic.easeOut' => Easing.cubicOut, 'Quart.easeOut' => Easing.quarticOut,
		'Quint.easeOut' => Easing.quinticOut, 'Sine.easeOut' => Easing.sineOut,
		'Expo.easeOut' => Easing.expoOut, 'Circ.easeOut' => Easing.circularOut,
		'Elastic.easeOut' => Easing.elasticOut.bind(_, 0.1, 0.1),
		'Back.easeOut' => Easing.backOut.bind(_, 1.70158),
		'Bounce.easeOut' => Easing.bounceOut, 'Quad.easeInOut' => Easing.quadraticInOut,
		'Cubic.easeInOut' => Easing.cubicInOut,
		'Quart.easeInOut' => Easing.quarticInOut,
		'Quint.easeInOut' => Easing.quinticInOut, 'Sine.easeInOut' => Easing.sineInOut,
		'Expo.easeInOut' => Easing.expoInOut, 'Circ.easeInOut' => Easing.circularInOut,
		'Elastic.easeInOut' => Easing.elasticInOut.bind(_, 0.1, 0.1),
		'Back.easeInOut' => Easing.backInOut.bind(_, 1.70158),
		'Bounce.easeInOut' => Easing.bounceInOut, // new
		"power0" => Easing.linear,
		"power1" => Easing.quadraticOut, "power2" => Easing.cubicOut,
		"power3" => Easing.quarticOut, "power4" => Easing.quinticOut,
		"quad" => Easing.quadraticOut, "cubic" => Easing.cubicOut,
		"quart" => Easing.quarticOut, "quint" => Easing.quinticOut,
		"sine" => Easing.sineOut, "expo" => Easing.expoOut,
		"elastic" => Easing.elasticOut.bind(_, 0.1, 0.1),
		"back" => Easing.backOut.bind(_, 1.70158), "bounce" => Easing.bounceOut,
		"stepped" => Easing.stepped.bind(_, 1), 'quadEaseIn' => Easing.quadraticIn,
		'cubicEaseIn' => Easing.cubicIn, 'quartEaseIn' => Easing.quarticIn,
		'quintEaseIn' => Easing.quinticIn, 'sineEaseIn' => Easing.sineIn,
		'expoEaseIn' => Easing.expoIn, 'circEaseIn' => Easing.circularIn,
		'elasticEaseIn' => Easing.elasticIn.bind(_, 0.1, 0.1),
		'backEaseIn' => Easing.backIn.bind(_, 1.70158),
		'bounceEaseIn' => Easing.bounceIn, 'quadEaseOut' => Easing.quadraticOut,
		'cubicEaseOut' => Easing.cubicOut, 'quartEaseOut' => Easing.quarticOut,
		'quintEaseOut' => Easing.quinticOut, 'sineEaseOut' => Easing.sineOut,
		'expoEaseOut' => Easing.expoOut, 'circEaseOut' => Easing.circularOut,
		'elasticEaseOut' => Easing.elasticOut.bind(_, 0.1, 0.1),
		'backEaseOut' => Easing.backOut.bind(_, 1.70158),
		'bounceEaseOut' => Easing.bounceOut, 'quadEaseInOut' => Easing.quadraticInOut,
		'cubicEaseInOut' => Easing.cubicInOut, 'quartEaseInOut' => Easing.quarticInOut,
		'quintEaseInOut' => Easing.quinticInOut, 'sineEaseInOut' => Easing.sineInOut,
		'expoEaseInOut' => Easing.expoInOut, 'circEaseInOut' => Easing.circularInOut,
		'elasticEaseInOut' => Easing.elasticInOut.bind(_, 0.1, 0.1),
		'backEaseInOut' => Easing.backInOut.bind(_, 1.70158),
		'bounceEaseInOut' => Easing.bounceInOut
	];

	public static inline function get(name:String):Null<(v:Float) -> Float>
	{
		return values.get(name);
	}

	public static inline function exists(name:String):Bool
	{
		return values.exists(name);
	}
}
