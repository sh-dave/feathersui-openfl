/*
	Feathers UI
	Copyright 2020 Bowler Hat LLC. All Rights Reserved.

	This program is free software. You can redistribute and/or modify it in
	accordance with the terms of the accompanying license agreement.
 */

package feathers.data;

import openfl.events.IEventDispatcher;

/**
	Interface for collections of hierarchical data, such as trees.

	@since 1.0.0
**/
interface IHierarchicalCollection<T> extends IEventDispatcher {
	function get(location:Array<Int>):T;
	function set(location:Array<Int>, value:T):Void;
	function getLength(?location:Array<Int>):Int;
	function locationOf(item:T):Array<Int>;
	function contains(item:T):Bool;
	function isBranch(item:T):Bool;
	function removeAt(location:Array<Int>):Void;
	function removeAll():Void;
	function updateAt(location:Array<Int>):Void;
	function updateAll():Void;
}
