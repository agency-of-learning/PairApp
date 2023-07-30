import { Controller } from '@hotwired/stimulus';

// Connects to data-controller="link-builder"
export default class extends Controller {
  static targets = ['source', 'destination'];

  static values = {
    param: String,
    url: String,
  };

  updateDestinationParams() {
    const url = new URL(this.destinationTarget.href);
    const params = new URLSearchParams(url.search);
    params.set(this.paramValue, this.sourceTarget.value);
    this.destinationTarget.href = `${this.urlValue}?${params}`;
  }
}
