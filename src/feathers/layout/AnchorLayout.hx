/*
	Feathers
	Copyright 2019 Bowler Hat LLC. All Rights Reserved.

	This program is free software. You can redistribute and/or modify it in
	accordance with the terms of the accompanying license agreement.
 */

package feathers.layout;

import feathers.core.IValidating;
import openfl.display.DisplayObject;
import openfl.events.EventDispatcher;

/**
	Positions and sizes items by anchoring their edges (or center points) to
	to their parent container or to other items in the same container.

	@see [How to use AnchorLayout with Feathers containers](../../../help/anchor-layout.html)
	@see `feathers.layout.AnchorLayoutData`

	@since 1.0.0
**/
class AnchorLayout extends EventDispatcher implements ILayout {
	public function new() {
		super();
	}

	public function layout(items:Array<DisplayObject>, measurements:Measurements, ?result:LayoutBoundsResult):LayoutBoundsResult {
		for (item in items) {
			var layoutObject:ILayoutObject = null;
			if (Std.is(item, ILayoutObject)) {
				layoutObject = cast(item, ILayoutObject);
				if (!layoutObject.includeInLayout) {
					continue;
				}
			}
			if (Std.is(item, IValidating)) {
				cast(item, IValidating).validateNow();
			}
		}

		var needsWidth = measurements.width == null;
		var needsHeight = measurements.height == null;
		var maxX = 0.0;
		var maxY = 0.0;
		if (needsWidth || needsHeight) {
			for (item in items) {
				var layoutObject:ILayoutObject = null;
				if (Std.is(item, ILayoutObject)) {
					layoutObject = cast(item, ILayoutObject);
					if (!layoutObject.includeInLayout) {
						continue;
					}
				}
				var layoutData:AnchorLayoutData = null;
				if (layoutObject != null && Std.is(layoutObject.layoutData, AnchorLayoutData)) {
					layoutData = cast(layoutObject.layoutData, AnchorLayoutData);
				}

				if (Std.is(item, IValidating)) {
					cast(item, IValidating).validateNow();
				}

				if (layoutData == null) {
					if (needsWidth) {
						var itemMaxX = item.x + item.width;
						if (maxX < itemMaxX) {
							maxX = itemMaxX;
						}
					}
					if (needsHeight) {
						var itemMaxY = item.y + item.height;
						if (maxY < itemMaxY) {
							maxY = itemMaxY;
						}
					}
				} else // has AnchorLayoutData
				{
					if (layoutData.top != null) {
						item.y = layoutData.top;
					}
					if (layoutData.left != null) {
						item.x = layoutData.left;
					}
					if (layoutData.bottom == null && layoutData.verticalCenter == null) {
						if (needsHeight) {
							var itemMaxY = item.y + item.height;
							if (maxY < itemMaxY) {
								maxY = itemMaxY;
							}
						}
					}
					if (layoutData.right == null && layoutData.horizontalCenter == null) {
						if (needsWidth) {
							var itemMaxX = item.x + item.width;
							if (maxX < itemMaxX) {
								maxX = itemMaxX;
							}
						}
					}
				}
			}
		}
		var viewPortWidth = needsWidth ? maxX : measurements.width;
		var viewPortHeight = needsHeight ? maxY : measurements.height;
		for (item in items) {
			var layoutObject:ILayoutObject = null;
			if (Std.is(item, ILayoutObject)) {
				layoutObject = cast(item, ILayoutObject);
				if (!layoutObject.includeInLayout) {
					continue;
				}
			}
			var layoutData:AnchorLayoutData = null;
			if (layoutObject != null && Std.is(layoutObject.layoutData, AnchorLayoutData)) {
				layoutData = cast(layoutObject.layoutData, AnchorLayoutData);
			}
			if (layoutData == null) {
				continue;
			}
			if (layoutData.bottom != null) {
				if (layoutData.top == null) {
					item.y = viewPortHeight - layoutData.bottom - item.height;
				} else {
					var itemHeight = viewPortHeight - layoutData.bottom - layoutData.top;
					if (itemHeight < 0.0) {
						itemHeight = 0.0;
					}
					item.height = itemHeight;
				}
			} else if (layoutData.verticalCenter != null) {
				item.y = layoutData.verticalCenter + (viewPortHeight - item.height) / 2.0;
			}
			if (layoutData.right != null) {
				if (layoutData.left == null) {
					item.x = viewPortWidth - layoutData.right - item.width;
				} else {
					var itemWidth = viewPortWidth - layoutData.right - item.x;
					if (itemWidth < 0.0) {
						itemWidth = 0.0;
					}
					item.width = itemWidth;
				}
			} else if (layoutData.horizontalCenter != null) {
				item.x = layoutData.horizontalCenter + (viewPortWidth - item.width) / 2.0;
			}
		}
		if (result == null) {
			result = new LayoutBoundsResult();
		}
		result.contentWidth = viewPortWidth;
		result.contentHeight = viewPortHeight;
		result.viewPortWidth = viewPortWidth;
		result.viewPortHeight = viewPortHeight;
		return result;
	}
}