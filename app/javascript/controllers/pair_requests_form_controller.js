import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"
// Connects to data-controller="pair-requests-form"
export default class extends Controller {
  static targets = ["invitee", "user", "inviteeTime", "userTime"]
  change(event) {
    let invitee_id
    let invitee_time_zone
    let current_user_time_zone 
    let time 
    let userTime 
    let inviteeTime

    if(event.target.name == "pair_request[invitee_id]"){
      invitee_id = event.target.selectedOptions[0].value
      invitee_time_zone = event.target.selectedOptions[0].dataset.timezone
      current_user_time_zone = event.target.selectedOptions[0].dataset.usertimezone
      this.inviteeTarget.textContent = invitee_time_zone
      this.userTarget.textContent = current_user_time_zone

      this.inviteeTarget.value = invitee_time_zone
      this.userTarget.value = current_user_time_zone
     
    }
    else if(event.target.name == "pair_request[when]"){
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
     
  }
  
}
