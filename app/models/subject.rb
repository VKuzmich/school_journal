class Subject < ApplicationRecord
  has_many :lessons
  has_many :teachers
  validates :name,
            presence: true
end
