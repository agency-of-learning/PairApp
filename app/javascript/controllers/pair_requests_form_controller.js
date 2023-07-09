import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
  static targets = ["click", "invitee", "invitee_tz"]
  connect(){
    localStorage.clear()
    console.log("localStorage is cleared")
  }

  click(event) {
    const invitee_time_zone = event.target.selectedOptions[0].dataset.timezone
    localStorage.setItem("invitee_time_zone", invitee_time_zone)

    if(localStorage.getItem("pair_app_when")){
      let time = localStorage.getItem("pair_app_when")
      time = new Date(time);

      this.setSchedule(invitee_time_zone, time)
    }
  }
  
  date(event){
    let time = new Date(event.target.value)
    localStorage.setItem("pair_app_when", time)
    if(localStorage.getItem("invitee_time_zone")){
      const inviteeValue = localStorage.getItem("invitee_time_zone")
      this.setSchedule(inviteeValue, time)
    }
  }

  setSchedule(invitee, time){
    const inviteeResult = new TimeZoneConverter(invitee, time).conversion
    this.invitee_tzTarget.textContent = (`(${invitee})`)
    this.inviteeTarget.textContent = (`${inviteeResult}`)
  }
}

class TimeZoneConverter {
  constructor(input, time) {
    this.input = input;
    this.time = time
  }

  get conversion() {
    let match
    let ary = Intl.supportedValuesOf('timeZone');
    if (this.input == 'UTC'){
      match = this.input
    } else {
      match = ary.find(element => element.match(this.input))
    }
    const result = this.time.toLocaleString("en-US", {
        timeZone: match,
        month: '2-digit',
        day: "2-digit",
        year: "numeric",
        hour: '2-digit',
        minute: '2-digit' 
      });
      return result;
  }

}
