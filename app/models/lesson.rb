class Lesson < ApplicationRecord
  belongs_to :subject
  belongs_to :grade
  belongs_to :teacher

  has_many :rates

  validates :date_at, :home_task, :description, :number, presence: true
  validates :number, inclusion: 1..9
end
