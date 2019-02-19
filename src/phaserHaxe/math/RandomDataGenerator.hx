package phaserHaxe.math;

import haxe.ds.ReadOnlyArray;

/**
 * A seeded Random Data Generator.
 *
 * Access via `Phaser.Math.RND` which is an instance of this class pre-defined
 * by Phaser. Or, create your own instance to use as you require.
 *
 * The `Math.RND` generator is seeded by the Game Config property value `seed`.
 * If no such config property exists, a random number is used.
 *
 * If you create your own instance of this class you should provide a seed for it.
 * If no seed is given it will use a 'random' one based on Date.now.
 *
 * @since 1.0.0
 *
**/
class RandomDataGenerator
{
	/**
	 * Internal var.
	 *
	 * @since 1.0.0
	**/
	private var c:Int = 1;

	/**
	 * Internal var.
	 *
	 * @since 1.0.0
	**/
	private var s0:Float = 0;

	/**
	 * Internal var.
	 *
	 * @since 1.0.0
	**/
	private var s1:Float = 0;

	/**
	 * Internal var.
	 *
	 * @since 1.0.0
	**/
	private var s2:Float = 0;

	/**
	 * Internal var.
	 *
	 * @since 1.0.0
	**/
	private var n:Float = 0;

	/**
	 * Signs to choose from.
	 *
	 * @since 1.0.0
	**/
	private var signs:ReadOnlyArray<Int> = [-1, 1];

	/**
	 * @param seeds - The seeds to use for the random number generator.
	**/
	public function new(seeds:ReadOnlyArray<String>)
	{
		if (seeds == null)
		{
			seeds = [Std.string(Date.now().getTime() * Math.random())];
		}

		sow(seeds);
	}

	private static final emptyArray = new Array<String>();

	public static inline function newFromState(state:String):RandomDataGenerator
	{
		var rdg = new RandomDataGenerator(emptyArray);
		rdg.state(state);
		return rdg;
	}

	/**
	 * Private random helper.
	 *
	 * @since 1.0.0
	 *
	 * @return A random number.
	**/
	private function rnd()
	{
		var t = 2091639 * this.s0 + this.c * MathConst.POW2_NEGATIVE32;

		this.c = Compatibility.toIntSafe(t);
		this.s0 = this.s1;
		this.s1 = this.s2;
		this.s2 = t - this.c;

		return this.s2;
	}

	/**
	 * Internal method that creates a seed hash.
	 *
	 * @since 1.0.0
	 *
	 * @param data - The value to hash.
	 *
	 * @return The hashed value.
	**/
	private function hash(data:String)
	{
		var h:Float;
		var n:Float = this.n;

		data = Std.string(data);

		for (i in 0...data.length)
		{
			n += data.charCodeAt(i);
			h = 0.02519603282416938 * n;
			n = Compatibility.toJSUintRange(h);
			h -= n;
			h *= n;
			n = Compatibility.toJSUintRange(h);
			h -= n;
			n += h * MathConst.POW2_32;
		}

		this.n = n;

		return Compatibility.toJSUintRange(n) * MathConst.POW2_NEGATIVE32;
	}

	/**
	 * Initialize the state of the random data generator.
	 *
	 * @since 1.0.0
	 *
	 * @param seeds - The seeds to initialize the random data generator with.
	**/
	private function init(seeds:ReadOnlyArray<String>)
	{
		if (seeds.length == 1)
		{
			this.state(seeds[0]);
		}
		else
		{
			this.sow(seeds);
		}
	}

	/**
	 * Reset the seed of the random data generator.
	 *
	 * _Note_: the seed array is only processed up to the first `undefined` (or `null`) value, should such be present.
	 *
	 * @since 1.0.0
	 *
	 * @param seeds - The array of seeds: the `toString()` of each value is used.
	**/
	public function sow(seeds:ReadOnlyArray<String>)
	{
		// Always reset to default seed
		this.n = 4022871197;
		this.s0 = this.hash(" ");
		this.s1 = this.hash(" ");
		this.s2 = this.hash(" ");
		this.c = 1;

		if (seeds == null)
		{
			return;
		}

		for (i in 0...seeds.length)
		{
			if (seeds[i] == null)
			{
				break;
			}

			var seed = seeds[i];

			this.s0 -= this.hash(seed);
			this.s0 += MathUtility.boolToInt(this.s0 < 0);
			this.s1 -= this.hash(seed);
			this.s1 += MathUtility.boolToInt(this.s1 < 0);
			this.s2 -= this.hash(seed);
			this.s2 += MathUtility.boolToInt(this.s2 < 0);
		}
	}

	/**
	 * Returns a random integer between 0 and 2^32.
	 *
	 * @since 1.0.0
	 *
	 * @return A random integer between 0 and 2^32.
	**/
	public function integer():Float
	{
		// 2^32
		return this.rnd() * 4294967296;
	}

	/**
	 * Returns a random real number between 0 and 1.
	 *
	 * @since 1.0.0
	 *
	 * @return A random real number between 0 and 1.
	**/
	public function frac()
	{
		// 2^-53
		return this.rnd() + (Compatibility.toJSIntRange(this.rnd() * 0x200000)) * 1.1102230246251565e-16;
	}

	/**
	 * Returns a random real number between 0 and 2^32.
	 *
	 * @since 1.0.0
	 *
	 * @return A random real number between 0 and 2^32.
	**/
	public function real():Float
	{
		return this.integer() + this.frac();
	}

	/**
	 * Returns a random integer between and including min and max.
	 *
	 * @since 1.0.0
	 *
	 * @param min - The minimum value in the range.
	 * @param max - The maximum value in the range.
	 *
	 * @return A random number between min and max.
	**/
	public function integerInRange(min:Int, max:Int):Int
	{
		return Math.floor(this.realInRange(0, max - min + 1) + min);
	}

	/**
	 * Returns a random integer between and including min and max.
	 * This method is an alias for RandomDataGenerator.integerInRange.
	 *
	 * @since 1.0.0
	 *
	 * @param min - The minimum value in the range.
	 * @param max - The maximum value in the range.
	 *
	 * @return A random number between min and max.
	**/
	public function between(min:Int, max:Int):Int
	{
		return Math.floor(this.realInRange(0, max - min + 1) + min);
	}

	/**
	 * Returns a random real number between min and max.
	 *
	 * @since 1.0.0
	 *
	 * @param min - The minimum value in the range.
	 * @param max - The maximum value in the range.
	 *
	 * @return A random number between min and max.
	**/
	public function realInRange(min:Float, max:Float):Float
	{
		return this.frac() * (max - min) + min;
	}

	/**
	 * Returns a random real number between -1 and 1.
	 *
	 * @since 1.0.0
	 *
	 * @return A random real number between -1 and 1.
	**/
	public function normal():Float
	{
		return 1 - (2 * this.frac());
	}

	/**
	 * TODO: implement this function
	 * Returns a valid RFC4122 version4 ID hex string from https://gist.github.com/1308368
	 *
	 * @since 1.0.0
	 *
	 * @return A valid RFC4122 version4 ID hex string
	**/
	public function uuid():String
	{
		inline function toHex(num: Int) : String
		{
			#if js
			return js.Syntax.code("({0}).toString(16)",num);
			#else
			return StringTools.hex(num).toLowerCase();
			#end
		}

		var output = "";
		var a = 0;

		while (a++ < 36)
		{
			var b1 = (~a % 5 | a * 3 & 4) != 0;

			if (b1)
			{
				var b2 = (a ^ 15) != 0;

				var n1:Int;

				if (b2)
				{
					var b3 = (a ^ 20) != 0;
					var fracint:Int = Compatibility.toIntSafe(frac() * (b3 ? 16 : 4));
					output += toHex(8 ^ fracint);
				}
				else
				{
					output += toHex(4);
				}
			}
			else
			{
				output += "-";
			}
		}

		return output;
	}

	/**
	 * Returns a random element from within the given array.
	 *
	 * @since 1.0.0
	 *
	 * @param {array} array - The array to pick a random element from.
	 *
	 * @return {*} A random member of the array.
	**/
	public function pick<T>(array:ReadOnlyArray<T>):T
	{
		return array[this.integerInRange(0, array.length - 1)];
	}

	/**
	 * Returns a sign to be used with multiplication operator.
	 *
	 * @method Phaser.Math.RandomDataGenerator#sign
	 * @since 3.0.0
	 *
	 * @return -1 or +1.
	**/
	public function sign():Float
	{
		return this.pick(this.signs);
	}

	/**
	 * Returns a random element from within the given array, favoring the earlier entries.
	 *
	 * @since 1.0.0
	 *
	 * @param array - The array to pick a random element from.
	 *
	 * @return A random member of the array.
	**/
	public function weightedPick<T>(array:ReadOnlyArray<T>):T
	{
		var index:Int = Compatibility.toIntSafe(Math.pow(this.frac(), 2) * (array.length - 1) + 0.5);
		return array[index];
	}

	/**
	 * Returns a random timestamp between min and max, or between the beginning of 2000 and the end of 2020 if min and max aren't specified.
	 *
	 * @since 1.0.0
	 *
	 * @param min - The minimum value in the range.
	 * @param max - The maximum value in the range.
	 *
	 * @return A random timestamp between min and max.
	**/
	public function timestamp(min:Float = 0, max:Float = 0):Float
	{
		return this.realInRange(min != 0 ? min : 946684800000, max != 0 ? max : 1577862000000);
	}

	/**
	 * Returns a random angle between -180 and 180.
	 *
	 * @since 1.0.0
	 *
	 * @return A random number between -180 and 180.
	**/
	public function angle():Int
	{
		return this.integerInRange(-180, 180);
	}

	/**
	 * Returns a random rotation in radians, between -3.141 and 3.141
	 *
	 * @since 1.0.0
	 *
	 * @return A random number between -3.141 and 3.141
	**/
	public function rotation():Float
	{
		return this.realInRange(-3.1415926, 3.1415926);
	}

	/**
	 * Gets or Sets the state of the generator. This allows you to retain the values
	 * that the generator is using between games, i.e. in a game save file.
	 *
	 * To seed this generator with a previously saved state you can pass it as the
	 * `seed` value in your game config, or call this method directly after Phaser has booted.
	 *
	 * Call this method with no parameters to return the current state.
	 *
	 * If providing a state it should match the same format that this method
	 * returns, which is a string with a header `!rnd` followed by the `c`,
	 * `s0`, `s1` and `s2` values respectively, each comma-delimited.
	 *
	 * @since 1.0.0
	 *
	 * @param state - Generator state to be set.
	 *
	 * @return The current state of the generator.
	**/
	public function state(?state:String)
	{
		if (state != null && (~/^!rnd/).match(state))
		{
			var state = state.split(',');

			this.c = Std.parseInt(state[1]);
			this.s0 = Std.parseFloat(state[2]);
			this.s1 = Std.parseFloat(state[3]);
			this.s2 = Std.parseFloat(state[4]);
		}

		return '!rnd,${this.c},${this.s0},${this.s1},${this.s2}';
	}

	/**
	 * Shuffles the given array, using the current seed.
	 *
	 * @since 1.0.0
	 *
	 * @param array - The array to be shuffled.
	 *
	 * @return array The shuffled array.
	**/
	public function shuffle<T>(array:Array<T>):Array<T>
	{
		var len = array.length - 1;

		for (i in len...0)
		{
			var randomIndex = Math.floor(this.frac() * (i + 1));
			var itemAtIndex = array[randomIndex];

			array[randomIndex] = array[i];
			array[i] = itemAtIndex;
		}

		return array;
	}
}
