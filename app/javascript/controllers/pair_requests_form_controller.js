import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"
// Connects to data-controller="pair-requests-form"
export default class extends Controller {
  static targets = ["invitee"]
  change(event) {
    let invitee_id = event.target.selectedOptions[0].value
    console.log(invitee_id)
    let target = this.inviteeTarget.id
    
    get(`/pair_requests/invitee?invitee_id=${invitee_id}`,{
      responseKind: "turbo-stream"
    })
    console.log(this.inviteeTarget)
  }
}
