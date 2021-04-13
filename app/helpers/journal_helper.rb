module JournalHelper
  def time_range
    (Date.current.beginning_of_week..Date.current.end_of_week).map do |date|
      date.strftime("%A %d/%m/%Y")
    end
  end
end
