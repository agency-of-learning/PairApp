import { Controller } from "@hotwired/stimulus"
export default class extends Controller {
  static targets = ["invitee", "inviteeTz", "inviterRequestTime"]
  connect(){
    localStorage.clear()
    console.log("localStorage is cleared")
  }

  onClick(event) {
    const inviteeTimeZone = event.target.selectedOptions[0].dataset.timezone
    const userTimeZone = event.target.selectedOptions[0].dataset.usertz

    localStorage.setItem("inviteeTimeZone", inviteeTimeZone)
    localStorage.setItem("userTimeZone", userTimeZone)

    if(localStorage.getItem("pair_app_when")){
      let time = localStorage.getItem("pair_app_when")
      time = new Date(time);

      this.setInviteeSchedule(inviteeTimeZone, time)
      this.setUserSchedule(userTimeZone, time)
    }
  }
  
  date(event){
    
    let time = new Date(event.target.value)
    console.log(event.target.dataset.user)
    console.log(this.inviterRequestTimeTarget.value)

    localStorage.setItem("pair_app_when", time)
    const userTimeZone = localStorage.getItem("userTimeZone")

    this.setUserSchedule(userTimeZone, time)
    if (localStorage.getItem("inviteeTimeZone")){
      const inviteeValue = localStorage.getItem("inviteeTimeZone")
      this.setInviteeSchedule(inviteeValue, time)
    }
  }

  setInviteeSchedule(invitee, time){
    const inviteeResult = new TimeZoneConverter(invitee, time).conversion
    this.inviteeTzTarget.textContent = (`(${invitee})`)
    this.inviteeTarget.textContent = (`${inviteeResult}`)
  }

  setUserSchedule(user, time){
    const userResult = new TimeZoneConverter(user, time).conversion
    debugger
    this.inviterRequestTimeTarget = (`${userResult}`)
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
