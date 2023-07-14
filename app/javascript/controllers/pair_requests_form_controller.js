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
      const timezoneIdentifier = this.inviteeInfoTarget.selectedOptions[0].dataset.timezoneIdentifier
      const timezoneDisplayName = this.inviteeInfoTarget.selectedOptions[0].dataset.timezoneDisplayName

      this.setInviteeSchedule(timezoneIdentifier, time, timezoneDisplayName)
    }
  }
  
  date(event){
    this.inputValue =  event.target.value
    
    if (this.inviteeInfoTarget.selectedOptions[0].dataset){
      const timezoneIdentifier = this.inviteeInfoTarget.selectedOptions[0].dataset.timezoneIdentifier
      const timezoneDisplayName = this.inviteeInfoTarget.selectedOptions[0].dataset.timezoneDisplayName
      const timezoneIdentifierInviter = this.inviteeInfoTarget.selectedOptions[0].dataset.usertz
      
      this.setInviteeSchedule(timezoneIdentifier, this.inputValue, timezoneDisplayName)
      this.setUserSchedule(timezoneIdentifierInviter, event.target.value)
    }
  }

  setInviteeSchedule(timezoneIdentifier, time, timezoneDisplayName){
    dayjs.extend(utc)
    dayjs.extend(timezone)
    dayjs.extend(customParseFormat)

    const result = dayjs(time).tz(timezoneIdentifier).format("MM/DD/YYYY, hh:mm A")
    this.inviteeTzTarget.textContent = (`(${timezoneDisplayName})`)
    this.inviteeTarget.textContent = (`${result}`)
  }

  setUserSchedule(timezoneIdentifier, time){
    dayjs.extend(utc)
    dayjs.extend(timezone)
    dayjs.extend(customParseFormat)

    const result = dayjs(time).tz(timezoneIdentifier).format("YYYY-MM-DDThh:mm")
    this.inviterRequestTimeTarget.value = result
  } 
}
