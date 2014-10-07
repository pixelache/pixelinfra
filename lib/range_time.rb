#  return blank if event time is 00:00

module ActiveSupport
  class TimeWithZone
    def range_time
      return (strftime("%H:%M") == "00:00" ? '' : strftime("%H:%M"))
    end
  end
end