class Subject < ApplicationRecord
  has_many :lessons
  has_many :teachers, class_name: "Teacher"
  validates :name,
            presence: true
end
