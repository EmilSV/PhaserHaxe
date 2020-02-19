package;

import haxe.macro.Expr;
import haxe.macro.PositionTools;
import haxe.macro.Context;

using haxe.macro.Tools;

class Assert
{
	static public macro function assert(e:ExprOf<Bool>)
	{
		var s = e.toString();
		var loc = PositionTools.toLocation(Context.currentPos());
		var locFile = loc.file;
		var locLine = loc.range.start.line;
		var p = e.pos;
		var el = [];
		el.push(macro if (!$e) @:pos(p) throw new Assert.AssertionFailure($v{s}, $v{locFile}, $v{locLine}));
		return macro $b{el};
	}
}

class AssertionFailure
{
	public final message:String;
	public final file:String;
	public final line:Int;

	public function new(message:String, file:String, line:Int)
	{
		this.message = message;
		this.file = file;
		this.line = line;
	}

	public function toString()
	{
		return 'Assertion failure ($file:$line): $message';
	}
}
