# == Schema Information
#
# Table name: parents
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_parents_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Parent < ApplicationRecord
  belongs_to :user

  has_many :students

  delegate :email, :full_name, :address, to: :user
end
