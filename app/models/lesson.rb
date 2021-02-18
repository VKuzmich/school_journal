class Lesson < ApplicationRecord
  belongs_to :subject
  belongs_to :grade

  validates_presence_of :date_at, :home_task, :description
  end
