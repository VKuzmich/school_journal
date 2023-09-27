# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  address                :string
#  admin                  :boolean          default(FALSE)
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  phone                  :string(17)
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable

  has_one :parent
  has_one :student
  has_one :teacher

  validates :first_name,
            :last_name,
            presence: true,
            format: { with: /\A[a-zA-Z]+\z/ }

  validates :address,
            presence: true,
            format: { with: /\A[a-zA-Z0-9_.,!" ]+\z/ }

  validates :first_name, :last_name, :address, length: 3..40

  validates :phone,
            presence: true,
            format: { with: /(\+38)\(?\d{3}\)?(\d{3}\d{2}\d{2}|\d{3}-\d{4})/ }

  validates_each :first_name, :last_name, :address do |record, attr, value|
    record.errors.add(attr) if value =~ /\A[a-z]/
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def teacher?
    teacher.present?
  end

  def parent?
    parent.present?
  end

  def student?
    student.present?
  end
end
