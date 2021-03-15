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
end
