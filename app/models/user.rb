class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates_length_of :first_name, within: 3..30
  validates_length_of :last_name, within: 3..30
  validates_length_of :address, within: 3..50

  validates_format_of :phone, with:  /\A(?:\+?\d{1,3}\s*-?)?\(?(?:\d{3})?\)?[- ]?\d{3}[- ]?\d{4}\z/ , message:"Only positive number without spaces are allowed"
end
