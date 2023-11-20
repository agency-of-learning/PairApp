import { Controller } from '@hotwired/stimulus';
import dayjs from 'dayjs';
import utc from 'dayjs/plugin/utc';
import timezone from 'dayjs/plugin/timezone';
import customParseFormat from 'dayjs/plugin/customParseFormat';

dayjs.extend(utc);
dayjs.extend(timezone);
dayjs.extend(customParseFormat);

export default class extends Controller {
  static targets = ['invitee', 'inviteeTz', 'inviterRequestTime', 'inviteeInfo'];

  static values = {
    input: String,
  };

  onClick() {
    if (this.inviterRequestTimeTarget.value && this.inviteeInfoTarget.value !== '') {
      const time = this.inputValue;
      const { timeZoneIdentifier } = this.inviteeInfoTarget.selectedOptions[0].dataset;
      const { timeZoneDisplayName } = this.inviteeInfoTarget.selectedOptions[0].dataset;

      this.setInviteeSchedule(timeZoneIdentifier, time, timeZoneDisplayName);
    } else {
      this.inviteeTzTarget.textContent = '';
      this.inviteeTarget.textContent = '';
    }
  }

  date(event) {
    this.inputValue = event.target.value;

    if (this.inviteeInfoTarget.selectedOptions[0].dataset && this.inviteeInfoTarget.value !== '') {
      const { timeZoneIdentifier } = this.inviteeInfoTarget.selectedOptions[0].dataset;
      const { timeZoneDisplayName } = this.inviteeInfoTarget.selectedOptions[0].dataset;
      const inviterTimeZoneIdentifier = this.inviteeInfoTarget
        .selectedOptions[0]
        .dataset
        .userTimeZone;

      this.setInviteeSchedule(timeZoneIdentifier, this.inputValue, timeZoneDisplayName);
      this.setUserSchedule(inviterTimeZoneIdentifier, event.target.value);
    } else {
      this.inviteeTzTarget.textContent = '';
      this.inviteeTarget.textContent = '';
    }
  }

  setInviteeSchedule(timeZoneIdentifier, time, timeZoneDisplayName) {
    const result = dayjs(time).tz(timeZoneIdentifier).format('YYYY-MM-DD, hh:mm a');
    this.inviteeTzTarget.textContent = (`(${timeZoneDisplayName})`);
    this.inviteeTarget.textContent = (`${result}`);
  }

  setUserSchedule(timeZoneIdentifier, time) {
    const result = dayjs(time).tz(timeZoneIdentifier).format('YYYY-MM-DDTHH:mm');

    this.inviterRequestTimeTarget.value = result;
  }
}
