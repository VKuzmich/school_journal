class Lesson < ApplicationRecord
  belongs_to :subject
  belongs_to :grade
  belongs_to :teacher

  has_many :rates

  validates_presence_of :date_at, :home_task, :description
end
