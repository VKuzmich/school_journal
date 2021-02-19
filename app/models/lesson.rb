class Lesson < ApplicationRecord
  belongs_to :subject
  belongs_to :grade

  has_many :teachers
  has_many :rates

  validates_presence_of :date_at, :home_task, :description
end
