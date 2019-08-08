package phaserHaxe.macro;

#if eval
import haxe.macro.Expr;

typedef ClassMatch =
{
	final name:String;
	final pack:Array<String>;
}

/**
 * Class for macros that can replace all instance of a type in a expression with another.
 *
 * @since 1.0.0
**/
class TypeReplacer
{
	private final replaceClassMatch:TypePath;
	private final newClassPath:TypePath;

	/**
	 *
	 * @since 1.0.0
	 *
	 * @param replaceClassMatch - The matcher to check for if type should be replaced.
	 * @param newClassPath - The new type to use.
	**/
	public function new(replaceClassMatch:TypePath, newClassPath:TypePath)
	{
		this.replaceClassMatch = replaceClassMatch;
		this.newClassPath = newClassPath;
	}

	/**
	 * gets the replacement for the type if it matches the `replaceClassMatch`
	 *
	 * @since 1.0.0
	 *
	 * @param type - type to replace if match.
	 *
	 * @return the new type or the old one if it did not match
	**/
	public function tryReplaceType(type:ComplexType):ComplexType
	{
		return shouldReplaceType(type) ? TPath(newClassPath) : type;
	}

	/**
	 * gets the replacement for the expr if any of the types
	 * inside matches the `replaceClassMatch`
	 *
	 * @since 1.0.0
	 *
	 * @param expr - expr to get replacement for if match is found.
	 *
	 * @return the new expr or the old one if no match was found
	**/
	public function tryReplaceExpr(expr:Expr):Expr
	{
		final newExpr = replaceExpr(expr);
		return newExpr != null ? newExpr : expr;
	}

	/**
	 * gets the replacement for the function arguments if any of the types
	 * matches the `replaceClassMatch`
	 *
	 * @since 1.0.0
	 *
	 * @param args - arguments to get replacement for if match is found.
	 *
	 * @return the new arguments or the old ones if no match was found
	**/
	public function tryReplaceFunctionArgs(args:Array<FunctionArg>):Array<FunctionArg>
	{
		final newArgs = replaceFunctionArgArray(args);
		return newArgs != null ? newArgs : args;
	}

	private function replaceExpr(expr:Null<Expr>):Null<Expr>
	{
		if (expr == null)
		{
			return null;
		}

		var newExpr = switch (expr.expr)
		{
			case EArray(e1, e2):
				replaceEArray(e1, e2);

			case EBinop(op, e1, e2):
				replaceEBinop(op, e1, e2);

			case EField(e, field):
				replaceEField(e, field);

			case EParenthesis(e):
				replaceEParenthesis(e);

			case EObjectDecl(fields):
				replaceEObjectDecl(fields);

			case EArrayDecl(values):
				replaceEArrayDecl(values);

			case ENew(t, params):
				replaceENew(t, params);

			case EUnop(op, postFix, e):
				replaceEUnop(op, postFix, e);

			case EVars(vars):
				replaceEVars(vars);

			case EFunction(name, f):
				replaceEFunction(name, f);

			case EBlock(exprs):
				replaceEBlock(exprs);

			case EFor(it, expr):
				replaceEFor(it, expr);

			case EIf(econd, eif, eelse):
				replaceEIf(econd, eif, eelse);

			case EWhile(econd, e, normalWhile):
				replaceEWhile(econd, e, normalWhile);

			case ESwitch(e, cases, edef):
				replaceESwitch(e, cases, edef);

			case ETry(e, catches):
				replaceETry(e, catches);

			case EReturn(e):
				replaceEReturn(e);

			case EUntyped(e):
				replaceEUntyped(e);

			case EThrow(e):
				replaceEThrow(e);

			case ECast(e, t):
				replaceECast(e, t);

			case EDisplay(e, displayKind):
				replaceEDisplay(e, displayKind);

			case EDisplayNew(t):
				replaceEDisplayNew(t);

			case ETernary(econd, eif, eelse):
				replaceETernary(econd, eif, eelse);

			case ECheckType(e, t):
				replaceECheckType(e, t);

			case EMeta(s, e):
				replaceEMeta(s, e);

			default:
				null;
		}

		return if (newExpr != null)
		{
			{
				pos: expr.pos,
				expr: newExpr,
			}
		}
		else
		{
			return null;
		}
	}

	private function replaceEArray(e1:Null<Expr>, e2:Null<Expr>):Null<ExprDef>
	{
		final newE1 = replaceExpr(e1);
		final newE2 = replaceExpr(e2);

		return if (newE1 != null && newE2 != null)
		{
			EArray(newE1, newE2);
		}
		else if (newE1 != null)
		{
			EArray(newE1, e2);
		}
		else if (newE2 != null)
		{
			EArray(e1, newE2);
		}
		else
		{
			null;
		}
	}

	private function replaceEBinop(op:Binop, e1:Null<Expr>, e2:Null<Expr>):Null<ExprDef>
	{
		final newE1 = replaceExpr(e1);
		final newE2 = replaceExpr(e2);

		return if (newE1 != null && newE2 != null)
		{
			EBinop(op, newE1, newE2);
		}
		else if (newE1 != null)
		{
			EBinop(op, newE1, e2);
		}
		else if (newE2 != null)
		{
			EBinop(op, e1, newE2);
		}
		else
		{
			null;
		}
	}

	private function replaceEField(e:Null<Expr>, field:String):Null<ExprDef>
	{
		final newE = replaceExpr(e);

		return if (newE != null)
		{
			EField(newE, field);
		}
		else
		{
			null;
		}
	}

	private function replaceEParenthesis(e:Null<Expr>):Null<ExprDef>
	{
		final newE = replaceExpr(e);

		return if (newE != null)
		{
			EParenthesis(newE);
		}
		else
		{
			null;
		}
	}

	private function replaceEObjectDecl(fields:Null<Array<ObjectField>>):Null<ExprDef>
	{
		if (fields == null)
		{
			return null;
		}

		var changed = false;

		final newFields = [
			for (f in fields)
			{
				final newExpr = replaceExpr(f.expr);
				if (newExpr != null)
				{
					changed = true;
					{
						field: f.field,
						expr: f.expr,
						quotes: f.quotes
					}
				}
				else
				{
					f;
				}
			}
		];

		return if (changed)
		{
			EObjectDecl(newFields);
		}
		else
		{
			null;
		}
	}

	private function replaceEArrayDecl(values:Null<Array<Expr>>):Null<ExprDef>
	{
		var changed = false;

		final newValues = replaceExprArray(values);

		return if (changed)
		{
			EArrayDecl(newValues);
		}
		else
		{
			null;
		}
	}

	private function replaceCall(e:Null<Expr>, params:Null<Array<Expr>>):Null<ExprDef>
	{
		var paramsChanged = false;

		final newE = replaceExpr(e);

		final newParams = replaceExprArray(params);

		return if (newE != null && paramsChanged)
		{
			ECall(newE, newParams);
		}
		else if (newE != null)
		{
			ECall(newE, params);
		}
		else if (paramsChanged)
		{
			ECall(e, newParams);
		}
		else
		{
			return null;
		}
	}

	private function replaceENew(t:TypePath, params:Array<Expr>):Null<ExprDef>
	{
		var paramsChanged = false;

		final newT = replaceTypePath(t);

		final newParams = [
			for (p in params)
			{
				final newP = replaceExpr(p);
				if (newP != null)
				{
					paramsChanged = true;
					newP;
				}
				else
				{
					p;
				}
			}
		];

		return if (newT != null && paramsChanged)
		{
			ENew(newT, newParams);
		}
		else if (newT != null)
		{
			ENew(newT, params);
		}
		else if (paramsChanged)
		{
			ENew(t, newParams);
		}
		else
		{
			null;
		}
	}

	private function replaceEUnop(op:Unop, postFix:Bool, e:Null<Expr>):Null<ExprDef>
	{
		final newE = replaceExpr(e);

		return if (newE != null)
		{
			EUnop(op, postFix, newE);
		}
		else
		{
			null;
		}
	}

	private function replaceEVars(vars:Null<Array<Var>>):Null<ExprDef>
	{
		if (vars == null)
		{
			return null;
		}

		var changed = false;

		final newVars = [
			for (v in vars)
			{
				final newExpr = replaceExpr(v.expr);

				if (newExpr != null)
				{
					changed = true;
					{
						name: v.name,
						type: replaceType(v.type),
						expr: newExpr,
						isFinal: v.isFinal
					}
				}
				else if (shouldReplaceType(v.type))
				{
					changed = true;
					{
						name: v.name,
						type: TPath(newClassPath),
						expr: newExpr,
						isFinal: v.isFinal
					}
				}
				else
				{
					v;
				}
			}
		];

		if (changed)
		{
			return EVars(newVars);
		}
		else
		{
			return null;
		}
	}

	private function replaceEFunction(name:Null<String>, f:Function):Null<ExprDef>
	{
		final newF = replaceFunction(f);

		return if (newF != null)
		{
			EFunction(name, newF);
		}
		else
		{
			null;
		}
	}

	private function replaceEBlock(exprs:Null<Array<Expr>>):Null<ExprDef>
	{
		var changed = false;

		final newExprs = [
			for (e in exprs)
			{
				final newE = replaceExpr(e);
				if (newE != null)
				{
					changed = true;
					newE;
				}
				else
				{
					e;
				}
			}
		];

		if (changed)
		{
			return EBlock(newExprs);
		}
		else
		{
			return null;
		}
	}

	private function replaceEFor(it:Null<Expr>, expr:Null<Expr>):Null<ExprDef>
	{
		final newIt = replaceExpr(it);
		final newExpr = replaceExpr(expr);

		return if (newIt != null && newExpr != null)
		{
			EFor(newIt, newExpr);
		}
		else if (newIt != null)
		{
			EFor(newIt, expr);
		}
		else if (newExpr != null)
		{
			EFor(it, expr);
		}
		else
		{
			null;
		}
	}

	private function replaceEIf(econd:Null<Expr>, eif:Null<Expr>,
			eelse:Null<Expr>):Null<ExprDef>
	{
		var newEcond = replaceExpr(econd);
		var newEif = replaceExpr(eif);
		var newEelse = replaceExpr(eelse);

		if (newEcond != null || newEif != null || newEelse != null)
		{
			newEcond = newEcond != null ? newEcond : econd;
			newEif = newEif != null ? newEif : eif;
			newEelse = newEelse != null ? newEelse : eelse;

			return EIf(newEcond, newEif, newEelse);
		}
		else
		{
			return null;
		}
	}

	private function replaceEWhile(econd:Null<Expr>, e:Null<Expr>,
			normalWhile:Bool):Null<ExprDef>
	{
		final newEcond = replaceExpr(econd);
		final newE = replaceExpr(e);

		return if (newEcond != null && newE != null)
		{
			EWhile(newEcond, newE, normalWhile);
		}
		else if (newEcond != null)
		{
			EWhile(newEcond, e, normalWhile);
		}
		else if (newE != null)
		{
			EWhile(econd, newE, normalWhile);
		}
		else
		{
			null;
		}
	}

	private function replaceESwitch(e:Null<Expr>, cases:Null<Array<Case>>,
			edef:Null<Expr>):Null<ExprDef>
	{
		var newE = replaceExpr(e);
		var newCases = replaceCaseArray(cases);

		if (edef != null)
		{
			var newEdef = replaceExpr(edef);

			return if (newE != null || newCases != null || newEdef != null)
			{
				newE = newE != null ? newE : e;
				newCases = newCases != null ? newCases : cases;
				newEdef = newEdef != null ? newEdef : edef;

				ESwitch(newE, newCases, newEdef);
			}
			else
			{
				null;
			}
		}
		else
		{
			return if (newE != null && newCases != null)
			{
				ESwitch(newE, newCases, null);
			}
			else if (newE != null)
			{
				ESwitch(newE, cases, null);
			}
			else if (newCases != null)
			{
				ESwitch(e, newCases, null);
			}
			else
			{
				null;
			}
		}

		return null;
	}

	private function replaceETry(e:Null<Expr>, catches:Null<Array<Catch>>):Null<ExprDef>
	{
		final newE = replaceExpr(e);
		final newCatches = replaceCatchArray(catches);

		return if (newE != null && newCatches != null)
		{
			ETry(newE, newCatches);
		}
		else if (newE != null)
		{
			ETry(newE, catches);
		}
		else if (newCatches != null)
		{
			ETry(e, newCatches);
		}
		else
		{
			null;
		}

		return null;
	}

	private function replaceEReturn(e:Null<Expr>):Null<ExprDef>
	{
		final newE = replaceExpr(e);

		return if (newE != null)
		{
			EReturn(newE);
		}
		else
		{
			null;
		}
	}

	private function replaceEUntyped(e:Null<Expr>):Null<ExprDef>
	{
		final newE = replaceExpr(e);

		return if (newE != null)
		{
			EUntyped(newE);
		}
		else
		{
			null;
		}
	}

	private function replaceEThrow(e:Null<Expr>):Null<ExprDef>
	{
		final newE = replaceExpr(e);

		return if (newE != null)
		{
			EThrow(newE);
		}
		else
		{
			null;
		}
	}

	private function replaceECast(e:Null<Expr>, t:Null<ComplexType>):Null<ExprDef>
	{
		final newE = replaceExpr(e);
		final newT = replaceType(t);

		return if (newE != null && newT != null)
		{
			ECast(newE, newT);
		}
		else if (newE != null)
		{
			ECast(newE, t);
		}
		else if (newT != null)
		{
			ECast(e, newT);
		}
		else
		{
			null;
		}
	}

	private function replaceEDisplay(e:Null<Expr>, displayKind:DisplayKind):Null<ExprDef>
	{
		final newE = replaceExpr(e);

		return if (newE != null)
		{
			EDisplay(newE, displayKind);
		}
		else
		{
			null;
		}
	}

	private function replaceEDisplayNew(t:TypePath):Null<ExprDef>
	{
		final newT = replaceTypePath(t);

		return if (newT != null)
		{
			EDisplayNew(newT);
		}
		else
		{
			null;
		}
	}

	private function replaceETernary(econd:Expr, eif:Expr, eelse:Expr):Null<ExprDef>
	{
		var newEcond = replaceExpr(econd);
		var newEif = replaceExpr(eif);
		var newEelse = replaceExpr(eelse);

		if (newEcond != null || newEif != null || newEelse != null)
		{
			newEcond = newEcond != null ? newEcond : econd;
			newEif = newEif != null ? newEif : eif;
			newEelse = newEelse != null ? newEelse : eelse;

			return ETernary(newEcond, newEif, newEelse);
		}
		else
		{
			return null;
		}
	}

	private function replaceECheckType(e:Expr, t:ComplexType):Null<ExprDef>
	{
		final newE = replaceExpr(e);
		final newT = replaceType(t);

		return if (newE != null && newT != null)
		{
			ECheckType(newE, newT);
		}
		else if (newE != null)
		{
			ECheckType(newE, t);
		}
		else if (newT != null)
		{
			ECheckType(e, newT);
		}
		else
		{
			null;
		}
	}

	private function replaceEMeta(s:MetadataEntry, e:Expr):Null<ExprDef>
	{
		final newE = replaceExpr(e);

		return if (newE != null)
		{
			EMeta(s, newE);
		}
		else
		{
			null;
		}
	}

	private function replaceTypePath(typePath:Null<TypePath>):Null<TypePath>
	{
		return shouldReplaceTypePath(typePath) ? newClassPath : null;
	}

	private function replaceType(type:Null<ComplexType>):Null<ComplexType>
	{
		return shouldReplaceType(type) ? TPath(newClassPath) : null;
	}

	private function replaceCatchArray(catches:Null<Array<Catch>>):Null<Array<Catch>>
	{
		if (catches == null)
		{
			return null;
		}

		var changed = false;
		final newCatches = [
			for (c in catches)
			{
				final newType = replaceType(c.type);
				final newExpr = replaceExpr(c.expr);

				if (newType != null && newExpr != null)
				{
					changed = true;
					{
						name: c.name,
						type: newType,
						expr: newExpr
					}
				}
				else if (newType != null)
				{
					changed = true;
					{
						name: c.name,
						type: newType,
						expr: c.expr
					}
				}
				else if (newExpr != null)
				{
					changed = true;
					{
						name: c.name,
						type: c.type,
						expr: newExpr
					}
				}
				else
				{
					c;
				}
			}
		];

		return if (changed)
		{
			newCatches;
		}
		else
		{
			null;
		}
	}

	private function replaceFunctionArgArray(args:Null<Array<FunctionArg>>):Null<Array<FunctionArg>>
	{
		if (args == null)
		{
			return null;
		}

		var changed = false;

		final newArgs = [
			for (a in args)
			{
				final newType = replaceType(a.type);
				final newValue = replaceExpr(a.value);

				if (newType != null && newValue != null)
				{
					changed = true;
					{
						name: a.name,
						opt: a.opt,
						type: newType,
						value: newValue,
						meta: a.meta
					};
				}
				else if (newType != null)
				{
					changed = true;
					{
						name: a.name,
						opt: a.opt,
						type: newType,
						value: a.value,
						meta: a.meta
					};
				}
				else if (newValue != null)
				{
					changed = true;
					{
						name: a.name,
						opt: a.opt,
						type: a.type,
						value: newValue,
						meta: a.meta
					};
				}
				else
				{
					a;
				}
			}
		];

		return null;
	}

	private function replaceCaseArray(cases:Null<Array<Case>>):Null<Array<Case>>
	{
		if (cases == null)
		{
			return null;
		}

		var changed = false;

		final newCases = [
			for (c in cases)
			{
				final newE = c.expr;
				final newG = c.guard;
				final newV = c.values;

				if (newE != null || newG != null || newV != null)
				{
					changed = true;

					{
						expr: newE != null ? newE : c.expr,
						guard: newG != null ? newG : c.guard,
						values: newV != null ? newV : c.values
					};
				}
				else
				{
					c;
				}
			}
		];

		return if (changed)
		{
			newCases;
		}
		else
		{
			null;
		}

		return null;
	}

	private function replaceExprArray(exprs:Null<Array<Expr>>):Null<Array<Expr>>
	{
		if (exprs == null)
		{
			return null;
		}

		var changed = false;

		final newExprs = [
			for (e in exprs)
			{
				final newE = replaceExpr(e);

				if (newE != null)
				{
					changed = true;
					newE;
				}
				else
				{
					e;
				}
			}
		];

		return if (changed)
		{
			newExprs;
		}
		else
		{
			null;
		}
	}

	private function replaceArrayTypeParamDecl(params:Null<Array<TypeParamDecl>>)
	{
		if (params == null)
		{
			return null;
		}

		var changed = false;

		final newParams = [
			for (p in params)
			{
				final newConstraints = replaceTypeArray(p.constraints);
				final newParams = replaceArrayTypeParamDecl(p.params);

				if (newConstraints != null && newParams != null)
				{
					{
						name: p.name,
						constraints: newConstraints,
						params: newParams,
						meta: p.meta
					}
				}
				else if (newConstraints != null)
				{
					{
						name: p.name,
						constraints: newConstraints,
						params: p.params,
						meta: p.meta
					}
				}
				else if (newParams != null)
				{
					{
						name: p.name,
						constraints: p.constraints,
						params: newParams,
						meta: p.meta
					}
				}
				else
				{
					null;
				}
			}
		];

		return if (changed)
		{
			newParams;
		}
		else
		{
			null;
		}
	}

	private function replaceTypeArray(types:Null<Array<ComplexType>>):Null<Array<ComplexType>>
	{
		if (types == null)
		{
			return null;
		}

		var changed = false;

		final newTypes = [
			for (t in types)
			{
				final newT = replaceType(t);
				if (newT != null)
				{
					changed = true;
						(newT : ComplexType);
				}
				else
				{
					t;
				}
			}
		];

		return if (changed)
		{
			newTypes;
		}
		else
		{
			null;
		}
	}

	private function shouldReplaceType(complexType:Null<ComplexType>):Bool
	{
		if (complexType == null)
		{
			return false;
		}

		switch (complexType)
		{
			case TPath(p):
				return shouldReplaceTypePath(p);
			default:
				return false;
		}
		return false;
	}

	private function shouldReplaceTypePath(typePath:Null<TypePath>):Bool
	{
		if (typePath == null)
		{
			return null;
		}

		final pack1 = typePath.pack;
		final pack2 = replaceClassMatch.pack;

		if (pack1.length != pack2.length)
		{
			return false;
		}

		if (typePath.name != replaceClassMatch.name)
		{
			return false;
		}

		if (typePath.sub != replaceClassMatch.sub)
		{
			return false;
		}

		final length = typePath.pack.length;
		for (i in 0...length)
		{
			if (pack1[i] != pack2[i])
			{
				return false;
			}
		}

		return true;
	}

	private function replaceFunction(f:Function):Null<Function>
	{
		var newArgs = replaceFunctionArgArray(f.args);
		var newRet = replaceType(f.ret);
		var newExpr = replaceExpr(f.expr);
		var newParams = replaceArrayTypeParamDecl(f.params);

		return
			if (newArgs != null || newRet != null || newExpr != null || newParams != null)
		{
			newArgs = newArgs != null ? newArgs : f.args;
			newRet = newRet != null ? newRet : f.ret;
			newExpr = newExpr != null ? newExpr : f.expr;
			newParams = newParams != null ? newParams : f.params;

			{
				args: newArgs,
				ret: newRet,
				expr: newExpr,
				params: newParams
			}
		}
		else
		{
			null;
		}
	}
}
#end
