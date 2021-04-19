class Student < ApplicationRecord
  belongs_to :user
  belongs_to :grade
  belongs_to :parent

  delegate :email, :full_name, :address, to: :user
  delegate :grade_group, to: :grade
  validates :birthday, presence: true
end
