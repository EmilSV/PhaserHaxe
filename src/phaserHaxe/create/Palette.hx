package phaserHaxe.create;

import phaserHaxe.utils.StringOrInt;
import phaserHaxe.utils.ReadOnlyVector;
import haxe.ds.ReadOnlyArray;
import haxe.ds.Vector;
import phaserHaxe.Either;

abstract Palette(ReadOnlyVector<String>)
{
	public var colors(get, never):ReadOnlyVector<String>;

	public function new(colors:Either<ReadOnlyArray<String>, Dynamic>)
	{
		if (Std.is(colors, Array))
		{
			this = Vector.fromArrayCopy(cast colors);
		}
		else
		{
			var temSelf = new Vector(16);

			temSelf[0] = Reflect.field(colors, "0");
			temSelf[1] = Reflect.field(colors, "1");
			temSelf[2] = Reflect.field(colors, "2");
			temSelf[3] = Reflect.field(colors, "3");
			temSelf[4] = Reflect.field(colors, "4");
			temSelf[5] = Reflect.field(colors, "5");
			temSelf[6] = Reflect.field(colors, "6");
			temSelf[7] = Reflect.field(colors, "7");
			temSelf[8] = Reflect.field(colors, "8");
			temSelf[9] = Reflect.field(colors, "9");
			temSelf[10] = Reflect.field(colors, "A");
			temSelf[11] = Reflect.field(colors, "B");
			temSelf[12] = Reflect.field(colors, "C");
			temSelf[13] = Reflect.field(colors, "D");
			temSelf[14] = Reflect.field(colors, "E");
			temSelf[15] = Reflect.field(colors, "F");

			this = temSelf;
		}
	}

	public function get_colors():ReadOnlyVector<String>
	{
		return this;
	}

	@:arrayAccess function get(i:StringOrInt):String
	{
		final i = i.isInt() ? i.getInt() : i.getString().charCodeAt(0);

		if (i == null)
		{
			return null;
		}

		switch (i)
		{
			case "0".code:
				return colors[0];
			case "1".code:
				return colors[1];
			case "2".code:
				return colors[2];
			case "3".code:
				return colors[3];
			case "4".code:
				return colors[4];
			case "5".code:
				return colors[5];
			case "6".code:
				return colors[6];
			case "7".code:
				return colors[7];
			case "8".code:
				return colors[8];
			case "9".code:
				return colors[9];
			case "A".code:
				return colors[10];
			case "B".code:
				return colors[11];
			case "C".code:
				return colors[12];
			case "D".code:
				return colors[13];
			case "E".code:
				return colors[14];
			case "F".code:
				return colors[15];
		}

		return null;
	}
}
