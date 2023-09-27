# == Schema Information
#
# Table name: teachers
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  subject_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_teachers_on_subject_id  (subject_id)
#  index_teachers_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (subject_id => subjects.id)
#  fk_rails_...  (user_id => users.id)
#
class Teacher < ApplicationRecord
  belongs_to :user
  belongs_to :subject

  has_many :lessons

  def subject_name
    subject.name
  end

  delegate :email, :full_name, :address, to: :user
end
