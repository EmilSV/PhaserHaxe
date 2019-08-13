package phaserHaxe.macro;

#if eval
import haxe.macro.Type;
import haxe.macro.Context;
import haxe.macro.Expr;

using Lambda;

/**
 * A class to help with mixin through haxe `@:build` or `@:autoBuild`
 *
 * @since 1.0.0
**/
final class Mixin
{
	/**
	 * A macro build function to mixin other class into another. They will be mixed in the
	 * order they were give to the function ,and will skip any felid that is already defined
	 *
	 * @since 1.0.0
	 *
	 * @param classMixinExprs - the classes to mixin
	**/
	public static function build(classMixinExprs:Array<Expr>):Array<Field>
	{
		final localClass = Context.getLocalClass().get();

		final outputFelids = Context.getBuildFields();

		if (localClass.meta.has(":phaserHaxe.NoMixin"))
		{
			return outputFelids;
		}

		if (localClass.isInterface)
		{
			return outputFelids;
		}

		for (cme in classMixinExprs)
		{
			final mixinClass = getClassFromExpr(cme);
			if (MixinValidator.isValid(mixinClass, localClass))
			{
				addFromClassExpr(mixinClass, localClass, outputFelids);
			}
		}

		return outputFelids;
	}

	private static function getClassFromExpr(classMixinExpr:Expr):Null<ClassType>
	{
		var classMixinName = tryGetIdentifier(classMixinExpr);
		var classType:Null<ClassType>;
		if (classMixinName == null)
		{
			Context.error("Not an identifer", classMixinExpr.pos);
		}

		try
		{
			switch (Context.getType(classMixinName))
			{
				case TInst(t, params):
					classType = t.get();
					if (classType.isInterface)
					{
						Context.error("Not an Class", classMixinExpr.pos);
						classType = null;
					}
				default:
					Context.error("Not an Class", classMixinExpr.pos);
					classType = null;
			}
		}
		catch (exceptionString:String)
		{
			Context.error(exceptionString, classMixinExpr.pos);
			classType = null;
		}

		return classType;
	}

	private static function addFromClassExpr(classType:ClassType, localClass:ClassType,
			outputFelids:Array<Field>)
	{
		function convertParams(params:Array<TypeParameter>)
		{
			return [
				for (p in params)
				{
					TPType(Context.toComplexType(p.t));
				}
			];
		}

		function getLastModule(module:Null<String>)
		{
			if (module == null)
			{
				return null;
			}

			var moduleSplit = module.split(".");
			if (moduleSplit.length > 0)
			{
				return moduleSplit[moduleSplit.length - 1];
			}
			else
			{
				return null;
			}
		}

		function getTypePath(classType:ClassType)
		{
			var name = classType.name;
			var lastModule = getLastModule(classType.module);
			var sub = null;

			if (lastModule != name)
			{
				name = lastModule;
				sub = classType.name;
			}

			return {
				name: name,
				pack: classType.pack,
				sub: sub,
				params: convertParams(classType.params)
			}
		}

		final typeReplacer = new TypeReplacer(getTypePath(classType), getTypePath(localClass));

		var newFields = getFelids(classType, typeReplacer);

		for (nf in newFields)
		{
			if (outputFelids.exists(of -> of.name == nf.name))
			{
				continue;
			}

			outputFelids.push(nf);
		}
	}

	private static function getFelids(classType:ClassType,
			typeReplacer:TypeReplacer):Array<Field>
	{
		final mixinFelids = classType.fields.get();
		final mixinStaticFelids = classType.statics.get();

		var output:Array<Field> = [];

		for (felid in mixinFelids)
		{
			var kind = felid.kind;
			if (felid.meta.has(":phaserHaxe.mixinIgnore"))
			{
				continue;
			}

			switch (kind)
			{
				case FVar(read, write) if (isVariableFelid(read, write)):
					output.push(getVariableFelid(felid, false, typeReplacer));
				case FVar(read, write):
					output.push(getPropertyFelid(read, write, felid, false, typeReplacer));
				case FMethod(k):
					output.push(getMethodFelid(k, felid, false, typeReplacer));
			}
		}

		for (felid in mixinStaticFelids)
		{
			var kind = felid.kind;
			if (felid.meta.has(":phaserHaxe.mixinIgnore"))
			{
				continue;
			}

			switch (kind)
			{
				case FVar(read, write) if (isVariableFelid(read, write)):
					output.push(getVariableFelid(felid, true, typeReplacer));
				case FVar(read, write):
					output.push(getPropertyFelid(read, write, felid, true, typeReplacer));
				case FMethod(k):
					output.push(getMethodFelid(k, felid, true, typeReplacer));
			}
		}

		return output;
	}

	private static function getVariableFelid(classField:ClassField, isStatic:Bool,
			typeReplacer:TypeReplacer):Field
	{
		final name = classField.name;
		final isFinal = classField.isFinal;
		final isPublic = classField.isPublic;
		final comType = typeReplacer.tryReplaceType(Context.toComplexType(classField.type));
		final fieldExpr = classField.expr();
		final doc = classField.doc;
		final meta = classField.meta.get();
		final defaultExpr = if (fieldExpr != null)
		{
			typeReplacer.tryReplaceExpr(Context.getTypedExpr(fieldExpr));
		}
		else
		{
			null;
		}

		final access = [
			if (isPublic)
			{
				APublic;
			}
			else
			{
				APrivate;
			}
		];

		if (isFinal)
		{
			access.push(AFinal);
		}

		if (isStatic)
		{
			access.push(AStatic);
		}

		return {
			name: name,
			kind: FVar(comType, defaultExpr),
			pos: Context.currentPos(),
			doc: doc,
			access: access,
			meta: meta
		};
	}

	private static function getPropertyFelid(read:VarAccess, write:VarAccess,
			classField:Null<ClassField>, isStatic:Bool, typeReplacer:TypeReplacer):Field
	{
		final name = classField.name;
		final isFinal = classField.isFinal;
		final isPublic = classField.isPublic;
		final comType = typeReplacer.tryReplaceType((Context.toComplexType(classField.type)));
		final fieldExpr = classField != null ? classField.expr() : null;
		final doc = classField.doc;
		final meta = classField.meta.get();
		final defaultExpr = if (fieldExpr != null)
		{
			typeReplacer.tryReplaceExpr(Context.getTypedExpr(fieldExpr));
		}
		else
		{
			null;
		}

		final getPropType = switch (read)
		{
			case AccNormal:
				"default";
			case AccNo:
				"null";
			case AccNever:
				"never";
			case AccResolve:
				null;
			case AccCall:
				"get";
			case AccInline:
				null;
			case AccCtor:
				null;
			default:
				null;
		}

		final setPropType = switch (write)
		{
			case AccNormal:
				"default";
			case AccNo:
				"null";
			case AccNever:
				"never";
			case AccResolve:
				null;
			case AccCall:
				"set";
			case AccInline:
				null;
			case AccCtor:
				null;
			default:
				null;
		}

		final access = [
			if (isPublic)
			{
				APublic;
			}
			else
			{
				APrivate;
			}
		];

		if (isFinal)
		{
			access.push(AFinal);
		}

		if (isStatic)
		{
			access.push(AStatic);
		}

		return {
			name: name,
			kind: FProp(getPropType, setPropType, comType, defaultExpr),
			pos: Context.currentPos(),
			doc: doc,
			access: access,
			meta: meta
		};
	}

	private static function getMethodFelid(methodKind:MethodKind, classField:ClassField,
			isStatic:Bool, typeReplacer:TypeReplacer):Field
	{
		final name = classField.name;
		final isFinal = classField.isFinal;
		final isPublic = classField.isPublic;
		final access = [];
		final doc = classField.doc;
		final implCFExpr = classField.expr();
		final meta = classField.meta.get();

		final params = mapTypeParameters(classField.params);

		var mfArgs = null;
		var returnType = null;
		var implFuncExpr = null;

		switch (resolveLazy(classField.type))
		{
			case TFun(args, ret):
				mfArgs = typeReplacer.tryReplaceFunctionArgs(mapFunArgs(args));
				returnType = typeReplacer.tryReplaceType(Context.toComplexType(ret));
			default:
				Context.error("Error Todo", Context.currentPos());
		}

		if (implCFExpr != null)
		{
			final funcExpr:Expr = typeReplacer.tryReplaceExpr(Context.getTypedExpr(implCFExpr));
			switch (funcExpr.expr)
			{
				case EFunction(_, f):
					implFuncExpr = f.expr;
					mfArgs = f.args;
				default:
					Context.error("Error TODO", Context.currentPos());
			}
		}

		switch (methodKind)
		{
			case MethInline:
				access.push(AInline);
			case MethDynamic:
				access.push(ADynamic);
			case MethMacro:
				access.push(AMacro);
			default:
		}

		if (isPublic)
		{
			access.push(APublic);
		}
		else
		{
			access.push(APrivate);
		}

		if (isFinal)
		{
			access.push(AFinal);
		}

		if (isStatic)
		{
			access.push(AStatic);
		}

		return {
			name: name,
			kind: FFun({
				args: mfArgs,
				ret: returnType,
				expr: implFuncExpr,
				params: params
			}),
			pos: Context.currentPos(),
			access: access,
			doc: doc,
			meta: meta
		}
	}

	private static function mapFunArgs(args:Array<
		{
			name:String,
			opt:Bool,
			t:Type
		}>):Array<FunctionArg>
	{
		return [
			for (arg in args)
				{
					name: arg.name,
					type: Context.toComplexType(arg.t),
					opt: arg.opt,
				}
		];
	}

	private static function mapTypeParameters(params:Array<TypeParameter>)
	{
		final ret:Array<TypeParamDecl> = [];

		for (p in params)
		{
			switch (p.t)
			{
				case TInst(t, _):
					final t = t.get();
					switch (t.kind)
					{
						case KTypeParameter(constraints):
							ret.push({
								name: t.name,
								meta: t.meta.get(),
								constraints: [for (c in constraints) Context.toComplexType(c)],
							});
						default:
					}

				default:
			}
		}

		return ret;
	}

	private static function resolveLazy(t:Type):Type
	{
		while (true)
		{
			switch (t)
			{
				case TLazy(f):
					t = f();
				default:
					return t;
			}
		}
	}

	private static function isVariableFelid(read:VarAccess, write:VarAccess):Bool
	{
		return (read == AccNormal && write == AccNormal) || (read == AccInline || write == AccNormal);
	}

	private static function tryGetIdentifier(e:Expr):Null<String>
	{
		var currentExpr:Null<ExprDef> = e.expr;

		var output = "";

		while (true)
		{
			switch (currentExpr)
			{
				case EField(e, field):
					output = "." + field + output;
					currentExpr = e.expr;
				case EConst(c):
					switch (c)
					{
						case CIdent(s):
							output = s + output;
							return output;
						default:
							return null;
					}
				default:
					return null;
			}
		}
	}
}
#end
