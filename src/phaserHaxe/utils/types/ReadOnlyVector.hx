package phaserHaxe.utils.types;

import haxe.ds.Vector;

@:forward(copy, length, filter, join, map)
abstract ReadOnlyVector<T>(Vector<T>) from Vector<T>
{
	@:arrayAccess inline function get(i:Int)
		return this[i];
}
