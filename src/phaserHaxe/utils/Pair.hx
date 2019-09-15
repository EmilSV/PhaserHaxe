package phaserHaxe.utils;

@:structInit
@:generic
final class Pair<T1, T2>
{
	private var _a:T1;
	private var _b:T2;

	public var first(get, set):T1;
	public var second(get, set):T2;

	public var a(get, set):T1;
	public var b(get, set):T2;

	private inline function get_first():T1
	{
		return _a;
	}

	private inline function set_first(value:T1):T1
	{
		return _a = value;
	}

	private inline function get_second():T2
	{
		return _b;
	}

	private inline function set_second(value:T2):T2
	{
		return _b = value;
	}

	private inline function get_a():T1
	{
		return _a;
	}

	private inline function set_a(value:T1):T1
	{
		return _a = value;
	}

	private inline function get_b():T2
	{
		return _b;
	}

	private inline function set_b(value:T2):T2
	{
		return _b = value;
	}

	public inline function new(a:T1, b:T2)
	{
		this._a = a;
		this._b = b;
	}
}
