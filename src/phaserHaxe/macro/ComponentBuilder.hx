package phaserHaxe.macro;

import haxe.macro.Type.Ref;
#if eval
import haxe.macro.Context;
import haxe.macro.Expr;
import haxe.macro.Type;

using Lambda;

typedef Getter =
{
	var name:String;
	var type:ComplexType;
	var expr:Expr;
	var ?access:Array<Access>;
}

typedef Setter =
{
	var name:String;
	var type:ComplexType;
	var expr:Expr;
	var ?access:Array<Access>;
}

typedef Function =
{
	/**
		name of function
	**/
	var name:String;

	var ?doc:String;

	/**
		name of function
	**/
	var ?access:Array<Access>;

	/**
		A list of function arguments.
	**/
	var ?args:Array<FunctionArg>;

	/**
		The return type-hint of the function, if available.
	**/
	var ret:Null<ComplexType>;

	/**
		The expression of the function body, if available.
	**/
	var expr:Null<Expr>;
}

typedef Propriety =
{
	var name:String;
	var type:ComplexType;
	var ?doc:String;
	var ?access:Array<Access>;
	var ?get:Expr;
	var ?set:Expr;
}

typedef Variable =
{
	var name:String;
	var ?doc:String;
	var type:ComplexType;
	var ?access:Array<Access>;
	var ?expr:Expr;
}

class ComponentBuilder
{
	private var buildFelids:Array<Field>;
	private var pos:Position;
	private var newFelids:Array<Field>;

	public var buildType(default, null):ComplexType;

	public function new()
	{
		buildFelids = Context.getBuildFields();
		pos = Context.currentPos();
		buildType = Context.toComplexType(Context.getLocalType());
		newFelids = [];
	}

	public function addGetter(getter:Getter):ComponentBuilder
	{
		var access = getter.access;
		if (access == null)
		{
			access = [APrivate, AInline];
		}

		newFelids.push({
			name: getter.name,
			access: access,
			kind: FFun({
				args: [],
				ret: getter.type,
				expr: getter.expr
			}),
			pos: pos
		});

		return this;
	}

	public function addSetter(getter:Setter):ComponentBuilder
	{
		var access = getter.access;
		if (access == null)
		{
			access = [APrivate, AInline];
		}

		newFelids.push({
			name: getter.name,
			access: access,
			kind: FFun({
				args: [
					{
						name: "value",
						type: getter.type,
					}
				],
				ret: getter.type,
				expr: getter.expr
			}),
			pos: pos
		});

		return this;
	}

	public function addFunction(func:Function):ComponentBuilder
	{
		var access = func.access;
		var args = func.args;

		if (access == null)
		{
			access = [APublic];
		}

		if (args == null)
		{
			args = [];
		}

		newFelids.push({
			name: func.name,
			doc: func.doc,
			access: access,
			kind: FFun({
				args: args,
				ret: func.ret,
				expr: func.expr
			}),
			pos: pos
		});

		return this;
	}

	public function addPropriety(porp:Propriety):ComponentBuilder
	{
		var access = porp.access;

		if (access == null)
		{
			access = [APublic];
		}

		newFelids.push({
			name: porp.name,
			doc: porp.doc,
			access: access,
			kind: FProp("get", "set", porp.type, null),
			pos: pos
		});

		if (porp.get != null)
		{
			addGetter({
				name: 'get_${porp.name}',
				type: porp.type,
				expr: porp.get
			});
		}

		if (porp.set != null)
		{
			addSetter({
				name: 'set_${porp.name}',
				type: porp.type,
				expr: porp.set
			});
		}

		return this;
	}

	public function addVar(variable:Variable):ComponentBuilder
	{
		var access = variable.access;
		if (access == null)
		{
			access = [APublic];
		}

		newFelids.push({
			name: variable.name,
			doc: variable.doc,
			access: access,
			kind: FVar(variable.type, variable.expr),
			pos: pos
		});

		return this;
	}

	public function createFelids():Array<Field>
	{
		return newFelids.filter((f1) -> !buildFelids.exists((f2) -> f1.name == f2.name))
			.concat(buildFelids);
	}
}
#end
