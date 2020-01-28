package views;

import events.ContactEvent;
import feathers.events.FeathersEvent;
import feathers.layout.AnchorLayoutData;
import feathers.controls.Label;
import feathers.controls.Button;
import feathers.controls.LayoutGroup;
import feathers.layout.AnchorLayout;
import feathers.core.InvalidationFlag;
import feathers.controls.ListView;
import feathers.controls.Panel;
import feathers.data.ArrayCollection;
import openfl.events.Event;
import valueObjects.Contact;

class ChooseContactView extends Panel {
	public static final ID = "choose-contact";

	public function new() {
		super();
	}

	public var contacts(default, set):ArrayCollection<Contact> = null;

	private function set_contacts(value:ArrayCollection<Contact>):ArrayCollection<Contact> {
		if (this.contacts == value) {
			return this.contacts;
		}
		this.contacts = value;
		this.setInvalid(InvalidationFlag.DATA);
		return this.contacts;
	}

	public var selectedContact(default, set):Contact = null;

	private function set_selectedContact(value:Contact):Contact {
		if (this.selectedContact == value) {
			return this.selectedContact;
		}
		this.selectedContact = value;
		this.setInvalid(InvalidationFlag.DATA);
		return this.selectedContact;
	}

	private var contactList:ListView;

	override private function initialize():Void {
		super.initialize();

		this.layout = new AnchorLayout();

		this.headerFactory = () -> {
			var header = new LayoutGroup();
			header.variant = LayoutGroup.VARIANT_TOOL_BAR;

			header.layout = new AnchorLayout();

			var title = new Label();
			title.variant = Label.VARIANT_HEADING;
			title.text = "Contacts";
			title.layoutData = AnchorLayoutData.center();
			header.addChild(title);

			var doneButton = new Button();
			doneButton.addEventListener(FeathersEvent.TRIGGERED, doneButton_triggeredHandler);
			doneButton.text = "Done";
			doneButton.layoutData = new AnchorLayoutData(null, null, null, 10.0, null, 0.0);
			header.addChild(doneButton);

			return header;
		};

		this.contactList = new ListView();
		this.contactList.itemToText = (item:Contact) -> item.name;
		this.contactList.layoutData = AnchorLayoutData.fill();
		this.contactList.addEventListener(Event.CHANGE, contactList_changeHandler);
		this.addChild(this.contactList);
	}

	override private function update():Void {
		var dataInvalid = this.isInvalid(InvalidationFlag.DATA);

		if (dataInvalid) {
			this.contactList.dataProvider = this.contacts;
			this.contactList.selectedItem = this.selectedContact;
		}

		super.update();
	}

	private function doneButton_triggeredHandler(event:Event):Void {
		this.dispatchEvent(new ContactEvent(ContactEvent.CHOOSE_CONTACT, this.selectedContact));
	}

	private function contactList_changeHandler(event:Event):Void {
		this.selectedContact = cast(this.contactList.selectedItem, Contact);
	}
}