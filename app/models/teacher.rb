class Teacher < ApplicationRecord
  belongs_to :user
  belongs_to :subject

  has_many :lessons

  def subject_name
    subject.name
  end

  delegate :email, :full_name, :address, to: :user

  def teacher?
    teacher.present?
  end
end
