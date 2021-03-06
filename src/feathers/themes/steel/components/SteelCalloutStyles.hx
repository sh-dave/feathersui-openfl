/*
	Feathers UI
	Copyright 2020 Bowler Hat LLC. All Rights Reserved.

	This program is free software. You can redistribute and/or modify it in
	accordance with the terms of the accompanying license agreement.
 */

package feathers.themes.steel.components;

import feathers.skins.RectangleSkin;
import feathers.controls.Callout;
import feathers.style.Theme;
import feathers.themes.steel.BaseSteelTheme;

/**
	Initialize "steel" styles for the `Callout` component.

	@since 1.0.0
**/
@:dox(hide)
@:access(feathers.themes.steel.BaseSteelTheme)
class SteelCalloutStyles {
	public static function initialize(?theme:BaseSteelTheme):Void {
		if (theme == null) {
			theme = Std.downcast(Theme.fallbackTheme, BaseSteelTheme);
		}
		if (theme == null) {
			return;
		}

		var styleProvider = theme.styleProvider;
		if (styleProvider.getStyleFunction(Callout, null) == null) {
			styleProvider.setStyleFunction(Callout, null, function(callout:Callout):Void {
				if (callout.backgroundSkin == null) {
					var backgroundSkin = new RectangleSkin();
					backgroundSkin.fill = theme.getContainerFill();
					backgroundSkin.border = theme.getContainerBorder();
					callout.backgroundSkin = backgroundSkin;
				}
				callout.paddingTop = 1.0;
				callout.paddingRight = 1.0;
				callout.paddingBottom = 1.0;
				callout.paddingLeft = 1.0;

				callout.marginTop = 10.0;
				callout.marginRight = 10.0;
				callout.marginBottom = 10.0;
				callout.marginLeft = 10.0;
			});
		}
	}
}
