import { Application } from "@hotwired/stimulus";
import '@hotwired/turbo-rails';

const application = Application.start();
import { Alert, Autosave, Dropdown, Modal, Tabs, Popover, Toggle, Slideover } from "tailwindcss-stimulus-components"

application.register('alert', Alert);
application.register('autosave', Autosave);
application.register('dropdown', Dropdown);
application.register('modal', Modal);
application.register('tabs', Tabs);
application.register('popover', Popover);
application.register('toggle', Toggle);
application.register('slideover', Slideover);


// Configure Stimulus development experience;
application.debug = true;
window.Stimulus   = application;

// import Flatpickr
import Flatpickr from 'stimulus-flatpickr';
import "flatpickr/dist/flatpickr.css";
// Manually register Flatpickr as a stimulus controller
application.register('flatpickr', Flatpickr);

export { application }
