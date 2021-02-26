class Teacher < ApplicationRecord
  belongs_to :user
  belongs_to :subject

  has_many :lessons
end
