class Teacher < ApplicationRecord
  belongs_to :user
  belongs_to :subject
  belongs_to :lesson
end
