class Invitee < DelegateClass(User)
    def time_zone_identifier 
         ActiveSupport::TimeZone.new(time_zone).tzinfo.identifier
    end 
end 