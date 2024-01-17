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
    datetime: String,
  };

  onClick() {
    if (this.inviterRequestTimeTarget.value && this.inviteeIsSelected) {
      const { timeZoneIdentifier, timeZoneDisplayName } = this.setTimeZones();
      let time = this.datetimeValue;

      if (time === '') {
        time = this.inviterRequestTimeTarget.value;
      }
      this.setInviteeSchedule(timeZoneIdentifier, time, timeZoneDisplayName);
    } else {
      this.inviteeTzTarget.textContent = '';
      this.inviteeTarget.textContent = '';
    }
  }

  date(event) {
    this.datetimeValue = event.target.value;

    if (this.inviteeInfoTarget.selectedOptions[0].dataset && this.inviteeIsSelected) {
      const { timeZoneIdentifier, timeZoneDisplayName, userTimeZone } = this.setTimeZones();

      this.setInviteeSchedule(timeZoneIdentifier, this.datetimeValue, timeZoneDisplayName);
      this.setUserSchedule(userTimeZone, event.target.value);
    } else {
      this.inviteeTzTarget.textContent = '';
      this.inviteeTarget.textContent = '';
    }
  }

  setInviteeSchedule(timeZoneIdentifier, time, timeZoneDisplayName) {
    const result = dayjs(time).tz(timeZoneIdentifier).format('YYYY-MM-DD, hh:mm a');
    this.inviteeTzTarget.textContent = (`${timeZoneDisplayName}`);
    this.inviteeTarget.textContent = (`${result}`);
  }

  setUserSchedule(timeZoneIdentifier, time) {
    const result = dayjs(time).tz(timeZoneIdentifier).format('YYYY-MM-DDTHH:mm');

    this.inviterRequestTimeTarget.value = result;
  }

  setTimeZones() {
    const {
      timeZoneIdentifier,
      timeZoneDisplayName,
      userTimeZone,
    } = this.inviteeInfoTarget.selectedOptions[0].dataset;

    return { timeZoneIdentifier, timeZoneDisplayName, userTimeZone };
  }

  inviteeIsSelected() {
    return this.inviteeInfoTarget.value !== '';
  }
}
