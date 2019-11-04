package phaserHaxe.cameras.scene2D.typedefs;

import phaserHaxe.utils.types.Union;

typedef CameraConfig =
{
	public var ?name:String;
	public var ?x:Int;
	public var ?y:Int;
	public var ?width:Int;
	public var ?height:Int;
	public var ?zoom:Float;
	public var ?rotation:Float;
	public var ?roundPixels:Bool;
	public var ?scrollX:Float;
	public var ?scrollY:Float;
    public var ?visible:Bool;
	public var ?backgroundColor:String;
	public var ?bounds:
		{
			?x:Int,
			?y:Int,
			?width:Int,
			?height:Int
		};
};
