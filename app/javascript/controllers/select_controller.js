import { Controller } from '@hotwired/stimulus';

// Connects to data-controller="select"
export default class extends Controller {
  static targets = ['selectTag', 'result'];

  static values = {
    notes: Object,
  };

  connect() {
    this.displayResult();
  }

  onChange() {
    this.displayResult();
  }

  displayResult() {
    const selectedStatus = this.selectTagTarget.value;
    this.resultTarget.textContent = (`${this.notesValue[selectedStatus]}`);
  }
}
