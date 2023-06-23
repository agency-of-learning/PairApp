import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"
// Connects to data-controller="pair-requests-form"
export default class extends Controller {
  static targets = ["invitee", "userTime"]
  change(event) {
    let invitee_id = event.target.value
    console.log(invitee_id)
    let invitee_time_zone = event.target.selectedOptions[0].dataset.timezone
    console.log(invitee_time_zone)
    //get(`/pair_requests/invitee?invitee_id=${invitee_id}`,{
    //  responseKind: "turbo-stream"
    //})
    this.inviteeTarget.textContent = invitee_time_zone
  }
  time(event){
    let date = event.target.value 
    let user_time_zone = event.target.dataset.user
      let time = new Date(date)

    time = date.toLocaleString("en-US", {
      timeZone: `${user_time_zone}`
    });
    console.log(time)
    console.log(user_time_zone)
    this.userTimeTarget.textContent = time
  }
  
}
