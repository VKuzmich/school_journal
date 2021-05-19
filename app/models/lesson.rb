class Lesson < ApplicationRecord
  START_NUMBER = 1
  END_NUMBER = 9

  belongs_to :subject
  belongs_to :grade
  belongs_to :teacher

  has_many :rates

  validates :date_at, :home_task, :description, :number, presence: true
  validates :number, inclusion: START_NUMBER..END_NUMBER
end
