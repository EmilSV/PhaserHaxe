package phaserHaxe.structs;

import haxe.Constraints.Function;

class List<T>
{
	/**
	 * The parent of this list.
	 *
	 * @since 1.0.0
	**/
	public var parent:Any;

	/**
	 * The objects that belong to this collection.
	 *
	 * @since 1.0.0
	**/
	public var list:Array<T> = [];

	/**
	 * The index of the current element.
	 *
	 * This is used internally when iterating through the list with the {@link #first}, {@link #last}, {@link #get}, and {@link #previous} properties.
	 *
	 * @since 1.0.0
	**/
	public var position:Int = 0;

	/**
	 * A callback that is invoked every time a child is added to this list.
	 *
	 * @since 1.0.0
	**/
	public var addCallback:Function = () -> {};

	/**
	 * A callback that is invoked every time a child is removed from this list.
	 *
	 * @since 1.0.0
	**/
	public var removeCallback:Function = () -> {};

	/**
	 * The property key to sort by.
	 *
	 * @since 1.0.0
	**/
	private var _sortKey:String = '';

	public function new(parent:Any)
	{
		this.parent = parent;
	}

	/**
	 * Adds the given item to the end of the list. Each item must be unique.
	 *
	 * @method Phaser.Structs.List#add
	 * @since 3.0.0
	 *
	 * @genericUse {T} - [child,$return]
	 *
	 * @param {*|Array.<*>} child - The item, or array of items, to add to the list.
	 * @param {boolean} [skipCallback=false] - Skip calling the List.addCallback if this child is added successfully.
	 *
	 * @return {*} The list's underlying array.
	 */
	function add(child, skipCallback)
	{
		if (skipCallback)
		{
			return ArrayUtils.Add(this.list, child);
		}
		else
		{
			return ArrayUtils.Add(this.list, child, 0, this.addCallback, this);
		}
	}
}
