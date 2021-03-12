class Teacher < ApplicationRecord
  belongs_to :user, class_name: "User"
    belongs_to :subject, class_name: "Subject"

  has_many :lessons
end
