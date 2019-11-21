package phaserHaxe.macro;

#if (eval || macro)
import haxe.macro.Type.ClassKind;
import haxe.macro.Context;
import haxe.macro.Expr;

final class AbstractEnumGetNamerByValue
{
	macro static public function build(functionName:String = "getNameByValue"):Array<Field>
	{
		var fields = Context.getBuildFields();

		var type = Context.getLocalClass().get();

		var abstractType = switch (type.kind)
		{
			case ClassKind.KAbstractImpl(a):
				a.get();
			default:
				null;
		}

		if (abstractType == null)
		{
			Context.error("not a enum abstract", Context.currentPos());
		}

		var noMetaEnum = true;

		for (m in type.meta.get())
		{
			if (m.name == ":enum")
			{
				noMetaEnum = false;
				break;
			}
		}

		if (noMetaEnum)
		{
			Context.error("not a enum abstract", Context.currentPos());
		}

		fields.push({
			name: functionName,
			doc: 'Gets the name of the felid with the same value or if none is found `null`
				 @param value - the value of enum field 
				 @return the name of the felid with the same value',
			access: [Access.APublic, Access.AStatic],
			kind: FieldType.FFun({
				args: [
					{
						name: "value",
						type: Context.toComplexType(Context.getType(abstractType.name))
					}
				],
				ret: null,
				expr: createFunctionExpr("value", fields),
			}),
			pos: Context.currentPos()
		});

		return fields;
	}

	private static function createFunctionExpr(switchOn:String, fields:Array<Field>):Expr
	{
		return {
			pos: Context.currentPos(),
			expr: EBlock([
				{
					pos: Context.currentPos(),
					expr: EReturn({
						pos: Context.currentPos(),
						expr: createSwitch(switchOn, fields)
					})
				}
			])
		}
	}

	private static function createSwitch(switchOn:String, fields:Array<Field>)
	{
		var cases = [];

		for (item in fields)
		{
			switch item.kind
			{
				case FVar(_, _):
					cases.push(createCase(item.name));
				default:
			}
		}

		return ExprDef.ESwitch({
			expr: EConst(CIdent(switchOn)),
			pos: Context.currentPos()
		}, cases, createDefault());
	}

	private static function createDefault():Expr
	{
		return {
			pos: Context.currentPos(),
			expr: EBlock([{pos: Context.currentPos(), expr: EConst(CIdent("null"))}])
		}
	}

	private static function createCase(name:String):haxe.macro.Expr.Case
	{
		return {
			values: [{pos: Context.currentPos(), expr: EConst(CIdent(name))}],
			guard: null,
			expr: {
				pos: Context.currentPos(),
				expr: EBlock([{pos: Context.currentPos(), expr: EConst(CString(name))}])
			}
		};
	}
}
#end
