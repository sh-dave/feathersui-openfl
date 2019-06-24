package;

import openfl.display.FPS;
import feathers.style.Theme;
import openfl.display.DisplayObject;
import openfl.events.Event;
import feathers.controls.navigators.StackAction;
import feathers.controls.navigators.StackItem;
import feathers.controls.navigators.StackNavigator;
import feathers.motion.transitions.SlideTransitions;
import feathers.controls.Application;
import com.feathersui.components.ScreenID;
import com.feathersui.components.screens.MainMenu;
import com.feathersui.components.screens.ButtonScreen;
import com.feathersui.components.screens.CheckScreen;
import com.feathersui.components.screens.LabelScreen;
import com.feathersui.components.screens.ListBoxScreen;
import com.feathersui.components.screens.ProgressBarScreen;
import com.feathersui.components.screens.RadioScreen;
import com.feathersui.components.screens.SliderScreen;
import com.feathersui.components.screens.TextInputScreen;
import com.feathersui.components.screens.ToggleSwitchScreen;

class Main extends Application {
	public function new() {
		this.theme = new DefaultTheme(this.stage /*, 0xc0daed*/);
		Theme.setTheme(this.theme);

		super();
	}

	private var theme:DefaultTheme;

	override private function initialize():Void {
		// this.customScale = 4;
		var navigator = new StackNavigator();
		navigator.pushTransition = SlideTransitions.left();
		navigator.popTransition = SlideTransitions.right();
		this.addChild(navigator);
		var mainMenu = StackItem.withFunction(function():DisplayObject {
			var screen = new MainMenu();
			screen.theme = theme;
			return screen;
		}, [Event.CHANGE => StackAction.NewAction(createPushAction)]);
		navigator.addItem(ScreenID.MAIN_MENU, mainMenu);

		var button = StackItem.withClass(ButtonScreen, [Event.COMPLETE => StackAction.Pop()]);

		navigator.addItem(ScreenID.BUTTON, button);

		var check = StackItem.withClass(CheckScreen, [Event.COMPLETE => StackAction.Pop()]);
		navigator.addItem(ScreenID.CHECK, check);

		var label = StackItem.withClass(LabelScreen, [Event.COMPLETE => StackAction.Pop()]);
		navigator.addItem(ScreenID.LABEL, label);

		var listBox = StackItem.withClass(ListBoxScreen, [Event.COMPLETE => StackAction.Pop()]);
		navigator.addItem(ScreenID.LIST_BOX, listBox);

		var progressBar = StackItem.withClass(ProgressBarScreen, [Event.COMPLETE => StackAction.Pop()]);
		navigator.addItem(ScreenID.PROGRESS_BAR, progressBar);

		var radio = StackItem.withClass(RadioScreen, [Event.COMPLETE => StackAction.Pop()]);
		navigator.addItem(ScreenID.RADIO, radio);

		var slider = StackItem.withClass(SliderScreen, [Event.COMPLETE => StackAction.Pop()]);
		navigator.addItem(ScreenID.SLIDER, slider);

		var textInput = StackItem.withClass(TextInputScreen, [Event.COMPLETE => StackAction.Pop()]);
		navigator.addItem(ScreenID.TEXT_INPUT, textInput);

		var toggleSwitch = StackItem.withClass(ToggleSwitchScreen, [Event.COMPLETE => StackAction.Pop()]);
		navigator.addItem(ScreenID.TOGGLE_SWITCH, toggleSwitch);

		navigator.rootItemID = ScreenID.MAIN_MENU;

		/*var fps = new FPS();
			fps.x = 100;
			this.addChild(fps); */
	}

	private function createPushAction(event:Event):StackAction {
		var screen = cast(event.currentTarget, MainMenu);
		return StackAction.Push(screen.selectedScreenID);
	}
}