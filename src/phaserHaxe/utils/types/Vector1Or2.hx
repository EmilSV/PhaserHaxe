package phaserHaxe.utils.types;

import phaserHaxe.math.Vector3;
import phaserHaxe.math.Vector4;
import phaserHaxe.math.Vector2;
import phaserHaxe.math.Vector2Like;

private class Vector1Or2Data
{
	public final x:Float;
	public final y:Float;

	public inline function new(x:Float, y:Float)
	{
		this.x = x;
		this.y = y;
	}
}

abstract Vector1Or2(Vector1Or2Data)
{
	public var x(get, never):Float;
	public var y(get, never):Float;

	private inline function get_x():Float
	{
		return this.x;
	}

	private inline function get_y():Float
	{
		return this.y;
	}

	@:from
	public inline static function fromFloat(value:Float):Vector1Or2
	{
		return cast new Vector1Or2Data(value, value);
	}

	@:from
	public inline static function fromVector2(value:Vector2):Vector1Or2
	{
		return cast new Vector1Or2Data(value.x, value.y);
	}

	@:from
	public inline static function fromVector3(value:Vector3):Vector1Or2
	{
		return cast new Vector1Or2Data(value.x, value.y);
	}

	@:from
	public inline static function fromVector4(value:Vector4):Vector1Or2
	{
		return cast new Vector1Or2Data(value.x, value.y);
	}

	@:from
	public inline static function fromVector2Like(value:Vector2Like):Vector1Or2
	{
		return cast new Vector1Or2Data(value.x, value.y);
	}
}
