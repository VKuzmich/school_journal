module JournalHelper
  LESSONS = { 1=> { start_time: '8:00',  end_time: '8:45'},
              2=> { start_time: '9:00',  end_time: '9:45'},
              3=> { start_time: '10:00', end_time: '10:45'},
              4=> { start_time: '11:00', end_time: '11:45'},
              5=> { start_time: '12:00', end_time: '12:45'},
              6=> { start_time: '13:00', end_time: '13:45'},
              7=> { start_time: '14:00', end_time: '14:45'},
              8=> { start_time: '15:00', end_time: '15:45'},
              9=> { start_time: '16:00', end_time: '16:45'}
  }
  RAWS_NUMBER = 7

  def time_range
    (Date.current.beginning_of_week..Date.current.end_of_week).map do |date|
      date.strftime("%A %d/%m/%Y")
    end
  end

  def lessons_lists(lessons, number)
    lessons.select { |lesson| lesson.date_at.wday == number }
           .map { |lesson| lesson.subject.name }
           .join('<br />')
           .html_safe
  end

  def lesson_data(number, dates)
    "#{number} Lesson <br/> #{dates[:start_time]} - #{dates[:end_time]}".html_safe
  end
end
