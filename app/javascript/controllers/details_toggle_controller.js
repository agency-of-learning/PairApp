import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="details-toggle"
export default class extends Controller {
	static targets = ["details"];

	clickOut(event) {
		const detailsIsOpen = this.detailsTarget.hasAttribute('open');
		const clickedOutOfDetails = this.detailsTarget.contains(event.target) === false;

		if (detailsIsOpen && clickedOutOfDetails) this.detailsTarget.removeAttribute('open');
	}
}
