package phaserHaxe.iterator;

class StepIterator
{
	private var end:Int;
	private var step:Int;
	private var index:Int;
	private var positive:Bool;

	public inline function new(start:Int, end:Int, step:Int)
	{
		this.index = start;
		this.end = end;
		this.step = step;
		this.positive = step >= 0;
	}

	public inline function hasNext():Bool
	{
		return (positive && index < end) || (!positive && index > end);
	}

	public inline function next():Int
	{
		return (index += step) - step;
	}
}
