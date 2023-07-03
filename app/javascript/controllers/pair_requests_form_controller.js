import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"
// Connects to data-controller="pair-requests-form"
export default class extends Controller {
  static targets = ["click", "invitee", "user", "inviteeTime", "userTime"]
  connect(){
    localStorage.clear()
    console.log("localStorage is cleared")
  }
  change(event) {
   // invitee_id = event.target.selectedOptions[0].value
    //invitee_time_zone = event.target.selectedOptions[0].dataset.timezone //i dont think I need this? but I guess I can just pass it in for now 
    //current_user_time_zone = event.target.selectedOptions[0].dataset.usertimezone
    //get request to set these things 
  
  }
  click(event) {
    //console.log("hi")
    console.log(event.target.selectedOptions[0].dataset)
    let invitee_time_zone = event.target.selectedOptions[0].dataset.timezone
    let user_time_zone = event.target.selectedOptions[0].dataset.usertimezone
    
    localStorage.setItem("invitee_time_zone", invitee_time_zone)
    localStorage.setItem("user_time_zone", user_time_zone)

    let invitee_id = event.target.selectedOptions[0].value

    if(localStorage.getItem("pair_app_when")){
      console.log("WHEN???", invitee_time_zone, user_time_zone)
      const inviteeResult = new TimeZoneConverter(invitee_time_zone).conversion
      const userResult = new TimeZoneConverter(user_time_zone).conversion
     
      let time = localStorage.getItem("pair_app_when")
      time = new Date(time);
      let inviteeTime = time.toLocaleString("en-US", {
        timeZone: inviteeResult,
        year: 'numeric',
        month: 'numeric',
        day: 'numeric',
        hour: '2-digit',
        minute: '2-digit' 
      });
      let userTime = time.toLocaleString("en-US", {
        timeZone: userResult,
        year: 'numeric',
        month: 'numeric',
        day: 'numeric',
        hour: '2-digit',
        minute: '2-digit' 
      });
      console.log(time, inviteeTime, userTime)
      this.userTimeTarget.textContent = (`${userTime}, ${user_time_zone}`)
      this.inviteeTimeTarget.textContent = (`${inviteeTime}, ${invitee_time_zone}`)

    }
    //get(`/pair_requests/invitee?invitee_id=${invitee_id}`,{
    //  respondKind: "turbo-stream"
    //})
  }

  date(event){
    let time = new Date(event.target.value)
    localStorage.setItem("pair_app_when", time)
    if(localStorage.getItem("invitee_time_zone")){
      //console.log(localStorage.getItem("invitee_time_zone"))
      let inviteeValue = localStorage.getItem("invitee_time_zone")
      let userValue = localStorage.getItem("user_time_zone")
      
      const inviteeResult = new TimeZoneConverter(inviteeValue)
      const userResult = new TimeZoneConverter(userValue)

      console.log(inviteeResult, userResult)
      
      let inviteeTime = time.toLocaleString("en-US", {
        timeZone: inviteeResult.conversion,
        year: 'numeric',
        month: 'numeric',
        day: 'numeric',
        hour: '2-digit',
        minute: '2-digit' 
      });
    
      let userTime = time.toLocaleString("en-US", {
        timeZone: userResult.conversion,
        year: 'numeric',
        month: 'numeric',
        day: 'numeric',
        hour: '2-digit',
        minute: '2-digit' 
      });
      console.log(time, inviteeTime, userTime)
      this.userTimeTarget.textContent = (`${userTime}, ${userValue}`)
      this.inviteeTimeTarget.textContent = (`${inviteeTime}, ${inviteeValue}`)

    }
  }
  
}

class TimeZoneConverter {
  constructor(input) {
    this.input = input;
  }

  get conversion() {
    let ary = Intl.supportedValuesOf('timeZone');
    if (this.input == 'UTC'){
      console.log("UTC")
      return this.input;
    }

    let result = ary.find(element => element.match(this.input))
    console.log(`Result: ${result}`)
    return result 
  }

}


/* change(event) {
  let invitee_id
  let invitee_time_zone
  let current_user_time_zone
  let time
  let userTime
  let inviteeTime

  if (event.target.name == "pair_request[invitee_id]") {
    invitee_id = event.target.selectedOptions[0].value
    invitee_time_zone = event.target.selectedOptions[0].dataset.timezone
    current_user_time_zone = event.target.selectedOptions[0].dataset.usertimezone
    this.inviteeTarget.textContent = invitee_time_zone
    this.userTarget.textContent = current_user_time_zone

    this.inviteeTarget.value = invitee_time_zone
    this.userTarget.value = current_user_time_zone

  }
  else if (event.target.name == "pair_request[when]") {
    time = new Date(event.target.value)
    userTime = time.toLocaleString("en-US", {
      timeZone: this.userTarget.value
    });
    inviteeTime = time.toLocaleString("en-US", {
      timeZone: this.inviteeTarget.value
    });

    this.userTimeTarget.textContent = userTime
    this.inviteeTimeTarget.textContent = inviteeTime
  }

} */