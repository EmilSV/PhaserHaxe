package phaserHaxe.macro;

#if (eval || macro)
import haxe.macro.Type.ClassKind;
import haxe.macro.Context;
import haxe.macro.Expr;

final class EnumGetByName
{
	macro static public function build(functionName:String = "getByName", defaultName:String = "null"):Array<Field>
	{
		var fields = Context.getBuildFields();

		var type = Context.getLocalClass().get();

		var noAbstract = switch (type.kind)
		{
			case ClassKind.KAbstractImpl(_):
				false;
			default:
				true;
		}

		if (noAbstract)
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

		fields.push(
			{
				name: functionName,
				doc: 'Gets the value of enum field with the same name or if none is found `$defaultName`
				 @param name - the name of enum field 
				 @return the value that the field enum',
				access: [Access.APublic, Access.AStatic],
				kind: FieldType.FFun(
					{
						args: [
							{
								name: "name",
								type: macro:String
							}
						],
						ret: null,
						expr: createFunctionExpr("name", fields, defaultName),
					}),
				pos: Context.currentPos()
			});

		return fields;
	}

	private static function createFunctionExpr(switchOn:String, fields:Array<Field>, defaultName:String):Expr
	{
		return {
			pos: Context.currentPos(),
			expr: EBlock([
				{pos: Context.currentPos(), expr: EReturn({pos: Context.currentPos(), expr: createSwitch(switchOn, fields, defaultName)})}
			])
		}
	}

	private static function createSwitch(switchOn:String, fields:Array<Field>, defaultName:String)
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

		return ExprDef.ESwitch({expr: EConst(CIdent(switchOn)), pos: Context.currentPos()}, cases, createDefault(defaultName));
	}

	private static function createDefault(defaultName:String):Expr
	{
		return {
			pos: Context.currentPos(),
			expr: EBlock([
				{pos: Context.currentPos(), expr: EConst(CIdent(defaultName))}])
		}
	}

	private static function createCase(name:String):haxe.macro.Expr.Case
	{
		return {
			values: [
				{pos: Context.currentPos(), expr: EConst(CString(name))}],
			guard: null,
			expr:
				{
					pos: Context.currentPos(),
					expr: EBlock([
						{pos: Context.currentPos(), expr: EConst(CIdent(name))}])
				}
		};
	}
}
#end
