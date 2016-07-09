require 'date'

class Date
  def dayname
    DAYNAMES[wday]
  end

  def abbr_dayname
    ABBR_DAYNAMES[wday]
  end
end
