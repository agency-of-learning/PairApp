import { Controller } from "@hotwired/stimulus"
import dayjs from "dayjs"
import utc from "dayjs/plugin/utc"
import timezone from "dayjs/plugin/timezone"
import customParseFormat from "dayjs/plugin/customParseFormat"

export default class extends Controller {
  
  static targets = ["invitee", "inviteeTz", "inviterRequestTime", "inviteeInfo",]
  static values = {
    input : String
  }

  onClick(event) {
    if(this.inviterRequestTimeTarget.value){
      const time = this.inputValue
      const timeZoneIdentifier = this.inviteeInfoTarget.selectedOptions[0].dataset.timeZoneIdentifier
      const timeZoneDisplayName = this.inviteeInfoTarget.selectedOptions[0].dataset.timeZoneDisplayName

      this.setInviteeSchedule(timeZoneIdentifier, time, timeZoneDisplayName)
    }
  }
  
  date(event){
    this.inputValue =  event.target.value
    
    if (this.inviteeInfoTarget.selectedOptions[0].dataset){
      const timeZoneIdentifier = this.inviteeInfoTarget.selectedOptions[0].dataset.timeZoneIdentifier
      const timeZoneDisplayName = this.inviteeInfoTarget.selectedOptions[0].dataset.timeZoneDisplayName
      const invitertimeZoneIdentifier = this.inviteeInfoTarget.selectedOptions[0].dataset.userTimeZone
      
      this.setInviteeSchedule(timeZoneIdentifier, this.inputValue, timeZoneDisplayName)
      this.setUserSchedule(invitertimeZoneIdentifier, event.target.value)
    }
  }

  setInviteeSchedule(timeZoneIdentifier, time, timeZoneDisplayName){
    dayjs.extend(utc)
    dayjs.extend(timezone)
    dayjs.extend(customParseFormat)

    const result = dayjs(time).tz(timeZoneIdentifier).format("MM/DD/YYYY, hh:mm A")
    this.inviteeTzTarget.textContent = (`(${timeZoneDisplayName})`)
    this.inviteeTarget.textContent = (`${result}`)
  }

  setUserSchedule(timeZoneIdentifier, time){
    dayjs.extend(utc)
    dayjs.extend(timezone)
    dayjs.extend(customParseFormat)

    const result = dayjs(time).tz(timeZoneIdentifier).format("YYYY-MM-DDThh:mm")
    this.inviterRequestTimeTarget.value = result
  } 
}
