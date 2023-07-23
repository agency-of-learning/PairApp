import { Application } from '@hotwired/stimulus';
import '@hotwired/turbo-rails';
import {
  Alert, Autosave, Dropdown, Modal, Tabs, Popover, Toggle, Slideover,
} from 'tailwindcss-stimulus-components';
import TextareaAutogrow from 'stimulus-textarea-autogrow';

// import Flatpickr
import Flatpickr from 'stimulus-flatpickr';
import 'flatpickr/dist/flatpickr.css';

const application = Application.start();

application.register('alert', Alert);
application.register('autosave', Autosave);
application.register('dropdown', Dropdown);
application.register('modal', Modal);
application.register('tabs', Tabs);
application.register('popover', Popover);
application.register('toggle', Toggle);
application.register('slideover', Slideover);

application.register('textarea-autogrow', TextareaAutogrow);

// Configure Stimulus development experience;
application.debug = true;
window.Stimulus = application;
// Manually register Flatpickr as a stimulus controller
application.register('flatpickr', Flatpickr);

export { application }; // eslint-disable-line
