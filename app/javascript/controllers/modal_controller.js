import { Controller } from '@hotwired/stimulus';
import { enter, leave } from 'el-transition';

// Connects to data-controller="modal"
export default class extends Controller {
  static targets = ['transitionable'];

  static scrollLockClasses = ['overflow-hidden', 'pr-4'];

  connect() {
    this.#lockScroll();
    this.transitionableTargets.forEach(enter);
  }

  close() {
    Promise.all(this.transitionableTargets.map(leave)).then(() => {
      this.element.remove();
      this.#unlockScroll();
    });
  }

  submitEnd(event) {
    if (event.detail.success) {
      this.close();
    }
  }

  onKeydown(event) {
    if (event.key === 'Escape') {
      this.close();
    }
  }

  #lockScroll() {
    document.body.classList.add(...this.constructor.scrollLockClasses);
  }

  #unlockScroll() {
    document.body.classList.remove(...this.constructor.scrollLockClasses);
  }
}
