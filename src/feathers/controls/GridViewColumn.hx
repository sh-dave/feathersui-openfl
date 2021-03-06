/*
	Feathers UI
	Copyright 2020 Bowler Hat LLC. All Rights Reserved.

	This program is free software. You can redistribute and/or modify it in
	accordance with the terms of the accompanying license agreement.
 */

package feathers.controls;

import openfl.events.EventDispatcher;

/**
	Configures a column in a `GridView` component.

	@see `feathers.controls.GridView`

	@since 1.0.0
**/
class GridViewColumn extends EventDispatcher {
	public function new(headerText:String, itemToText:(Dynamic) -> String = null) {
		super();
		this.headerText = headerText;
		if (itemToText != null) {
			this.itemToText = itemToText;
		}
	}

	/**
		The text to display in the column's header.

		In the following example, the column's header text is customized.

		```hx
		column.headerText = "Name";
		```

		@since 1.0.0
	**/
	public var headerText:String;

	/**
		Converts an item to text to display within a grid view cell. By default,
		the `toString()` method is called to convert an item to text. This
		method may be replaced to provide custom text.

		For example, consider the following item:

		```hx
		{ text: "Example Item" }
		```

		If the grid view cell should display the text "Example Item", a custom
		implementation of `itemToText()` might look like this:

		```hx
		column.itemToText = (item:Dynamic) ->
		{
			return item.text;
		};
		```

		@since 1.0.0
	**/
	public dynamic function itemToText(data:Dynamic):String {
		return Std.string(data);
	}
}
