# frozen_string_literal: true

require 'rails_helper'

RSpec.describe JournalHelper do
  describe '#time_range' do
    let(:beginning_of_week) { Date.current.beginning_of_week }
    let(:end_of_week) { Date.current.end_of_week }

    it "is between the time range" do
      range = (beginning_of_week..end_of_week).map {|date| date.strftime("%A %d/%m/%Y") }
      expect(helper.time_range).to eq(range)
    end
  end

  describe '#lessons_lists' do
    let(:subject1) { create(:subject, name: 'Music')}
    let(:subject2) { create(:subject, name: 'Physics')}
    let(:subject3) { create(:subject, name: 'Math')}
    let(:lesson1) { create(:lesson, date_at: 'Thu, 06 May 2021', subject: subject1) }
    let(:lesson2) { create(:lesson, date_at: 'Thu, 06 May 2021', subject: subject2) }
    let(:lesson3) { create(:lesson, date_at: 'Thu, 06 May 2021', subject: subject3) }
    let(:number) { 3 }
    let(:lessons_data) do
      lessons_data = []
      lessons_data << lesson1
      lessons_data << lesson2
      lessons_data << lesson3
    end

    it 'gives list of lessons' do
      list_of_lessons = lessons_data.select { |lesson| (lesson.date_at.wday-1) == number }
      list_of_lessons =list_of_lessons.map { |lesson| lesson.subject.name }.join('<br />').html_safe
      expect(helper.lessons_lists(lessons_data, number)).to eq(list_of_lessons )
    end
  end
end
