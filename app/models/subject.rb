class Subject < ApplicationRecord
  has_many :lessons
  has_many :teachers
end
