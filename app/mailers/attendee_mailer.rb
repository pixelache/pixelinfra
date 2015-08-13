class AttendeeMailer < ApplicationMailer

  def enduser_notification(attendee)
    @attendee = attendee
    @event = attendee.item
    # if @event.email_registrations_to.blank?
      to_address = 'office@pixelache.ac'
      mail(:to => attendee.email, :from => to_address, :subject => "#{t :confirmation}: #{@event.name}")
    # else
      # to_address = @event.registration_recipient
    # end
    
  end
  
  def registration_notification(attendee)
    @attendee = attendee
    @event = attendee.item

    #mail(:to => 'office@pixelache.ac', :from => "#{attendee.name} <#{attendee.email}>", :subject =>"[Event registration: #{@event.name} (#{@attendee.name})]" )
    if @event.email_registrations_to.blank?
      mail(:to => 'office@pixelache.ac', :from => "#{attendee.name} <#{attendee.email}>", :subject =>"[Event registration: #{@event.name} (#{@attendee.name})]" )
    elsif @event.email_registrations_to =~ /\,/
      recips = @event.email_registrations_to.split(/,/)
      recips.each do |recip|
        mail(:to => recip.strip, :from => "#{attendee.name} <#{attendee.email}>", :subject =>"[Event registration: #{@event.name} (#{@attendee.name})]" )
      end
    else
      mail(:to => @event.email_registrations_to, :from => "#{attendee.name} <#{attendee.email}>", :subject =>"[Event registration: #{@event.name} (#{@attendee.name})]" )
    end

    
  end
  
  def volunteers(attendee)
    @attendee = attendee
    @post = attendee.item
    to_address = 'office@pixelache.ac'
    mail(:to => attendee.email, :from => to_address, :subject => "#{t(:thank_you_volunteering)}!")  
  end
  
  def waitinglist_notification(attendee)
    @attendee = attendee
    @event = attendee.item
    to_address = 'office@pixelache.ac'
    mail(:to => attendee.email, :from => to_address, :subject => "#{t(:space_now_available)}: #{@event.name}")
  end

end
