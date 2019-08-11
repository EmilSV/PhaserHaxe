package phaserHaxe.macro;

#if eval
import haxe.macro.Context;
import haxe.macro.Type.ClassType;

using Lambda;

private typedef InterfaceArray = Array<
	{
		t:haxe.macro.Type.Ref<ClassType>,
		params:Array<haxe.macro.Type>
	}>;

private typedef InterfaceType =
{
	t:haxe.macro.Type.Ref<ClassType>,
	params:Array<haxe.macro.Type>
};

final class MixinValidator
{
	public static function isValid(mixinClass:ClassType, localClass:ClassType):Bool
	{
		final mixinSuperClass = mixinClass.superClass;

		if (mixinSuperClass != null)
		{
			final mixinSuperClassType = mixinSuperClass.t.get();

			if (!extendsClass(localClass, mixinSuperClassType))
			{
				Context.error('${getFullName(localClass)} does not extend ${getFullName(mixinSuperClassType)} which is needed to mixin ${getFullName(mixinClass)}',
					Context.currentPos());
				return false;
			}
		}

		final mixinInterfaces = getAllInterface(mixinClass);
		final localClassInterfaces = getAllInterface(localClass);

		for (mi in mixinInterfaces)
		{
			final miType = mi.t.get();
			if (!localClassInterfaces.exists(lc -> isSameClass(miType, lc.t.get())))
			{
				Context.error('${getFullName(localClass)} does not implement ${getFullName(miType)} which is needed to mixin ${getFullName(mixinClass)}',
					Context.currentPos());
				return false;
			}
		}

		return true;
	}

	private static function extendsClass(localClass:ClassType, classToCheckFor:ClassType)
	{
		var superClass = localClass.superClass;

		while (superClass != null)
		{
			final superClassType = superClass.t.get();

			if (isSameClass(superClassType, classToCheckFor))
			{
				return true;
			}

			superClass = superClassType.superClass;
		}
		return false;
	}

	private static function isSameClass(a:ClassType, b:ClassType)
	{
		if (a.pack.length != b.pack.length)
		{
			return false;
		}

		if (a.name != b.name)
		{
			return false;
		}

		if (a.module != b.module)
		{
			return false;
		}

		for (i in 0...a.pack.length)
		{
			if (a.pack[i] != b.pack[i])
			{
				return false;
			}
		}

		return true;
	}

	private static function getAllInterface(classType:ClassType):InterfaceArray
	{
		var output:InterfaceArray = [];

		var current = classType;

		do
		{
			for (i in current.interfaces)
			{
				output.push(i);
			}

			final superClass = current.superClass;
			if (superClass != null)
			{
				current = superClass.t.get();
			}
			else
			{
				current = null;
			}
		}
		while (current != null);

		return output;
	}

	private static function getFullName(classType:ClassType)
	{
		final moduleSplit = classType.module.split(".");
		final moduleLast = moduleSplit[moduleSplit.length - 1];

		return if (moduleLast == classType.name)
		{
			classType.module;
		}
		else
		{
			'${classType.module}.${classType.name}';
		}
	}
}
#end
