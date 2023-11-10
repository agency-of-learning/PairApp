import { Controller } from '@hotwired/stimulus';

// Connects to data-controller="removal"
export default class extends Controller {
  remove() {
    this.element.remove();
  }
}
