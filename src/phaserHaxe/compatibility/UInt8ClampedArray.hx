package phaserHaxe.compatibility;

import haxe.io.ArrayBufferView;
import haxe.io.Error;

#if js
typedef UInt8ClampedArrayData = js.lib.Uint8ClampedArray;

abstract UInt8ClampedArray(UInt8ClampedArrayData)
{
	public static inline var BYTES_PER_ELEMENT = 1;

	public var length(get, never):Int;
	public var view(get, never):ArrayBufferView;

	public inline function new(elements:Int)
	{
		this = new UInt8ClampedArrayData(elements);
	}

	inline function get_length():Int
	{
		return this.length;
	}

	public inline function get_view():ArrayBufferView
	{
		return ArrayBufferView.fromData(this);
	}

	@:arrayAccess public inline function get(index:Int):Int
	{
		return this[index];
	}

	@:arrayAccess public inline function set(index:Int, value:Int):Int
	{
		return this[index] = value;
	}

	public inline function sub(begin:Int, ?length:Int):UInt8ClampedArray
	{
		return
			fromData(this.subarray(begin, length == null ? this.length : begin + length));
	}

	public inline function subarray(?begin:Int, ?end:Int):UInt8ClampedArray
	{
		return fromData(this.subarray(begin, end));
	}

	private inline function getData():UInt8ClampedArrayData
	{
		return this;
	}

	private static inline function fromData(d:UInt8ClampedArrayData):UInt8ClampedArray
	{
		return cast d;
	}

	public static function fromArray(a:Array<Int>, pos:Int = 0,
			?length:Int):UInt8ClampedArray
	{
		if (length == null) length = a.length - pos;
		if (pos < 0 || length < 0 || pos + length > a.length) throw Error.OutsideBounds;
		if (pos == 0 && length == a.length) return fromData(new UInt8ClampedArrayData(a));
		var i = new UInt8ClampedArray(a.length);
		for (idx in 0...length)
			i[idx] = a[idx + pos];
		return i;
	}

	public static function fromBytes(bytes:haxe.io.Bytes, bytePos:Int = 0,
			?length:Int):UInt8ClampedArray
	{
		if (length == null) length = bytes.length - bytePos;
		return fromData(new UInt8ClampedArrayData(bytes.getData(), bytePos, length));
	}
}
#else
@:forward(length, view)
abstract UInt8ClampedArray(UInt8Array)
{
	@:arrayAccess public inline function get(index:Int):Int
	{
		return this[index];
	}

	@:arrayAccess public inline function set(index:Int, value:Int):Int
	{
		return this[index] = value > 255 ? 255 : value < 0 ? 0 : value;
	}

	public inline function sub(begin:Int, ?length:Int):UInt8ClampedArray
	{
		return
			cast UInt8Array.fromData(this.subarray(begin, length == null ? this.length : begin + length));
	}

	public inline function subarray(?begin:Int, ?end:Int):UInt8ClampedArray
	{
		return cast UInt8Array.fromData(this.subarray(begin, end));
	}

	public static inline function fromArray(a:Array<Int>, pos:Int = 0,
			?length:Int):UInt8ClampedArray
	{
		return cast UInt8Array.fromArray(a, pos, length);
	}

	public static function fromBytes(bytes:haxe.io.Bytes, bytePos:Int = 0,
			?length:Int):UInt8Array
	{
		return cast UInt8Array.fromBytes(bytes, bytePos, length);
	}
}
#end
